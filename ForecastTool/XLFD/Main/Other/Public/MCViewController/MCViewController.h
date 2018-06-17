//
//  MCViewController.h
//  SchoolMakeUp
//
//  Created by goulela on 16/9/26.
//  Copyright © 2016年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKAbnormalNetworkView.h"  // 网络404页面
#import "MCEmptyDataView.h"        // 数据请求空页面
#import "DefineDataHeader.h"

@interface MCViewController : UIViewController
<
KKAbnormalNetworkViewDelegate  // 刷新按钮点击事件
>
@property (nonatomic, strong) KKAbnormalNetworkView * abnormalView;
@property (nonatomic, strong) MCEmptyDataView * emptyView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, assign) BOOL isShow404View;
@property (nonatomic, assign) BOOL isShowEmptyView;
@property (nonatomic, strong) UIBarButtonItem *customLeftItem;
@property (nonatomic, strong) UIBarButtonItem *STcustomLeftItem;
@property (nonatomic, strong) UIBarButtonItem *noticeButtonItem;
@property (nonatomic, strong) UIBarButtonItem *doubtButtonItem;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, assign) BOOL isFirstVC;
-(void)pushToServiceController;
-(void)numberUnreadMessages;
@end
