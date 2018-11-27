import TUIO.*; //Tangible User Interface


TuioProcessing client;
TuioCodeService tuioCodeService;
CodeDataSource codeDataSource;
SceneManager sceneManager;
MenuScene menuScene;

void setup() {
  client=new TuioProcessing(this); //Instantiate the TUIO Client Library on this Application
  tuioCodeService = new TuioCodeService();
  codeDataSource = new CodeDataSource();
  sceneManager = new SceneManager();
  menuScene = new MenuScene();
  sceneManager.setScene(menuScene);
  codeDataSource.parse();
  size(800, 600);
}

void draw()
{
  background(100);
  sceneManager.activeScene().render();
  noLoop();  // Wasteful method as our application is mostly static
}

void addTuioObject(TuioObject tobj) {
  //println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  // When a TUIO is add display the text
  sceneManager.activeScene().addTuioObjectHook(tobj);
}



// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  sceneManager.activeScene().updateTuioObjectHook(tobj);
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  sceneManager.activeScene().removeTuioObjectHook(tobj);
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  sceneManager.activeScene().addTuioCursorHook(tcur);
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  sceneManager.activeScene().updateTuioCursorHook(tcur);
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  sceneManager.activeScene().removeTuioCursorHook(tcur);
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  sceneManager.activeScene().addTuioBlobHook(tblb);
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
}
