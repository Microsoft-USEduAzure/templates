#load "..\shared\pocoTypes.csx"

using System;
using System.IO;

public static void Run(Stream fastQZipBlob, string barcodeId, string fileId, out fastQFile outputQueueItem, out fastQFile outputQueueItemWithError, TraceWriter log)
{
  
    outputQueueItem = null;
    outputQueueItemWithError = null;

    try
    {        
        outputQueueItem = new fastQFile() { fileId = fileId, barcodeId = barcodeId };
    }
    catch (Exception ex)
    {

        outputQueueItemWithError = new fastQFile() { fileId = fileId ?? "", barcodeId = barcodeId ?? "", errorMessage = ex.Message };        
    }
    
   
}
 
