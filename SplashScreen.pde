public class SplashScreen implements IScene {

  private PImage menuImage;
  private int timerTick = 0;
  


  public void render() {
    
    image(menuImage, 0, 0);

    // After some certain interval move to another scene
    int millis = millis();
    if( millis >= timerTick){
        InstructionScene scene = new InstructionScene();
        sceneManager.setScene(scene);
    }
  }

  public void load() {
    // Load the image asset for the menu page
    loop();
    timerTick = millis() * 3;
    menuImage = loadImage("assets/ui/splash.jpg");
    bootPlayer.play();
  
  }

  public void unload() {
    //Unload the image
    menuImage = null;
  }

  public void addTuioObjectHook(TuioObject tobj) {
    
  }

  public void removeTuioObjectHook(TuioObject tobj) {
  }

  //an object was moved on the table surface
  public void updateTuioObjectHook(TuioObject tobj) {
  }

  //this is called when a new cursor is detected
  public void addTuioCursorHook(TuioCursor tcur) {
  }

  //a cursor was removed from the table
  public void removeTuioCursorHook(TuioCursor tcur) {
  }

  public void updateTuioCursorHook(TuioCursor tcur) {
  }

  public void addTuioBlobHook(TuioBlob tblb) {
  }

  public void updateTuioBlobHook(TuioBlob tblb) {
  }

  public void removeTuioBlobHook(TuioBlob tblb) {
  }

  public void refreshHook(TuioTime frameTime) {
  }
}
