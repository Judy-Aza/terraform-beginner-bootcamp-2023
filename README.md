# Terraform Beginner Bootcamp 2023

## Semantic Versioning :cloud:

This project is going to use Semantic Versioning for its tagging: 
[semver.org](https://semver.org/)

The general formata:

**MAJOR.MINOR.PATCH**, eg: `1.0.1`


- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Consideration with the terraform CLI changes

The Terraform CLI installation instructions have changed due to GPG keyring changes. So we needed to refer to the latest install CLI instructions  via Terrform Documentation and change the ecripting for intall. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux didtribution

This project is built against Ubuntu. 
Please consider checking your Linux Distribution and change according to your distributions needs.

[How to check os version in linux](https://unix.stackexchange.com/questions/88644/how-to-check-os-and-version-using-a-linux-command)


Example of checking OS version:
```sh

$ cat /etc/*-release

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactioring into Bash Scripts

while fixing the Terraform CLI gpg deprecation issue, we noticed the bash script steps were a considerable amount more code. So we decided to create a bash to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli.sh)

- This will keep the gitpod Task File ([.gitpod.yml]*(.gitpod.yml)) tidy.
- This allow us an easier debug and execute manually Terraform CLI install.
- This will allow better portability for other project that need to install Terraform CLI.


#### Shebang considerations

A shebang tells the bash script what program that will interpret the script: eg `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- For partability for different os distributions
- Will search the user's Path for the bash executable.

#### Execution considerations

When executing the bash script we can use the `./` shortand notation to execute the bash script.

eg: `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a rogram to interpret it.

eg: `source ./bin/install_terraform_cli`

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```
we could also 

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, init, command)

we need to be carefull when using the init. Because it will not rerun if we start and existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

#### env command

We can list all environment varoiables using the `env` command

we can filter specific env vars using grep eg: `env | grep aws_`

#### Setting and unseting Env Vars

In the terminal we set using `export HELLO='world'`

In bthe terminal we unset using `unset HELLO`

We can set an env var temporaly when just running a command.

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg. 

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Env Vars

We can print an env var using echo eg: `echo $HELLO`

#### scoping of Env Vars

When you open a new bash terminals in VSCode, it will not be aware of env vars that you set in another window.

If you wnat Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profiles. eg: `.bash_profie`

#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO=world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this an only contain non-sensitive env vars. 

### AWS CLI installation

AWS CI is install for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[getting started install aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running rge following command

```sh
aws sts get-caller-identity
```
If it succesfful, you should see a json payload return that looks like this:

```json
{
    "UserId": "BICAZX23Y35Z7STB5BA3Y",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We will need ti generate AWS CLI credentials from IAM users in order to user AWS CLI.