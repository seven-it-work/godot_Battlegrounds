import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ByteUtil;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class JieMi {
    public static void main(String[] args) {
        jieMi("E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\7_点击ui");
    }
    private static void jieMi(String file) {
        jieMi(new File(file));
    }
    private static void jieMi(File file) {
        if (!file.getName().startsWith("7_")) {
            throw new RuntimeException("非法文件");
        }
        List<String> strings = FileUtil.readLines(file, StandardCharsets.UTF_8);
        String[] split = strings.get(0).split("");
        if (split.length != 256) {
            throw new RuntimeException("错误文件");
        }
        HashMap<String, Integer> keys = new HashMap<>();
        for (int i = 0; i < split.length; i++) {
            keys.put(split[i], i);
        }
        ArrayList<Byte> bytes = new ArrayList<>();
        for (int i = 1; i < strings.size(); i++) {
            String s = strings.get(i);
            String[] temp = s.split("");
            for (String string : temp) {
                Integer byteData = keys.get(string);
                if (byteData == null) {
                    System.out.println(string);
                    throw new RuntimeException("错误索引");
                }
                bytes.add((byte) (byteData - 128));
            }
        }
        String absolutePath = file.getParent();
        String path = absolutePath + "\\解7_" + file.getName() + ".txt";
        System.out.println("写入：" + path);

        FileUtil.writeBytes(convert(bytes), path);
    }

    public static byte[] convert(List<Byte> bytes) {
        byte[] result = new byte[bytes.size()];
        for (int i = 0; i < bytes.size(); i++) {
            result[i] = bytes.get(i);
        }
        return result;
    }

}
