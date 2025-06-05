package org.example;

import cn.hutool.core.io.FileUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        String json= FileUtil.readString("D:/devSoft/godot/Godot_v4.3-stable_win64/godot_Battlegrounds/资料/32.2.4.221850/get_full_cards.json",  "UTF-8");
        JSONObject entries = JSONUtil.parseObj(json);
        JSONArray jsonArray = entries.getJSONObject("data").getJSONArray("minion");
        List<BaseCard> list = jsonArray.toList(BaseCard.class);
        for (BaseCard baseCard : list) {
            baseCard.writeToTscnFile();
        }
    }
}