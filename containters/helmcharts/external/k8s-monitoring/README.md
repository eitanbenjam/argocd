# k8s-monitoring

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Grafana k8s monitoring

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | k8s-monitoring | 3.3.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| k8s-monitoring.alloy-logs.enabled | bool | `true` |  |
| k8s-monitoring.alloy-metrics.enabled | bool | `true` |  |
| k8s-monitoring.alloy-metrics.metrics.extraRelabelingRules | string | `"rule {\n  action = \"replace\"\n  source_labels = [\"__meta_kubernetes_pod_node_name\"]\n  target_label = \"node\"\n}\n# Add specific labeling for SNMP exporter metrics\nrule {\n  source_labels = [\"job\"]\n  regex = \"prometheus-snmp-exporter.*\"\n  target_label = \"monitoring_type\"\n  replacement = \"snmp\"\n}\nrule {\n  source_labels = [\"job\"]\n  regex = \"prometheus-snmp-exporter.*\"\n  target_label = \"infrastructure_component\"\n  replacement = \"hp_ilo\"\n}"` | Rule blocks to be added to the discovery.relabel component for all metric sources. See https://grafana.com/docs/agent/latest/flow/reference/components/discovery.relabel/#rule-block |
| k8s-monitoring.alloy-operator.crds.deployAlloyCRD | bool | `true` |  |
| k8s-monitoring.alloy-operator.crds.deployPodLogsCRD | bool | `true` |  |
| k8s-monitoring.alloy-operator.deploy | bool | `true` |  |
| k8s-monitoring.alloy-singleton.enabled | bool | `true` |  |
| k8s-monitoring.annotationAutodiscovery.annotations.metricsPath | string | `"prometheus.io/path"` |  |
| k8s-monitoring.annotationAutodiscovery.annotations.metricsPortNumber | string | `"prometheus.io/port"` |  |
| k8s-monitoring.annotationAutodiscovery.annotations.scrape | string | `"prometheus.io/scrape"` |  |
| k8s-monitoring.annotationAutodiscovery.enabled | bool | `true` |  |
| k8s-monitoring.autoInstrumentation.enabled | bool | `false` |  |
| k8s-monitoring.clusterEvents.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.cadvisor.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[0] | string | `"container_cpu_cfs_throttled_seconds_total"` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[1] | string | `"container_cpu_usage_seconds_total"` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[2] | string | `"container_memory_working_set_bytes"` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[3] | string | `"container_network_receive_errors_total"` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[4] | string | `"container_oom_events_total"` |  |
| k8s-monitoring.clusterMetrics.cadvisor.metricsTuning.includeMetrics[5] | string | `"machine_cpu_cores"` |  |
| k8s-monitoring.clusterMetrics.controlPlane.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.kepler.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricAnnotationsAllowList[0] | string | `"namespaces=[*]"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricLabelsAllowlist[0] | string | `"namespaces=[*]"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[0] | string | `"kube_deployment_status_replicas_unavailable"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[1] | string | `"kube_namespace_annotations"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[2] | string | `"kube_namespace_created"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[3] | string | `"kube_namespace_labels"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[4] | string | `"kube_node_labels"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[5] | string | `"kube_pod_container_resource_limits"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[6] | string | `"kube_pod_container_resource_requests"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[7] | string | `"kube_pod_container_status_restarts_total"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[8] | string | `"kube_pod_info"` |  |
| k8s-monitoring.clusterMetrics.kube-state-metrics.metricsTuning.includeMetrics[9] | string | `"kube_pod_status_qos_class"` |  |
| k8s-monitoring.clusterMetrics.kubelet.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[0] | string | `"kubelet_node_name"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[1] | string | `"kubelet_running_pod_count"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[2] | string | `"kubelet_runtime_operations_total"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[3] | string | `"kubelet_volume_stats_available_bytes"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[4] | string | `"kubelet_volume_stats_capacity_bytes"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[5] | string | `"kubelet_volume_stats_inodes"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[6] | string | `"kubelet_volume_stats_inodes_used"` |  |
| k8s-monitoring.clusterMetrics.kubelet.metricsTuning.includeMetrics[7] | string | `"kubelet_volume_stats_used_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[0] | string | `"node_boot_time_seconds"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[10] | string | `"node_filefd_maximum"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[11] | string | `"node_filesystem_avail_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[12] | string | `"node_filesystem_device_error"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[13] | string | `"node_filesystem_files"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[14] | string | `"node_filesystem_files_free"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[15] | string | `"node_filesystem_size_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[16] | string | `"node_intr_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[17] | string | `"node_load1"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[18] | string | `"node_load1"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[19] | string | `"node_load15"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[1] | string | `"node_context_switches_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[20] | string | `"node_load5"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[21] | string | `"node_memory_Buffers_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[22] | string | `"node_memory_Cached_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[23] | string | `"node_memory_MemFree_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[24] | string | `"node_memory_MemTotal_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[25] | string | `"node_memory_Slab_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[26] | string | `"node_memory_SReclaimable_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[27] | string | `"node_memory_SUnreclaim_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[28] | string | `"node_memory_SwapFree_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[29] | string | `"node_memory_SwapTotal_bytes"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[2] | string | `"node_cpu_core_throttles_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[30] | string | `"node_netstat_Tcp_CurrEstab"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[31] | string | `"node_network_receive_bytes_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[32] | string | `"node_network_receive_drop_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[33] | string | `"node_network_receive_errs_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[34] | string | `"node_network_receive_packets_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[35] | string | `"node_nf_conntrack_entries"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[36] | string | `"node_time_seconds"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[37] | string | `"node_timex_estimated_error_seconds"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[38] | string | `"node_timex_maxerror_seconds"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[39] | string | `"node_uname_info"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[3] | string | `"node_cpu_seconds_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[4] | string | `"node_disk_io_now"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[5] | string | `"node_disk_read_bytes_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[6] | string | `"node_disk_reads_completed_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[7] | string | `"node_disk_writes_completed_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[8] | string | `"node_disk_written_bytes_total"` |  |
| k8s-monitoring.clusterMetrics.node-exporter.metricsTuning.includeMetrics[9] | string | `"node_filefd_allocated"` |  |
| k8s-monitoring.clusterMetrics.opencost.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.opencost.metricsSource | string | `"custom"` |  |
| k8s-monitoring.clusterMetrics.opencost.opencost.prometheus.external.enabled | bool | `true` |  |
| k8s-monitoring.clusterMetrics.opencost.opencost.prometheus.external.url | string | `"http://mimir.radcom.co.il/prometheus"` |  |
| k8s-monitoring.clusterMetrics.windows-exporter.deploy | bool | `false` |  |
| k8s-monitoring.clusterMetrics.windows-exporter.enabled | bool | `false` |  |
| k8s-monitoring.destinations[0].name | string | `"hostedMetrics"` |  |
| k8s-monitoring.destinations[0].type | string | `"prometheus"` |  |
| k8s-monitoring.destinations[0].url | string | `"http://mimir.radcom.co.il/api/v1/push"` |  |
| k8s-monitoring.destinations[1].name | string | `"hostedLogs"` |  |
| k8s-monitoring.destinations[1].type | string | `"loki"` |  |
| k8s-monitoring.destinations[1].url | string | `"http://loki.radcom.co.il/loki/api/v1/push"` |  |
| k8s-monitoring.integrations.alloy.instances[0].labelSelectors."app.kubernetes.io/name" | string | `"alloy-metrics"` |  |
| k8s-monitoring.integrations.alloy.instances[0].name | string | `"alloy"` |  |
| k8s-monitoring.integrations.etcd.instances[0].labelSelectors."app.kubernetes.io/component" | string | `"etcd"` |  |
| k8s-monitoring.integrations.etcd.instances[0].name | string | `"k8s-controlplane-etcd"` |  |
| k8s-monitoring.integrations.loki.instances[0].labelSelectors."app.kubernetes.io/name" | string | `"loki"` |  |
| k8s-monitoring.integrations.loki.instances[0].logs.enabled | bool | `true` |  |
| k8s-monitoring.integrations.loki.instances[0].name | string | `"loki"` |  |
| k8s-monitoring.integrations.mimir.instances[0].labelSelectors."app.kubernetes.io/name" | string | `"mimir"` |  |
| k8s-monitoring.integrations.mimir.instances[0].logs.enabled | bool | `true` |  |
| k8s-monitoring.integrations.mimir.instances[0].name | string | `"mimir"` |  |
| k8s-monitoring.integrations.prometheus-snmp-exporter.instances[0].labelSelectors."app.kubernetes.io/name" | string | `"prometheus-snmp-exporter"` |  |
| k8s-monitoring.integrations.prometheus-snmp-exporter.instances[0].name | string | `"prometheus-snmp-exporter"` |  |
| k8s-monitoring.nodeLogs.enabled | bool | `true` |  |
| k8s-monitoring.podLogs.enabled | bool | `true` |  |
| k8s-monitoring.prometheusOperatorObjects.enabled | bool | `true` |  |
| k8s-monitoring.prometheusOperatorObjects.podMonitors.enabled | bool | `true` |  |
| k8s-monitoring.prometheusOperatorObjects.serviceMonitors.enabled | bool | `true` |  |

