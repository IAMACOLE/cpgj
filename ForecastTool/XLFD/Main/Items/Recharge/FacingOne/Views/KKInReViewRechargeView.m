//
//  KKInReViewRechargeView.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/9.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKInReViewRechargeView.h"

#import "KKInReViewRechargeTabelViewCell.h"
#import "KKInReViewModel.h"
#import "IAPShare.h"
@interface KKInReViewRechargeView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UILabel *balanceLabel;
@end

@implementation KKInReViewRechargeView

- (void)drawRect:(CGRect)rect {

    [self basicSetting];
    [self addSubViews];
}


-(void)basicSetting {
//    self.backgroundColor  = MCUIColorFromRGB(0xE4E4E4);
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *price in KIAP_Array) {
        KKInReViewModel *model = [[KKInReViewModel alloc] init];
        model.price = price;
        [self.dataArray addObject:model];
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDcell = @"cell";
    KKInReViewRechargeTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (cell ==nil) {
        cell = [[KKInReViewRechargeTabelViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDcell];
        //cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor clearColor];
    KKInReViewModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell buildWithData:model];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self RechargeClick:indexPath.row];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 45, 0, 0)];
    [_tableView setLayoutMargins:UIEdgeInsetsZero];
}


-(void)RechargeClick:(NSInteger ) index {
    
    
    [MCView BSMBProgressHUD_bufferAndTextWithView:[MCTool getCurrentVC].view andText:@"Loading..."];
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest* request,SKProductsResponse* response)
     {
         [MCView BSMBProgressHUD_hideWith:[MCTool getCurrentVC].view];
         if(response > 0 ) {
             
             
             NSMutableArray *bundleIds =  [MCTool getIAPsBundleId];
             NSString *productIdentifier  = [bundleIds objectAtIndex:index];
             
            SKProduct* product = [SKProduct new];
             
             for (SKProduct *object in response.products) {
                 if ([object.productIdentifier isEqualToString:productIdentifier]) {
                     product = object;
                     NSLog(@"Price: %@",object.price);
                     NSLog(@"Title: %@",object.localizedTitle);
                     [[IAPShare sharedHelper].iap buyProduct:object
                                                onCompletion:^(SKPaymentTransaction* trans){
                                                    
                                                    if(trans.error)
                                                    {
                                                        NSLog(@"Fail %@",[trans.error localizedDescription]);
                                                    }
                                                    else if(trans.transactionState == SKPaymentTransactionStatePurchased) {
                                                        
                                                        NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
                                                        NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
                                                        
                                                        NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
                                                        NSLog(@"receiptString : %@",receiptString);
                                                        
                                                        [self checkIap:receiptString];
                                                        
                                                        
                                                        
                                                    }
                                                    else if(trans.transactionState == SKPaymentTransactionStateFailed) {
                                                        NSLog(@"Fail");
                                                    }
                                                }];//end of buy product
                 }
             }
             
            
             
             
         }
     }];
    
}

-(void)checkIap:(NSString *)receiptStr {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/iap/set-validate"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSDictionary *   parameter =  @{
                                    @"user_token" : token,
                                    @"receipt_data": receiptStr,
                                    @"choose_env": @IS_TEST,
                                    };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:[MCTool getCurrentVC] isShowHUD:YES isShowTabbar:YES success:^(id data) {
        
        [KKBalanceManager getBalance:^(NSString *balance) {
            self.balanceLabel.text = balance;
            
        }];
    } dislike:^(id data) {
    } failure:^(NSError *error) {
    }];
    
}

-(void)addSubViews {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.tableView.tableHeaderView = self.headView;

    [KKBalanceManager getBalance:^(NSString *balance) {
        self.balanceLabel.text = balance;
    }];
    
}
-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, MCScreenWidth, 64);
        _headView.backgroundColor = [UIColor clearColor];
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = CGRectMake(0, 10, MCScreenWidth, 44);
        [_headView addSubview:contentView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [contentView addSubview:titleLabel];
        titleLabel.frame = CGRectMake(15, 0, 100, 44);
        titleLabel.font = MCFont(15);
        titleLabel.text = @"账户余额:";
        titleLabel.textColor = [UIColor blackColor];
        [contentView addSubview:titleLabel];
        
        self.balanceLabel = [[UILabel alloc] init];
        self.balanceLabel.frame = CGRectMake(MCScreenWidth - 50 - 150, 0, 150, 44);
        self.balanceLabel.textAlignment = NSTextAlignmentRight;
        self.balanceLabel.textColor = [UIColor blackColor];
        self.balanceLabel.font = MCFont(15);
        self.balanceLabel.text = @"0";
        [contentView addSubview:self.balanceLabel];
        //icon-pay
        UIImageView *payImageView = [[UIImageView alloc] init];
        payImageView.image = [UIImage imageNamed:@"icon-pay"];
        payImageView.frame = CGRectMake(MCScreenWidth -26 - 10, (44 -19)/2, 26, 19);
        [contentView addSubview:payImageView];
        //52 × 38
        
    }
    return _headView;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorColor = MCUIColorFromRGB(0xF6F6F6);
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 45, 0, 0)];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    return _tableView;
}

@end
