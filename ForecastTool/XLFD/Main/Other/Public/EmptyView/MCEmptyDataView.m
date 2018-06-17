//
//  MCEmptyDataView.m
//  SchoolMakeUp
//
//  Created by goulela on 16/10/27.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "MCEmptyDataView.h"

@interface MCEmptyDataView ()




@end

@implementation MCEmptyDataView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = MCMineTableCellBgColor;
        
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).with.offset(150);
            make.size.mas_equalTo(CGSizeMake(175, 160));
            //make.size.mas_equalTo(CGSizeMake(300, 300));
        }];
        
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(3);
            make.height.mas_equalTo(18);
        }];
    }
    return self;


}

- (void)drawRect:(CGRect)rect {
    
 
}

#pragma mark - setter & getter 
- (UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"Reuse_empty"];
    } return _imageView;
}

- (UILabel *)label {
    if (_label == nil) {
        self.label = [[UILabel alloc] init];
        self.label.textColor = MCUIColorMiddleGray;
        self.label.font = MCFont(18.0f);
        self.label.text = @"这里什么都没有";
    } return _label;
}

@end
