## QmlDisigner二次开发计划

### 介绍主页：

http://qtdream.com/topic/70/发起qmldesigner二次开发工作/2

目前已兼容的最高QtCreator版本：

qt-creator-opensource-src-3.6.0


QmlDesignerPlus分为两大块，一块为propertyEditorQmlSources二次开发，一块为qmleditorwidgets的二次开发




## propertyEditorQmlSources部分

### 使用方法

1.找到propertyEditorQmlSources目录

  在我的Windows系统下，目录是
  
      C:\Qt\Qt5.5.1\Tools\QtCreator\share\qtcreator\qmldesigner\propertyEditorQmlSources
      
  在我的OS X系统下，目录是：
  
      /Applications/Qt5.5.1/Qt\ Creator.app/Contents/Resources/qmldesigner/propertyEditorQmlSources
      

2.使用GitHub中的propertyEditorQmlSources目录替换本地的这个目录，然后就可以使用了。

注意是替换！


### 开发的功能

1.汉化部分属性编辑界面

2.在XY编辑界面，增加移动中心到XY的功能




## qmleditorwidgets部分

### 使用方法

1.下载Creator源码并解压

2.合并本源码目录到src/libs/qmleditorwidgets/

注意是合并！

3.编译Creator源码


### 二次开发的功能

1.新增Item的HelperWidget

2.改进了Text的HelperWidget

3.改进了Rectangle的HelperWidget

4.改进了Easing的HelperWidget
