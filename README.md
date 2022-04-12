# AWS Dev Environment
Develop on the go with AWS.

Being on the go but wanting to develop has it's challenges. This project aims to create a dev environment I can ssh into at all times.

---

## Setup

1. Install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

2. Clone the repository
```
git clone https://github.com/jonathansapp08/dev-env-aws.git
```

3. In AWS, create an IAM user. Have the Access Key ID and the Secret access key ready.

4. [Create AWS credentials profile](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_credentials_profiles.html). Here you will enter the info from the previous step


5. Update the bucket name in init/vars.tf

6. If using Windows update the path in dev/scripts/windows-ssh-config.tpl. The path should reflect where your .ssh folder is.

7. Create the backend
```
cd init/
terraform init
terraform apply -auto-generate
```

4. Create an ssh key (it is expected that you save it to ~/.ssh/)
```
ssh-keygen -t ed25519
```

5. Set your variables in dev/vars.tf

6. With the backend created and your variables set, deploy the infrastructure
```
cd dev/
terraform init
terraform apply -auto-generate
```

---

## Usage
Once the infrastructure is running, you are free to begin working! Now you will be able to ssh into an ec2 for dev work. There are many tools you can use to accomplish this but personally I am using the "Remote - SSH" plugin from VSCode.