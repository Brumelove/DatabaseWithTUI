public class SQLEditor implements IScene {

  private final int HEADER_HEIGHT = 62;
  private final int HEADER_TOP_PADDING = HEADER_HEIGHT / 2;
  private final int HEADER_LEFT_PADDING = 20;

  public SQLEditor() {
  }

  public void render() {
    renderHeader();
    image(graphicsContext, 0, 0);
  }

  public void load() {
  }

  public void unload() {
    //Unload the image
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

  public void renderHeader() {
    graphicsContext.beginDraw();
    //Let's draw the reactangle first
    graphicsContext.noStroke();
    graphicsContext.fill(colors.WHITE);
    graphicsContext.rect(0, 0, width, HEADER_HEIGHT); 
    graphicsContext.endDraw();
    renderHeaderTitle();
  }

  public void renderHeaderTitle() {
    // Calculate the Y Offset and give padding
    graphicsContext.beginDraw();
    // Write text offset to the padding top
    graphicsContext.textSize(20);
    graphicsContext.fill(colors.BLACK);
    graphicsContext.text("SQL Editor", HEADER_LEFT_PADDING, HEADER_TOP_PADDING);
    graphicsContext.endDraw();
  }
}
