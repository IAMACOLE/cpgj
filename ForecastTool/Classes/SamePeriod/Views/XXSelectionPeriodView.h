//
//  XXSelectionPeriodView.h
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXSelectionPeriodView : UIView
@property(nonatomic,strong)NSString *selectionPeriodID;
@property(nonatomic,copy)void(^retutnselectionPeriodID)(NSString *selectionPeriodID);
@end
