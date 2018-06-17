//
//  LotteryAlgorithm.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/7/4.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryAlgorithm.h"
#define sign_empty @"A"
@interface LotteryAlgorithm ()
@property(nonatomic,copy)NSMutableString *dataStr;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger selectCount;
@property(nonatomic,strong)NSMutableArray *dealwithDataArray;
@end
@implementation LotteryAlgorithm
+(NSInteger)ssc_q2zhix_kd:(NSString *)bet_number{
    NSArray *array = [bet_number componentsSeparatedByString:@","];
    NSInteger result = 0;
    for (NSString *str in array) {
        switch ([str integerValue]) {
            case 0:
            result = result +10;
            break;
            case 1:
            result = result +18;
            break;
            case 2:
            result = result +16;
            break;
            case 3:
            result = result +14;
            break;
            case 4:
            result = result +12;
            break;
            case 5:
            result = result +10;
            break;
            case 6:
            result = result +8;
            break;
            case 7:
            result = result +6;
            break;
            case 8:
            result = result +4;
            break;
            case 9:
            result = result +2;
            break;
            default:
            break;
        }
    }
    return result;
}
+(NSInteger)ssc_q3zhix_kd:(NSString *)bet_number{
    NSArray *array = [bet_number componentsSeparatedByString:@","];
    NSInteger result = 0;
    for (NSString *str in array) {
        switch ([str integerValue]) {
            case 0:
            result = result +10;
            break;
            case 1:
            result = result +54;
            break;
            case 2:
            result = result +96;
            break;
            case 3:
            result = result +126;
            break;
            case 4:
            result = result +144;
            break;
            case 5:
            result = result +150;
            break;
            case 6:
            result = result +144;
            break;
            case 7:
            result = result +126;
            break;
            case 8:
            result = result +96;
            break;
            case 9:
            result = result +54;
            break;
            default:
            break;
        }
    }
    return result;
}
+(NSInteger)ssc_r3zux_hz:(NSInteger)result{
    NSArray <NSNumber *>* arr1 = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9];
    NSArray <NSNumber *>* arr2 = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9];
    NSArray <NSNumber *>* arr3 = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9];
    
    NSInteger count = 0;
    NSMutableArray <NSMutableArray *>* allSets = [NSMutableArray array];
    
    for (int i = 0; i < arr1.count; i++) {
        NSNumber * a = arr1[i];
        for (int j = 0; j < arr2.count; j++) {
            NSNumber * b = arr2[j];
            for (int k = 0; k < arr3.count; k++) {
                NSNumber * c = arr3[k];
                //排除集合中所有的值一样的情况
                if (c.integerValue == a.integerValue && a.integerValue == b.integerValue) {
                    continue;
                }
                NSMutableArray <NSNumber *>*temp = [NSMutableArray arrayWithObjects:a,b,c,nil];
                //排序
                for (int i = 0; i < temp.count; i++) {
                    for (int j = 0; j < temp.count-1; j++) {
                        if (temp[j].integerValue > temp[j+1].integerValue) {
                            [temp exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                
                //排除重复集合
                if (![allSets containsObject:temp]) {
                    [allSets addObject:temp];
                }
            }
        }
    }
    
    
    
    for (int i = 0; i < allSets.count; i++) {
        NSMutableArray * values = [NSMutableArray arrayWithArray:allSets[i]];
        NSInteger sum = 0;
        for (int j = 0; j < values.count; j++) {
            NSNumber * a = values[j];
            sum += a.integerValue;
        }
        if (sum == result) {
            
            count += 1;
        }
    }
    
    
    return count;

}
+(NSInteger)ssc_r4zhix_fs:(NSString *)bet_number{
    NSArray *bet_array = [bet_number componentsSeparatedByString:@","];
    NSString* array_wan = bet_array[0];
    NSString* array_qian = bet_array[1];
    NSString* array_bai = bet_array[2];
    NSString* array_shi = bet_array[3];
    NSString* array_ge = bet_array[4];
   
    NSMutableArray <NSMutableArray *>* allSets = [NSMutableArray array];
    // 万
    for (int a = 0; a < array_wan.length; a ++) {
        NSInteger  wan = [[array_wan substringWithRange:NSMakeRange(a,1)] integerValue];
        // 千
        for (int b = 0; b < array_qian.length; b ++) {
            NSInteger qian =  [[array_qian substringWithRange:NSMakeRange(b,1)] integerValue];
            // 百
            for (int c = 0; c < array_bai.length; c ++) {
                NSInteger bai =  [[array_bai substringWithRange:NSMakeRange(c,1)] integerValue];
                // 十
                for (int d = 0; d < array_shi.length; d ++) {
                    NSInteger shi =  [[array_shi substringWithRange:NSMakeRange(d,1)] integerValue];
                    // 个
                    for (int e = 0; e < array_ge.length; e ++) {
                        NSInteger ge = [[array_ge substringWithRange:NSMakeRange(e,1)] integerValue];
                        NSMutableArray *temp = [NSMutableArray arrayWithObjects:@(wan),@(qian),@(bai),@(shi),@(ge),nil];
                        [allSets addObject:temp];
                    }
                }
            }
        }
    }
    
    
    
    NSMutableArray <NSMutableArray *>* allSituation = [NSMutableArray array];
    for (int i = 0; i < allSets.count; i ++) {
        NSArray * subArr = allSets[i];
        
        for (int j = 0; j < subArr.count; j ++) {
            NSMutableArray * subArrM = [subArr mutableCopy];
            
            [subArrM replaceObjectAtIndex:j withObject:@(100000)];
            
            //去重
            if (![allSituation containsObject:subArrM]) {
                [allSituation addObject:subArrM];
            }
        }
    }
    
    // 总共的注数
    NSInteger result = allSituation.count;
    return result;
}
+(NSInteger)ssc_r3zhix_fs:(NSString *)bet_number{
    NSArray *bet_array = [bet_number componentsSeparatedByString:@","];
    NSString* array_wan = bet_array[0];
    NSString* array_qian = bet_array[1];
    NSString* array_bai = bet_array[2];
    NSString* array_shi = bet_array[3];
    NSString* array_ge = bet_array[4];
    if (array_wan.length == 0) {
        array_wan = sign_empty;
    }
    if (array_qian.length == 0) {
        array_qian = sign_empty;
    }
    if (array_bai.length == 0) {
        array_bai = sign_empty;
    }
    if (array_shi.length == 0) {
        array_shi = sign_empty;
    }
    if (array_ge.length == 0) {
        array_ge = sign_empty;
    }
    NSMutableArray <NSMutableArray *>* allSets = [NSMutableArray array];
    // 万
    for (int a = 0; a < array_wan.length; a ++) {
        NSString *  wan = [NSString stringWithFormat:@"%@W",[array_wan substringWithRange:NSMakeRange(a,1)]];
        // 千
        for (int b = 0; b < array_qian.length; b ++) {
            NSString * qian =  [NSString stringWithFormat:@"%@Q",[array_qian substringWithRange:NSMakeRange(b,1)]];
            // 百
            for (int c = 0; c < array_bai.length; c ++) {
                NSString * bai =  [NSString stringWithFormat:@"%@B",[array_bai substringWithRange:NSMakeRange(c,1)]];
                // 十
                for (int d = 0; d < array_shi.length; d ++) {
                    NSString * shi =  [NSString stringWithFormat:@"%@S",[array_shi substringWithRange:NSMakeRange(d,1)]];
                    // 个
                    for (int e = 0; e < array_ge.length; e ++) {
                        NSString * ge = [NSString stringWithFormat:@"%@G",[array_ge substringWithRange:NSMakeRange(e,1)]];
                        NSMutableArray *temp = [NSMutableArray arrayWithObjects:wan,qian,bai,shi,ge,nil];
                        [allSets addObject:temp];
                    }
                }
            }
        }
    }
    
    
    // 去空
    for (int i = 0; i < allSets.count; i ++) {
        
        
        NSArray * subArr = allSets[i];
        
        NSMutableArray * acceptArrayM = [NSMutableArray arrayWithCapacity:0];
        
        NSLog(@"subArr: %@",subArr);
        
        for (int j = 0; j < subArr.count; j ++) {
            NSString * digital = subArr[j];
            
            NSLog(@"digital: %@  i=%d  j=%d",digital,i,j);
            
            if (![digital hasPrefix:sign_empty]) {
                [acceptArrayM addObject:digital];
            }
        }
        
        
        [allSets replaceObjectAtIndex:i withObject:acceptArrayM];
    }
    
    
    
    
    
    NSMutableArray <NSMutableArray *>* allSituation = [NSMutableArray array];
    
    // 每一个数组
    for (int i = 0; i < allSets.count; i ++) {
        NSArray * subArr = allSets[i];
        
        
        // 获取第一个数字
        for (int j = 0; j < subArr.count; j ++) {
            
            
            // 获取第二个数字
            if (j != (subArr.count-1)) {
                
                for (int k = j + 1; k < subArr.count; k ++) {
                    
                    
                    
                    if (k != (subArr.count-1)) {
                        
                        for (int l = k + 1; l < subArr.count; l ++) {
                            
                            
                            NSMutableArray * subArrM = [NSMutableArray arrayWithCapacity:0];
                            NSNumber * number_a = subArr[j];
                            [subArrM addObject:number_a];
                            
                            
                            NSNumber * number_b = subArr[k];
                            [subArrM addObject:number_b];
                            
                            
                            NSNumber * number_c = subArr[l];
                            [subArrM addObject:number_c];
                            
                            
                            //去重
                            if (![allSituation containsObject:subArrM]) {
                                [allSituation addObject:subArrM];
                            }
                            
                        }
                    }
                }
            }
        }
    }
    // 总共的注数
    NSInteger result = allSituation.count;
    return result;
}
+(NSInteger)ssc_r2zhix_fs:(NSString *)bet_number{
    NSArray *bet_array = [bet_number componentsSeparatedByString:@","];
    NSString* array_wan = bet_array[0];
    NSString* array_qian = bet_array[1];
    NSString* array_bai = bet_array[2];
    NSString* array_shi = bet_array[3];
    NSString* array_ge = bet_array[4];
    if (array_wan.length == 0) {
        array_wan = sign_empty;
    }
    if (array_qian.length == 0) {
        array_qian = sign_empty;
    }
    if (array_bai.length == 0) {
        array_bai = sign_empty;
    }
    if (array_shi.length == 0) {
        array_shi = sign_empty;
    }
    if (array_ge.length == 0) {
        array_ge = sign_empty;
    }
    NSMutableArray <NSMutableArray *>* allSets = [NSMutableArray array];
    // 万
    for (int a = 0; a < array_wan.length; a ++) {
        NSString *  wan = [NSString stringWithFormat:@"%@W",[array_wan substringWithRange:NSMakeRange(a,1)]];
        // 千
        for (int b = 0; b < array_qian.length; b ++) {
            NSString * qian =  [NSString stringWithFormat:@"%@Q",[array_qian substringWithRange:NSMakeRange(b,1)]];
            // 百
            for (int c = 0; c < array_bai.length; c ++) {
                NSString * bai =  [NSString stringWithFormat:@"%@B",[array_bai substringWithRange:NSMakeRange(c,1)]];
                // 十
                for (int d = 0; d < array_shi.length; d ++) {
                    NSString * shi =  [NSString stringWithFormat:@"%@S",[array_shi substringWithRange:NSMakeRange(d,1)]];
                    // 个
                    for (int e = 0; e < array_ge.length; e ++) {
                        NSString * ge = [NSString stringWithFormat:@"%@G",[array_ge substringWithRange:NSMakeRange(e,1)]];
                        NSMutableArray *temp = [NSMutableArray arrayWithObjects:wan,qian,bai,shi,ge,nil];
                        [allSets addObject:temp];
                    }
                }
            }
        }
    }
    NSLog(@"---%@",allSets);
    // 去空
    for (int i = 0; i < allSets.count; i ++) {
        
        
        NSArray * subArr = allSets[i];
        
        NSMutableArray * acceptArrayM = [NSMutableArray arrayWithCapacity:0];
        
        NSLog(@"subArr: %@",subArr);
        
        for (int j = 0; j < subArr.count; j ++) {
            NSString * digital = subArr[j];
            
            NSLog(@"digital: %@  i=%d  j=%d",digital,i,j);
            
            if (![digital hasPrefix:sign_empty]) {
                [acceptArrayM addObject:digital];
            }
        }
        
        
        [allSets replaceObjectAtIndex:i withObject:acceptArrayM];
    }

    
    
    NSMutableArray <NSMutableArray *>* allSituation = [NSMutableArray array];
    
    // 每一个数组
    for (int i = 0; i < allSets.count; i ++) {
        NSArray * subArr = allSets[i];
        
        
        // 获取第一个数字
        for (int j = 0; j < subArr.count; j ++) {
            
            
            // 获取第二个数字
            if (j != (subArr.count -1)) {
                
                for (int k = j + 1; k < subArr.count; k ++) {
                    
                    
                    NSMutableArray * subArrM = [NSMutableArray arrayWithCapacity:0];
                    NSNumber * number_a = subArr[j];
                    [subArrM addObject:number_a];
                    
                    
                    NSNumber * number_b = subArr[k];
                    [subArrM addObject:number_b];
                    
                    //去重
                    if (![allSituation containsObject:subArrM]) {
                        [allSituation addObject:subArrM];
                    }
                    
                }
            }
        }
    }
    
    // 总共的注数
    NSInteger result = allSituation.count;
    return result;
}
-(NSInteger)pk10GuessTheNumber:(NSString *)bet_number{
    self.selectCount = 0;
    NSArray *tempArray = [bet_number componentsSeparatedByString:@"-"];
    [self recursive:tempArray.count andTempArray:tempArray andCount:1];

    return self.selectCount;
}
-(void)recursive:(NSInteger)specialValue andTempArray:(NSArray *)tempArray andCount:(NSInteger )p{
    NSArray *array = [tempArray[p-1] componentsSeparatedByString:@","];
    
    for (int i=0; i <array.count; i++) {
        NSString *str1 = array[i];
        if ([str1  isEqual: @"10"]) {
            str1 = @"0";
        }
        if ([str1 isEqual:@"11"]) {
            str1 = @"A";
        }
        [self.dataStr appendFormat:@"%@,",str1];
     
        if (p == specialValue) {
            if (self.dataStr.length<specialValue*2) {
                if (self.dataArray.count>0) {
                    NSString *str = self.dataArray[self.dataArray.count-1];

                [self.dataStr insertString:[str substringToIndex:str.length-self.dataStr.length] atIndex:0];
                    NSArray *array = [self.dataStr componentsSeparatedByString:@","];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
                    for(NSString *str in array)
                    {
                        [dic setValue:str forKey:str];
                    }
                    NSArray *newArray = [dic allKeys];
                    if (newArray.count == array.count && array.count!=2) {
                      
                        self.selectCount ++;
                    }
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObject:self.dataStr];
                }
                
            }else{
                
                NSString *str = self.dataStr;
                NSArray *array = [str componentsSeparatedByString:@","];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
                for(NSString *str in array)
                {
                    [dic setValue:str forKey:str];
                }
                NSArray *newArray = [dic allKeys];
                if (newArray.count == array.count && array.count!=2) {
                    self.selectCount ++;
                }
                [self.dataArray removeAllObjects];

                
                [self.dataArray addObject:self.dataStr];
               
            }
           
            
             self.dataStr = nil;
      
        }else{
            [self recursive:specialValue andTempArray:tempArray andCount:p+1];
        }
    }
}
-(NSInteger)factorial:(NSInteger )index{
    return index>1 ? index*([self factorial:index-1]):1;
}
-(NSInteger)combination:(NSInteger)n andM:(NSInteger)m{
    return (n>=m)?[self factorial:n]/[self factorial:n-m]/[self factorial:m] :0;
}
-(NSMutableString *)dataStr{
    if (!_dataStr) {
        _dataStr = [[NSMutableString alloc]init];
        
    }
    return _dataStr;
}
-(NSMutableArray *)dealwithDataArray{
    if (!_dealwithDataArray) {
        _dealwithDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dealwithDataArray;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
@end
