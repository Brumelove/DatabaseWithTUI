/**
* @description DisplayService handles the messages to be display on the screen
**/
public class DisplayService {

    PFont pfont;
    public DisplayService(){
        pfont = createFont("Consolas", 32);
        textFont(pfont);
        textAlign(CENTER,TOP);
    }

    public void render(String text){
        text(text,height/2, width/2);
    }

}