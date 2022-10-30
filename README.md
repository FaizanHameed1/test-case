# Deploying Rasa-X in k8s cluster on GCP using helm
Assuming Goodle Cloud CLI is pre configured
### 1) Login youR Google Cloud:
`gcloud auth login`

`gcloud auth list`
### 2) Checking Project:
To list project property

`gcloud config list project`
### 3) Selecting a specific project:
`gcloud config  set project {project_id}`

Replace project_id in the command with id of your project.
### 4) Setting zone:
`gcloud config set compute/zone {zone-name}`

Replace `zone-name` with your region/zone name i.e `us-central-a`
For further details check https://cloud.google.com/compute/docs/regions-zones
### 5) Creating K8S cluster:
`gcloud container clusters create cluster-name`

Replace cluster-name with your name of choice.
  
Checking created cluster
`gcloud container clusters list`

Note: Install kubectl if it is not installed
### 6) Installing helm:
`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`

`chmod 700 get_helm.sh`

`./get_helm.sh`

For more details https://helm.sh/docs/intro/install/
  
To check version
`helm version`
### 7) Creating namespace:
`kubectl create namespace {namespace_name}`

Replace namespace name with name accprding to your choice
### 8) Creating and configuring values.yml file:
`touch values.yml`

`code values.yml`

Copy paste the values.yml file from this github repo and save the file.
### 9) Adding rasa repo:
`helm repo add rasa-x https://rasahq.github.io/rasa-x-helm`
### 10) Deploy rasax:
`helm install --generate-name --namespace {namespace_name} --values values.yml rasa-x/rasa-x`

Remember to replace namespace name.
### 11) Checking pods and services:
`kubectl --namespace {namespace_name} get pods`
   
 # Setting up model tracker store

1) Get pods with ` kubectl get pods -n namespace-name`

2) Check which container/pod have models. Mostly it will be in rasax pod.

3) Open the shell inside the pod with command `kubectl --namespace namespace-name  exec --stdin --tty pod-name -- bash`
or with this command `kubectl exec -it pod-name --namespace rasax -- bash`

4)Install google cloud CLI inside pod. To download setup use `curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-407.0.0-linux-x86_64.tar.gz` command.

Extract the content of zipped file with this command.
`tar -xf google-cloud-cli-407.0.0-linux-x86.tar.gz`

To install use the command `./google-cloud-sdk/install.sh`

If you want more details visit the following link.
`https://cloud.google.com/sdk/docs/install`


5) Make a bucket in gcp storage. You can do this after going inside your google cloud plateform account. Further you can make sub folder inside the bucket. My sub folder name will be "models". 
Note: Point 6 & 7 is only for your better understanding purpose you can skip and go directly to point 8. In comming commands "models" is the name of sub folder inside bucket. Run the following command inside "model" folder directory in your pod.

6) Use `gsutil rsync models gs://rasax-models/models/` command for one time model upload in bucket.
Note: `gs://rasax-models/models/` is address of bucket/subfolder which will change according to every bucket name and its subfolder.To check this go in bucket name and in "configuratation" you can see gsutil url)

7) To update models in bucket  in evey 60 seconds use watch command like `watch -n 60 gsutil rsync models gs://rasax-models/models/`

8) To run the command in background detached mode `nohup watch -n 60 gsutil rsync models gs://rasax-models/models/`
Note: After running on background detach mode you can close your terminal (that you have run inside container/pod). The command will run in every 60 seconds and if there will be a new model inside folder it will automatically upload it inside bucket. 

  
