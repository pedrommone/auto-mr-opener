# Auto MR Opener

GitLab container to automatically create a new merge request on every push.

# Environment variables

| Variable  | Default Value | Description | 
|-----------|---------------|-------------|
| TARGET_BRANCH | master | Target branch on merge requests |
| HOST | https://gitlab.com | You should set that when using a self hosted version | 
| PRIVATE_TOKEN | | Get your token at `/profile/personal_access_tokens` | 
| REMOVE_SOURCE_BRANCH | true | Remove source branch when commit is merged |
| SQUASH | true | Uses squash mode |

# Usage

You should use it at your .gitlab-ci.yml configuration.

```
stages:
  - prepare
  
prepare:mr:
  stage: prepare
  image: pedrommone/auto-mr-opener
  script: docker-entrypoint.sh
  variables:
    TARGET_BRANCH: develop
    PRIVATE_TOKEN: $GITLAB_CI_AUTO_MR
  except:
    - develop
    - master
```