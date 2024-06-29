# 科大讯飞AI学习机展讯机型Root工具：System.img与Vendor.img的半自动合成、修改脚本（分开的两个脚本）

## 注意事项

**为确认脚本功能正常运作，请在  x86_64(amd64)架构的Ubuntu Linux on WSL2环境下  使用sudo运行**

**脚本运行过程提示文本使用英语是为了兼容性考虑,没有别的意思(套盾**

**脚本原理详见[Root教程](https://github.com/KDXF-BOOM/studentpad-research#%E8%8E%B7%E5%8F%96%E5%AD%A6%E4%B9%A0%E6%9C%BA%E5%B1%95%E8%AE%AF%E7%B3%BB%E6%9C%BA%E5%9E%8B%E7%9A%84root%E5%8D%B3%E5%88%B7%E5%85%A5magisk)**

**我们欢迎各位开PR来提出并解决该脚本中存在的一些不足**

**本文假定你已经学会了如何装好WSL2 Ubuntu环境，否则请尝试 ~~往嫩豆腐上撞击头部直至失去生命体征(bushi)~~ 自行应用搜索引擎，AI（如ChatGPT）解决问题**

## 可实现的功能

* 模拟学习机在安卓Recovery环境下的OTA修补分区功能(使用了[imgpatchtools](https://github.com/erfanoabdi/imgpatchtools)项目)
* 实现对 科大讯飞AI学习机展讯机型 的Root镜像合成

## 如何使用？

* 在Windows下，将本仓库进行克隆，然后使用如下命令切换分支

```
git checkout System-Image-Patch-Script
```

* 在Windows上下载到OTA全包,利用**DNA3(建议)**将其分解为多个镜像
* 在仓库目录的窗口中，将光标拖到导航栏下空白处，利用Shift+鼠标右键在当前目录打开命令窗口，执行以下命令：

  ```
  wsl -u root
  ```

如果你已经有system,vendor镜像存在（或由上一步得到了），你可能会做以下两种事：

* Root镜像：你需要使用 ./patch_root_adb.sh 来进行半自动化Root
* 想要合成然后再Root：你需要去找到你下载的差分包（就是那个文件名是inc开头的），把它几个带[.list .dat .new]文件扩展名的文件复制过来，然后执行 ./ota_image.sh 进行自动化合成镜像，然后如'Root镜像'步骤一样，故不阐述
