//
//  KKExcelTableView.h
//  tableTestDemo
//
//  Created by hello on 2018/5/3.
//  Copyright © 2018年 XP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKExcelTableView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray titleHeight:(CGFloat)titleH titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor dataArray:(NSArray *)dataArray dataFont:(UIFont *)dataFont dataColor:(UIColor *)dataColor dataCellWidthArray:(NSArray *)cellWArr dataCellHeight:(CGFloat)cellH borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

@interface KKExcelTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *cellWidthArray;
@property(nonatomic,strong)UIColor *dataColor;
@property(nonatomic,strong)UIFont  *dataFont;
@property(nonatomic,strong)UIColor *borderColor;
@property(nonatomic,assign)CGFloat borderWidth;
@property(nonatomic,assign)CGFloat cellH;
@property(nonatomic,assign)CGFloat cellW;

@end
