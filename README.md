#### Follow [@YongkangHe](https://twitter.com/yongkanghe) on Twitter, Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

I just want to build an RKE Cluster (Rancher Kubernetes Engine) to play with the various Data Management capabilities e.g. Backup/Restore, Disaster Recovery and Application Mobility. 

It is challenging to create an RKE cluster from Alibaba Cloud if you are not familiar to it. After the RKE Cluster is up running, we still need to install Kasten, create a sample DB, create policies etc.. The whole process is not that simple.

![image](https://pbs.twimg.com/media/FHLSGL8VEAAUrZQ?format=png&name=900x900)

This script based automation allows you to build a ready-to-use Kasten K10 demo environment running on RKE in about 3 minutes. If you don't have an RKE Cluster, you can watch the Youtube video and follow the guide to build an RKE cluster on Alibaba Cloud. Once the RKE Cluster is up running, you can proceed to the next steps. 

#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Here Are the prerequisities. 

1. Go to Alibaba Cloud Shell
2. Verify if you can access the cluster via kubectl
````
kubectl get nodes
````
3. Clone the github repo, run below command
````
git clone https://github.com/yongkanghe/ack-k10.git
````
4. Install the tools and set Alibaba Cloud Access Credentials
````
cd ack-k10;./aliprep.sh
````
5. Optionally, you can customize the clustername, instance-type, zone, region, bucketname
````
vi setenv.sh
````
# To build the labs, run 
````
./k10-deploy.sh
````
1. Install Kasten K10
2. Deploy a Postgresql database
3. Create an Alicloud OSS location profile
4. Create a backup policy for Postgresql
5. Backup jobs scheduled automatically

# To delete the labs, run 
````
./k10-destroy.sh
````
1. Remove Postgresql database
2. Remove Kasten K10
3. Remove all the relevant snapshots
4. Remove the objects from the storage bucket

# Cick my photos to watch how-to videos.

# Backup Containers on RKE cluster
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Sa4_O9C3E_0/0.jpg)](https://wwww.youtube.com/watch?v=Sa4_O9C3E_0)

# Deploy a Rancher server
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/AO2LAMZV074/0.jpg)](https://www.youtube.com/watch?v=AO2LAMZV074)

# Build a RKE cluster
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Z2dLw0_NJ2o/0.jpg)](https://www.youtube.com/watch?v=Z2dLw0_NJ2o)

#### Subscribe [K8s Data Management](https://www.youtube.com/channel/UCm-sw1b23K-scoVSCDo30YQ?sub_confirmation=1) Youtube Channel

# Kasten - No. 1 Kubernetes Backup
https://kasten.io 

# FREE Kubernetes Learning
https://learning.kasten.io 

# Kasten - DevOps tool of the month July 2021
http://k10.yongkang.cloud

# Contributors
#### Follow [Yongkang He](http://yongkang.cloud) on LinkedIn, Join [Kubernetes Data Management](https://www.linkedin.com/groups/13983251) LinkedIn Group

#### Follow [Louisa He](https://www.linkedin.com/in/louisahe/) on LinkedIn, Join [Kubernetes Data Management](https://lnkd.in/gZbwVMg5) Slack Channel

