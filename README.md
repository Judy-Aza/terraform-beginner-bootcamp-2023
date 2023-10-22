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