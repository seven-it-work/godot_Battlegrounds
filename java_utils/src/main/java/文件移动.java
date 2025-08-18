import cn.hutool.core.io.FileUtil;

import java.io.File;
import java.util.List;

public class 文件移动 {
    public static void main(String[] args) {
        String path="E:\\dev_soft\\Godot_v4.3-stable_win64.exe\\godot_Battlegrounds\\炉石V1.0\\所有卡牌";
        List<File> files = FileUtil.loopFiles(path);
        for (File file : files) {
            String name=file.getName().split("\\.")[0];
            System.out.println(file.getParent()+"\\"+name+"\\");
            FileUtil.move(file,new File(file.getParent()+"\\"+name+"\\"+file.getName()),true);
//            FileUtil.copyFile(file.getAbsolutePath(),file.getAbsolutePath()+"\\"+name+"\\");

        }

    }
}
