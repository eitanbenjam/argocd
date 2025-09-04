# external-dns

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for external dns

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-sigs.github.io/external-dns/ | external-dns | 1.18.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| external-dns.provider.name | string | `"coredns"` |  |

