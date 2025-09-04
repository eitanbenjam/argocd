# openebs

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for openebs.

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://openebs.github.io/openebs | openebs(openebs) | 4.3.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | `false` |  |
| openebs.engines.local.lvm.enabled | bool | `true` |  |
| openebs.engines.local.zfs.enabled | bool | `false` |  |
| openebs.engines.replicated.mayastor.enabled | bool | `false` |  |
| openebs.localpv-provisioner.hostpathClass.isDefaultClass | bool | `true` |  |
| openebs.localpv-provisioner.hostpathClass.reclaimPolicy | string | `"Retain"` |  |
| openebs.localpv-provisioner.localpv.basePath | string | `"/var/lib/k0s/openebs/local"` |  |
| openebs.localpv-provisioner.rbac.create | bool | `true` |  |
| openebs.lvm-localpv.crds.csi.volumeSnapshots.enabled | bool | `false` |  |
| openebs.lvm-localpv.crds.lvmLocalPv.enabled | bool | `true` |  |
| openebs.lvm-localpv.enabled | bool | `true` |  |
| openebs.mayastor.crds.enabled | bool | `false` |  |
| openebs.mayastor.csi.node.initContainers.enabled | bool | `true` |  |
| openebs.mayastor.enabled | bool | `true` |  |
| openebs.mayastor.localpv-provisioner.enabled | bool | `false` |  |
| openebs.openebs-crds.csi.volumeSnapshots.enabled | bool | `true` |  |
| openebs.openebs-crds.csi.volumeSnapshots.keep | bool | `true` |  |
| openebs.preUpgradeHook | object | `{"image":{"pullPolicy":"IfNotPresent","registry":"docker.io","repo":"bitnami/kubectl","tag":"1.25.15"}}` | Configuration options for pre-upgrade helm hook job. |
| openebs.preUpgradeHook.image.pullPolicy | string | `"IfNotPresent"` | The imagePullPolicy for the container |
| openebs.preUpgradeHook.image.registry | string | `"docker.io"` | The container image registry URL for the hook job |
| openebs.preUpgradeHook.image.repo | string | `"bitnami/kubectl"` | The container repository for the hook job |
| openebs.preUpgradeHook.image.tag | string | `"1.25.15"` | The container image tag for the hook job |
| openebs.release | string | `nil` |  |
| openebs.zfs-localpv.crds.csi.volumeSnapshots.enabled | bool | `false` |  |
| openebs.zfs-localpv.crds.zfsLocalPv.enabled | bool | `true` |  |
| openebs.zfs-localpv.enabled | bool | `true` |  |

