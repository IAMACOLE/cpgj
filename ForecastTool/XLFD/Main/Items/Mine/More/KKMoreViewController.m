//
//  KKMoreViewController.m
//  Kingkong_ios
//
//  Created by goulela on 17/4/8.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKMoreViewController.h"

@interface KKMoreViewController ()
<
UITableViewDelegate,UITableViewDataSource
>

@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;

@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) NSArray * imageArray;

@end

@implementation KKMoreViewController

#pragma mark - 生命周期
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    
    [self sendNetWorking];
    
    [self initUI];
}

#pragma mark - 系统代理

#pragma mark UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    cell.backgroundColor = MCMineTableCellBgColor;
    
    cell.textLabel.text = self.titleArray[indexPath.row];
//    cell.imageView.image = self.imageArray[indexPath.row];
    cell.textLabel.font = MCFont(16);
    cell.textLabel.textColor = MCUIColorBlack;
    
    if (indexPath.row == 0) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@",app_Version];
    }
    if (indexPath.row == 1)
    {
        NSString * sizeStr = [self MCGetImageCache];
        cell.detailTextLabel.text = sizeStr;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        
//        MCH5ViewController * h5 = [[MCH5ViewController alloc] init];
//        h5.url = [MCTool BSGetObjectForKey:BSConfig_security_problem];
//        [self.navigationController pushViewController:h5 animated:YES];
    
    } else {
        
        [MCView BSMBProgressHUD_customWithView:self.view andImage:nil andText:@"清理中"];
        
        [self removeCache];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - 点击事件


#pragma mark 清理缓存
-(void)removeCache {
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

- (NSString *)MCGetImageCache {
    NSString *cacheSizeStr;
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    // 缓存的最小单位 B
    if (cacheSize < 1024)
    {
        cacheSizeStr = [NSString stringWithFormat:@"%lu B", (unsigned long)cacheSize];
    }
    else if(cacheSize >= 1024 && cacheSize < 1024 * 1024)
    {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f KB", cacheSize / 1024.0];
    }
    else if (cacheSize >= 1024 * 1024 && cacheSize < 1024 * 1024 * 1024)
    {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f MB", cacheSize / (1024 * 1024.0)];
    }
    else
    {
        cacheSizeStr = [NSString stringWithFormat:@"%.2f GB", cacheSize / (1024 * 1024 * 1024.0)];
    }
    return cacheSizeStr;
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    self.titleArray = @[@"当前版本",@"清理缓存"];
    self.imageArray = @[[UIImage imageNamed:@"Mine_version"],[UIImage imageNamed:@"Mine_clean"]];

    [self.tableView reloadData];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"更多";
    
}

#pragma mark - UI布局
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}



#pragma mark - setter & getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.backgroundColor = MCMineTableViewBgColor;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = MCMineTableViewBgColor;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    } return _tableView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}


@end
