package org.example;

import cn.hutool.core.io.FileUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import lombok.Data;

import java.io.File;
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Collectors;

@Data
public class BaseCard {
    private String version = "32.2.4.221850";
    private String savePath="";

    private String strId;
    private String cardType;
    private String nameCN;
    private String text;
    private String goldText;
    private int tier;
    private int health;
    private int attack;
    private int manaCost;
    private List<String> minionTypes=new ArrayList<>();
    private Boolean showLv=true;
    private Boolean showAtk=true;
    private Boolean showHp=true;
    private int buyCoins=3;
    private Boolean showBuyCoins=false;
    private Boolean 是否出现在酒馆=true;
    private Boolean 是否为伙伴=false;
    private BaseCard upgradeCard;

    public JSONObject toJson(){
        JSONObject entries = JSONUtil.parseObj(this);
        entries.set("cardType",CardTypeEnum.valueOf(cardType.toUpperCase()).ordinal());
        entries.set("minionTypes",minionTypes.stream().map((str)->RaceEnum.valueOf(str.toUpperCase()).ordinal()).collect(Collectors.toList()));
        if(upgradeCard!=null){
            entries.set("goldText",upgradeCard.text.replace("\n",""));
        }else {
            entries.set("goldText",text.replace("\n",""));
        }
        return entries;
    }

    /**
     * 从 .tscn 文件路径解析出 BaseCard 对象
     *
     * @param filePath .tscn 文件路径
     * @return BaseCard 对象
     */
    public static BaseCard fromTscnFile(String filePath) {
        BaseCard card = new BaseCard();
        List<String> lines = FileUtil.readLines(new File(filePath), "UTF-8");
        for (String line : lines) {
            if (line.contains(" = ")) {
                String[] parts = line.split(" = ", 2);
                String key = parts[0].trim();
                String value = parts.length > 1 ? parts[1].trim() : "";
                switch (key) {
                    case "version":
                        card.setVersion(value);
                        break;
                    case "ls_card_id":
                        card.setStrId(value);
                        break;
                    case "name_str":
                        card.setNameCN(value);
                        break;
                    case "lv":
                        card.setTier(Integer.parseInt(value));
                        break;
                    case "atk":
                        card.setAttack(Integer.parseInt(value));
                        break;
                    case "hp":
                        card.setHealth(Integer.parseInt(value));
                        break;
                    case "desc":
                        card.setText(value);
                        break;
                    default:
                        // 忽略其他字段
                        break;
                }
            }
        }
        return card;
    }

    public String getTscnFilePath() {
        String type = minionTypes.get(0);
        return "D:\\devSoft\\godot\\Godot_v4.3-stable_win64\\godot_Battlegrounds\\all_card\\"
                + cardType + "/"
                + type + "/"
                + nameCN + "/"
                + nameCN
                + ".tscn";
    }

    /**
     * 将当前对象属性写入对应的 .tscn 文件
     */
    public void writeToTscnFile() {
        String filePath = getTscnFilePath();
        File file = new File(filePath);

        if (!file.exists()) {
            System.out.println("文件不存在");
            return;
        }

        List<String> lines = FileUtil.readLines(file, "UTF-8");
        List<String> newLines = new ArrayList<>();
        Set<String> updatedKeys = new HashSet<>();

        // 映射关系：tscn 属性名 -> 当前类中的值
        Map<String, Supplier<String>> propertyMap = new LinkedHashMap<>();
        propertyMap.put("version", () -> "\""+version+"\"");
        propertyMap.put("ls_card_id", () -> "\""+strId+"\"");
        propertyMap.put("name_str", () -> "\""+nameCN+"\"");
        propertyMap.put("lv", () -> String.valueOf(tier));
        propertyMap.put("atk", () -> String.valueOf(attack));
        propertyMap.put("hp", () -> String.valueOf(health));
//        propertyMap.put("desc", () -> "\""+text+"\"");

        for (String line : lines) {
            boolean matched = false;
            for (Map.Entry<String, Supplier<String>> entry : propertyMap.entrySet()) {
                String key = entry.getKey();
                if (line.trim().startsWith(key + " = ")) {
                    newLines.add(key + " = " + entry.getValue().get());
                    updatedKeys.add(key);
                    matched = true;
                    break;
                }
            }
            if (!matched) {
                newLines.add(line); // 保留未修改的原始行
            }
        }

        // 追加未在原文件中出现的属性
        for (Map.Entry<String, Supplier<String>> entry : propertyMap.entrySet()) {
            if (!updatedKeys.contains(entry.getKey())) {
                newLines.add(entry.getKey() + " = " + entry.getValue().get());
            }
        }

        // 写回文件
        FileUtil.writeLines(newLines, file, "UTF-8");
    }

    /**
     * 若文件不存在，则直接写入所有属性
     */
    private void writeAllPropertiesToFile(File file) {
        List<String> lines = new ArrayList<>();
        lines.add("[node name=\"" + nameCN + "\" type=\"Node2D\"]");

        lines.add("version = " + version);
        lines.add("ls_card_id = " + strId);
        lines.add("name_str = " + nameCN);
        lines.add("lv = " + tier);
        lines.add("atk = " + attack);
        lines.add("hp = " + health);
        lines.add("desc = " + text);

        FileUtil.writeLines(lines, file, "UTF-8");
    }


    public void checkTscnDataAndChange() {
        List<String> lines = FileUtil.readLines(getTscnFilePath(), "utf-8");
        ArrayList<String> newLines = new ArrayList<String>();
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.contains(" = ")) {
                String[] split = line.split(" = ");
                if (split.length >= 1) {
                    String key = split[0];
//                    String value = split[1];
                    if (key.equals("version")) {
                        newLines.add(key + " = " + version);
                    } else if (key.equals("ls_card_id")) {
                        newLines.add(key + " = " + strId);
                    } else if (key.equals("name_str")) {
                        newLines.add(key + " = " + nameCN);
                    } else if (key.equals("lv")) {
                        newLines.add(key + " = " + tier);
                    } else if (key.equals("atk")) {
                        newLines.add(key + " = " + attack);
                    } else if (key.equals("hp")) {
                        newLines.add(key + " = " + health);
                    } else if (key.equals("desc")) {
                        newLines.add(key + " = " + text);
                    } else if (key.equals("race")) {
//                        newLines.add(key + " = " + text);
                    } else {
//                        System.out.println(line);
                    }
                }
            }
            newLines.add(line);
        }
    }
}
