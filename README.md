# Auto MR Opener

This project is useful for auto creating MR on GitLab on every code push.

# Environment variables

| Variable  | Default Value | Description | 
|-----------|---------------|-------------|
| TARGET_BRANCH | master | Target branch on merge requests |
| HOST | https://gitlab.com | You should set that when using a self hosted version | 
| PRIVATE_TOKEN | | Get your token at `/profile/personal_access_tokens` | 
# Usag

You should use it at your .gitlab-ci.yml configuration.