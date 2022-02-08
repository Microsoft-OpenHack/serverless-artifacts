# Development Environment Configuration

Please ensure your machine conforms to these prerequisites.

* A modern laptop running Windows 10, Mac OSX 10.12 or
higher, or one of
[these Ubuntu versions](https://github.com/Azure/azure-functions-core-tools#linux)

* Your preferred IDE (integrated development environments), like
Visual Studio Code or Visual Studio:
    * If using Visual Studio for Windows, make sure you have the
  [latest Visual Studio version](https://visualstudio.microsoft.com/)
  with the `Azure development` option selected.

    * If using Visual Studio Code in Windows, OSX, or Linux make sure you
  have the latest Visual Studio Code version for your OS, and  

        * [VSCode Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)

        * [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local#v3) version 3x  

    * Optionally, you may just desire to get the Azure Tools extension, which includes functions and many other Azure resources

        * [Azure Tools VSCode Extensions](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack)

## Language specific prerequisites

Depending on the language your team uses, there are additional prerequisites that your machine will need to have. Please review these language specific prerequisites to ensure your machine is ready for the open hack.

### C# .NET Core

* Either [Visual Studio](https://visualstudio.microsoft.com/)

or

* [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).  

    * Use of the Visual Studio Code [C# Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) is recommended.

    * [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local#v3) version 3x

> .Net 6.0 with Azure Functions v4 has not been validated for these OpenHack challenges (and are currently not available for Azure functions v3). Please use Azure Functions v3 and .NET 3.1. Refer to [supported languages](https://docs.microsoft.com/azure/azure-functions/supported-languages) to determine when .Net 6.0 and Azure functions v4 are no longer in preview state.  At that time, you may choose to attempt the exercises in Functions v4 and .Net 6.

### Java/Maven

* [Java Developer Kit](https://aka.ms/azure-jdks) version 8
* [Apache Maven](https://maven.apache.org/) version 3.0 or later
* [Azure CLI](https://docs.microsoft.com/cli/azure)
* [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local#v3) version 3.x

> Refer to [Azure Functions Java Developer guide](https://docs.microsoft.com/azure/azure-functions/functions-reference-java) for latest version support information

### JavaScript

* [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms)
* [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local#v3) version 3x
* [Node.js](https://nodejs.org/) Active LTS and Maintenance LTS versions (8.11.1 and 10.14.1 recommended)

> Refer to [Azure Function Supported Languages](https://docs.microsoft.com/azure/azure-functions/functions-reference-java) for further Node supported version information

### Python  

#### Previous Versions  

If you have 3.6.x or 3.7.x you **should** have no issues with those versions, just be certain to select the correct version when creating your function apps at Azure.  

#### Use a VM instead of multiple versions  

It is recommended you do not do a side-by-side installation of a new python version for this challenge.  To be clean and avoid potential issues, consider using a low-cost VM running Linux at Azure and install the latest python tools there.  

#### Use VSCode with the Azure Functions Extension  

It is very easy to work with VSCode with python functions at Azure.  Although you may be new to VSCode, it is recommended due to the high availability of extensions that can easily run (locally) and publish Azure functions to your integrated Azure subscription.  

* [Python 3.8.x](https://www.python.org/downloads/)  

    * Using VSCode with Azure Functions extension makes it easy to select the compiler. language, and project and integrate directly to your function app at Azure, including deployment.  

    * VS Code users on Windows, in the past, python interpreter selection can be troublesome. Review [Python in VS Code environments](https://code.visualstudio.com/docs/languages/python#_environments) for assistance with this if you run into issues.  

* [VSCode](https://code.visualstudio.com/download)  

* [VSCode Azure Functions extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)  

* [Azure Functions Core Tools](https://docs.microsoft.com/azure/azure-functions/functions-run-local#v3) version 3x.  You need this to run/test locally.  

* [Azure CLI](https://docs.microsoft.com/cli/azure)

* Recommended for Mac OSX and Linux users to install  [Azurite v2](https://www.nuget.org/packages/Azurite/)  

* [VSCode Azure Storage extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestorage)  

## Optional - Infrastructure as Code

Team members who are participating to learn how to support and manage "serverless" services in Azure should prepare their machines with:

* IDE of Choice
* Azure CLI
* Extensions or tooling required to support Azure deployments via ARM, Bicep, Terraform, etc.
