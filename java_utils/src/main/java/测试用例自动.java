import cn.hutool.core.io.FileUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import java.io.File;
import java.io.FileFilter;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class 测试用例自动 {
    public static final String PATH="D:\\my_project\\";

    public static void main(String[] args) {
        用例1生成();
        json处理();
        测试用例自动2.用例2生成();
        测试用例自动3.用例3生成();
    }

    private static void 检查(){
        String checkPath=PATH+"godot_Battlegrounds\\炉石V1.0\\所有卡牌\\随从";
        List<File> test = FileUtil.loopFiles(checkPath, new FileFilter() {
            @Override
            public boolean accept(File pathname) {
                return !pathname.getName().startsWith("test_");
            }
        });
        test.forEach(file->{
            File[] files = file.getParentFile().listFiles();
            if(files!=null){
                boolean hasTscn=false;
                boolean hasJson=false;
                for(File f:files){
                    if(f.getName().endsWith(".tscn")){
                        hasTscn=true;
                    }
                    if(f.getName().endsWith(".json")){
                        hasJson=true;
                    }
                }
                if(!hasTscn&&!hasJson){

                }
            }
        });
    }

    private static void  json处理(){
        String path = PATH+"\\godot_Battlegrounds\\资料\\32.2.4.221850\\get_full_cards.json";
        JSONObject parse = JSONUtil.parseObj(FileUtil.readUtf8String(path));
        JSONArray jsonArray = parse.getJSONObject("data").getJSONArray("minion");
        jsonArray.forEach(item -> {
            String savePath=PATH+"godot_Battlegrounds\\炉石V1.0\\所有卡牌\\随从";
            JSONObject obj = (JSONObject) item;
            JSONArray minionTypesCN = obj.getJSONArray("minionTypesCN");
            String nameCN = obj.getStr("nameCN");
            if(minionTypesCN.size()>0){
                String 目录 = minionTypesCN.getStr(0);
                savePath+="\\"+目录+"\\"+nameCN+"\\"+nameCN+".json";
                FileUtil.writeUtf8String(JSONUtil.toJsonStr(item),savePath);
            }
        });
    }

    private static void 用例1生成() {
        String path = PATH+"godot_Battlegrounds\\炉石V1.0\\所有卡牌";
        List<File> files = FileUtil.loopFiles(path, new FileFilter() {
            @Override
            public boolean accept(File file) {
                return file.getName().endsWith(".tscn") && !file.getName().startsWith("test_");
            }
        });
        for (File file : files) {
            String out = file.getParent() + "//test_" + file.getName();
            if (!FileUtil.isFile(out)) {
                String s = FileUtil.readString(PATH+"\\godot_Battlegrounds\\java_utils\\src\\main\\java\\测试用例.txt", StandardCharsets.UTF_8);
                String text = s.replace("{name}", file.getName().replace(".tscn", ""));
                FileUtil.writeString(text, out, StandardCharsets.UTF_8);
            }
        }
    }
}
