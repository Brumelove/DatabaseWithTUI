public class MenuScene implements IScene {

  private PImage menuImage;
  
  private final int INSTRUCTION_PAGE_MARKER = 0;
  private final int SQL_EDITOR_SCENE_MARKER = 1; // Replace this with the Blue Marker

  public void render() {
    image(menuImage, 0, 0);
  }

  public void load() {
    // Load the image asset for the menu page
    menuImage = loadImage("assets/ui/main-menu.jpg");
  }

  public void unload() {
    //Unload the image
    menuImage = null;
  }

  public void addTuioObjectHook(TuioObject tobj) {
    int fudicialMarkerDisplayed = tobj.getSymbolID();
    if(fudicialMarkerDisplayed == INSTRUCTION_PAGE_MARKER){
        // Use the SceneManager to Change scene we can use here since this is all a PApplet
        InstructionScene scene = new InstructionScene();
        sceneManager.setScene(scene);
    }

    if(fudicialMarkerDisplayed == SQL_EDITOR_SCENE_MARKER){
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
