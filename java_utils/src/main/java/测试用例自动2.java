import cn.hutool.core.io.FileUtil;

import java.io.File;
import java.io.FileFilter;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class 测试用例自动2 {
    public static void main(String[] args) {
        用例2生成();
    }

    public static void 用例2生成() {
        String path = 测试用例自动.PATH+"godot_Battlegrounds\\炉石V1.0\\所有卡牌";
        List<File> files = FileUtil.loopFiles(path, file -> file.getName().endsWith(".tscn") && !file.getName().startsWith("test_"));
        for (File file : files) {
            String out = file.getParent() + "//test_2" + file.getName();
            if (!FileUtil.isFile(out)) {
                String s = FileUtil.readString(测试用例自动.PATH+"godot_Battlegrounds\\java_utils\\src\\main\\java\\测试用例2.txt", StandardCharsets.UTF_8);
                String text = s.replace("{name}", file.getName().replace(".tscn", ""));
                FileUtil.writeString(text, out, StandardCharsets.UTF_8);
            }
        }
    }
}
