# local-path-provisioner

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for local-path-provisioner

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.rancher.io | local-path-provisioner | 0.0.32 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| helperImage.repository | string | `"nexus3-prod.radcom.co.il:8084/busybox"` |  |
| helperImage.tag | string | `"latest"` |  |

