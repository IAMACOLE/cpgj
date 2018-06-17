//
//  KKActivityHeadView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/11.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKActivityHeadView.h"

#import <UIKit/UIKit.h>



@interface KKActivityHeadView ()
@property (assign, nonatomic) UIEdgeInsets contentInsets;
@end

@implementation KKActivityHeadView

- (instancetype)initWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.imageArray = imageArray;
        self.titleArray = titleArray;
        self.contentInsets = UIEdgeInsetsMake(10, 20, 10, 20);
        [self initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
}

-(void) initUI {
    
    CGFloat itemWidth = kAdapterWith(54 );
    
    CGFloat itemSpacing = (MCScreenWidth - self.contentInsets.left - self.contentInsets.right - (self.imageArray.count * itemWidth)) / (self.imageArray.count-1);
    
    for (int i = 0;i< self.imageArray.count;i++) {
        NSString *imageName = self.imageArray[i];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(self.contentInsets.left + (i * (itemSpacing + itemWidth)), self.contentInsets.top, itemWidth, itemWidth);
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
         
        button.tag = i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    UIImageView *dottedLine = [UIImageView new];
    [self addSubview:dottedLine];
    [dottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-2);
    }];
    dottedLine.image = [UIImage imageNamed:@"dotted_line"];
}

-(void) btnClick:(UIButton *) button {
    if ([self.delegate respondsToSelector:@selector(didSelectCategoryAtIndex:atIndex:)] && self.delegate) {
        [self.delegate didSelectCategoryAtIndex:self atIndex:button.tag];
    }
}

-(void)selectIndex:(NSInteger)index {

    for (UIButton *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            if (view.tag == index) {
                [self btnClick: view];
            }
        }
    }
}

@end
