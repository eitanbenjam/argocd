# monitoring-tools

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

monitoring-tools

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-monitoring-tools.application-authentication-chart.enabled | bool | `false` |  |
| cs-monitoring-tools.elasticsearch-chart.enabled | bool | `false` |  |
| cs-monitoring-tools.fluentd-chart.enabled | bool | `false` |  |
| cs-monitoring-tools.grafana-helm-chart.enabled | bool | `false` |  |
| cs-monitoring-tools.kibana-chart.enabled | bool | `true` |  |
| cs-monitoring-tools.prometheus-operator-chart."prometheus.prometheusSpec".retentionSize | string | `"12G"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator_on_post | bool | `false` |  |

