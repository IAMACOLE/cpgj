//
//  KKActivityViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/10.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKActivityViewController.h"
#import "KKNotificationViewController.h"
#import "KKActivityHeadView.h"
#import "KKActivityTableViewCell.h"
#import "KKActivityModel.h"
@interface KKActivityViewController () <UITableViewDelegate,UITableViewDataSource,KKActivityHeadViewDelegate>
@property (nonatomic, strong) UITableView    * tableView;
@property (nonatomic, strong) NSMutableArray * dataArrayM;
@property (nonatomic, strong) KKActivityHeadView * headView;
@property (nonatomic,strong) NSString *activity_type;
@property (nonatomic,strong) NSString *order_by;
@property (assign,nonatomic) int  page_no;
@end

@implementation KKActivityViewController


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    
    [self initUI];
}

#pragma mark - 网络请求
- (void)sendNetWorking {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/activity/get-activity"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSDictionary * parameter = nil;
  
    if ([self.activity_type isEqualToString:@""]) {
        parameter =  @{
                       @"user_token" : token,
                       @"order_by": self.order_by
                       };
    }else{
        parameter =  @{
                       @"user_token" : token,
                       @"activity_type": self.activity_type,
                       @"order_by": self.order_by
                       };
    }
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:YES success:^(id data) {
        [self setIsShow404View:NO];
        
        NSArray * dataArray = (NSArray *)data;
        self.dataArrayM = [KKActivityModel arrayOfModelsFromDictionaries:dataArray error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
             [self.tableView reloadData];
            
        });
        
        [self.tableView.mj_header endRefreshing];
    } dislike:^(id data) {
        [self setIsShow404View:YES];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        if (self.page_no == 1) {
            [self setIsShow404View:YES];
        }
        [self.tableView.mj_header endRefreshing];
        
    }];

}

-(void)KKAbnormalNetworkView_hitReloadButtonMethod {
    [self setIsShow404View:NO];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 实现方法
#pragma mark 基本设置
- (void)basicSetting {
    
    self.activity_type = @"";
    self.order_by = @"";
    self.page_no = 1;
    self.titleString = @"优惠活动";
    self.navigationItem.leftBarButtonItem = self.customLeftItem;
    self.navigationItem.rightBarButtonItem = self.noticeButtonItem;
    self.bgImageView.image = [UIImage imageNamed:@"bgImageView_Image1"];
}

#pragma mark - UI布局
- (void)initUI {
    
    if(IS_IPHONE_X){
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-30);
        }];
        UIImageView *imageView = [UIImageView new];
        [self.view addSubview:imageView];
        imageView.backgroundColor = MCUIColorFromRGB(0x272522);
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            
        }];
    }else{
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.headView selectIndex:0];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - 代理
-(void)didSelectCategoryAtIndex:(KKActivityHeadView *)view atIndex:(NSInteger)index{

    switch (index) {
        case 0:
//            self.sortView.titleLabel.text = @"所有活动";
            self.activity_type = @"";
            break;
        case 1:
//            self.sortView.titleLabel.text = @"限时优惠";
            self.activity_type = @"01";
            break;
        case 2:
//            self.sortView.titleLabel.text = @"免费活动";
            self.activity_type = @"02";
            break;
        case 3:
//            self.sortView.titleLabel.text = @"VIP专享";
            self.activity_type = @"03";
            break;
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
//    [self.sortView selectIndex:0];

}
//
//-(void)didSelectSortAtIndex:(KKActivitySortView *)view atIndex:(NSInteger)index {
//    switch (index) {
//        case 0:
//            self.order_by = @"1";
//            break;
//        case 1:
//            self.order_by = @"2";
//            break;
//        default:
//            break;
//    }
//
//}

#pragma mark - 点击事件
- (void)rightItemClikced {
    KKNotificationViewController * notificationViewController = [[KKNotificationViewController alloc] init];
    [self.navigationController pushViewController:notificationViewController animated:YES];

}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.rowHeight = 84;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            [self sendNetWorking];
        }];
    } return _tableView;
}

#pragma mark -  UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    KKActivityModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    //cell.model = self.dataArrayM[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKActivityModel *model = [self.dataArrayM objectAtIndex:indexPath.row];
   
    if (![model.turn_url isEqualToString:@""]) {
        MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        NSString *jmpUrl = nil;
        NSString * token = [MCTool BSGetUserinfo_token];
        if (token.length == 0) {
            jmpUrl = model.turn_url;
        }else{
            jmpUrl = [NSString stringWithFormat:@"%@?user_token=%@",model.turn_url,token];
        }
        
        mch5Vc.url = jmpUrl;
        [self.navigationController pushViewController:mch5Vc animated:YES];
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}

- (KKActivityHeadView *)headView {
     if (_headView == nil) {
    NSArray *imageArray = [NSArray arrayWithObjects:@"icon-activit-all",@"icon-activit-free",@"icon-activit-time",@"icon-activit-vip", nil];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"所有活动",@"限时优惠",@"免费活动",@"VIP专享", nil];
    _headView = [[KKActivityHeadView alloc] initWithImageArray:imageArray titleArray:titleArray];
     _headView.backgroundColor = [UIColor clearColor];
         _headView.delegate = self;
     }
     return _headView;
}

- (NSMutableArray *)dataArrayM {
    if (_dataArrayM == nil) {
        self.dataArrayM = [NSMutableArray arrayWithCapacity:0];
    } return _dataArrayM;
}


@end
