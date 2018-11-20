  import java.io.*;

  public class TuioCodeService {

    private final String filename = "code-dump.txt";
    private PrintWriter  printerWriter;
    
    public TuioCodeService(){
        // instantiate the Printer Writer
        printerWriter = createWriter(sketchPath("code/")+ filename);
    }

    public void write(String textCode){
        printerWriter.println(textCode);
    }

    public void save(){
        printerWriter.flush();
        printerWriter.close();
    }



}
