//
//  KKProgramViewController.h
//  Kingkong_ios
//
//  Created by hello on 2018/1/18.
//  Copyright © 2018年 MC. All rights reserved.
//


#import "VTMagic.h"

#import "KKFindModel.h"
@class KKProgramViewController;
//@protocol KKProgramViewControllerDelegate<NSObject>
//
//- (void)didSliderAtIndexClick:(KKProgramViewController *)view atIndex:(NSInteger) index;
//@end

@interface KKProgramViewController : UIViewController
//@property(nonatomic,weak)id<KKProgramViewControllerDelegate>delegate;
-(void)buildData:(NSMutableArray *)gdDetailModelArray gdUserModelArray:(NSMutableArray*)gdUserModelArray findModel:(KKFindModel *)findModel;

@end
