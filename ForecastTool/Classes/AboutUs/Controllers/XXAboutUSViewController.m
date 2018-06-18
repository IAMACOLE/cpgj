//
//  XXAboutUSViewController.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXAboutUSViewController.h"

@interface XXAboutUSViewController ()

@end

@implementation XXAboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBackBtn];
    self.title = @"关于我们";
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    UIImageView *iconView = [UIImageView new];
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(70);
        make.top.mas_equalTo(100);
    }];
    iconView.image = [UIImage imageNamed:@"STAPPLogo"];
    iconView.clipsToBounds = YES;
    iconView.layer.cornerRadius = 10;
    
    
    UILabel *versionLab = [UILabel new];
    [self.view addSubview:versionLab];
    [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(iconView.mas_bottom).mas_offset(10);
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLab.text = [NSString stringWithFormat:@"v%@",appCurVersion];//@"v1.0";
    versionLab.textColor = [UIColor grayColor];
    versionLab.textAlignment = NSTextAlignmentCenter;
    
    UILabel *updateLabel = [UILabel new];
    [self.view addSubview:updateLabel];
    [updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(versionLab.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    updateLabel.text = @"       彩票工具提供PK10最新的开奖公告、走势图、号码统计等相关内容,方便彩民浏览、投注参考之用！";
    updateLabel.font = [UIFont systemFontOfSize:14];
    updateLabel.numberOfLines = 0;
    updateLabel.textColor = [UIColor grayColor];
    
    UILabel *copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MCScreenHeight - 50 -MCTabBarHeight, MCScreenWidth, 40)];
    copyrightLabel.backgroundColor = [UIColor clearColor];
    copyrightLabel.font = [UIFont systemFontOfSize:12.0f];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.textColor = [UIColor grayColor];
    copyrightLabel.text = @"Copyright © 北京极客科技有限公司.";
    copyrightLabel.numberOfLines = 0;
    [self.view addSubview:copyrightLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
