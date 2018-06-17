//
//  NSString+EmptyZero.m
//  YGServe
//
//  Created by 刘烨 on 16/11/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "NSString+EmptyZero.h"

@implementation NSString (EmptyZero)
-(NSString *)opinionPriceIsZero:(NSInteger )testPrice{
    CGFloat price = testPrice;
    NSString *prict1 = [NSString stringWithFormat:@"%.2f",price/100];
    NSString *price2 = [NSString stringWithFormat:@"%.2f",price/100];
    if ([[prict1 substringFromIndex:prict1.length - 1]  isEqual: @"0"]) {
        price2 = [NSString stringWithFormat:@"%.1f",price/100];
    }
    if ([[prict1 substringFromIndex:prict1.length - 2] isEqual:@"00"]) {
        price2 = [NSString stringWithFormat:@"%.0f",price/100];
    }
    return price2;
}


+(NSString *)opinionPriceIsZero:(NSInteger )testPrice{
    CGFloat price = testPrice;
    NSString *prict1 = [NSString stringWithFormat:@"¥%.2f",price/100];
    NSString *price2 = [NSString stringWithFormat:@"¥%.2f",price/100];
    if ([[prict1 substringFromIndex:prict1.length - 1]  isEqual: @"0"]) {
        price2 = [NSString stringWithFormat:@"¥%.1f",price/100];
    }
    if ([[prict1 substringFromIndex:prict1.length - 2] isEqual:@"00"]) {
        price2 = [NSString stringWithFormat:@"¥%.0f",price/100];
    }
    return price2;
}


@end
