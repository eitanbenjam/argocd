# radcom-base

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

radcom base template that create conductor service

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| add_default_sa_prometheus_permissions | bool | `true` |  |
| ingress.enabled | bool | `true` |  |
| ingress.service.annotations."metallb.universe.tf/address-pool" | string | `"openshiftpoc-ip-pools"` |  |
| ingress.service.externalTrafficPolicy | string | `"Local"` |  |
| ingress.service.type | string | `"LoadBalancer"` |  |

