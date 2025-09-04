# argocd-metrics-server

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Argocd metrics server extension

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.christianhuth.de | argocd-metrics-server | 1.0.7 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| argocd-metrics-server.prometheus.namespace | string | `"observability"` |  |
| argocd-metrics-server.prometheus.service | string | `"http://mimir.radcom.co.il/prometheus"` |  |

