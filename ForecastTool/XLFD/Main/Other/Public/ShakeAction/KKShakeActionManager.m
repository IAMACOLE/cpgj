//
//  KKShakeActionManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/1/30.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKShakeActionManager.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "KKLotteryDataModel.h"
#import "LotteryDetailModel.h"
#import "LHCLotteryModel.h"

@implementation KKShakeActionManager

+(void)shakeActionWithLotteryType:(NSString *)lotteryType dataArray:(NSArray *)dataArray wf_flag:(NSString *)wf_flag selectedDigitArr:(NSMutableArray *)selectedDigitArr{
    
    //设置震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSLog(@"%@",wf_flag);
    
    if([lotteryType isEqualToString:@"11选5"]){
        
        //任选1中1复式  前一直选  定单双
        if([wf_flag isEqual:@"11x5_rx_1z1fs"] || [wf_flag isEqual:@"11x5_1m_q1zhix"] || [wf_flag isEqual:@"11x5_bdw_q3bdw"] || [wf_flag isEqual:@"11x5_qwx_dds"] || [wf_flag isEqual:@"11x5_qwx_czs"]){
            for(int j = 0;j < dataArray.count;j++){
                int allCount = 0;
                if([wf_flag isEqual:@"11x5_qwx_dds"]){
                    allCount = 6;
                }else if ([wf_flag isEqual:@"11x5_qwx_czs"]){
                    allCount = 7;
                }else{
                    allCount = 11;
                }
                KKLotteryDataModel *dataModel = dataArray[j];
                NSMutableArray *dataArr = [NSMutableArray arrayWithArray:dataModel.dataSource];
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                int newNum = arc4random() % allCount;
                NSLog(@"%d",newNum);
                
                for(int i = 0;i < dataArr.count;i++){
                    if(i == newNum){
                        LotteryDetailModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
            }
            //任选2中2复式 任选3中3复式 任选4中4复式 任选5中5复式 任选6中5复式 任选7中5复式 任选8中5复式 前三组选复式 前二组选复式
        }else if([wf_flag isEqual:@"11x5_rx_2z2fs"] || [wf_flag isEqual:@"11x5_rx_3z3fs"] ||[wf_flag isEqual:@"11x5_rx_4z4fs"] || [wf_flag isEqual:@"11x5_rx_5z5fs"] || [wf_flag isEqual:@"11x5_rx_6z5fs"] || [wf_flag isEqual:@"11x5_rx_7z5fs"] || [wf_flag isEqual:@"11x5_rx_8z5fs"] || [wf_flag isEqual:@"11x5_3m_q3zuxfs"]  || [wf_flag isEqual:@"11x5_2m_q2zuxfs"] ) {
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSMutableArray *dataArr = [NSMutableArray arrayWithArray:dataModel.dataSource];
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
                int count = 0;
                if([wf_flag isEqual:@"11x5_rx_2z2fs"] || [wf_flag isEqual:@"11x5_2m_q2zuxfs"]){
                    count = 9;
                }else if([wf_flag isEqual:@"11x5_rx_3z3fs"] || [wf_flag isEqual:@"11x5_3m_q3zuxfs"]){
                    count = 8;
                }else if ([wf_flag isEqual:@"11x5_rx_4z4fs"]){
                    count = 7;
                }else if([wf_flag isEqual:@"11x5_rx_5z5fs"]){
                    count = 6;
                }else if([wf_flag isEqual:@"11x5_rx_6z5fs"]){
                    count = 5;
                }else if([wf_flag isEqual:@"11x5_rx_7z5fs"]){
                    count = 4;
                }else if([wf_flag isEqual:@"11x5_rx_8z5fs"]){
                    count = 3;
                }
                
                for(int k = 11;k > count;k--){
                    int newNum = arc4random() % k;
                    NSLog(@"%d",newNum);
                    
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                    [numArr removeObjectAtIndex:newNum];
                }
            }
            // 前三定位胆
        }else if ([wf_flag isEqual:@"11x5_dwd_q3dwd"]){
            int randRow = arc4random() % 3;
            int newNum = arc4random() % 11;
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSMutableArray *dataArr = [NSMutableArray arrayWithArray:dataModel.dataSource];
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                if(j == randRow){
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
                
            }
            
            //前三直选复式 前二直选复式
        }else if ([wf_flag isEqual:@"11x5_3m_q3zhixfs"] || [wf_flag isEqual:@"11x5_2m_q2zhixfs"]){
            
            //生成不重复随机数
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
            NSMutableArray *selectedArr = [NSMutableArray array];
            int count = 8;
            if([wf_flag isEqual:@"11x5_3m_q3zhixfs"]){
                count = 7;
            }
            for(int k = 10;k > count;k--){
                int newNum = arc4random() % k;
                NSLog(@"%d",newNum);
                [selectedArr addObject:numArr[newNum]];
                [numArr removeObjectAtIndex:newNum];
            }
            
            for(int j = 0;j < dataArray.count;j++){
                KKLotteryDataModel *dataModel = dataArray[j];
                NSMutableArray *dataArr = [NSMutableArray arrayWithArray:dataModel.dataSource];
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                for(int i = 0;i < dataArr.count;i++){
                    if(i == [selectedArr[j] integerValue]){
                        LotteryDetailModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
                
            }
            
            // 前三组选胆拖 前二组选拖胆 任选二胆拖 任选三胆拖 任选四胆拖 任选五胆拖 任选六胆拖 任选七胆拖
        }else if ([wf_flag isEqual:@"11x5_3m_q3zuxdt"] || [wf_flag isEqual:@"11x5_2m_q2zuxdt"] ||[wf_flag isEqual:@"11x5_dt_2"] || [wf_flag isEqual:@"11x5_dt_3"] || [wf_flag isEqual:@"11x5_dt_4"]|| [wf_flag isEqual:@"11x5_dt_5"]|| [wf_flag isEqual:@"11x5_dt_6"] || [wf_flag isEqual:@"11x5_dt_7"]){
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSMutableArray *dataArr = [NSMutableArray arrayWithArray:dataModel.dataSource];
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                static int newNum = 0;
                //先随机生成一个胆码
                if(j == 0){
                    newNum = arc4random() % 11;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }else{
                    //生成不重复随机数 作为拖码
                    NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"]];
                    //除去已选数字
                    for(int h = 0;h < numArr.count;h++){
                        NSString *numStr = numArr[h];
                        if(newNum == [numStr integerValue]){
                            [numArr removeObject:numStr];
                        }
                    }
                    
                    int lastNum = 0;
                    if([wf_flag isEqual:@"11x5_2m_q2zuxdt"] || [wf_flag isEqual:@"11x5_dt_2"] ){
                        lastNum = 9;
                    }else if([wf_flag isEqual:@"11x5_3m_q3zuxdt"] ||[wf_flag isEqual:@"11x5_dt_3"] ){
                        lastNum = 8;
                    }else if ([wf_flag isEqual:@"11x5_dt_4"]){
                        lastNum = 7;
                    }else if ([wf_flag isEqual:@"11x5_dt_5"]){
                        lastNum = 6;
                    }else if ([wf_flag isEqual:@"11x5_dt_6"]){
                        lastNum = 5;
                    }else if ([wf_flag isEqual:@"11x5_dt_7"]){
                        lastNum = 4;
                    }
                    
                    for(int k = 10;k > lastNum;k--){
                        int newNum = arc4random() % k;
                        NSLog(@"%d",newNum);
                        
                        for(int i = 0;i < dataArr.count;i++){
                            if(i == [numArr[newNum] integerValue]){
                                LotteryDetailModel *model = dataArr[i];
                                model.isSelect = YES;
                            }
                        }
                        [numArr removeObjectAtIndex:newNum];
                    }
                }
                
            }
        }
        
    }else if ([lotteryType isEqualToString:@"时时彩"]){
        
        //五星组选120  前四组选24 后四组选24 前四组选6 后四组选6 前三组三复式 前三组六复式 中三组三复式 中三组六复式 后三组三复式 后三组六复式 前二组选复式 后二组选复式 前三二码不定 中三二码不定 后三二码不定 后四二码不定 五星二码不定 五星三码不定 任二组选复式 任三组三复式 任三组六复式 任四组选24 任四组选6
        if ([wf_flag isEqual:@"ssc_5xzux_120"] || [wf_flag isEqual:@"ssc_4xzux_qszux24"] || [wf_flag isEqual:@"ssc_4xzux_hszux24"] || [wf_flag isEqual:@"ssc_4xzux_qszux6"]|| [wf_flag isEqual:@"ssc_4xzux_hszux6"] || [wf_flag isEqual:@"ssc_q3zux_q3zu3fs"] || [wf_flag isEqual:@"ssc_q3zux_q3zu6fs"] || [wf_flag isEqual:@"ssc_z3zux_z3zu3fs"] || [wf_flag isEqual:@"ssc_z3zux_z3zu6fs"] || [wf_flag isEqual:@"ssc_h3zux_h3zu3fs"] || [wf_flag isEqual:@"ssc_h3zux_h3zu6fs"] || [wf_flag isEqual:@"ssc_3xbdw_q32"] || [wf_flag isEqual:@"ssc_3xbdw_z32"] || [wf_flag isEqual:@"ssc_3xbdw_h32"] ||[wf_flag isEqual:@"ssc_4xbdw_h42"] ||[wf_flag isEqual:@"ssc_4xbdw_h52"] || [wf_flag isEqual:@"ssc_4xbdw_h53"] || [wf_flag isEqual:@"ssc_r2zux_fs"] || [wf_flag isEqual:@"ssc_r3zux_z3fs"] || [wf_flag isEqual:@"ssc_r3zux_z6hz"] || [wf_flag isEqual:@"ssc_r4zux_24"]|| [wf_flag isEqual:@"ssc_r4zux_6"]||[wf_flag isEqual:@"ssc_h2zux_fs"]||[wf_flag isEqual:@"ssc_q2zux_fs"]){
            
            
            NSMutableArray *digitArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4"]];
            [selectedDigitArr removeAllObjects];
            //随机取得 万位 千位 百位 十位 个位中的相应个数
            if([wf_flag isEqual:@"ssc_r2zux_fs"] || [wf_flag isEqual:@"ssc_r3zux_z3fs"] || [wf_flag isEqual:@"ssc_r3zux_z6hz"] || [wf_flag isEqual:@"ssc_r4zux_24"] || [wf_flag isEqual:@"ssc_r4zux_6"]){
                int selectCount = 0;
                if([wf_flag isEqual:@"ssc_r2zux_fs"]){
                    selectCount = 3;
                }else if([wf_flag isEqual:@"ssc_r4zux_24"]|| [wf_flag isEqual:@"ssc_r4zux_6"]){
                    selectCount = 1;
                }else{
                    selectCount = 2;
                }
                
                //生成不重复随机数
                for(int k = 5;k > selectCount;k--){
                    int newNum = arc4random() % k;
                    [selectedDigitArr addObject:digitArr[newNum]];
                    [digitArr removeObjectAtIndex:newNum];
                }
            }
            
            for(int j = 0;j < dataArray.count;j++){
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
                int count = 0;
                if([wf_flag isEqual:@"ssc_5xzux_120"]){
                    count = 5;
                }else if([wf_flag isEqual:@"ssc_4xzux_qszux24"] || [wf_flag isEqual:@"ssc_4xzux_hszux24"]|| [wf_flag isEqual:@"ssc_r4zux_24"]){
                    count = 6;
                }else if([wf_flag isEqual:@"ssc_q3zux_q3zu6fs"] || [wf_flag isEqual:@"ssc_z3zux_z3zu6fs"]|| [wf_flag isEqual:@"ssc_h3zux_h3zu6fs"] || [wf_flag isEqual:@"ssc_4xbdw_h53"] || [wf_flag isEqual:@"ssc_dxds_q3"] || [wf_flag isEqual:@"ssc_dxds_h3"] || [wf_flag isEqual:@"ssc_r3zux_z6hz"]){
                    count = 7;
                }else if([wf_flag isEqual:@"ssc_4xzux_qszux6"]|| [wf_flag isEqual:@"ssc_4xzux_hszux6"] || [wf_flag isEqual:@"ssc_q3zux_q3zu3fs"] || [wf_flag isEqual:@"ssc_z3zux_z3zu3fs"]|| [wf_flag isEqual:@"ssc_h3zux_h3zu3fs"]|| [wf_flag isEqual:@"ssc_q2zux_fs"] || [wf_flag isEqual:@"ssc_h2zux_fs"] || [wf_flag isEqual:@"ssc_3xbdw_q32"] || [wf_flag isEqual:@"ssc_3xbdw_z32"] || [wf_flag isEqual:@"ssc_3xbdw_h32"] ||[wf_flag isEqual:@"ssc_4xbdw_h42"] ||[wf_flag isEqual:@"ssc_4xbdw_h52"] || [wf_flag isEqual:@"ssc_dxds_q2"] || [wf_flag isEqual:@"ssc_dxds_h2"]|| [wf_flag isEqual:@"ssc_r2zux_fs"] || [wf_flag isEqual:@"ssc_r3zux_z3fs"]|| [wf_flag isEqual:@"ssc_r4zux_6"]){
                    count = 8;
                }
                //生成不重复随机数
                for(int k = 10;k > count;k--){
                    int newNum = arc4random() % k;
                    NSLog(@"%d",newNum);
                    
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                    [numArr removeObjectAtIndex:newNum];
                }
                
            }
            //五星组选60
        }else if ([wf_flag isEqual:@"ssc_5xzux_60"]){
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                static int newNum = 0;
                //先随机生成一个二重数
                if(j == 0){
                    newNum = arc4random() % 10;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }else{
                    //生成不重复随机数
                    NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
                    //除去已选数字
                    for(int h = 0;h < numArr.count;h++){
                        NSString *numStr = numArr[h];
                        if(newNum == [numStr integerValue]){
                            [numArr removeObject:numStr];
                        }
                    }
                    
                    for(int k = 9;k > 6;k--){
                        int newNum = arc4random() % k;
                        NSLog(@"%d",newNum);
                        
                        for(int i = 0;i < dataArr.count;i++){
                            if(i == [numArr[newNum] integerValue]){
                                LotteryDetailModel *model = dataArr[i];
                                model.isSelect = YES;
                            }
                        }
                        [numArr removeObjectAtIndex:newNum];
                    }
                }
            }
            //五星组选30
        }else if ([wf_flag isEqual:@"ssc_5xzux_30"]){
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                //先随机生成两个不重复二重数
                static int randomNum = 0;
                if(j == 0){
                    
                    for(int k = 10;k > 8;k--){
                        randomNum = arc4random() % k;
                        NSLog(@"%d",randomNum);
                        
                        for(int i = 0;i < dataArr.count;i++){
                            if(i == [numArr[randomNum] integerValue]){
                                LotteryDetailModel *model = dataArr[i];
                                model.isSelect = YES;
                            }
                        }
                        [numArr removeObjectAtIndex:randomNum];
                    }
                }else{
                    //生成随机数
                    int newNum = arc4random() % 8;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
            }
            //五星组选20 前四组选12 后四组选12 任四组选12
        }else if ([wf_flag isEqual:@"ssc_5xzux_20"] || [wf_flag isEqual:@"ssc_4xzux_qszux12"] || [wf_flag isEqual:@"ssc_4xzux_hszux12"] || [wf_flag isEqual:@"ssc_r4zux_12"]){
            //随机取得 万位 千位 百位 十位 个位中的相应个数
            NSMutableArray *digitArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4"]];
            [selectedDigitArr removeAllObjects];
            if([wf_flag isEqual:@"ssc_r4zux_12"]){
                int selectCount = 1;
                //生成不重复随机数
                for(int k = 5;k > selectCount;k--){
                    int newNum = arc4random() % k;
                    [selectedDigitArr addObject:digitArr[newNum]];
                    [digitArr removeObjectAtIndex:newNum];
                }
            }
            
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                static int newNum = 0;
                //先随机生成一个三重数
                if(j == 0){
                    newNum = arc4random() % 10;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }else{
                    //生成不重复随机数
                    NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
                    //除去已选数字
                    for(int h = 0;h < numArr.count;h++){
                        NSString *numStr = numArr[h];
                        if(newNum == [numStr integerValue]){
                            [numArr removeObject:numStr];
                        }
                    }
                    for(int k = 9;k > 7;k--){
                        int newNum = arc4random() % k;
                        NSLog(@"%d",newNum);
                        
                        for(int i = 0;i < dataArr.count;i++){
                            if(i == [numArr[newNum] integerValue]){
                                LotteryDetailModel *model = dataArr[i];
                                model.isSelect = YES;
                            }
                        }
                        [numArr removeObjectAtIndex:newNum];
                    }
                }
            }
            //五星组选10 前四组选4 后四组选4 任四组选4
        }else if ([wf_flag isEqual:@"ssc_5xzux_10"] || [wf_flag isEqual:@"ssc_5xzux_5"] || [wf_flag isEqual:@"ssc_4xzux_qszux4"] || [wf_flag isEqual:@"ssc_4xzux_hszux4"]|| [wf_flag isEqual:@"ssc_r4zux_4"]){
            //随机取得 万位 千位 百位 十位 个位中的相应个数
            NSMutableArray *digitArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4"]];
            [selectedDigitArr removeAllObjects];
            if([wf_flag isEqual:@"ssc_r4zux_4"]){
                int selectCount = 1;
                //生成不重复随机数
                for(int k = 5;k > selectCount;k--){
                    int newNum = arc4random() % k;
                    [selectedDigitArr addObject:digitArr[newNum]];
                    [digitArr removeObjectAtIndex:newNum];
                }
            }
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                static int newNum = 0;
                //先随机生成一个三重数 或四重数
                if(j == 0){
                    newNum = arc4random() % 10;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }else{
                    //生成不重复随机数
                    NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
                    //除去已选数字
                    for(int h = 0;h < numArr.count;h++){
                        NSString *numStr = numArr[h];
                        if(newNum == [numStr integerValue]){
                            [numArr removeObject:numStr];
                        }
                    }
                    newNum = arc4random() % 9;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
            }
            
            //五星直选复式 五星直选组合 一帆风顺 好事成双 三星报喜 四季发财 前四直选复式 前四直选组合 后四直选复式 后四直选组合 前三直选复式 前三直选组合 前三直选和值 前三直选跨度 前三组选和值 前三组选包胆 中三直选复式 中三直选组合 中三直选和值 中三直选跨度 中三组选和值 中三组选包胆 后三直选复式 后三直选组合 后三直选和值 后三直选跨度 后三组选和值 后三组选包胆 前二直选复式 前二直选和值 前二直选跨度 前二组选和值 前二组选包胆 后二直选复式 后二直选和值 后二直选跨度 后二组选和值 后二组选包胆 五星定位胆  前三一码不定 中三一码不定 后三一码不定 后四一码不定 前二大小单双 后二大小单双 前三大小单双 后三大小单双 任二直选复式 任二直选和值 任二组选和值 任三直选复式 任三直选和值 任三组选和值 任四直选复式  龙虎斗
        }else{
            
            int randRow = arc4random() % 5;
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4"]];
            NSMutableArray *selectedNumArr = [NSMutableArray array];
            [selectedDigitArr removeAllObjects];
            //任二直选复式 任三直选复式  先预先产生两或者三个不重复随机数 作为随机的row 抑或随机取得 万位 千位 百位 十位 个位中的相应个数
            if([wf_flag isEqual:@"ssc_r2zhix_fs"] || [wf_flag isEqual:@"ssc_r3zhix_fs"] || [wf_flag isEqual:@"ssc_r4zhix_fs"]|| [wf_flag isEqual:@"ssc_r2zhix_hz"] || [wf_flag isEqual:@"ssc_r2zux_hz"] ||[wf_flag isEqual:@"ssc_r3zux_hz"] ||  [wf_flag isEqual:@"ssc_r3zhix_hz"] ){
                int selectCount = 0;
                if([wf_flag isEqual:@"ssc_r2zhix_fs"] || [wf_flag isEqual:@"ssc_r3zhix_hz"] ||[wf_flag isEqual:@"ssc_r3zux_hz"]){
                    selectCount = 2;
                }else if([wf_flag isEqual:@"ssc_r3zhix_fs"] || [wf_flag isEqual:@"ssc_r2zhix_hz"] || [wf_flag isEqual:@"ssc_r2zux_hz"]){
                    selectCount = 3;
                }else{
                    selectCount = 4;
                }
                
                //生成不重复随机数
                for(int k = 5;k > selectCount;k--){
                    int newNum = arc4random() % k;
                    NSLog(@"%d",newNum);
                    if([wf_flag isEqual:@"ssc_r2zhix_hz"] || [wf_flag isEqual:@"ssc_r2zux_hz"] || [wf_flag isEqual:@"ssc_r3zhix_hz"]||[wf_flag isEqual:@"ssc_r3zux_hz"]){
                        [selectedDigitArr addObject:numArr[newNum]];
                    }else{
                        [selectedNumArr addObject:numArr[newNum]];
                    }
                    [numArr removeObjectAtIndex:newNum];
                    
                }
            }
            for(int j = 0;j < dataArray.count;j++){
                
                int allCount = 0;
                
                if([wf_flag isEqual:@"ssc_q3zhix_hz"] || [wf_flag isEqual:@"ssc_z3zhix_hz"] ||[wf_flag isEqual:@"ssc_h3zhix_hz"]|| [wf_flag isEqual:@"ssc_r3zhix_hz"]|| [wf_flag isEqual:@"r3zux_hz"]){
                    allCount = 28;
                }else if([wf_flag isEqual:@"ssc_q3zux_q3zuxhz"] || [wf_flag isEqual:@"ssc_h3zux_h3zuxhz"] || [wf_flag isEqual:@"ssc_z3zux_z3zuxhz"] || [wf_flag isEqual:@"ssc_r3zux_hz"]){
                    allCount = 26;
                }else if([wf_flag isEqual:@"ssc_q2zux_hz"] || [wf_flag isEqual:@"ssc_h2zux_hz"] || [wf_flag isEqual:@"ssc_r2zhix_hz"] || [wf_flag isEqual:@"ssc_r2zux_hz"]){
                    allCount = 18;
                }else if([wf_flag isEqual:@"ssc_h2zhix_hz"]){
                    allCount = 19;
                }else if([wf_flag isEqual:@"ssc_dxds_q2"] || [wf_flag isEqual:@"ssc_dxds_h2"] || [wf_flag isEqual:@"ssc_dxds_q3"] || [wf_flag isEqual:@"ssc_dxds_h3"]){
                    allCount = 4;
                }else if([wf_flag isEqual:@"ssc_lhd"] && j == 1){
                    allCount = 3;
                }else{
                    allCount = 10;
                }
                //生成随机数
                int newNum = arc4random() % allCount;
                NSLog(@"%d",newNum);
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                //非五星定位 或者 五星定位且row等于随机数
                if(![wf_flag isEqual:@"ssc_5xdwd"] || ([wf_flag isEqual:@"ssc_5xdwd"] && j == randRow)){
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
                //任二直选复式 任三直选复式 遍历数组把随机的row的数字取消
                if([wf_flag isEqual:@"ssc_r2zhix_fs"] || [wf_flag isEqual:@"ssc_r3zhix_fs"]|| [wf_flag isEqual:@"ssc_r4zhix_fs"]){
                    
                    for (int h = 0;h < selectedNumArr.count;h++){
                        if(j == [selectedNumArr[h] integerValue]){
                            for( LotteryDetailModel *model in  dataArr){
                                model.isSelect = NO;
                            }
                        }
                    }
                }
            }
        }
        
    }else if ([lotteryType isEqualToString:@"pk10"]){
        
        //猜前二 猜前三 猜前四 猜前五 猜前六 猜前七 猜前八 猜前九 猜前十
        if([wf_flag isEqual:@"pk10_cq2_q2"]||[wf_flag isEqual:@"pk10_cq3_q3"]||[wf_flag isEqual:@"pk10_cq4_q4"]||[wf_flag isEqual:@"pk10_cq5_q5"]||[wf_flag isEqual:@"pk10_cq6_q6"]||[wf_flag isEqual:@"pk10_cq7_q7"]||[wf_flag isEqual:@"pk10_cq8_q8"]||[wf_flag isEqual:@"pk10_cq9_q9"]||[wf_flag isEqual:@"pk10_cq10_q10"]){
            
            //生成不重复随机数
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
            NSMutableArray *selectedArr = [NSMutableArray array];
            int count = 0;
            if([wf_flag isEqual:@"pk10_cq10_q10"]){
                count = 0;
            }else if([wf_flag isEqual:@"pk10_cq9_q9"]){
                count = 1;
            }else if([wf_flag isEqual:@"pk10_cq8_q8"]){
                count = 2;
            }else if([wf_flag isEqual:@"pk10_cq7_q7"]){
                count = 3;
            }else if([wf_flag isEqual:@"pk10_cq6_q6"]){
                count = 4;
            }else if([wf_flag isEqual:@"pk10_cq5_q5"]){
                count = 5;
            }else if([wf_flag isEqual:@"pk10_cq4_q4"]){
                count = 6;
            }else if([wf_flag isEqual:@"pk10_cq3_q3"]){
                count = 7;
            }else if([wf_flag isEqual:@"pk10_cq2_q2"]){
                count = 8;
            }
            
            for(int k = 10;k > count;k--){
                int newNum = arc4random() % k;
                NSLog(@"%d",newNum);
                [selectedArr addObject:numArr[newNum]];
                [numArr removeObjectAtIndex:newNum];
            }
            
            for(int j = 0;j < dataArray.count;j++){
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                for(int i = 0;i < dataArr.count;i++){
                    if(i == [selectedArr[j] integerValue]){
                        LotteryDetailModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
                
            }
            //猜第一 猜第二 猜第三 猜第四 猜第五 猜第六 猜第七 猜第八 猜第九 猜第十 定胆位 冠军大小单双 亚军大小单双 季军大小单双 冠亚军和值 冠亚季军和值 龙虎斗
        }else{
            int randRow = arc4random() % 10;
            for(int j = 0;j < dataArray.count;j++){
                
                int allCount = 0;
                
                if([wf_flag isEqual:@"pk10_dxds_gj"] || [wf_flag isEqual:@"pk10_dxds_yj"] || [wf_flag isEqual:@"pk10_dxds_jj"]){
                    allCount = 4;
                }else if([wf_flag isEqual:@"pk10_hz_gy"]){
                    allCount = 17;
                }else if([wf_flag isEqual:@"pk10_hz_gyj"]){
                    allCount = 22;
                }else if([wf_flag isEqual:@"pk10_lhd"]){
                    allCount = 2;
                }else{
                    allCount = 10;
                }
                //生成随机数
                int newNum = arc4random() % allCount;
                NSLog(@"%d",newNum);
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                //非定胆位 或者 定胆位且row等于随机数
                if(![wf_flag isEqual:@"pk10_gp_dwd_child"] || ([wf_flag isEqual:@"pk10_gp_dwd_child"] && j == randRow)){
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == newNum){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
                
            }
        }
        
    }else if ([lotteryType isEqualToString:@"k3"]){
        
        //二同号标准 三不同标准
        if ([wf_flag isEqual:@"k3_2bth_bz"] || [wf_flag isEqual:@"k3_3bth_bz"]){
            for(int j = 0;j < dataArray.count;j++){
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                //生成不重复随机数
                NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5"]];
                int count = 0;
                if([wf_flag isEqual:@"k3_2bth_bz"]){
                    count = 4;
                }else{
                    count = 3;
                }
                
                for(int k = 6;k > count;k--){
                    int newNum = arc4random() % k;
                    NSLog(@"%d",newNum);
                    
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                    [numArr removeObjectAtIndex:newNum];
                }
                
            }
            //二同号标准 二不同胆拖
        }else if ([wf_flag isEqual:@"k3_2th_bz"]){
            //生成不重复随机数
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5"]];
            NSMutableArray *selectedArr = [NSMutableArray array];
            int count = 4;
            for(int k = 6;k > count;k--){
                int newNum = arc4random() % k;
                NSLog(@"%d",newNum);
                [selectedArr addObject:numArr[newNum]];
                [numArr removeObjectAtIndex:newNum];
            }
            
            for(int j = 0;j < dataArray.count;j++){
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                
                for(int i = 0;i < dataArr.count;i++){
                    if(i == [selectedArr[j] integerValue]){
                        LotteryDetailModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
                
            }
            
            // 三不同胆拖
        }else if ([wf_flag isEqual:@"k3_3bth_dt"]){
            NSMutableArray *numArr = [NSMutableArray arrayWithArray: @[@"0",@"1",@"2",@"3",@"4",@"5"]];
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                int count = 0;
                if([wf_flag isEqual:@"k3_2bth_dt"]){
                    count = 5;
                }else{
                    count = 4;
                }
                
                //先随机生成两个不重复二重数
                static int randomNum = 0;
                if(j == 0){
                    
                    for(int k = 6;k > count;k--){
                        randomNum = arc4random() % k;
                        NSLog(@"%d",randomNum);
                        
                        for(int i = 0;i < dataArr.count;i++){
                            if(i == [numArr[randomNum] integerValue]){
                                LotteryDetailModel *model = dataArr[i];
                                model.isSelect = YES;
                            }
                        }
                        [numArr removeObjectAtIndex:randomNum];
                    }
                }else{
                    //生成随机数
                    int newNum = arc4random() % count;
                    for(int i = 0;i < dataArr.count;i++){
                        if(i == [numArr[newNum] integerValue]){
                            LotteryDetailModel *model = dataArr[i];
                            model.isSelect = YES;
                        }
                    }
                }
            }
            
            //三同号通选  三连号通选
        }else if ([wf_flag isEqual:@"k3_3th_thtx"] || [wf_flag isEqual:@"k3_3th_lhtx"]){
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = YES;
                }
            }
            //二同号标准 二同号复选  三同号单选 三不同和值 和值
        }else{
            
            for(int j = 0;j < dataArray.count;j++){
                
                KKLotteryDataModel *dataModel = dataArray[j];
                NSArray *dataArr = dataModel.dataSource;
                dataModel.selectedBtnIndex = -1;
                for( LotteryDetailModel *model in  dataArr){
                    model.isSelect = NO;
                }
                int allCount = 0;
                
                if([wf_flag isEqual:@"k3_3bth_hz"]){
                    allCount = 10;
                }else if ([wf_flag isEqual:@"k3_hz_hz"]){
                    allCount = 16;
                }else{
                    allCount = 6;
                }
                
                //生成随机数
                int newNum = arc4random() % allCount;
                NSLog(@"%d",newNum);
                
                for(int i = 0;i < dataArr.count;i++){
                    if(i == newNum){
                        LotteryDetailModel *model = dataArr[i];
                        model.isSelect = YES;
                    }
                }
            }
        }
        
    }else if ([lotteryType isEqualToString:@"北京28"]){
        
        int allCount = 0;
        
        if([wf_flag isEqual:@"xy28_qthh_hh"]){
            allCount = 10;
        }else if([wf_flag isEqual:@"xy28_qtbs_bs"]){
            allCount = 3;
        }else if([wf_flag isEqual:@"xy28_qtbz_bz"]){
            allCount = 1;
        }else{
            allCount = 27;
        }
        
        NSArray *dataArr = dataArray;
        for( LHCLotteryModel *model in  dataArr){
            model.isSelect = NO;
        }
        if(![wf_flag isEqual:@"xy28_tmb3_b3"]){
            //生成随机数
            int newNum = arc4random() % allCount;
            NSLog(@"%d",newNum);
            
            for(int i = 0;i < dataArr.count;i++){
                LHCLotteryModel *model = dataArr[i];
                //特码包三 需要随机选取三个数字
                if(i == newNum){
                    model.isSelect = YES;
                }
            }
        }else{
            NSMutableArray *numArr = [NSMutableArray array];
            for(int i = 0;i <= allCount;i++){
                [numArr addObject:@(i)];
            }
            
            for (int j = allCount; j > allCount - 3; j--) {
                int newNum = arc4random() % allCount;
                for(int k = 0;k < dataArr.count;k++){
                    if(k == [numArr[newNum] integerValue]){
                        LotteryDetailModel *model = dataArr[k];
                        model.isSelect = YES;
                    }
                }
                [numArr removeObjectAtIndex:newNum];
            }
            
        }
    
    }
    
}

@end
