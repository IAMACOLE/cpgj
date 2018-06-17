//
//  KKRegistProtocolViewController.m
//  BaBaQiQi_ios
//
//  Created by hello on 2018/5/31.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKRegistProtocolViewController.h"

@interface KKRegistProtocolViewController ()

@property(nonatomic,strong)UITextView *textView;

@end

@implementation KKRegistProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册协议";
    [self setupUI];
    [self getData];
}

-(void)getData{
    
    NSDictionary* imagesDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = imagesDict[@"CFBundleDisplayName"];
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"v2/app-charge-url/get-register-protocol"];
    NSDictionary *parameters = @{@"content":appName};
    [MCTool BSNetWork_postWithUrl:urlStr parameters:parameters andViewController:nil isShowHUD:NO isShowTabbar:NO success:^(id data) {
        NSDictionary *dict = data;
        NSString *string = dict[@"content"];
        if(!kStringIsEmpty(string)){
            NSAttributedString *attributeStr = [[NSAttributedString alloc]initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute :NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            _textView.attributedText = attributeStr;
        }
        
    } dislike:^(id data) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}

-(void)setupUI{
    UITextView *textView = [UITextView new];
    [self.view addSubview:textView];
    _textView = textView;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    textView.editable = NO;
    textView.selectable = NO;
    textView.font = [UIFont systemFontOfSize:15];
    
}

@end
