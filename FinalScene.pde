public class FinalScene implements IScene {

  private final float CODE_EDITOR_Y_OFFSET = 50; // the 2 px will be used to render a rect to serve as a border for the header section
  private final float MARGIN_BETWEEN_SCREEN = 0; // Each distance between the screens will be 50
  private final float CODE_TEXT_SIZE = 14;

  private final float DISTANCE_BETWEEN_ERD = 70;
  private final float ERD_UI_WIDTH = 150;
  private final float ERD_FONT_SIZE = 13;

  private final int SQL_EDITOR_SCENE_MARKER = 1;

  public void render() {
    clear();
    renderERD();
    image(pg, 0, 0);
  }

  public void renderERD() {
    pg.beginDraw();
    pg.background(colors.GREEN);
    pg.clear();
    pg.endDraw();
    
    int indexCount = 0;
    //Iterate all over the diagram and draw
    Iterator<TableObject> iterator = tableManager.tableArray.iterator();
    while (iterator.hasNext()) {
      TableObject tableObjectRenderable = iterator.next();
      int sizeofColumns = tableObjectRenderable.columnNames.size();
      renderSingleErd(tableObjectRenderable, indexCount, sizeofColumns);
      indexCount++; // Increment count
    }

  }



  public void renderSingleErd(TableObject table, int index, int noOfColumns) {
    pg.beginDraw();
    
    float calculatedHeight = (noOfColumns * 25) + 45;
    float xOffset = ((index * ERD_UI_WIDTH)) + (index == 0 ? DISTANCE_BETWEEN_ERD / 2 : index * DISTANCE_BETWEEN_ERD);
    float yOffset = CODE_EDITOR_Y_OFFSET + 30;
    pg.fill(colors.WHITISH);
    pg.textSize(ERD_FONT_SIZE);

    // Render the ERD BOX
    pg.rect( xOffset, yOffset, ERD_UI_WIDTH, calculatedHeight, 5);
    pg.fill(colors.BLACK);

    // Render the ERD Tabe Name and Line
    pg.text(table.getName(), xOffset + 20, yOffset + 22.5);
    pg.line(xOffset, yOffset + 35, xOffset + ERD_UI_WIDTH, yOffset + 35);

    // Render the Column names
    int columnCount = 1;
    Iterator columnIterator = table.columnNames.iterator();
    while (columnIterator.hasNext()) {
      float columnOffsetY = (yOffset + (columnCount * 25) + 30);
      String columnName = (String) columnIterator.next();
      if (table.hasFK() && table.isFK(columnName)) {
        pg.text(columnName + "- FK", xOffset + 15, columnOffsetY);
      } else {
        pg.text(columnName, xOffset + 15, columnOffsetY);
      }

      columnCount++;
    }
    pg.endDraw();
  }

  public void load() {
    try {

      sqlservice.readAllDatabase();
    }
    catch(SQLException e)
    {
      println(e.getMessage());
    }
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
