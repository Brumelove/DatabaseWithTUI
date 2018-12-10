public class SQLEditor implements IScene {

  // Markers
  private final int MARKER_RUN_SQL_EXECUTE = 5;
  // Declare values for the Settings of the UI
  private final float HEADER_HEIGHT = 62;
  private final float HEADER_TOP_PADDING = HEADER_HEIGHT / 2;
  private final float HEADER_LEFT_PADDING = 20;
  private final float BUTTON_WIDTH = 76;
  private final float BUTTON_HEIGHT = 46;
  private final float RUNBUTTON_PADDING_RIGHT_OFFSET = BUTTON_WIDTH + 20; // Extra 50 margin
  private final float BORDER_RADIUS = 5;
  private final float CODE_EDITOR_Y_OFFSET = HEADER_HEIGHT + 2; // the 2 px will be used to render a rect to serve as a border for the header section
  private final float MARGIN_BETWEEN_SCREEN = (width / 2) - 25; // Each distance between the screens will be 50
  private final float CODE_TEXT_SIZE = 14;
  private final float CODE_EDITOR_PADDING_LEFT = 40;
  private final float CODE_EDITOR_PADDING_TOP = CODE_EDITOR_Y_OFFSET + 30 + CODE_TEXT_SIZE;
  private final float CODE_EDITOR_TEXTZONE = MARGIN_BETWEEN_SCREEN;

  private final float CODE_STATUS_OFFSET_Y = height;
  private final float CODE_STATUS_HEIGHT = 50;

  private String errorMessageText;


  // Declare states for the Application depending on the state determines the what to render
  private boolean shouldRenderStatusBar = false;
  private boolean isSuccessful = false;

  public String codeText = "";
  private int shouldElapse = 0;


  public SQLEditor() {
  }

  public void render() {
    renderHeader();
    image(pg, 0, 0);
  } //<>//

  public void load() { //<>//
  } //<>// //<>//

  public void unload() { //<>// //<>//
    //Unload the image
  } //<>//

  public void addTuioObjectHook(TuioObject tobj) { //<>//
    int millis = millis();
    if ( millis >= shouldElapse && isSuccessful) {
      shouldElapse = 0;
      isSuccessful = false;
    }
    if (!isSuccessful) {
      int fudicialMarkerDisplayed = tobj.getSymbolID(); 
      if ( fudicialMarkerDisplayed != MARKER_RUN_SQL_EXECUTE) {
        CodeItem item = codeDataSource.getTextById(fudicialMarkerDisplayed);
        if (item != null) {
          codeText = item.getCodeText();
        }
      } else {
        // Execute the statement
        try {
          println("Execution Query");
          int result = sqlservice.execute(codeText);
          if (result == 1) {
            isSuccessful = true;
            shouldElapse = millis() + 50000; // 50 Seconds 
          }
        }
        catch(SQLException e) {
          shouldRenderStatusBar = true;
          errorMessageText = e.getMessage();
          println(e.getMessage());
        }
      }

      // let's update the loop once
      redraw();
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

  public void renderHeader() {
    pg.beginDraw();
    //Let's draw the reactangle first
    pg.noStroke();
    pg.fill(colors.WHITE);
    pg.rect(0, 0, width, HEADER_HEIGHT); 
    pg.endDraw();

    pg.beginDraw();
    pg.fill(colors.WHITISH);
    pg.rect(0, HEADER_HEIGHT, width, 2 /*2px after Height of Header*/);
    pg.endDraw();

    renderHeaderTitle();
    renderRunButton();
    renderCodeEditor();
    if (shouldRenderStatusBar) {
      renderStatusBar("error", errorMessageText);
    }
    
    if(isSuccessful){
     renderStatusBar("success", "The Query has been executed successfully"); 
    }
  }

  public void renderHeaderTitle() {
    // Calculate the Y Offset and give padding
    pg.beginDraw();
    // Write text offset to the padding top
    font = createFont("Consolas", 20);
    pg.textFont(font);
    pg.fill(colors.BLACK);
    pg.text("SQL Editor", HEADER_LEFT_PADDING, HEADER_TOP_PADDING);
    pg.endDraw();
  }

  public void renderRunButton() {
    // Draw the button at the end of the width but make an offset
    pg.beginDraw();
    float offset = width - RUNBUTTON_PADDING_RIGHT_OFFSET;
    pg.noStroke();
    pg.fill(colors.GREEN);
    pg.rect(offset, HEADER_TOP_PADDING - (BUTTON_HEIGHT / 2), BUTTON_WIDTH, BUTTON_HEIGHT, BORDER_RADIUS);
    pg.endDraw();

    pg.beginDraw();
    pg.fill(colors.WHITE);
    font = createFont("Consolas", 19);
    pg.textFont(font);
    pg.text("Run", offset + 20, HEADER_TOP_PADDING + (BUTTON_HEIGHT - 40));
    pg.endDraw();
  }

  public void renderCodeEditor() {
    pg.beginDraw();
    // We need to render the box 
    pg.fill(colors.BLACK);
    pg.rect(0, CODE_EDITOR_Y_OFFSET, MARGIN_BETWEEN_SCREEN, (height - CODE_EDITOR_Y_OFFSET));
    pg.endDraw();

    pg.beginDraw();
    font = createFont("Consolas", 14);
    pg.textFont(font);
    // Draw the text
    pg.fill(colors.WHITE);
    pg.text(codeText, CODE_EDITOR_PADDING_LEFT, CODE_EDITOR_PADDING_TOP, MARGIN_BETWEEN_SCREEN - 10, (height - CODE_EDITOR_Y_OFFSET));
    pg.endDraw();
  }

  public void renderStatusBar(String statusType, String message) {

    pg.beginDraw();

    if (statusType.equals("success")) {
      pg.fill(colors.BLUE);
    }

    if (statusType.equals("error")) {
      pg.fill(colors.RED);
    }

    pg.rect(0, (CODE_STATUS_OFFSET_Y - CODE_STATUS_HEIGHT), width, CODE_STATUS_HEIGHT);
    pg.fill(colors.WHITE);
    pg.text(message, 50, (CODE_STATUS_OFFSET_Y - CODE_STATUS_HEIGHT) + 30 );
    pg.endDraw();
  }
}
