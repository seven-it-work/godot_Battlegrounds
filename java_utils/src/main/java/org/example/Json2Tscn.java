package org.example;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 * json 转 tscn
 */
public class Json2Tscn {
    public static String workPath="E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\";

    public static String savePath=workPath+"all_card\\";

    public static void main(String[] args) {
        // System.out.println(CardTypeEnum.MINION.ordinal());
        String jsonPath=workPath+"资料\\32.2.4.221850\\get_full_cards.json";

        酒馆法术(jsonPath);
    }

    private static void 伙伴随从(String jsonPath) {
        // 过滤出想要的数组
        JSONArray jsonArray = JSONUtil.parseObj(FileUtil.readString(jsonPath,StandardCharsets.UTF_8)).getJSONObject("data").getJSONArray("companion");
        List<BaseCard> list = jsonArray.toList(BaseCard.class);
        // 将BaseCard转换对应tscn
        String s = FileUtil.readString(workPath+"java_utils\\src\\main\\java\\org\\example\\Tscn模板.txt",
            StandardCharsets.UTF_8);
        for (BaseCard baseCard : list) {
            // 额外设置
            baseCard.setShowAtk(true);
            baseCard.setShowHp(true);
            baseCard.setShowBuyCoins(false);
            baseCard.set是否出现在酒馆(false);
            baseCard.set是否为伙伴(true);

            baseCard.setSavePath(StrUtil.format("companion/{nameCN}/{nameCN}",baseCard.toJson()));

            String tscn = StrUtil.format(s, baseCard.toJson());
            System.out.println("-----------------------------");
            System.out.println(tscn);
            System.out.println("-----------------------------");
            System.out.println("写入tscn");
            FileUtil.writeString(tscn,savePath+baseCard.getSavePath()+".tscn",StandardCharsets.UTF_8);
            System.out.println("写入gd");
            FileUtil.writeString(FileUtil.readString(workPath+"java_utils\\src\\main\\java\\org\\example\\gd模板.txt",
                StandardCharsets.UTF_8),savePath+baseCard.getSavePath()+".gd",StandardCharsets.UTF_8);
        }
    }

    private static void 酒馆法术(String jsonPath) {
        // 过滤出想要的数组
        JSONArray jsonArray = JSONUtil.parseObj(FileUtil.readString(jsonPath,StandardCharsets.UTF_8)).getJSONObject("data").getJSONArray("tavern");
        List<BaseCard> list = jsonArray.toList(BaseCard.class);
        // 将BaseCard转换对应tscn
        String s = FileUtil.readString(workPath+"java_utils\\src\\main\\java\\org\\example\\Tscn模板.txt",
            StandardCharsets.UTF_8);
        for (BaseCard baseCard : list) {
            // 额外设置
            baseCard.setShowAtk(false);
            baseCard.setShowHp(false);
            baseCard.setShowBuyCoins(true);

            baseCard.setSavePath(StrUtil.format("tavern/{nameCN}/{nameCN}",baseCard.toJson()));

            String tscn = StrUtil.format(s, baseCard.toJson());
            System.out.println("-----------------------------");
            System.out.println(tscn);
            System.out.println("-----------------------------");
            System.out.println("写入tscn");
            FileUtil.writeString(tscn,savePath+baseCard.getSavePath()+".tscn",StandardCharsets.UTF_8);
            System.out.println("写入gd");
            FileUtil.writeString(FileUtil.readString(workPath+"java_utils\\src\\main\\java\\org\\example\\gd模板.txt",
                StandardCharsets.UTF_8),savePath+baseCard.getSavePath()+".gd",StandardCharsets.UTF_8);
        }
    }
}
