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

**"Azure Batch" as our High Performance Computing Solution:**

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

**Steps to Deploy Required Resources in Azure**

Option 1: Direct Deployment from GitHub 

Click to Preview Deployed Resources

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft-USEduAzure%2Ftemplates%2Fmaster%2FGenomics-FastQDataAnalysis%2FSampleDeploymentScript%2FAzureARMTemplate%2Ftemplate.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

OR

Click to Deploy using Microsoft Azure Portal 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoft-USEduAzure%2Ftemplates%2Fmaster%2FGenomics-FastQDataAnalysis%2FSampleDeploymentScript%2FAzureARMTemplate%2Ftemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

Option 2: Using Powershell
1. Browse to https://github.com/Microsoft-USEduAzure/templates/tree/master/Genomics-FastQDataAnalysis/SampleDeploymentScript/AzureARMTemplate
2. 
> Written with [StackEdit](https://stackedit.io/).
