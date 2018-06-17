//
//  KKInfoSegmentView.m
//  Kingkong_ios
//
//  Created by hello on 2018/3/24.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKInfoSegmentView.h"
@interface KKInfoSegmentView ()
@property(nonatomic,strong)UIButton *programBtn;
@property(nonatomic,strong)UIButton *followUerBtn;
@end

@implementation KKInfoSegmentView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    } return self;
}

-(void)addSubViews {
    
    
    
    
    self.programBtn = [[UIButton alloc] init];
    self.programBtn.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    
    [self.programBtn setTitle:@"方案详情" forState:UIControlStateNormal];
   
    self.programBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:_programBtn];
   
    [self.programBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.programBtn setTitleColor:MCUIColorFromRGB(0x6A6767) forState:UIControlStateNormal];
    [self.programBtn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.programBtn setBackgroundImage:[self imageWithColor:MCUIColorFromRGB(0xC7B7B4)] forState:UIControlStateNormal];
    [self.programBtn setBackgroundImage:[self imageWithColor:MCUIColorFromRGB(0x6F0908)] forState:UIControlStateSelected];
    
    self.programBtn.selected = YES;
    
    self.followUerBtn = [[UIButton alloc] init];
    self.followUerBtn.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    
    [self.followUerBtn setTitle:@"跟单用户" forState:UIControlStateNormal];
    
    self.followUerBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.followUerBtn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.followUerBtn];
    
    [self.followUerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.followUerBtn setTitleColor:MCUIColorFromRGB(0x6A6767) forState:UIControlStateNormal];
    
    [self.followUerBtn setBackgroundImage:[self imageWithColor:MCUIColorFromRGB(0xC7B7B4)] forState:UIControlStateNormal];
    [self.followUerBtn setBackgroundImage:[self imageWithColor:MCUIColorFromRGB(0x6F0908)] forState:UIControlStateSelected];
    self.followUerBtn.selected = NO;
}



-(void)segmentClick:(UIButton *)sender {
    if (self.programBtn == sender) {
        self.programBtn.selected = YES;
        self.followUerBtn.selected = NO;
    }else{
        self.programBtn.selected = NO;
        self.followUerBtn.selected = YES;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(didSelectFollowAtIndex:atIndex:)] && self.delegate) {
        
        if (self.programBtn == sender) {
          [self.delegate didSelectFollowAtIndex:self atIndex:0];
        }else{
            [self.delegate didSelectFollowAtIndex:self atIndex:1];
        }
        
        
    }
    
}



// 颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
