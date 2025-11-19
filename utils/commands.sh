# Run pre-commit hooks
git commit -a -m "Message"

# Skip pre-commit hooks
git commit -a -m "Message" --no-verify

# Run pre-coomit hooks
pre-commit run --all-files

# Reset git token
# This is useful when you want to reset the token for a specific repository
# and you don't want to use the `gh auth login` command.
# This command will remove the token from the environment and then
# re-authenticate with the GitHub CLI.
unset GITHUB_TOKEN && gh auth login -h github.com -p https -s delete_repo -w