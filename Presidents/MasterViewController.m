//
//  MasterViewController.m
//  Presidents
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"		// 子控制器

@interface MasterViewController ()

//@property NSMutableArray *objects;	// 表单元名称数组
@property (copy, nonatomic) NSArray *presidents;		// 数组元素是字典对象

@end

@implementation MasterViewController

// 此函数最先执行
- (void)awakeFromNib {
    [super awakeFromNib];
    // 设备标识
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        // 表视图在显示时不取消选择的行
        self.clearsSelectionOnViewWillAppear = NO;
        // 主视图控制器在纵向模式时显示其他控制器(表视图)的尺寸, 左侧分割视图的宽度默认是320点, 与纵向模式下的 iPhone 宽度相同, 在 iOS8 中无效
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
        NSLog(@"iPad");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    // 向工具栏添加编辑按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
    // 向工具栏添加加号按钮, 向主视图控制器的表视图添加新条目
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    */
    
    // 加载属性列表
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PresidentList" ofType:@"plist"];
    NSDictionary *presidentInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    self.presidents = [presidentInfo objectForKey:@"presidents"];
    
    // 获取 DetailViewController 子控制器类实例变量, 一直存在, 无须新建, 可重用
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.title = @"Presidents~";		// 覆盖 storyboard 中的设置
    
    NSLog(@"master");
}

- (void)viewWillAppear:(BOOL)animated {
    // 点击 master 返回按钮, 分割视图被折叠, 则相应的选择自然要清除
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    NSLog(@"back to master");
}

/*
- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
        NSLog(@"master mutable array");
    }
    [self.objects insertObject:[NSDate date] atIndex:0];						// 日期作为条目名称存入数组
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"添加新条目");
}
*/

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // master 视图控制器到 detail 导航控制器
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];	// 表视图中选择的行
//        NSDate *object = self.objects[indexPath.row];						// 该行名称(日期字符串)
        
        // 创建新的详情视图控制器并将其视图添加到视图层级中
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        // 将就得详情控制器的语言复制到新的控制器, 在切换时就可以保留上次设置的语言
        controller.languageString = self.detailViewController.languageString;
        self.detailViewController = controller;
        
        NSDictionary *president = self.presidents[indexPath.row];
        controller.detailItem = president;
        
//        [controller setDetailItem:object];	// 设置子视图控制器的属性
        //在详情控制器的导航栏上添加了一个显示模式按钮(纵向模式下的 master 返回按钮)
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        NSLog(@"click");
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.objects.count;
    NSLog(@"共有%lu行", (unsigned long)[self.presidents count]);
    return [self.presidents count];		// 当前分区的单元数
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
    NSDictionary *president = self.presidents[indexPath.row];
    cell.textLabel.text = president[@"name"];	// 按键访问值
    
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];		// 数组名称作为表单元名称
    NSLog(@"new cell %@", cell.textLabel.text);
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"editing style delete");
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"editing style insert");
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/

@end
