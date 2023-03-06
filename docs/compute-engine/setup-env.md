# Setup the Google Cloud Platform environment

In order to deploy on Google Cloud, we can create an account for free and benefit from $300 of credit usable for 3 months.

To do so, go to [cloud.google.com](https://cloud.google.com/), click on the "Get started for free" button and create an account.

Once you have signed up, you need to create a new project.

Notes:

* Project names are *globally unique* -- no one else can have the same project name as you.
* We're going to be referring to this name as `PROJECT_ID`.
* Each project must be linked to a billing account, so you must have a valid one.

---

In this tutorial, we will use [Cloud shell](https://cloud.google.com/shell) for simplicity.

Click "Activate Cloud Shell" button at the top of the Google Cloud console.

Next, we need to set our project ID in both the command-line and as an environment variable.

```shell
export PROJECT_ID=YourProjectID
gcloud config set project $PROJECT_ID
```
*where `YourProjectID` represents the unique id of your project*

Then we clone our project in our `$HOME`:

```shell
git clone https://github.com/7sinStone/symfony-demo-gcp.git
```
---

The next step is to enable all necessary APIs:

- [Cloud Resource Manager](https://cloud.google.com/resource-manager)
- [Cloud SQL](https://cloud.google.com/sql)
- [Private service access](https://cloud.google.com/vpc/docs/private-services-access)

To do so, type the following commands:

```shell
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable servicenetworking.googleapis.com
```
---
Next step: [Provision the infrastructure using Terraform](terrafrom-provisioning.md) 