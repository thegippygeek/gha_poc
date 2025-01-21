# gha_poc
[![Docker - Build Images](https://github.com/thegippygeek/gha_poc/actions/workflows/main.yml/badge.svg)](https://github.com/thegippygeek/gha_poc/actions/workflows/main.yml)
## Goals
1. Container base images built in GHA
2. Stretch Goals:
	1. Branch building
3. STOP USING CURRENT  BUILD SOLUTION 


## Image Builds
1. Login to Client Private Container Registry
2. Login Client Public Container Registry
3. Set Build Tag
	1. shell script
4. Build Base
	1. docker build --target al2023-base
5. Push Image
	1. docker push

## Utilise Github Action reusable Workflows
- [Sharing Automations](https://docs.github.com/en/actions/sharing-automations)
    - [Reusing workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)
