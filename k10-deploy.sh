if [ ! -f myecsip ]; then
  echo -n "-------Enter your node IP address and press [ENTER]: "
  read myecsip
  echo "" | awk '{print $1}'
  echo $myecsip > myecsip
fi

echo '-------Deploy Kasten K10 and Postgresql on RKE in 3 mins'
starttime=$(date +%s)
. ./setenv.sh
# MY_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
TEMP_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
FIRST2=$(echo -n $TEMP_PREFIX | head -c2)
LAST2=$(echo -n $TEMP_PREFIX | tail -c2)
MY_PREFIX=$(echo $FIRST2$LAST2)
echo $MY_BUCKET > rke_bucketname
# export KUBECONFIG=./rke4louisa.yml

echo '-------Install K10'
helm repo add kasten https://charts.kasten.io
helm repo update
kubectl create ns kasten-io
kubectl config set-context --current --namespace kasten-io

# kubectl annotate sc longhorn storageclass.kubernetes.io/is-default-class=true

#For Production, remove the lines ending with =1Gi from helm install
#For Production, remove the lines ending with airgap from helm install
helm install k10 kasten/k10 -n kasten-io \
  --set global.persistence.metering.size=1Gi \
  --set prometheus.server.persistentVolume.size=1Gi \
  --set global.persistence.catalog.size=1Gi \
  --set global.persistence.jobs.size=1Gi \
  --set global.persistence.logging.size=1Gi \
  --set global.persistence.grafana.size=1Gi \
  --set metering.mode=airgap

echo '-------Deploying a PostgreSQL database'
kubectl create namespace yong-postgresql
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace yong-postgresql postgres bitnami/postgresql --set primary.persistence.size=1Gi

echo '-------Output the Cluster ID'
clusterid=$(kubectl get namespace default -ojsonpath="{.metadata.uid}{'\n'}")
echo "" | awk '{print $1}' > rke_token
echo My Cluster ID is $clusterid >> rke_token

echo '-------Wait for 1 or 2 mins for the Web UI IP and token'
kubectl wait --for=condition=ready --timeout=300s -n kasten-io pod -l component=jobs

echo "#Change to NodePort"
kubectl patch svc gateway --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
nodeport=$(kubectl get svc gateway | grep -v NAME | awk '{print $5}' | sed -e 's/8000://' | sed -e 's/\/TCP//')

echo '-------Accessing K10 UI'
k10ui=http://$(cat myecsip):$(kubectl get svc gateway | grep -v NAME | awk '{print $5}' | sed -e 's/8000://' | sed -e 's/\/TCP//')/k10/# > rke_token
echo -e "\nCopy below token before clicking the link to log into K10 Web UI -->> $k10ui" >> rke_token
echo "" | awk '{print $1}' >> rke_token
sa_secret=$(kubectl get serviceaccount k10-k10 -o jsonpath="{.secrets[0].name}" --namespace kasten-io)
echo "Here is the token to login K10 Web UI" >> rke_token
echo "" | awk '{print $1}' >> rke_token
kubectl get secret $sa_secret --namespace kasten-io -ojsonpath="{.data.token}{'\n'}" | base64 --decode | awk '{print $1}' >> rke_token
echo "" | awk '{print $1}' >> rke_token

echo '-------Waiting for K10 services are up running in about 1 or 2 mins'
kubectl wait --for=condition=ready --timeout=300s -n kasten-io pod -l component=catalog

./oss-location.sh

./postgresql-policy.sh

# kubectl create -f ./eula.yaml

echo '-------Accessing K10 UI'
cat rke_token

endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time for K10+DB+Policy deployment is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'