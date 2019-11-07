# Spring Function App

[![Build Status](https://dascholl.visualstudio.com/osdu/_apis/build/status/danielscholl.spring-function-app?branchName=master)](https://dascholl.visualstudio.com/osdu/_build/latest?definitionId=62&branchName=master)

Generate a new Functions project#
Once you've installed the Azure Functions extension, you can easily create a new project by:

## Generate a New Function App

1. Click Create New Project button on the FUNCTIONS Explorer within the Azure tab.
2. Select target folder.
3. Select Java the target language.
4. Fill in the parameters.

_or fire a command line_

```bash
RESOURCE_GROUP="<your_resource_group>"
APP_NAME="<your_function_app>"
APP_REGION="<location>"
GROUP_ID="com.function"
ARTIFACT_ID="<your_function_app>"
PACKAGE="com.function"

mvn archetype:generate -DarchetypeGroupId=com.microsoft.azure \
    -DarchetypeArtifactId=azure-functions-archetype \
    -DappName=$APP_NAME \
    -DappRegion=$APP_REGION  \
    -DresourceGroup=$RESOURCE_GROUP \
    -DgroupId=$GROUP_ID \
    -DartifactId=$RESOURCE_GROUP \
    -Dpackage=$PACKAGE \
    -DinteractiveMode=false

cd $RESOURCE_GROUP
```

## Deploy Function App to Azure

1. Click Deploy to Function App button on the FUNCTIONS Explorer within the Azure tab.
2. Select subscription.
3. Create new Function App in Azure.
4. Fill in the parameters.

_or fire a command line_

```bash
# Package the Application
mvn clean package

# Deploy to Azure
mvn azure-functions:deploy
```

_or deploy with [terraform](terraform/README.md)_


