public class SQLEditor implements IScene { //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  // Markers
  private final int MARKER_RUN_SQL_EXECUTE = 5;
  // Declare values for the Settings of the UI
  private final float HEADER_HEIGHT = 62;
  private final float HEADER_TOP_PADDING = HEADER_HEIGHT / 2;
  private final float HEADER_LEFT_PADDING = 20;
  private final float BUTTON_WIDTH = 180;
  private final float BUTTON_HEIGHT = 46;
  private final float RUNBUTTON_PADDING_RIGHT_OFFSET = BUTTON_WIDTH + 20; // Extra 50 margin
  private final float BORDER_RADIUS = 5;
  private final float CODE_EDITOR_Y_OFFSET = HEADER_HEIGHT + 2; // the 2 px will be used to render a rect to serve as a border for the header section
  private final float MARGIN_BETWEEN_SCREEN = width; // Each distance between the screens will be 50
  private final float CODE_TEXT_SIZE = 14;
  private final float CODE_EDITOR_PADDING_LEFT = 40;
  private final float CODE_EDITOR_PADDING_TOP = CODE_EDITOR_Y_OFFSET + 30 + CODE_TEXT_SIZE;
  private final float CODE_EDITOR_TEXTZONE = MARGIN_BETWEEN_SCREEN;
  private final float DISTANCE_BETWEEN_ERD = 70;
  private final float ERD_UI_WIDTH = 150;
  private final float ERD_FONT_SIZE = 13;

  private final float CODE_STATUS_OFFSET_Y = height;
  private final float CODE_STATUS_HEIGHT = 50;
  public ModalWindow modal;
  private CodeItem previousItem;
  private AudioPlayer fanFareSong;
  private AudioPlayer errorSong;
  private String errorMessageText;


  // Declare states for the Application depending on the state determines the what to render
  private boolean shouldRenderStatusBar = false;
  private boolean isSuccessful = false;

  public String codeText = "";
  private int shouldElapse = 0;


  public SQLEditor() {
    modal = new ModalWindow();
    modal.shouldRender = true;
  }

  public void render() {
    renderHeader();
    image(pg, 0, 0);
  }

  public void load() {
    musicPlayer = minim.loadFile(sketchPath("assets/audio/")+"2.mp3");
    musicPlayer.loop();
    // Load the Success sound to tbe played
    fanFareSong = minim.loadFile("assets/audio/fanfare.mp3");
    errorSong = minim.loadFile("assets/audio/error.mp3");
  } 
 //<>//
  public void unload() { //<>//
    //Unload the image
  }

  public void addTuioObjectHook(TuioObject tobj) {
    int fudicialMarkerDisplayed = tobj.getSymbolID(); 

    if (!isSuccessful) {

      if ( fudicialMarkerDisplayed != MARKER_RUN_SQL_EXECUTE) {
        CodeItem item = codeDataSource.getTextById(fudicialMarkerDisplayed);
        if (item != null) {
          previousItem = item;
          codeText = item.getCodeText();
        }
      } else {
        // Execute the statement
        try {
          int result;
          println("Execution Query");
          if (previousItem.getIsDummy()) {
            result = 1;
            println("Dummy Data");
          } else {
            result = sqlservice.execute(codeText);
          }

          if (result == 1) {
            isSuccessful = true;
            shouldElapse = millis() * 8; // 15 Seconds
            modal.setData("Query Successful", previousItem.getNextMarkerText());
            modal.display(true);
            fanFareSong.play();
          }
        }
        catch(SQLException e) {
          shouldRenderStatusBar = true;
          errorMessageText = e.getMessage();
          errorSong.play();
          println(e.getMessage());
        }
      }
    }

    if (isWaitingForNextMarker()) {
      // We need to check for the last previous Marker
      int newMarkerSymbol = previousItem.getNextSymbolId();
      if (newMarkerSymbol != fudicialMarkerDisplayed)
      {
        println("Wrong Marker Displayed");
      } else {
        boolean isFinalScene = previousItem.getFinalScene();
        if (isFinalScene) {  
          FinalScene finalScene = new FinalScene();
          sceneManager.setScene(finalScene);
        } else {
          clearScreen(); // Clears the screen
        }
      }
    }
  }

  public void clearScreen() {
    codeText="";
    isSuccessful = false;
    modal.hide();
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

    if (isSuccessful) {
      renderStatusBar("success", "The Query has been executed successfully");
    }

    if (modal.shouldRender) {
      modal.show();
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
    pg.text("Run with ID 5", offset + 20, HEADER_TOP_PADDING + (BUTTON_HEIGHT - 40));
    pg.endDraw();
  }

  private boolean isWaitingForNextMarker() {
    return (modal.shouldRender && isSuccessful);
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

class ModalWindow {
  public boolean shouldRender = false; // makes the class not to render depending on the state
  private String title = "";
  private String message = "";
  private final int HEADER_HEIGHT = 62;
  private final int CODE_EDITOR_Y_OFFSET = HEADER_HEIGHT + 2; 


  public ModalWindow() {
  }

  public void setData(String title, String message) {
    this.title = title;
    this.message = message;
  }

  public String getTitle() {
    return title;
  }

  public String getMessage() {
    return message;
  }

  public void display(boolean mode) {
    shouldRender = mode;
  }

  public void show() {
 
      int xOffset = (width) - 400;
      int yOffset = CODE_EDITOR_Y_OFFSET;
      pg.beginDraw();
      pg.fill(colors.WHITISH);
      pg.rect(xOffset, yOffset, 400, height, 0);
      pg.fill(colors.BLACK);
      pg.textSize(32);
      pg.text(title, xOffset + 20, yOffset + 30, 400, 400);
      pg.textSize(14);
      pg.text(message, xOffset + 25, yOffset + 105, 400-50, 400);
      pg.endDraw();
    
  }



  public void hide() {
    shouldRender = false;
  }
}
