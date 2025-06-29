package v2;

import static org.example.Json2Tscn.savePath;
import static org.example.Json2Tscn.workPath;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONUtil;

import org.example.BaseCard;
import org.example.RaceEnum;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class Create {
    public static String workPath="E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\";

    public static String savePath=workPath+"v2.0\\新建游戏项目\\all_card\\";

    public static void main(String[] args) {
        随从("E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\资料\\32.2.4.221850\\get_full_cards.json");
    }
    private static void 随从(String jsonPath) {
        // 过滤出想要的数组
        JSONArray jsonArray = JSONUtil.parseObj(FileUtil.readString(jsonPath, StandardCharsets.UTF_8))
            .getJSONObject("data")
            .getJSONArray("minion");
        List<BaseCard> list = jsonArray.toList(BaseCard.class);
        // 将BaseCard转换对应tscn
        String s = FileUtil.readString(workPath + "java_utils\\src\\main\\java\\v2\\Tscn模板.txt",
            StandardCharsets.UTF_8);
        for (BaseCard baseCard : list) {
            // 额外设置
            baseCard.setShowAtk(true);
            baseCard.setShowHp(true);
            baseCard.setShowBuyCoins(false);
            baseCard.set是否出现在酒馆(true);
            baseCard.set是否为伙伴(false);

            String type= RaceEnum.NONE.toString();
            List<String> minionTypes = baseCard.getMinionTypes();
            if(!minionTypes.isEmpty()) {
                type=minionTypes.get(0);
            }
            baseCard.setSavePath(StrUtil.format("minion/"+type+"/{nameCN}/{nameCN}", baseCard.toJson()));

            String tscn = StrUtil.format(s, baseCard.toJson());
            System.out.println("-----------------------------");
            System.out.println(tscn);
            System.out.println("-----------------------------");
            System.out.println("写入tscn");
            FileUtil.writeString(tscn, savePath + baseCard.getSavePath() + ".tscn", StandardCharsets.UTF_8);
            System.out.println("写入gd");
            FileUtil.writeString(FileUtil.readString(workPath + "java_utils\\src\\main\\java\\v2\\gd模板.txt",
                StandardCharsets.UTF_8), savePath + baseCard.getSavePath() + ".gd", StandardCharsets.UTF_8);
            if (baseCard.get是否需要选择目标()) {
                System.out.println("写入选择脚本");
            }
        }
    }


    private static void 酒馆法术(String jsonPath) {
        // 过滤出想要的数组
        JSONArray jsonArray = JSONUtil.parseObj(FileUtil.readString(jsonPath, StandardCharsets.UTF_8))
            .getJSONObject("data")
            .getJSONArray("tavern");
        List<BaseCard> list = jsonArray.toList(BaseCard.class);
        // 将BaseCard转换对应tscn
        String s = FileUtil.readString(workPath + "java_utils\\src\\main\\java\\v2\\Tscn模板.txt",
            StandardCharsets.UTF_8);
        for (BaseCard baseCard : list) {
            // 额外设置
            baseCard.setShowAtk(false);
            baseCard.setShowHp(false);
            baseCard.setShowBuyCoins(true);
            baseCard.set是否出现在酒馆(true);
            baseCard.set是否为伙伴(false);
            if (baseCard.getText().contains("选择")) {
                baseCard.set是否需要选择目标(true);
            }

            baseCard.setSavePath(StrUtil.format("tavern/{nameCN}/{nameCN}", baseCard.toJson()));

            String tscn = StrUtil.format(s, baseCard.toJson());
            System.out.println("-----------------------------");
            System.out.println(tscn);
            System.out.println("-----------------------------");
            System.out.println("写入tscn");
            FileUtil.writeString(tscn, savePath + baseCard.getSavePath() + ".tscn", StandardCharsets.UTF_8);
            System.out.println("写入gd");
            FileUtil.writeString(FileUtil.readString(workPath + "java_utils\\src\\main\\java\\v2\\gd模板.txt",
                StandardCharsets.UTF_8), savePath + baseCard.getSavePath() + ".gd", StandardCharsets.UTF_8);
            if (baseCard.get是否需要选择目标()) {
                System.out.println("写入选择脚本");
            }
        }
    }
}
