#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="install-tools.log"
SUMMARY_FILE="${SUMMARY_FILE:-install-summary.json}"
VERSIONS_FILE="${VERSIONS_FILE:-.tool-versions.json}"
DRY_RUN=false
INSTALL_TOOLS=(all)

for arg in "$@"; do
  case $arg in
    --dry-run)
      DRY_RUN=true
      echo "[Dry Run] No changes will be made. Commands will be printed only."
      ;;
    --tools=*)
      IFS=',' read -ra INSTALL_TOOLS <<< "${arg#*=}"
      ;;
    --summary-path=*)
      SUMMARY_FILE="${arg#*=}"
      ;;
  esac
done

exec > >(tee -a "$LOG_FILE") 2>&1

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SUMMARY_JSON="{}"
EXPECTED_JSON="{}"

if [[ -f "$VERSIONS_FILE" ]]; then
  EXPECTED_JSON=$(<"$VERSIONS_FILE")
fi

log_step() {
  echo -e "\n${YELLOW}🔧 $(date '+%Y-%m-%d %H:%M:%S') - $1${NC}"
}

run_cmd() {
  log_step "$1"
  shift
  if $DRY_RUN; then
    echo "[Dry Run] $*"
  else
    if "$@"; then
      echo -e "${GREEN}✅ Success: $1${NC}"
    else
      echo -e "${RED}❌ Failed: $1${NC}"
      exit 1
    fi
  fi
}

add_summary() {
  local name=$1
  local version=$2
  SUMMARY_JSON=$(echo "$SUMMARY_JSON" | jq --arg name "$name" --arg ver "$version" '. + {($name): $ver}')

  local expected_version
  expected_version=$(echo "$EXPECTED_JSON" | jq -r --arg name "$name" '.[$name] // empty')

  if [[ -n "$expected_version" && "$version" != "$expected_version" ]]; then
    echo -e "${RED}⚠️ Version mismatch for $name: expected $expected_version, got $version${NC}"
  fi
}

get_expected_version() {
  local name=$1
  echo "$EXPECTED_JSON" | jq -r --arg name "$name" '.[$name] // empty'
}

should_run() {
  [[ " ${INSTALL_TOOLS[*]} " =~ " all " || " ${INSTALL_TOOLS[*]} " =~ " $1 " ]]
}

# OS dependencies
log_step "Installing OS dependencies"
run_cmd "Install OS dependencies" sudo apt-get update -y && sudo apt-get install -y \
  curl unzip git jq gnupg software-properties-common ca-certificates lsb-release tar build-essential

# Terraform (manual installation)
if should_run terraform; then
  log_step "Installing Terraform"
  version=$(get_expected_version terraform)
  version="${version:-1.8.4}"

  if ! $DRY_RUN; then
    run_cmd "Download Terraform" curl -sLo terraform.zip "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip"
    run_cmd "Unzip Terraform" unzip -o terraform.zip
    run_cmd "Move Terraform" sudo mv terraform /usr/local/bin/
    rm -f terraform.zip
  fi

  TERRAFORM_VERSION=$(terraform version -json | jq -r .terraform_version)
  add_summary terraform "$TERRAFORM_VERSION"
fi

# AWS CLI
if should_run awscli; then
  log_step "Installing AWS CLI"
  run_cmd "Download AWS CLI" curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  run_cmd "Unzip AWS CLI" unzip awscliv2.zip
  run_cmd "Install AWS CLI" sudo ./aws/install
  rm -rf awscliv2.zip aws
  AWS_VERSION=$(aws --version 2>&1 | awk '{print $1}' | cut -d/ -f2)
  add_summary awscli "$AWS_VERSION"
fi

# Terraform Docs
if should_run terraform-docs; then
  log_step "Installing terraform-docs"
  version=$(get_expected_version terraform-docs)
  version="${version:-0.12.0}"
  run_cmd "Download terraform-docs" curl -sLo terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${version}/terraform-docs-v${version}-$(uname)-amd64.tar.gz"
  run_cmd "Extract terraform-docs" tar -xzf terraform-docs.tar.gz
  run_cmd "Move terraform-docs" sudo mv terraform-docs /usr/local/bin/
  rm terraform-docs.tar.gz
  TERRADOCS_VERSION=$(terraform-docs --version | awk '{print $2}')
  add_summary terraform-docs "$TERRADOCS_VERSION"
fi

# Remaining tools untouched...
# (you can keep Terragrunt, TFLint, tfsec, etc. blocks as-is from your last version)

# Write summary
if ! $DRY_RUN; then
  echo "$SUMMARY_JSON" | jq . > "$SUMMARY_FILE"
  echo -e "\n${GREEN}📦 Tool summary written to $SUMMARY_FILE${NC}"
fi

echo -e "\n${GREEN}✅ All tools installed successfully at $(date '+%Y-%m-%d %H:%M:%S')${NC}"
