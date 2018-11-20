
public class CodeItem {
    public String codetext;
    public int id;

    public void setId(int id){
        id = id;
    } 

    public int getId(){
        return id;
    }

    public void setCodeText(String codetext){
        codetext = codetext;
    }

    public String getCodeText(){
        return codetext;
    }


}


public class CodeDataSource {
    private JSONArray jsonObject;
    public String dataJSONPath = "";
    private String jsonPath = "code.json";

    public CodeDataSource(){
        // Set the path to the JSON file
        dataJSONPath = sketchPath("data/");
        jsonObject = loadJSONArray(dataJSONPath+jsonPath);

    }

    public void parse(){
        if(jsonObject != null){
       
            for(int code = 0; code < jsonObject.size(); code++){
                JSONObject currentCodeObject = jsonObject.getJSONObject(code);
                print(currentCodeObject.getString("code"));
            }

        }
    }



}
