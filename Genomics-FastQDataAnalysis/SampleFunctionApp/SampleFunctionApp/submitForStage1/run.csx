#load "..\shared\pocoTypes.csx"

#r "Microsoft.WindowsAzure.Storage"

using System;
using System.Text;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.Azure.Batch;
using Microsoft.Azure.Batch.Auth;


public static async void Run(fastQFile myQueueItem, TraceWriter log)
{
    try
    {
        await submitForStage2(myQueueItem.barcodeId, myQueueItem.fileId);
    }
    catch (Exception)
    {
        
        throw;
    }
    
}

static async Task<string> submitForStage2(string barcodeId, string fileId)
{
    try
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(
            Environment.GetEnvironmentVariable("StorageAccountMain"));

        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

        CloudBlobContainer container = blobClient.GetContainerReference("processroot");

        BatchSharedKeyCredentials cred = new BatchSharedKeyCredentials(
            Environment.GetEnvironmentVariable("BatchAccountURL"), 
            Environment.GetEnvironmentVariable("BatchAccountName"), 
            Environment.GetEnvironmentVariable("BatchAccountKey"));

        BatchClient batchClient = BatchClient.Open(cred);

        CloudJob job = batchClient.JobOperations.CreateJob();
        job.PoolInformation = new PoolInformation { PoolId = "largemachinepool1" };

        string jobId = String.Format("jobId-{0}-{1}-{2}",
            DateTime.Now.ToString("yyyyMMdd-HHmmssff"),
            barcodeId,
            fileId);

        jobId = (jobId.Length > 64) ? jobId.Substring(0, 64) : jobId;

        string taskId = String.Format("taskId-{0}-{1}", 
            jobId, 
            DateTime.Now.ToString("HHmmssff"));
                
        taskId = (taskId.Length > 64) ? taskId.Substring(0, 64) : taskId;
        
        job.Id = jobId;
        
        job.OnAllTasksComplete = Microsoft.Azure.Batch.Common.OnAllTasksComplete.TerminateJob;

        CloudBlockBlob blobData;

        SharedAccessBlobPolicy sasConstraints = new SharedAccessBlobPolicy
        {
            SharedAccessExpiryTime = DateTime.UtcNow.AddHours(2),
            Permissions = SharedAccessBlobPermissions.Read
        };

        List<string> resourceFilePaths = new List<string>()
                    {
                        "input/"+barcodeId+"/"+fileId+"_1_fastq.gz",
                        "input/"+barcodeId+"/"+fileId+"_2_fastq.gz",
                        "scripts/script_stage1.sh",
                        "scripts/script_azcopy.py"
                    };

        List<ResourceFile> listResourceFiles = new List<ResourceFile>();

        foreach (string resourceFielPath in resourceFilePaths)
        {
            string fileName = Path.GetFileName(resourceFielPath);
            string filePath = Path.GetDirectoryName(resourceFielPath);

            blobData = container.GetDirectoryReference(filePath).GetBlockBlobReference(fileName);
            string sasBlobToken = blobData.GetSharedAccessSignature(sasConstraints);
            string blobSasUri = String.Format("{0}{1}", blobData.Uri, sasBlobToken);

            listResourceFiles.Add(new ResourceFile(blobSasUri.Replace("%5C", "/"), fileName));
        };

        sasConstraints = new SharedAccessBlobPolicy
        {
            SharedAccessExpiryTime = DateTime.UtcNow.AddHours(2),
            Permissions = SharedAccessBlobPermissions.Write
        };

        string sasContainerToken = container.GetSharedAccessSignature(sasConstraints);

        StringBuilder command = new StringBuilder("");
        command.Append(String.Format("/bin/bash -c \" ./script_stage1.sh '{0}' '{1}' '{2}' '{3}' '{4}' '{5}' \" ",
            fileId + "_1_fastq.gz",
            fileId + "_2_fastq.gz",
            "uncpoc",
            "processroot",
            sasContainerToken.Remove(0, 1), //remove ? mark in the begining
            barcodeId
            ));

        CloudTask cloudTask = new CloudTask(taskId, command.ToString());
        cloudTask.ResourceFiles = listResourceFiles;

        List<CloudTask> cloudTasks = new List<CloudTask>();
        cloudTasks.Add(cloudTask);

        await job.CommitAsync();
        batchClient.JobOperations.AddTask(job.Id, cloudTask);

        return "ok";
    }
    catch (Exception ex)
    {

        return ex.Message;
    }

}

