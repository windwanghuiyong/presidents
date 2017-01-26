//
//  MasterViewController.h
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController				//根控制器, 用于创建包含应用导航的表视图

@property (strong, nonatomic) DetailViewController *detailViewController;	// 子控制器


@end

