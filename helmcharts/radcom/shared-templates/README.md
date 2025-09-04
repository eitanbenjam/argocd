# shared-templates

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

shared templates for helm hooks

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| CONDUCTOR_VIP_PLACEHOLDER | string | `"internal-argocd14RadcomBEALB-783104905.us-east-2.elb.amazonaws.com"` |  |
| DOCKER_REGISTRY | string | `"692859913461.dkr.ecr.us-east-2.amazonaws.com"` |  |
| ace_cd_tag | string | `"latest"` |  |
| add_blueprint | bool | `false` |  |
| create_cluster_role | bool | `false` |  |
| cronjob_name | bool | `false` |  |
| global.conductorVip | string | `"internal-argocd14RadcomBEALB-783104905.us-east-2.elb.amazonaws.com"` |  |
| global.docker_registry | string | `"692859913461.dkr.ecr.us-east-2.amazonaws.com"` |  |
| save_blueprint | bool | `false` |  |
| wait_for_ace_orchestrator | bool | `false` |  |
| wait_for_ace_orchestrator_on_post | bool | `false` |  |
| wait_for_event_bus | bool | `false` |  |

