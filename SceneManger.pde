public class SceneManager {

  public IScene currentScene;

  public void setScene(IScene scene) {
    println(scene); //<>//
    if (currentScene != null) {
      currentScene.unload();
      currentScene = null;
    }
    currentScene = scene;
    currentScene.load();
    
    // Let's call loop once so it can update screen to draw
    redraw(); // Flush the Graphics to the screen
  }

  public IScene activeScene() {
    return currentScene;
  }
}
