//
//  DetailViewController.h
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

//@property (strong, nonatomic) NSDate *detailItem;	// 视图控制器会将用户在主视图控制器中所选对象的引用赋给该属性
@property (strong, nonatomic) NSDictionary *detailItem;		// 总统信息, 由主控制器传入
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;	// 标签
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UIBarButtonItem		*languageButton;
@property (strong, nonatomic) UIPopoverController	*languagePopoverController;	// 详细视图拥有弹出窗口, 强引用
@property (copy, nonatomic) NSString					*languageString;

@end

