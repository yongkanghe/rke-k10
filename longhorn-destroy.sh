echo '-------Destroy RKE Snapshot Capabilities-------'
starttime=$(date +%s)
. ./setenv.sh

kubectl delete -f ./longhorn-vsc.yaml
kubectl delete -f ./longhorn-sc.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl delete -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml
#kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/backupstores/minio-backupstore.yaml
kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/backupstores/nfs-backupstore.yaml
kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.2.4/deploy/longhorn.yaml

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time for K10+DB+Policy deployment is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'