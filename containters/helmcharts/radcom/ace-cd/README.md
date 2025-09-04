# ace-cd

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

ace-cd

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ace-cd.ace-cd-chart.ansible_check | bool | `false` |  |
| ace-cd.ace-cd-chart.create_log_pvc | bool | `true` |  |
| ace-cd.ace-cd-chart.image.helm_repository_tag | string | `"latest"` |  |
| ace-cd.ace-cd-chart.image.tag | string | `"1.156.0"` |  |
| ace-cd.ace-cd-chart.kuberiq_cluster_name | string | `"Kuberiq_reg"` |  |
| ace-cd.ace-cd-chart.kuberiq_type | string | `"kuberiq_cdf"` |  |
| ace-cd.ace-cd-chart.resources.limits.cpu | string | `"500m"` |  |
| ace-cd.ace-cd-chart.resources.limits.memory | string | `"512M"` |  |
| ace-cd.ace-cd-chart.source_control | string | `"configmap"` |  |
| rbac.create | bool | `true` |  |
| rbac.useClusterRole | bool | `true` |  |

