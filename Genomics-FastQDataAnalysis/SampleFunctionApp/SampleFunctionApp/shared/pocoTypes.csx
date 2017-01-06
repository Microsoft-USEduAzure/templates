
public class fastQFile
{
    public string fileId { get; set; }
    public string barcodeId { get; set; }
    public string errorMessage { get; set; }
    
    public fastQFile()
    {
        fileId = "";
        barcodeId = "";
        errorMessage = "";
    }

    public override String ToString()
    {
        return  "\n{" +
                "\n\t fileId : " + fileId +
                "\n\t barcodeId : " + barcodeId +
                "\n\t errorMessage : " + errorMessage +
                "\n}";
    }
    
}

