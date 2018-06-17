//
//  MCViewController.m
//  SchoolMakeUp
//
//  Created by goulela on 16/9/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCViewController.h"
#import "KKNotificationViewController.h"

@interface MCViewController ()

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabelView;
@property (nonatomic, strong)UILabel *numberMessagesLabel;
@property (nonatomic,strong)UIButton *noticeButton;


@end

@implementation MCViewController

#pragma mark - 生命周期


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = MCUIColorWhite;
    
    if(KK_STATUS){
        
//        [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(40, 40) target:self selected:@selector(leftItemClicked) image:@"ST_BackBtn" isLeft:YES];
        
    }else{
        
        [self setTitleView];
        [self.view addSubview:self.bgImageView];
        if(self.isFirstVC && IS_IPHONE_X){
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
        
        
        [MCView BSBarButtonItem_image_Who:self.navigationItem size:CGSizeMake(40, 40) target:self selected:@selector(leftItemClicked) image:@"Reuse_Back" isLeft:YES];
    }
    
   
//    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
//    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

-(void)setIsFirstVC:(BOOL)isFirstVC{
    _isFirstVC = isFirstVC;
}

- (void)leftItemClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setIsShow404View:(BOOL)isShow404View {
    if (isShow404View == YES) {
        [self.view addSubview:self.abnormalView];
        [self.abnormalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.view);
        }];
    } else {
        [self.abnormalView removeFromSuperview];
    }
}

- (void)setIsShowEmptyView:(BOOL)isShowEmptyView {
    
    if (isShowEmptyView == YES) {
        [self.view addSubview:self.emptyView];
        [self.emptyView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(self.view);
        }];
    } else {
        [self.emptyView removeFromSuperview];
    }
}


- (void)KKAbnormalNetworkView_hitReloadButtonMethod {

}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabelView.text = titleString;
}

- (void)setTitleView {
    self.navigationItem.titleView = [[UIView alloc] init];
    self.titleImageView.frame = CGRectMake(0, 0, 200, 30);
    self.titleImageView.center = self.navigationItem.titleView.center;
    [self.navigationItem.titleView addSubview:self.titleImageView];
    self.titleLabelView.center = self.navigationItem.titleView.center;
    [self.navigationItem.titleView addSubview:self.titleLabelView];
}

- (UIImageView *)titleImageView {
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"标题框"]];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _titleImageView;
}

- (UILabel *)titleLabelView {
    if (_titleLabelView == nil) {
        _titleLabelView = [[UILabel alloc] init];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        _titleLabelView.text = app_name;
        _titleLabelView.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18.0f];
        _titleLabelView.textAlignment = NSTextAlignmentCenter;
        _titleLabelView.textColor = MCUIColorWithRGB(58, 54, 52, 1.0);
        [_titleLabelView sizeToFit];
        _titleLabelView.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabelView;
}

- (UIImageView *)bgImageView{
    if(_bgImageView == nil){
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"bgImageView_Image2"];
    }
    return _bgImageView;
}

- (KKAbnormalNetworkView *)abnormalView {
    if (_abnormalView == nil) {
        self.abnormalView = [[KKAbnormalNetworkView alloc] init];
        self.abnormalView.backgroundColor = MCUIColorWhite;
        self.abnormalView.customDelegate = self;
    } return _abnormalView;
}

- (MCEmptyDataView *)emptyView {
    if (_emptyView == nil) {
        self.emptyView = [[MCEmptyDataView alloc] init];
    } return _emptyView;
}

-(UIBarButtonItem *)noticeButtonItem {
    if (_noticeButtonItem == nil) {
        UIButton *noticeButtonItemView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        [noticeButtonItemView addTarget:self action:@selector(pushToNoticeController) forControlEvents:UIControlEventTouchUpInside];
        
        _noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _noticeButton.userInteractionEnabled = NO;
        _noticeButton.frame = CGRectMake(18, 5, 22, 20);
        [_noticeButton setBackgroundImage:[UIImage imageNamed:@"Mine_message"] forState:UIControlStateNormal];
        _noticeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _noticeButton.adjustsImageWhenHighlighted = NO;
        [noticeButtonItemView addSubview:_noticeButton];
        
        _numberMessagesLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 10, 10)];
        _numberMessagesLabel.backgroundColor = [UIColor redColor];
        _numberMessagesLabel.layer.cornerRadius = 5;
        _numberMessagesLabel.layer.masksToBounds = YES;
        _numberMessagesLabel.adjustsFontSizeToFitWidth = YES;
        _numberMessagesLabel.font = [UIFont systemFontOfSize:8];
        _numberMessagesLabel.textAlignment = NSTextAlignmentCenter;
        _numberMessagesLabel.textColor = [UIColor whiteColor];
        _numberMessagesLabel.hidden = YES;
        [noticeButtonItemView addSubview:_numberMessagesLabel];
        _noticeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:noticeButtonItemView];
    }
    
    return _noticeButtonItem;
}

- (UIBarButtonItem *)STcustomLeftItem {
    if (_STcustomLeftItem == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 42, 30);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"ST_BackBtn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;
        
        _STcustomLeftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _STcustomLeftItem;
}

- (UIBarButtonItem *)customLeftItem {
    if (_customLeftItem == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 42, 30);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"index2-4-3"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pushToServiceController) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;

        _customLeftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _customLeftItem;
}

-(void)pushToNoticeController {
    KKNotificationViewController * notificationViewController = [[KKNotificationViewController alloc] init];
    [self.navigationController pushViewController:notificationViewController animated:YES];

}
- (void)pushToServiceController {
    NSString *url = [MCTool BSGetObjectForKey:BSConfig_customer_service_url];
    if (url.length > 0) {
        MCH5ViewController *mch5Vc = [[MCH5ViewController alloc]init];
        mch5Vc.url = url;
        [self.navigationController pushViewController:mch5Vc animated:YES];
    }
}

#pragma mark 获了未读消息的条数
-(void)numberUnreadMessages{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"ad/message-not-read"];
    NSString *token = [MCTool BSGetUserinfo_token];
    if (token.length == 0) {
        return;
    }
    NSDictionary *  parameter =  @{@"user_token" : token};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameter andViewController:self isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSString *num = [NSString stringWithFormat:@"%@",[data objectForKey:@"num"]];
        if ([num isEqualToString:@"0"]) {
            _noticeButton.frame = CGRectMake(18, 5, 22, 20);
            _numberMessagesLabel.hidden = YES;
        }else{
            _noticeButton.frame = CGRectMake(0, 5, 22, 20);
            _numberMessagesLabel.hidden = NO;
            _numberMessagesLabel.text = num;
        }
    } dislike:^(id data) {} failure:^(NSError *error) {}];
}

@end

