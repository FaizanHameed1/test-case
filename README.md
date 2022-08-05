# test-case
# Setting up K8S cluster on google Cloud & running rasa-x inside cluster
Assuming Goodle Cloud CLI is pre configured
### 1) login you Google Cloud:
>>gcloud auth login
>>gcloud auth list
### 2) Checking Project:
To list project property
>> gcloud config list project
### 3) Selecting a specific project:
>> gcloud config  set project project_id
Replace project_id in the command with id of your project.
### 4) Setting zone:
>> gcloud config set compute/zone zone-name
Replace zone-name with your region/zone name i.e us-central-a
For further details check https://cloud.google.com/compute/docs/regions-zones
### 5) Creating K8S cluster:
>> gcloud container clusters create cluster-name
Replace cluster-name with your name of choice.
   
Checking created cluster
>> gcloud container clusters list
Note: Install kubectl if it is not installed
### 6) Installing helm:
>>curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3


>>chmod 700 get_helm.sh


>>./get_helm.sh

For more details https://helm.sh/docs/intro/install/
  
To check version
>> helm version
### 7) Creating namespace:
>> kubectl create namespace namespace_name
Replace namespace name with name accprding to your choice
### 8) Creating and configuring values.yml file:
>> touch values.yml


>> code values.yml
Copy paste the values.yml file from this github repo and save the file.
### 9) Adding rasa repo:
>> helm repo add rasa-x https://rasahq.github.io/rasa-x-helm
### 10) Deploy rasax:
>> helm install --generate_name --namespace namespace_name --values values.yml rasa-x/rasa-x
Remember to replace namespace name.
### 11) Checking pods and services:
>> kubectl --namespace namespace_name get pods
   
   >> kubectl --namespace namespace_name get pods
    
    
  
