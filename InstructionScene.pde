public class InstructionScene implements IScene {

  private final int SQL_EDITOR_SCENE_MARKER = 1;

  private PImage menuImage;

  public void render() {
    image(menuImage, 0, 0);
      
  }

  public void load() {

    // Load the image asset for the menu page
    menuImage = loadImage("assets/ui/screen1.jpg");
  }

  public void unload() {
  }

  public void addTuioObjectHook(TuioObject tobj) {

    int fudicialMarkerDisplayed = tobj.getSymbolID();
    if (fudicialMarkerDisplayed == SQL_EDITOR_SCENE_MARKER) {
      // Use the SceneManager to Change scene we can use here since this is all a PApplet
      SQLEditor sqlScene = new SQLEditor();
      sceneManager.setScene(sqlScene);
    }
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
