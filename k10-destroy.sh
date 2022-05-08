starttime=$(date +%s)
. ./setenv.sh
echo '-------Deleting Kasten K10 and Postgresql (typically in few mins)'
# MY_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
TEMP_PREFIX=$(echo $(whoami) | sed -e 's/\_//g' | sed -e 's/\.//g' | awk '{print tolower($0)}')
FIRST2=$(echo -n $TEMP_PREFIX | head -c2)
LAST2=$(echo -n $TEMP_PREFIX | tail -c2)
MY_PREFIX=$(echo $FIRST2$LAST2)
# export KUBECONFIG=./rke4louisa.yml

echo '-------Uninstalling postgresql and kasten'
helm uninstall postgres -n yong-postgresql
helm uninstall k10 -n kasten-io

kubectl delete ns yong-postgresql
kubectl delete ns kasten-io

echo '-------Deleting objects from the bucket'
ossutil64 -i $(cat aliaccess | head -1) -k $(cat aliaccess | tail -1) -e https://oss-$MY_REGION.aliyuncs.com rm oss://$(cat rke_bucketname)/ -r -f

echo '-------Deleting kubeconfig for this cluster'
#kubectl config delete-context $(kubectl config get-contexts | grep $MY_PREFIX-$MY_CLUSTER | awk '{print $2}')
echo "" | awk '{print $1}'
endtime=$(date +%s)
duration=$(( $endtime - $starttime ))
echo "-------Total time is $(($duration / 60)) minutes $(($duration % 60)) seconds."
echo "" | awk '{print $1}'
echo "-------Created by Yongkang"
echo "-------Email me if any suggestions or issues he@yongkang.cloud"
echo "" | awk '{print $1}'