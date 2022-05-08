echo '-------Deploy RKE Snapshot Capabilities-------'
starttime=$(date +%s)
. ./setenv.sh

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.2.4/deploy/longhorn.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/release-4.0/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml
#kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/backupstores/minio-backupstore.yaml
kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/backupstores/nfs-backupstore.yaml
kubectl create -f ./longhorn-sc.yaml
kubectl create -f ./longhorn-vsc.yaml
kubectl wait --for=condition=ready --timeout=300s -n longhorn-system pod -l app=longhorn-ui
kubectl get settings.longhorn.io backup-target -n longhorn-system -o yaml > backup-target.settings.yaml
sed -e 's#value: ""#value: "nfs://longhorn-test-nfs-svc.default:/opt/backupstore"#g' backup-target.settings.yaml > new-backup-target.settings.yaml
kubectl replace -f new-backup-target.settings.yaml
kubectl annotate sc longhorn storageclass.kubernetes.io/is-default-class=true

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "" | awk '{print $1}'
echo "-------Total time for RKE deployment is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'