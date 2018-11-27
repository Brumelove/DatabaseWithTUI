public class InstructionScene implements IScene {

  private PImage menuImage;

  public void render() {
    image(menuImage,0,0);
    print(sceneManager);
  }

  public void load() {
    // Load the image asset for the menu page
    menuImage = loadImage("assets/ui/instruction.jpg");
  }

  public void unload() {
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
