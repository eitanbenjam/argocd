#!/bin/bash
name=$1
PVC=${name}-rootdisk
NAMESPACE=default

cat <<EOF | kubectl create -n $NAMESPACE -f -
apiVersion: v1
kind: Pod
metadata:
  name: consumer-$PVC
spec:
  volumes:
    - name: pod1-storage
      persistentVolumeClaim:
        claimName: $PVC
  containers:
  - name: test-pod-container
    image: busybox
    command: ['sh', '-c', 'echo "Will bind the pvc!" ']
    volumeMounts:
      - mountPath: /disk
        name: pod1-storage
EOF
sleep 1
kubectl delete pod consumer-$PVC -n $NAMESPACE

