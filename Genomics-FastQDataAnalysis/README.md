Data Analysis Solution for Genomics FastQ Sample Files
----------


----------


**Problem Statement**

 - Data Analysis - the most crucial step for DNA sequencing, demands
   tremendous amount of HPC power.
 - HPC combined with Big Data orchestrates and executes multiple Open
   Source tools per DNA sample.
 - Limited capacity of the required HPC infrastructure increases the per
   sample processing time
 - Reprocessing thousands of analyzed samples with new reference data
   becomes impossible due to such limitations

**Solution Architecture and Components**

![enter image description here](https://github.com/Microsoft-USEduAzure/templates/blob/master/Genomics-FastQDataAnalysis/solarch1.png?raw=true)
----------


"Azure Batch" as our High Performance Computing Solution:
---------------------------------------------------------

Azure Batch is a Platform as a Service offering  for running unlimited large-scale, parallel and HPC applications efficiently in the cloud.

Schedules compute-intensive work to run on a managed collection of virtual machines, and can automatically scale compute resources.

Combining Azure Batch with Azure Functions, Azure Data Lake and Power-BI can enable a single processing platform which offers:
   
 - Automated job submissions to reduce large manual efforts.
 
 - Auto scale HPC resources based on the FastQ samples submitted.
 
 - Versioning of reference data and reprocessing of the DNA samples with
   any version.
 
 - Historic and real-time aggregated analysis of the speed and cost of
   per sample.
 
 - End to end security and collaboration of proprietary research
   operations and data.

Sample Genomics Input and Reference Data
----------------------------------------
1. Download from [Here](https://github.com/Microsoft-USEduAzure/templates/tree/master/Genomics-FastQDataAnalysis/SampleInputDataAndScripts/processroot/input).

(**NOTE:** We used [1000 Genomics](http://www.internationalgenome.org/data) website to downloads sample FASTQ flow-cell Sample data files)

Linux BASH Scripts for Stage1 and Stage2 Processing
---------------------------------------------------

Steps to Deploy Required Resources in Azure
-------------------------------------------

**Option 1:  Direct Deployment from GitHub** 

Click to Preview Deployed Resources

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft-USEduAzure%2Ftemplates%2Fmaster%2FGenomics-FastQDataAnalysis%2FSampleDeploymentScript%2FAzureARMTemplate%2Ftemplate.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

OR

Click to Deploy using Microsoft Azure Portal 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft-USEduAzure%2Ftemplates%2Fmaster%2FGenomics-FastQDataAnalysis%2FSampleDeploymentScript%2FAzureARMTemplate%2Ftemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

**Option 2: Using Powershell Script**

1. Install Powershell for Azure from here.

3. Browse to https://github.com/Microsoft-USEduAzure/templates/tree/master/Genomics-FastQDataAnalysis/SampleDeploymentScript/AzureARMTemplate

4.  Download all scripts and configurations.

5.  Modify [parameters file](https://raw.githubusercontent.com/Microsoft-USEduAzure/templates/master/Genomics-FastQDataAnalysis/SampleDeploymentScript/AzureARMTemplate/parameters.json). 

6. Modify and Execute [PowerShell Script](https://raw.githubusercontent.com/Microsoft-USEduAzure/templates/master/Genomics-FastQDataAnalysis/SampleDeploymentScript/AzureARMTemplate/deploy.sh).



Steps to Download and Publish Sample Function App (Written in C#, working on NodeJS Version)
------------------------------------------------------------------------

1. Download Sample Function App from [here](https://github.com/Microsoft-USEduAzure/templates/tree/master/Genomics-FastQDataAnalysis/SampleFunctionApp).

2.  Open the solution inside Visual Studio 2015 Update 3 or later.

3.  Rename the Solution and Project name suitable for your needs.

4.  Publish to Azure App Service using Publish menu item by right clicking the Project inside Solution Explorer.

5.  **NOTE**: You need to modify Web Configuration Setting either using Azure Portal or by defining [appsettings.json](https://raw.githubusercontent.com/Microsoft-USEduAzure/templates/master/Genomics-FastQDataAnalysis/SampleFunctionApp/SampleFunctionApp/appsettings.json) file provided. You can define one storage account for Function App and Azure Batch processing by defining same connection string or keep them in separate storage accounts.

**(Web Configuration Settings to modify):**

"**AzureWebJobsStorage**": "DefaultEndpointsProtocol=https;AccountName=**YourAccount**;AccountKey=**YourKey**",
    
"**AzureWebJobsDashboard**": "DefaultEndpointsProtocol=https;AccountName=**YourAccount**;AccountKey=YourKey",

"**StorageAccountMain**": "DefaultEndpointsProtocol=https;AccountName=YourAccount;AccountKey=**YourKey**",
    
"**BatchAccountName**": "YourBatchAccount",
"**BatchAccountURL**": "YourBatchAccountURL",
"**BatchAccountKey**": "YourBatchAccountKey"



----------

> Written with [StackEdit](https://stackedit.io/).
