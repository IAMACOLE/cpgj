//
//  BannerDetailTableViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "BannerDetailTableViewCell.h"
@interface BannerDetailTableViewCell()




@end
@implementation BannerDetailTableViewCell
static float RowHeight = 45;
static float ButtonHeight = 34;
static NSInteger row = 3;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
           }
    return self;
}
-(void)selectClick:(UIButton *)sender{
    NSInteger index = sender.tag -100;
    if (self.delegate &&[_delegate respondsToSelector:@selector(BannerDetailTableViewCellButtonClick:andSection:)]) {
        [self.delegate BannerDetailTableViewCellButtonClick:index andSection:index];
    }
}
+(id)cellWithCellTableView:(UITableView *)tableView andIndex:(NSIndexPath*)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
    BannerDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BannerDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;

}

-(void)setDetailButton:(NSArray *)dataArray{
    CGFloat space = MCScreenWidth/row;
    NSInteger Y = dataArray.count/row;
    for (int i=0; i<Y; i++) {
        for (int j=0; j<3; j++) {
            NSDictionary *dict1 = dataArray[i*3+j];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(j*space+15, i*RowHeight+8, space-30, ButtonHeight)];
            [btn setTitle:dict1[@"name"] forState:UIControlStateNormal];
            [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
            btn.layer.cornerRadius = ButtonHeight/2;
            btn.clipsToBounds = YES;
            btn.layer.borderColor = MCUIColorMain.CGColor;
            btn.layer.borderWidth = 1;
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100+j+i*row;
            [self addSubview:btn];
        }
       
    }
     _rowHeight =  Y*RowHeight;
    
    NSInteger surplus = dataArray.count%row;
    for (int z=0; z<surplus; z++) {
        NSDictionary *dict1 = dataArray[z + Y *row];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(z*space +15, RowHeight*Y+8, space-30, ButtonHeight)];
        [btn setTitle:dict1[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MCUIColorMain forState:UIControlStateNormal];
        btn.layer.cornerRadius = ButtonHeight/2;
        btn.clipsToBounds = YES;
        btn.layer.borderColor = MCUIColorMain.CGColor;
        btn.layer.borderWidth = 1;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+z+Y*row;
        [self addSubview:btn];
    }
    if (surplus != 0) {
        _rowHeight = _rowHeight + RowHeight;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
