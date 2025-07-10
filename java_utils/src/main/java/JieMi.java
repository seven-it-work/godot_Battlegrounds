import cn.hutool.core.io.FileUtil;
import cn.hutool.core.text.UnicodeUtil;
import cn.hutool.core.util.HexUtil;
import cn.hutool.core.util.StrUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class JieMi {
  public static byte[] jiemi2(String str) {
    String[] huanHang = str.split("\n");
    ArrayList<Byte> bytes = new ArrayList<>();
    String unicode = customJavaToUnicode(huanHang[0]);
    String[] hexList = unicode.split("\\\\u");

    for (String s : hexList) {
      for (String splitEveryTwoChar : splitEveryTwoChars(s)) {
        byte aByte = hex2Byte(splitEveryTwoChar);
        bytes.add(aByte);
      }
    }
    if (huanHang.length > 1) {
      unicode = customJavaToUnicode(huanHang[1]);
      String hex = unicode2Hex(unicode);
      bytes.add(hex2Byte(hex.substring(0, 2)));
    }

    byte[] result = new byte[bytes.size()];
    for (int i = 0; i < bytes.size(); i++) {
      result[i] = bytes.get(i);
    }
    return result;
  }

  /**
   * 将输入的字符串按每两个字符划分成一组，返回字符串列表。
   *
   * @param s 输入字符串
   * @return 字符每两个一组构成的列表
   * @throws IllegalArgumentException 如果输入为 null 或长度不是偶数
   */
  public static List<String> splitEveryTwoChars(String s) {
    if (s == null) {
      throw new IllegalArgumentException("输入字符串不能为 null");
    }
    if (s.length() % 2 != 0) {
      throw new IllegalArgumentException("输入字符串的长度必须为偶数");
    }

    List<String> result = new ArrayList<>();
    for (int i = 0; i < s.length(); i += 2) {
      String sub = s.substring(i, i + 2);
      result.add(sub);
    }

    return result;
  }

  public static String jiami2(String file) {
    StringBuilder stringBuilder = new StringBuilder();
    byte[] bytes = FileUtil.readBytes(file);
    String tempHex = "";
    int aCoupleOfPairs = 2;
    for (byte aByte : bytes) {
      String hex = byte2Hex(aByte);
      if (StrUtil.isBlank(tempHex)) {
        if (hex.equals("10")) {
          aCoupleOfPairs = 3;
        } else {
          aCoupleOfPairs = 2;
        }
      }
      tempHex += hex;
      if (tempHex.length() == aCoupleOfPairs * 2) {
        String unicode = hex2Unicode(tempHex);
        String unicode2Str = customUnicodeToJava(unicode);
        stringBuilder.append(unicode2Str);
        tempHex = "";
      }
    }
    if (StrUtil.isNotBlank(tempHex)) {
      stringBuilder.append("\n").append(unicode2Str(hex2Unicode(tempHex + "00")));
    }
    return stringBuilder.toString();
  }

  public static String customUnicodeToJava(String unicodeStr) {
    StringBuilder result = new StringBuilder();
    Pattern pattern = Pattern.compile("\\\\u([0-9a-fA-F]{4,6})");
    Matcher matcher = pattern.matcher(unicodeStr);

    int lastEnd = 0;
    while (matcher.find()) {
      result.append(unicodeStr, lastEnd, matcher.start());

      String hex = matcher.group(1);
      int codePoint;

      // 补零至最少 4 位
      while (hex.length() < 4) {
        hex = "0" + hex;
      }

      codePoint = Integer.parseInt(hex, 16);

      if (codePoint <= 0xFFFF) {
        result.append((char) codePoint);
      } else {
        char[] surrogates = Character.toChars(codePoint);
        result.append(surrogates[0]).append(surrogates[1]);
      }
      lastEnd = matcher.end();
    }

    // 添加剩余未匹配的内容
    result.append(unicodeStr.substring(lastEnd));
    return result.toString();
  }

  public static String customJavaToUnicode(String javaStr) {
    StringBuilder result = new StringBuilder();

    for (int i = 0; i < javaStr.length(); ) {
      int codePoint = javaStr.codePointAt(i);
      i += Character.charCount(codePoint);

      if (codePoint <= 0xFFFF) {
        result.append(String.format("\\u%04x", codePoint));
      } else {
        result.append(String.format("\\u%05x", codePoint));
      }
    }
    return result.toString();
  }

  public static String unicode2Str(String unicode) {
    if (!unicode.startsWith("\\u")) {
      throw new RuntimeException("不是unicode马");
    }
    return UnicodeUtil.toString(unicode);
  }

  public static String unicode2Hex(String unicode) {
    if (!unicode.startsWith("\\u")) {
      throw new RuntimeException("不是unicode马");
    }
    return unicode.replace("\\u", "");
  }

  public static String hex2Unicode(String hex) {
    if (hex.length() < 4) {
      throw new RuntimeException("非4位，无法转换");
    }
    return "\\u" + hex.toLowerCase();
  }

  public static String byte2Hex(byte b) {
    String hex = HexUtil.toHex(b + 128);
    if (hex.length() < 2) {
      hex = "0" + hex;
    }
    return hex;
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
