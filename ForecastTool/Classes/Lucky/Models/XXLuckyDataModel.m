//
//  XXLuckyDataModel.m
//  ForecastTool
//
//  Created by hello on 2018/6/6.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXLuckyDataModel.h"

@implementation XXLuckyDataModel

-(void)setKj_code:(NSString *)kj_code{
    _kj_code = kj_code;
    NSArray *lottery_qhArr = [_kj_code componentsSeparatedByString:@","];
    _dataArr = lottery_qhArr;
    _colorArr = [NSMutableArray array];
    for(NSString *number in  lottery_qhArr){
        NSInteger num = [number integerValue];
        UIColor *color = nil;
        switch (num) {
            case 1:
                color = MCUIColorWithRGB(226, 220, 87, 1.0);
                break;
            case 2:
                color = MCUIColorWithRGB(97, 144, 212, 1.0);
                break;
            case 3:
                color = MCUIColorWithRGB(75, 75, 75, 1.0);
                break;
            case 4:
                color = MCUIColorWithRGB(211, 124, 58, 1.0);
                break;
            case 5:
                color = MCUIColorWithRGB(152, 222, 226, 1.0);
                break;
            case 6:
                color = MCUIColorWithRGB(74, 63, 240, 1.0);
                break;
            case 7:
                color = MCUIColorWithRGB(190, 190, 190, 1.0);
                break;
            case 8:
                color = MCUIColorWithRGB(202, 66, 43, 1.0);
                break;
            case 9:
                color = MCUIColorWithRGB(94, 30, 10, 1.0);
                break;
            case 10:
                color = MCUIColorWithRGB(127, 186, 69, 1.0);
                break;
            default:
                break;
        }
        [_colorArr addObject:color];
    }
    _rankingArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    for(int i = 0; i < lottery_qhArr.count;i++){
        NSString *ranking = nil;
        switch (i) {
            case 0:
                ranking = @"冠军";
                break;
            case 1:
                ranking = @"亚军";
                break;
            case 2:
                ranking = @"季军";
                break;
            case 3:
                ranking = @"第四";
                break;
            case 4:
                ranking = @"第五";
                break;
            case 5:
                ranking = @"第六";
                break;
            case 6:
                ranking = @"第七";
                break;
            case 7:
                ranking = @"第八";
                break;
            case 8:
                ranking = @"第九";
                break;
            case 9:
                ranking = @"第十";
                break;
            default:
                break;
        }
        NSInteger index = [lottery_qhArr[i] integerValue] - 1;
        _rankingArr[index] = ranking;
    }
    
}

@end


