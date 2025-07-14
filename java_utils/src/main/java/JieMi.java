import cn.hutool.core.io.FileUtil;
import cn.hutool.core.text.UnicodeUtil;
import cn.hutool.core.util.HexUtil;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class JieMi {
    public static void main(String[] args) {
        String file = "E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\java_utils\\";
        FileUtil.writeBytes(jiemi2(FileUtil.readString(file + "temp.txt", StandardCharsets.UTF_8)), file + "temp.7z");
    }

    public static byte[] jiemi2(String fileStr) {
        String prefix = fileStr.substring(0, 1);
        String data = fileStr.substring(1);
        String[] split = data.split("");
        String hex = "";
        String lastStr = "";
        for (String s : split) {
            if (StrUtil.isNotBlank(lastStr)) {
                lastStr += s;
            } else {
                if (s.equals("=")) {
                    lastStr += s;
                } else {
                    String unicode = UnicodeUtil.toUnicode(s);
                    String tempHex = unicode.replace("\\u", "");
                    if (tempHex.startsWith(prefix)) {
                        String hexTemp = tempHex.substring(1);
                        hex += hexTemp;
                    } else {
                        throw new RuntimeException("错了");
                    }
                }
            }
        }
        int count = StrUtil.count(lastStr, "=");
        String tempHex = UnicodeUtil.toUnicode(lastStr.replace("=", "")).replace("\\u", "");
        String h = tempHex.substring(1, 3 - count + 1);
        hex += h;
        List<String> strings = splitStringByLength(hex, 2);
        byte[] bytes = new byte[strings.size()];
        for (int i = 0; i < strings.size(); i++) {
            bytes[i] = hex2Byte(strings.get(i));
        }
        return bytes;
    }

    public static String jiami2(String file) {
        byte[] bytes = FileUtil.readBytes(file);
        String prefix = RandomUtil.randomString("123456789ABCEF", 1);
        String result = "";
        String hex = "";
        for (byte aByte : bytes) {
            hex += byte2Hex(aByte);
        }
        System.out.println(hex.toUpperCase());
        List<String> strings = splitStringByLength(hex, 3);
        for (String string : strings) {
            if (string.length() == 3) {
                String unicode = "\\u" + prefix + string;
                String str = UnicodeUtil.toString(unicode);
                if (str.equals("=")) {
                    System.out.println("");
                }
                result += str;
            } else {
                String unicode = "\\u" + prefix + string;
                for (int i = 0; i < 3 - string.length(); i++) {
                    result += "=";
                    unicode += "0";
                }
                result += UnicodeUtil.toString(unicode);
            }
        }
        return prefix + result;
    }

    public static List<String> splitStringByLength(String input, int length) {
        List<String> result = new ArrayList<>();
        // 检查输入是否有效
        if (input == null || input.isEmpty() || length <= 0) {
            return result;
        }
        // 按指定长度分割字符串
        for (int i = 0; i < input.length(); i += length) {
            int end = Math.min(i + length, input.length());
            result.add(input.substring(i, end));
        }
        return result;
    }

    public static String byte2Hex(byte b) {
        String hex = HexUtil.toHex(b + 128);
        if (hex.length() < 2) {
            hex = "0" + hex;
        }
        return hex.toUpperCase(Locale.ROOT);
    }

    public static byte hex2Byte(String hex) {
        int tempB = HexUtil.hexToInt(hex);
        int i = tempB - 128;
        if (i > 127) {
            System.out.println(hex);
            throw new RuntimeException("错误了");
        }
        return (byte) i;
    }
}
