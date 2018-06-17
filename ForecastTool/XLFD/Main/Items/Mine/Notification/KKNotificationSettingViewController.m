//
//  KKNotificationSettingViewController.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKNotificationSettingViewController.h"
#import "KKNotificationSettingCell.h"
#import "KKNotificationSettingModel.h"

@interface KKNotificationSettingViewController ()<UITableViewDelegate, UITableViewDataSource, SwitchOnOrOffDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArrayM;
@property (nonatomic, strong) NSMutableArray *subLotteryArray;

@end

@implementation KKNotificationSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
    [self sendNetWorking];
    [self initUI];
    
}

#pragma mark - 系统代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  ((NSMutableArray *)self.dataArrayM[section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KKNotificationSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
    cell.delegate = self;
    KKNotificationSettingModel *model;
    if (self.dataArrayM.count > 0) {
        model = self.dataArrayM[indexPath.section][indexPath.row];
        cell.customSwitch.tag = (indexPath.section + 1) * 100 + indexPath.row;
        cell.customSwitch.on = model.notice_on_off == 1 ? YES : NO;
        if (model.remark.length > 0) {
            NSString *title = [NSString stringWithFormat:@"%@\n%@", model.notice_title, model.remark];
             NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:title];
            NSRange range = [[titleStr string] rangeOfString:model.remark];
            [titleStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1.0] range:range];
            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
            cell.titleLabel.attributedText = titleStr;
        } else {
            cell.titleLabel.text = model.notice_title;
        }
    }
	if (indexPath.row > 0) {
		[cell remakeConstraints];
	} else {
		[cell restoreConstraints];
	}
    return cell;
}

- (void)switchOnOrOff:(UISwitch *)sender {
    for (int i=0; i < self.dataArrayM.count; i++) {
		NSMutableArray *tmpArray = self.dataArrayM[i];
		for (int j = 0; j < tmpArray.count; j++) {
			if (sender.tag == (i + 1) * 100 + j) {
				KKNotificationSettingModel *model = tmpArray[j];
				if ([model.notice_type isEqual:@"notice_kjgg"] && sender.on) {
					[tmpArray addObjectsFromArray:model.subList];
				}
				if ([model.notice_type isEqual:@"notice_kjgg"] && !sender.on) {
					[tmpArray removeObjectsInArray:model.subList];
					
				}
				[self switchOnOrOffNetWorkingWith:model.notice_type AndOnOrOff:sender.on];
				return;
			}
		}
    }
}


#pragma mark - 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"推送通知";
}

#pragma mark - 网络设置
- (void)sendNetWorking {
    self.dataArrayM = [NSMutableArray array];
		self.subLotteryArray = [NSMutableArray array];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/setting/get-notice-setup"];
    NSString * token = [MCTool BSGetUserinfo_token];
    NSDictionary *param = @{@"user_token": token};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self success:^(id data) {
        NSArray *dataArray = (NSArray *)data;
        
        for (int i=0; i<dataArray.count; i++) {
            NSDictionary *dataDict = dataArray[i];
					KKNotificationSettingModel *model = [[KKNotificationSettingModel alloc] initWithDictionary:dataDict error:nil];
			if (model.subList.count > 0) {
				NSMutableArray *subDataArray = [NSMutableArray array];
				for (NSDictionary *subDataDict in model.subList) {
					KKNotificationSettingModel *subModel = [[KKNotificationSettingModel alloc] initWithDictionary:subDataDict error:nil];
					[subDataArray addObject:subModel];
				}
				model.subList = subDataArray;
			}
			NSMutableArray *tmpArray = [NSMutableArray array];
			[tmpArray addObject:model];
			if ([model.notice_type isEqual:@"notice_kjgg"] && model.notice_on_off == 1) {
				[tmpArray addObjectsFromArray:model.subList];
			}
			
            [self.dataArrayM addObject:tmpArray];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } error:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:data];
        
    } failure:^(NSError *error) {
       
    }];
}

- (void)switchOnOrOffNetWorkingWith:(NSString *)notice_type AndOnOrOff:(BOOL)swtich {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", MCIP, @"/v2/setting/set-notice-setup"];
    NSString *token = [MCTool BSGetUserinfo_token];
    NSNumber *i = [[NSNumber alloc] initWithInt:(swtich == 0 ? 0 : 1)];
    NSDictionary *param = @{
                            @"user_token": token,
                            @"notice_type": notice_type,
                            @"notice_on_off": i
                            };
    [MCTool BSNetWork_postWithUrl:urlStr parameters:param andViewController:self success:^(id data) {
		for (NSMutableArray *subDataArray in self.dataArrayM) {
			for (KKNotificationSettingModel *model in subDataArray) {
				if ([model.notice_type isEqual:notice_type]) {
					model.notice_on_off = (swtich == 0 ? 0 : 1);
				}
			}
		}
		if ([notice_type isEqual:@"notice_kjgg"]) {
			[self sendNetWorking];
		}
    } error:^(id data) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:data];
    } failure:^(NSError *error) {
       
    }];
}

#pragma mark - UI设置
- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = MCMineTableViewBgColor;
        [_tableView registerClass:[KKNotificationSettingCell class] forCellReuseIdentifier:@"cell"];
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = MCMineTableViewBgColor;
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

@end
