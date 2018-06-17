//
//  HomeCollectionViewHeadCell.h
//  Kingkong_ios
//
//  Created by 222 on 2018/1/4.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefineDataHeader.h"

@protocol GrantsButtonDelegate

@required
- (void)grantsButtonClick;

@end

@interface HomeCollectionViewHeadCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *grantsButton;
@property (nonatomic, strong) UILabel *streamContentLabel;
@property (nonatomic, strong) UILabel *gainAndLossContentLabel;
@property (nonatomic, strong) UILabel *rankingContentLabel;
@property (nonatomic, weak) id<GrantsButtonDelegate>delegate;

- (void)loadData:(id)data;

@end
