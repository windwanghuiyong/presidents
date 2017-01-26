//
//  LanguageListController.h
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LanguageListController : UITableViewController

@property (weak, nonatomic) DetailViewController *detailViewController;		// 详细视图控制器拥有弹出窗口控制器, 弱引用
@property (copy, nonatomic) NSArray *languageNames;		// copy 特性将总是返回不可变数组
@property (copy, nonatomic) NSArray *languageCodes;

@end
