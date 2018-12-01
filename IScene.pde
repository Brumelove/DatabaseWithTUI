/**
 * @description A Interface that ensure each Scene fulfills the contract
 **/
public interface IScene
{
  public void render(); // redraw everything on screen
  public void load(); // load all of the data and graphics that this scene needs to function.
  public void unload(); // unload everything that the garbage collector won’t unload, itself, including graphics
  public void addTuioObjectHook(TuioObject tobj); // this is called when an object becomes visible
  public void removeTuioObjectHook(TuioObject tobj); //an object was removed from the table
  public void updateTuioObjectHook(TuioObject tobj); //an object was moved on the table surface
  public void addTuioCursorHook(TuioCursor tcur); //this is called when a new cursor is detected
  public void removeTuioCursorHook(TuioCursor tcur); //a cursor was removed from the table
  public void updateTuioCursorHook(TuioCursor tcur); //a cursor was moving ton the table surface 
  public void addTuioBlobHook(TuioBlob tblb);
  public void updateTuioBlobHook (TuioBlob tblb);
  public void removeTuioBlobHook(TuioBlob tblb);
  public void refreshHook(TuioTime frameTime);
}

public interface IRenderable {
  /**
  * @description Any class that implements this interface is responsible for rendering to the screen 
  **/
  public void render();
}
