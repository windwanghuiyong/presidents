//
//  DetailViewController.m
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController () <UIPopoverControllerDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建弹出窗口按钮, 点击切换弹出窗口
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.languageButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language" style:UIBarButtonItemStylePlain target:self action:@selector(toggleLanguagePopover)];
        self.navigationItem.rightBarButtonItem = self.languageButton;
    }

    [self configureView];
    NSLog(@"detail updated when loaded");
}

-(void) toggleLanguagePopover {
    if (self.languagePopoverController == nil) {
        // 创建弹出窗口
        LanguageListController *languageListController = [[LanguageListController alloc] init];
        languageListController.detailViewController = self;
        UIPopoverController *poc = [[UIPopoverController alloc] initWithContentViewController:languageListController];
        
        // 显示弹出窗口
        [poc presentPopoverFromBarButtonItem:self.languageButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.languagePopoverController = poc;
    } else {
        // 销毁弹出窗口
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

// 点击弹出窗口外其他地方关闭该窗口
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    if (popoverController == self.languagePopoverController) {
        self.languagePopoverController = nil;
    }
}

#pragma mark - Managing the detail item
// 转场时, 主视图控制器会调用此设值方法, 顺便更新详情视图控制器内容
- (void)setDetailItem:(NSDictionary *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        NSLog(@"detail updated when segue");
    
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSDictionary *dict = (NSDictionary *)self.detailItem;
//        NSString *urlString = dict[@"url"];
        
        // 设置详细视图 URL 地址名称
        NSString *urlString = modifyUrlForLanguage(dict[@"url"], self.languageString);    
        self.detailDescriptionLabel.text = urlString;
        
        // 请求 URL, 并加载
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        // 导航栏名称
        NSString *name = dict[@"name"];
        self.title = name;
        
//        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

-(void)setLanguageString:(NSString *)languageString {
    // 语言发生变化
    if (![languageString isEqualToString:self.languageString]) {
        _languageString = [languageString copy];
        [self configureView];
    }
    // 设置完语言后即可关闭弹出窗口
    if (self.languagePopoverController != nil) {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

// 根据指定语言替换 URL 中指定范围的字符, 自定义函数而非方法
static NSString *modifyUrlForLanguage(NSString *url, NSString *lang) {
    if (!lang) {
        return url;
    }
    NSRange codeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:codeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:codeRange withString:lang];
        return newUrl;
    }
}

@end
