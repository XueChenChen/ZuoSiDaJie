# 作死大结局

### 项目简介:

      该软件面向17+年龄，旨在娱乐大众，内有音乐、视频、直播、段子、内涵动图、web新闻...
      
### 项目详解：

      项目主要分基础UI和网络下载模块两大模块，项目主要框架采用MVC框架，部分采用MVVM框架，多出使用通知、代理、KVC、单例、工厂，几处使用KVO
      基础UI：main(自定义UITabBarController、UINavigationController)、精华、直播、发布、关注、我的
      
### 主要技术要点：

####     1.main：
       a).自定义控制器UITabBarController的tabBar，对tabBar上的item重新布局操作
       b).自定义控制器UINavigationController,从而对整个程序中的所用导航控制器的UINavigationBar和自定义返回navigationItem所产生的侧边滑动返回和全屏滑动返回有关问题进行操作
     
####     2.精华：
       a).利用通知来实现精华页面tabBar双击和精华页面中titleButton双击刷新页面的功能
       b).点击UITableViewCell上的图片进行图片查看和保存
     
####     3.直播：
       a).利用MVVM模式和storyboard搭建简单UICollectionView见面
     
####     4.发布：
       a).利用pop三方框架实现UIButton从底部弹出的简单动画
     
####     5.关注：
       a).利用kvc/runtime技术对登录注册中UITextField的私有placeholderColor属性默认颜色进行修改
       b).利用Bmob SDK实现简单的登录注册功能
     
####     6.我的：
       a).利用WKWebView来实现网页加载的进度、刷新、前进、后退...
       b).利用NSUserDefaults、通知技术来实现app主题的选择切换
     
####     7.借鉴三方框架SDWebImage、YYKit...对项目中的缓存数据进行清除
      ...
