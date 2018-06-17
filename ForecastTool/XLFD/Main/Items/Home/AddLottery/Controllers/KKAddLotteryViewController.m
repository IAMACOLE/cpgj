//
//  KKAddLotteryViewController.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/9.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "KKAddLotteryViewController.h"
#import "KKAddLotteryTableViewCell.h"
#import "BannerButtonModel.h"
#import "KeyBoardView.h"

@interface KKAddLotteryViewController ()<UITableViewDelegate,UITableViewDataSource,KKAddLotteryTableViewCellDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation KKAddLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
     [self initUI];
    
    [self sendNetWorking];
    
   

}
-(void)initUI{
    [self.view addSubview:self.tableView];
}

-(void)sendNetWorking{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/get-all-cp-zl"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSDictionary * parameter = @{
                                 @"user_token" : token,
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        for ( NSDictionary *dict in data) {
            BannerButtonModel *model = [[BannerButtonModel alloc]initWithDictionary:dict error:nil];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}

-(void)basicSetting{
    self.titleString = @"彩种管理";
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDcell = @"cell";
    KKAddLotteryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKAddLotteryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.delegate = self;
    cell.row = indexPath.row;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
-(void)AddLotteryStatusClick:(BannerButtonModel *)model andRow:(NSInteger)row{

    BannerButtonModel *model1 = self.dataArray[row];
    model1.lottery_flag = model.lottery_flag;


    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"gc/edit-user-lottery"];
 
    NSString *token = [MCTool BSGetUserinfo_token];
    NSString *lottery_flag = @"1";
    if ([model.lottery_flag isEqual:@"0"]) {
        lottery_flag = @"1";
    }else{
        lottery_flag = @"0";
    }
    NSDictionary * parameter = @{
                                 @"user_token" : token,
                                 @"lottery_id" : model.lottery_id,
                                 @"lottery_flag" :lottery_flag
                                 };
    
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        if (IS_SUCCESS) {
            if ([model.lottery_flag  isEqual: @"0"]) {
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"删除成功"];
            }else{
                [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"添加成功"];
            }
        }
        
        NSNotification * notification = [NSNotification notificationWithName:@"RELOADHOMEPAGE" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
       
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setter & getter
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth, MCScreenHeight-64) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 95;
        //       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
