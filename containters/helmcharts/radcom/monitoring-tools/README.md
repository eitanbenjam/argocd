# monitoring-tools

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

monitoring-tools

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-monitoring-tools.grafana-helm-chart."grafana.ini".database.transaction_retries | string | `"10"` |  |
| cs-monitoring-tools.grafana-helm-chart."grafana.ini".dataproxy.timeout | string | `"120"` |  |
| cs-monitoring-tools.grafana-helm-chart.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| cs-monitoring-tools.prometheus-operator-chart."prometheus.prometheusSpec".retentionSize | string | `"12G"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `true` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `true` |  |
| shared-templates.wait_for_ace_orchestrator_on_post | bool | `false` |  |

