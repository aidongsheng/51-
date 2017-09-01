//
//  ZJDCIndexViewController.m
//  Pods
//
//  Created by aidongsheng on 2017/8/30.
//
//

#import "ZJDCIndexViewController.h"
#import "ZJDCIndexHeadMenuTableViewCell.h"
#import "ZJDCIndexTableView.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ZJDCIndexViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) ZJDCIndexTableView * indexTableView;

@end

static NSString * const headMenuCellIdentifier = @"ZJDCIndexHeadMenuTableViewCell";

@implementation ZJDCIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _indexTableView = [[ZJDCIndexTableView alloc]initWithFrame:CGRectMake(0, 0, 300, 500) style:UITableViewStyleGrouped];
    _indexTableView.dataSource = self;
    _indexTableView.delegate = self;
    [_indexTableView registerClass:[ZJDCIndexHeadMenuTableViewCell class] forCellReuseIdentifier:headMenuCellIdentifier];
    [self.view addSubview:_indexTableView];
    self.view.backgroundColor = [UIColor redColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJDCIndexHeadMenuTableViewCell * headMenucell = [tableView dequeueReusableCellWithIdentifier:headMenuCellIdentifier];
    
    if (headMenucell == nil) {
        headMenucell = [[ZJDCIndexHeadMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:headMenuCellIdentifier];
        
        
    }
    return headMenucell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_indexTableView fd_heightForCellWithIdentifier:headMenuCellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
