# ztunnel

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for istio

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://istio-release.storage.googleapis.com/charts | ztunnel | 1.27.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| istio.cni.ambient.enabled | bool | `true` |  |
| istio.global.variant | string | `"distroless"` |  |
| istio.meshConfig.defaultConfig.proxyMetadata.ISTIO_META_ENABLE_HBONE | string | `"true"` |  |
| istio.pilot.env.PILOT_ENABLE_AMBIENT | string | `"true"` |  |

