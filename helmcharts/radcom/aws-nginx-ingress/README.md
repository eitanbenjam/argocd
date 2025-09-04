# aws-nginx-ingress

![Version: 1.375.0](https://img.shields.io/badge/Version-1.375.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

aws-nginx-ingress

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://692859913461.dkr.ecr.us-east-2.amazonaws.com | cs-k8s-infra | 1.180.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| DOCKER_REGISTRY_PLACEHOLDER | string | `"692859913461.dkr.ecr.us-east-2.amazonaws.com"` |  |
| cs-k8s-infra.maveriq-dns-chart.enabled | bool | `false` |  |
| cs-k8s-infra.multus-chart.enabled | bool | `false` |  |
| cs-k8s-infra.persistence-volume-provisioner-chart.enabled | bool | `false` |  |
| cs-k8s-infra.radcom-crds-chart.enabled | bool | `false` |  |
| cs-k8s-infra.radcom-ingress-nginx-chart.enabled | bool | `false` |  |
| shared-templates.add_blueprint | bool | `true` |  |

