# JIMultiSlideShowView

[![CI Status](https://img.shields.io/travis/jerryelectricity@me.com/JIMultiSlideShowView.svg?style=flat)](https://travis-ci.org/jerryelectricity@me.com/JIMultiSlideShowView)
[![Version](https://img.shields.io/cocoapods/v/JIMultiSlideShowView.svg?style=flat)](https://cocoapods.org/pods/JIMultiSlideShowView)
[![License](https://img.shields.io/cocoapods/l/JIMultiSlideShowView.svg?style=flat)](https://cocoapods.org/pods/JIMultiSlideShowView)
[![Platform](https://img.shields.io/cocoapods/p/JIMultiSlideShowView.svg?style=flat)](https://cocoapods.org/pods/JIMultiSlideShowView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

JIMultiSlideShowView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JIMultiSlideShowView'
```

![JIMultiShowViewIcon](https://github.com/JerryIce/JIMultiShowView/blob/main/Example/JIMultiSlideShowView/JIMultiShowViewIcon.png)

>一个iOS UICollectionView嵌套UITabelView并附带头部展示栏的多功能显示视图控件： 实现左右滑动与上下拖动展示内容的同时，还能显示共用的头部展示栏。

>语言：Objective-C

## 具体样式展示示意图如下：
***
![JIMultiShowView功能示意图](https://github.com/JerryIce/JIMultiShowView/blob/main/Example/JIMultiSlideShowView/JIMultiShowViewDemoDiagram.gif)

## 介绍说明：
***
如今大多数的APP都有类似JIMultiShowView"示意图"中展示的界面视图结构：即滑实现左右滑动与上下拖动展示内容的同时，还能显示共用的头部展示栏。比如：唱吧，网易云音乐，全民K歌。本Demo在实现了上述效果的基础上，辅助以可替换的视图类，达到了较高的可自定义化，方便使用。

## 使用说明：

### 视图结构示意图：
![JIMultiShowView视图结构示意图](https://github.com/JerryIce/JIMultiShowView/blob/main/Example/JIMultiSlideShowView/JIMultiShowViewCompositionDiagram.png)

### 内部类结概览：
![JIMultiShowView内部类结构图](https://github.com/JerryIce/JIMultiShowView/blobmain/Example/JIMultiSlideShowView/JIMultiShowViewClassDiagram.png)

## 使用方式：
1.首先确认头部展示栏的数据JIMultiShowTableHeaderItem，即提供左右滑动时头部需要做出相应变化的数据，以数组方式提供给jiMultiShowViewGetDataArray的实现方。
JIMultiShowTableHeaderItem可根据需求加入其它属性。  
2.创建JIMultiShowView并设置dataSource代理，以获取头部展示栏的数据。获取完需要reloadData刷新。  
3.至此，JIMultiShowView会根据[JIMultiShowTableHeaderItem]数组来创建可左右滑动的cell数目，并同时设置对应cell的头部展示栏显示样式，基本实现Demo中的效果。  
4.本Demo中左右滑动cell内部的视图为JIMultiShowContentCell，主要为tableView，可根据需求自行替换JIMultiShowContentCell。

## Author

jerryelectricity@me.com

## License

JIMultiSlideShowView is available under the MIT license. See the LICENSE file for more info.
