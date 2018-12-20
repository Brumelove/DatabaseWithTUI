
public class CodeItem {
  private String codetext;
  private int id;
  private boolean finalScene;
  private int nextSymbolID;
  private String nextMarkerText;
  private boolean isDummy;

  public String getNextMarkerText()
  {
    return this.nextMarkerText;
  }

  public boolean getFinalScene()
  {
    return this.finalScene;
  }

 
  public void setFinalScene(boolean finalScene)
  {
    this.finalScene = finalScene;
  }

  public boolean getIsDummy(){
    return isDummy;
  }

  public void setIsDummy(boolean isDummy){
    this.isDummy = isDummy;
  }


  public void setNextMarkerText(String nextMarkerText)
  {
    this.nextMarkerText = nextMarkerText;
  }

  public int getNextSymbolId()
  {
    return this.nextSymbolID;
  }

  public void setNextSymbolId(int nextSymbolID)
  {
    this.nextSymbolID = nextSymbolID;
  }



  public CodeItem(int id, String codetext) {
    this.id = id;
    this.codetext = codetext;
  }

  public void setId(int id) {
    this.id = id;
  } 

  public int getId() {
    return id;
  }

  public void setCodeText(String codetext) {
    this.codetext = codetext;
  }

  public String getCodeText() {
    return codetext;
  }
}


public class CodeDataSource {
  private JSONArray jsonObject;
  public String dataJSONPath = "";
  private String jsonPath = "code.json";
  private HashMap<Integer, CodeItem> hashMapData;

  public CodeDataSource() {
    // Set the path to the JSON file
    dataJSONPath = sketchPath("data/");
    jsonObject = loadJSONArray(dataJSONPath+jsonPath);
    hashMapData = new HashMap<Integer, CodeItem>();
  }

  public CodeItem getTextById(int symbolId) {
    return hashMapData.get(symbolId);
  }

  public void parse() {
    if (jsonObject != null) {

      for (int code = 0; code < jsonObject.size(); code++) {
        JSONObject currentCodeObject = jsonObject.getJSONObject(code);
        CodeItem item = new CodeItem(currentCodeObject.getInt("id"), currentCodeObject.getString("code"));
        item.setFinalScene(currentCodeObject.getBoolean("finalScene"));
        item.setNextMarkerText(currentCodeObject.getString("nextMarkerText"));
        item.setNextSymbolId(currentCodeObject.getInt("nextSymbolID"));
        item.setIsDummy(currentCodeObject.getBoolean("isDummyData"));
        hashMapData.put(item.getId(), item);
      }
    }
  }
}
