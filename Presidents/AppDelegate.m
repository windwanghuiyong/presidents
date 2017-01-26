//
//  AppDelegate.m
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 获取窗口的根控制器作为分割视图控制器
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    // 详情视图控制器的导航控制器, 数组中是分割分割视图控制器对主视图导航控制器和详情视图导航控制器的引用
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    // 设置 Presidents 返回按钮(在 iPhone 中会变成一个双向箭头, 在详情控制器中点击返回按钮返回主控制器
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    // 注册应用程序委托作为分割视图的委托
    splitViewController.delegate = self;		// 分割视图控制器的 delegate 输出接口指向应用程序委托自身
    NSLog(@"back button");
    return YES;
}

#pragma mark - Split view 以下是 UISplitViewControllerDelegate 协议方法

// 主视图控制器和详情视图控制器均可见情况下, 在分割视图控制器的展开模式和折叠模式之间切换时被调用, iPhone 6 Plus 下才行, 在 5s 下将总是显示上次的视图, 不会调用此方法
// 返回真: 在竖屏时, 什么也不选的情况下, detailItem 属性为 nil, 切换到横屏, 再切回来, 详情视图被移除, 将显示主视图
// 返回假: 在竖屏时, 选择一个行, detailItem 属性有东西在显示, 切换到横屏, 再切回来, 将依然显示详情视图, 以下默认操作代码将确保 detailItem 属性不为 nil 时, 详情控制器不会被移除
// 主视图控制器即为 primaryViewController, 详情视图控制器即为 secondaryViewController, 只对后者进行了判断
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {

    // 次要控制器是导航控制器, 其顶层控制器是详情控制器, 其内容为空, 即详情视图不存在, 即启动后没有任何操作, 没有创建详情视图
    if (    [secondaryViewController isKindOfClass:[UINavigationController class]] 
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] 
        && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        NSLog(@"he he he");
        return YES;
    } else {
        NSLog(@"la la la");
        return NO;
    }
}

@end
