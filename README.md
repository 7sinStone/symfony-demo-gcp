# Deploying Symfony Demo app to Google Cloud Plateform

## An example of deploying the symfony demo application on google cloud platform using terraform and other GCP components


This project is an example that shows how to deploy a symfony application on google cloud platform using:

* [Symfony 6.2 Demo application](https://github.com/symfony/demo) as an example project with a PostgreSQL database 
* [Docker](https://www.docker.com/) to containerize the application
* [Terraform](https://www.terraform.io/) for provisioning and managing the infrastructure used for application deployment
* [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine) as the hosting platform
* [Artifact Registry](https://cloud.google.com/artifact-registry) to store and manage our docker images

<p align="center">
  <img src="docs/screenshots/application_gif.gif" />
</p>


## Steps

Manual deployment:

1. [Setup the Google Cloud Plateform environment](docs/setup-gcp-env.md)
2. [Provision the infrastructure using Terraform](docs/terrafrom-provisioning.md) 
3. [Deploy the application](docs/gke-deploy.md)