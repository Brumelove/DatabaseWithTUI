
public class CodeItem {
    public String codetext;
    public int id;


    public CodeItem(int id,String codetext){
        this.id = id;
        this.codetext = codetext;
    }

    public void setId(int id){
        this.id = id;
    } 

    public int getId(){
        return id;
    }

    public void setCodeText(String codetext){
        this.codetext = codetext;
    }

    public String getCodeText(){
        return codetext;
    }


}


public class CodeDataSource {
    private JSONArray jsonObject;
    public String dataJSONPath = "";
    private String jsonPath = "code.json";
    private HashMap<Integer, CodeItem> hashMapData;

    public CodeDataSource(){
        // Set the path to the JSON file
        dataJSONPath = sketchPath("data/");
        jsonObject = loadJSONArray(dataJSONPath+jsonPath);
        hashMapData = new HashMap<Integer,CodeItem>();

    }
    
    public CodeItem getTextById(int symbolId){
        return hashMapData.get(symbolId);
    }

    public void parse(){
        if(jsonObject != null){
       
            for(int code = 0; code < jsonObject.size(); code++){
                JSONObject currentCodeObject = jsonObject.getJSONObject(code);
                println("ID is :"+ currentCodeObject.getInt("id"));
                CodeItem item = new CodeItem(currentCodeObject.getInt("id"), currentCodeObject.getString("code"));
                hashMapData.put(item.getId(),item);
            }

        }
    }
}
