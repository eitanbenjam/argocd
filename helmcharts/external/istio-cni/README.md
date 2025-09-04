# istio-cni

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for istio-cni

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://istio-release.storage.googleapis.com/charts | istio/cni | 1.24.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| istio-cni.cni.ambient.enabled | bool | `true` |  |
| istio-cni.cni.logLevel | string | `"info"` |  |
| istio-cni.cni.privileged | bool | `true` |  |

