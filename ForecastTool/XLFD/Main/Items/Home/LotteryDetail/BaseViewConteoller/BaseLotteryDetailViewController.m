//
//  BaseLotteryDetailViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/2.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "BaseLotteryDetailViewController.h"

@interface BaseLotteryDetailViewController ()

@property(nonatomic,strong)UIBarButtonItem *playButton;
@property(nonatomic,strong)UIBarButtonItem *noteButton;
@property(nonatomic,strong)UIButton *navTitleButton;
@property(nonatomic,strong)UIView *titleView;

@end




@implementation BaseLotteryDetailViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-navigationbar"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(36);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon-lotterydetail-navigationbar"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *placeholderButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 40)];
    placeholderButton.userInteractionEnabled = NO;
    UIBarButtonItem *letftItem = [[UIBarButtonItem alloc] initWithCustomView: placeholderButton];

//    self.navigationItem.leftBarButtonItems = @[self];

    self.navigationItem.rightBarButtonItems = @[self.playButton, self.noteButton];

    UIView *titleView = [UIView new];
    titleView.frame = CGRectMake(0, 0, 130, 36);
    [titleView addSubview:self.navTitleButton];
    [self.navTitleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [self.navTitleButton sizeToFit];
    _titleView = titleView;
    self.navigationItem.titleView = titleView;
//    self.view.backgroundColor = MCUIColorBetTableView;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self.navTitleButton setTitle:titleStr forState:UIControlStateNormal];
    [self setBtnImgAndLabel];
}

-(void)setBtnImgAndLabel{

    CGFloat labelWidth = [_navTitleButton.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MCFont(18)} context:nil].size.width;
    _navTitleButton.imageEdgeInsets = UIEdgeInsetsMake(5, labelWidth, 0, -labelWidth);
    _navTitleButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_navTitleButton.currentImage.size.width, 0, _navTitleButton.currentImage.size.width);

}

- (UIButton *)navTitleButton {
    if (_navTitleButton == nil) {
        _navTitleButton = [[UIButton alloc]init];
        _navTitleButton.titleLabel.font = MCFont(18);
        [_navTitleButton setTitle:@"广西11选5" forState:UIControlStateNormal];
        [_navTitleButton setTitleColor:MCUIColorWhite forState:UIControlStateNormal];
//        [_navTitleButton setImage:[UIImage imageNamed:@"icon-lotterydetail-class-down"] forState:UIControlStateNormal];
//        [_navTitleButton addTarget:self action:@selector(titleViewClick) forControlEvents:UIControlEventTouchUpInside];
        [self setBtnImgAndLabel];
    } return _navTitleButton;
}

-(UIBarButtonItem *)playButton {
    if (!_playButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn setImage:[UIImage imageNamed:@"icon-lotterydetail-play"] forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        _playButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    return _playButton;
}

-(UIBarButtonItem *)noteButton {
    if (!_noteButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn setImage:[UIImage imageNamed:@"icon-lotterydetail-note"] forState: UIControlStateNormal];
        [btn addTarget:self action:@selector(promptClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        _noteButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
    return _noteButton;
}

-(void)titleViewClick{
  
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
