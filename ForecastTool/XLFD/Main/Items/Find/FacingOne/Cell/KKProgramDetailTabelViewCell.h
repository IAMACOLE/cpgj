//
//  KKProgramDetailTabelViewCell.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/21.
//  Copyright © 2018年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGDDetailModel.h"
@interface KKProgramDetailTabelViewCell : UITableViewCell
-(void)buildWithData:(KKGDDetailModel *)model;
@property(assign,nonatomic)NSInteger row;
@end
