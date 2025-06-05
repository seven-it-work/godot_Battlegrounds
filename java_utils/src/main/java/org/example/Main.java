package org.example;

import cn.hutool.core.io.FileUtil;
import cn.hutool.json.JSONUtil;

public class Main {
    public static void main(String[] args) {
        String json= FileUtil.readString("D:/devSoft/godot/Godot_v4.3-stable_win64/godot_Battlegrounds/资料/32.2.4.221850/get_full_cards.json",  "UTF-8");
        JSONUtil.toBean(json,  BaseCard.class).writeToTscnFile();
    }
}