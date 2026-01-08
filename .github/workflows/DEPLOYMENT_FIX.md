# Ansible Collection Installation Fix

## Problem
The Ansible playbook fails with the error:
```
[ERROR]: couldn't resolve module/action 'amazon.aws.s3_sync'. This often indicates a misspelling, missing collection, or incorrect module path.
```

This occurs because the required Ansible collections (`amazon.aws` and `community.general`) are not installed before running the playbook.

## Solution

### Option 1: Update Reusable Workflow (Recommended)
The reusable workflow `subhamay-bhattacharyya-gha/run-ansible-playbook-wf` needs to install Ansible collections before running playbooks.

Add this step to the reusable workflow before the "Run Ansible playbook" step:

```yaml
- name: Install Ansible collections
  run: |
    REQUIREMENTS_FILE="${{ inputs.ansible-playbook-path | replace('deploy-resume.yaml', 'requirements.yml') }}"
    if [ -f "$REQUIREMENTS_FILE" ]; then
      echo "Installing Ansible collections from $REQUIREMENTS_FILE"
      ansible-galaxy collection install -r "$REQUIREMENTS_FILE"
    else
      echo "No requirements.yml found, skipping collection installation"
    fi
```

### Option 2: Manual Installation (Temporary Fix)
If you can't modify the reusable workflow immediately, you can create a wrapper workflow:

1. Create `.github/workflows/deploy-resume-wrapper.yaml`:

```yaml
name: Deploy Cloud Resume Website (With Collections)
run-name: >
  Deploy resume to ${{ github.event.inputs['cloud-provider'] }} by ${{ github.actor }} on ${{ github.ref_name }}

on:
  workflow_dispatch:
    inputs:
      cloud-provider:
        description: "Choose the cloud provider"
        required: true
        type: choice
        options:
          - aws
          - gcp
          - azure
        default: aws
      s3-bucket-name:
        description: "AWS Target S3 bucket"
        required: false
        type: string
        default: "subhamay-crc-website"
      cloudfront-distribution-id:
        description: "AWS CloudFront distribution ID"
        required: false
        type: string
        default: "EW4CNVNO57XTH"

jobs:
  setup-and-deploy:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
    
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
      
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'
      
      - name: Install Ansible
        run: |
          python -m pip install --upgrade pip
          pip install ansible
      
      - name: Install Ansible collections
        run: |
          ansible-galaxy collection install -r frontend/playbooks/aws/requirements.yml
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_OIDC_ROLE_ARN }}
          aws-region: us-east-1
      
      - name: Run Ansible playbook
        run: |
          ansible-playbook frontend/playbooks/${{ inputs.cloud-provider }}/deploy-resume.yaml \
            --extra-vars '{
              "deployment": {
                "cloud_provider": "${{ inputs.cloud-provider }}",
                "deployment_id": "${{ github.run_id }}",
                "git_commit": "${{ github.sha }}",
                "deployed_by": "${{ github.actor }}",
                "branch": "${{ github.ref_name }}"
              },
              "aws": {
                "s3_bucket_name": "${{ inputs.s3-bucket-name }}",
                "cloudfront_distribution_id": "${{ inputs.cloudfront-distribution-id }}"
              }
            }'
```

### Option 3: Create PR to External Workflow Repository
Submit a pull request to `subhamay-bhattacharyya-gha/run-ansible-playbook-wf` to add collection installation support.

## Files Created
- `frontend/playbooks/aws/requirements.yml` - Specifies required Ansible collections

## Required Collections
- `amazon.aws` (>=8.0.0) - For S3 and CloudFront operations
- `community.general` (>=9.0.0) - For NPM module

## Testing Locally
```bash
# Install collections
ansible-galaxy collection install -r frontend/playbooks/aws/requirements.yml

# Run playbook
ansible-playbook frontend/playbooks/aws/deploy-resume.yaml \
  --extra-vars '{"deployment":{"cloud_provider":"aws"},"aws":{"s3_bucket_name":"test-bucket"}}'
```
