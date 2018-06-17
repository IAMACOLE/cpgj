//
//  KKFindMVPView.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKFindMVPView.h"
#import "KKFindMVPPeopleView.h"
@interface KKFindMVPView ()
@property (nonatomic, strong)  NSMutableArray *peopleViewArray;
@end
@implementation KKFindMVPView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
    }
    return self;
}




-(void)addViews {

    UIImageView *titleview = [[UIImageView alloc] init];
    titleview.image = [UIImage imageNamed:@"icon-find-titleview"];
    [self addSubview:titleview];
    [titleview mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"大神榜";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = MCFont(kAdapterFontSize(14));
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.centerY.mas_equalTo(titleview);
        make.height.mas_equalTo(20);
    }];
    

    
    
    for (int i = 0; i < 5; i++) {
        
        
        CGFloat itemWith = (MCScreenWidth - 20) / 5;
        
        KKFindMVPPeopleView *peopleView = [[KKFindMVPPeopleView alloc] init];
        peopleView.backgroundColor = [UIColor clearColor];
        peopleView.frame = CGRectMake(10 + (itemWith * i), 27.5, itemWith, kAdapterheight(100));
        [peopleView setHidden:YES];
        [self addSubview:peopleView];
        peopleView.tag = i;
        peopleView.bgButton.tag = i;
        [peopleView.bgButton addTarget:self action:@selector(peopleViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.peopleViewArray addObject:peopleView];
        if (i == 4) {
            peopleView.lineView.hidden = YES;
        }
        
    }
    
}




-(void)buildWithData:(NSMutableArray *)modelArray {
    
    
    for (KKFindMVPPeopleView *peopleView in self.peopleViewArray) {
        [peopleView setHidden:YES];
    }
    
    
    
    for (int i = 0; i<modelArray.count; i++) {
        KKFindMVPPeopleView *peopleView = [self.peopleViewArray objectAtIndex:i];
        KKMVPPeopleModel *model = [modelArray objectAtIndex:i];
        [peopleView buildWithData:model];
        [peopleView setHidden:NO];
    }
    
    
}

- (NSMutableArray *)peopleViewArray {
    if (_peopleViewArray == nil) {
        _peopleViewArray = [NSMutableArray arrayWithCapacity:0];
    } return _peopleViewArray;
}

-(void)peopleViewClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(didClickMvpPeople:index:)] && self.delegate) {
        [self.delegate didClickMvpPeople:self index:sender.tag];
    }
}

-(void)lookMoreClick{
    if ([self.delegate respondsToSelector:@selector(didClickLookMore:)] && self.delegate) {
        [self.delegate didClickLookMore:self];
    }
}
-(CGFloat)heightFowView{
    return 30 + kAdapterheight(95);
}


@end
