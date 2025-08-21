import cn.hutool.core.io.FileUtil;

import java.io.File;
import java.io.FileFilter;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class 测试用例自动 {
    public static void main(String[] args) {
        String path = "E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\炉石V1.0\\所有卡牌";
        List<File> files = FileUtil.loopFiles(path, new FileFilter() {
            @Override
            public boolean accept(File file) {
                return file.getName().endsWith(".tscn") && !file.getName().startsWith("test_");
            }
        });
        for (File file : files) {
            String out = file.getParent() + "//test_" + file.getName();
            if (!FileUtil.isFile(out)) {
                String s = FileUtil.readString("E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\java_utils\\src\\main\\java\\测试用例.txt", StandardCharsets.UTF_8);
                String text = s.replace("{name}", file.getName().replace(".tscn", ""));
                FileUtil.writeString(text, out, StandardCharsets.UTF_8);
            }
        }
    }
}
