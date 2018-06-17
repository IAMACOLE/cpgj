//
//  LotteryTimeView.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/4/16.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "LotteryTimeView.h"
#import "TCTCountdownTimer.h"
#import "ZTGCDTimerManager.h"
@interface LotteryTimeView()<TCTTimerDelegate>
@property (nonatomic, strong) TCTCountdownTimer *timer;
@property (nonatomic, strong) TCTCountdownTimer *endTimer;
@property (nonatomic, strong) NSMutableDictionary *timerDict;
@property (nonatomic, strong) UIImageView *downImg;
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, assign) BOOL isFirst;

@end
@implementation LotteryTimeView

- (void)drawRect:(CGRect)rect {
    [self addSubview:self.distanceLabel];
   
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(MCScreenWidth/2-60);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.distanceLabel.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(65, 14));
        make.centerY.mas_equalTo(0);
   
    }];
    [self addSubview:self.timeEndLabel];
    [self.timeEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.distanceLabel.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(65, 14));
        make.centerY.mas_equalTo(0);
    }];
    
    UIImageView *downImg = [UIImageView new];
    [self addSubview:downImg];
    [downImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.timeLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(14, 10));
    }];
    downImg.image = [UIImage imageNamed:@"icon-lotterydetail-down"];
    _downImg = downImg;
    
    UIButton *showBtn = [UIButton new];
    [self addSubview:showBtn];
    [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [showBtn addTarget:self action:@selector(didClickShowMore) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)didClickShowMore{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickDownImgBtn)]) {
        [self.delegate clickDownImgBtn];
    }
}


-(void)setPeriod:(NSString *)period andTime:(NSString *)timeStr andEndTimer:(NSString *)endTile {
    self.distanceLabel.text = period;
    self.isFirst = NO;
    
    if(self.subviews.count){
        CGSize size = [period boundingRectWithSize:CGSizeMake(MCScreenWidth-80, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MCFont(kAdapterFontSize(12))} context:nil].size;
        [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(MCScreenWidth/2 - size.width/2 - 40);
        }];
    }else{
        self.downImg.hidden = YES;
    }
    
    
    NSString * end = timeStr;
    NSDateFormatter * startDateFormatter = [[NSDateFormatter alloc] init];
    [startDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * endDate = [startDateFormatter dateFromString:end];
    NSDate * ChinaEndDate = [self worldDateToLocalDate:endDate];
    
    NSString * end1 = endTile;
    NSDateFormatter * startDateFormatter1 = [[NSDateFormatter alloc] init];
    [startDateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * endDate1 = [startDateFormatter dateFromString:end1];
    NSDate * ChinaEndDate1 = [self worldDateToLocalDate:endDate1];
   
    
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];
    
    //结束时间与当前时间比较
    NSTimeInterval value = [self calculateBetweenStartDate:dateNow AndEndDate:ChinaEndDate];
    
    NSTimeInterval value1 = [self calculateBetweenStartDate:dateNow AndEndDate:ChinaEndDate1];
    
    NSString *timeIntervalStr1 = [NSString stringWithFormat:@"%li", (long)value];
    NSString *timeIntervalStr2 = [NSString stringWithFormat:@"%li", (long)value1];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    BIWeakObj(self)
    NSArray *tmpAry = @[timeIntervalStr1, timeIntervalStr2];
    for (int i=0; i< tmpAry.count; i++) {
        NSString *timerKey = [NSString stringWithFormat:@"yao.ming.timer%i", i];
        __block int totalSeconds = [tmpAry[i] intValue];
        [dict setValue:[NSString stringWithFormat:@"%ld",(long)totalSeconds] forKey:timerKey];
        [[ZTGCDTimerManager sharedInstance] scheduleGCDTimerWithName:timerKey interval:1 queue:dispatch_get_main_queue() repeats:YES option:CancelPreviousTimerAction  action:^{
            
            int totalCount = [[dict objectForKey:timerKey] intValue];
            
            totalCount -= 1;
            totalCount = totalCount > 0? totalCount : 0;
            [dict setValue:[NSString stringWithFormat:@"%ld",(long)totalCount] forKey:timerKey];
            
            [selfWeak.timerDict setValue:[NSString stringWithFormat:@"%@",[selfWeak mainButtonTimeFormatted:totalCount]] forKey:timerKey];
            if (i == 0) {
                self.timeLabel.text = [selfWeak.timerDict objectForKey:timerKey];
            }else if (i == 1) {
                self.timeEndLabel.text = [selfWeak.timerDict objectForKey:timerKey];
            }
            if (totalCount == 1) {
                if (i == 1) {
                    if (!self.isFirst) {
                        if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeReloadData)]) {
                            [self.delegate endTimeReloadData];
                        }
                        self.isFirst = YES;
                    }
                }
            }
            if(totalCount == 0)
            {
                [[ZTGCDTimerManager sharedInstance] cancelTimerWithName:timerKey];
                if (i == 0) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeResponder)]) {
                        [self.delegate endTimeResponder];
                    }
                }
            }
            
            
        }];
    }
    
//    self.endTimer.timeInterval = value1;
//
//
//    self.timer.timeInterval = value;
//    [self.timer start];
}

// 转换成时天分秒
- (NSString *)mainButtonTimeFormatted:(int)totalSeconds
{
    int day = (int)totalSeconds / (24 * 3600);
    int hours =  (int)totalSeconds / 3600 % 24;
    int minutes =  (int)(totalSeconds - day * 24 * 3600 - hours * 3600) / 60;
    int seconds = (int)(totalSeconds - day * 24 * 3600 - hours * 3600 - minutes*60);
    
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%02d天%02d:%02d",day,hours,minutes];
    } else {
        str = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    }
    
    return str;
}

-(UILabel *)distanceLabel{
    if (!_distanceLabel) {
        self.distanceLabel = [[UILabel alloc]init];
        self.distanceLabel.textColor = [UIColor blackColor];
        
        self.distanceLabel.font = MCFont(kAdapterFontSize(12));
    }
    return _distanceLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeLabel.font = MCFont(kAdapterFontSize(12));
        self.timeLabel.text = @"正在加载";
    }
    return _timeLabel;
}
-(UILabel *)timeEndLabel{
    if (!_timeEndLabel) {
        self.timeEndLabel = [[UILabel alloc]init];
        self.timeEndLabel.textColor = [UIColor blackColor];
        self.timeEndLabel.font = MCFont(kAdapterFontSize(12));
        self.timeEndLabel.hidden= YES;
    }
    return _timeEndLabel;
}
//世界时间转换为本地时间
- (NSDate *)worldDateToLocalDate:(NSDate *)date
{
    //获取本地时区(中国时区)
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    
    //计算世界时间与本地时区的时间偏差值
    NSInteger offset = [localTimeZone secondsFromGMTForDate:date];
    
    //世界时间＋偏差值 得出中国区时间
    NSDate *localDate = [date dateByAddingTimeInterval:offset];
    
    return localDate;
}
- (void)timer:(id<TCTTimer>)timer timeInterval:(NSTimeInterval)timeInterval refreshWithData:(id<TCTTimerRefreshData>)data{
    if (timer == self.timer) {
        if ([[data day] integerValue]>0) {
            NSInteger hourIndex = [[data day] integerValue] * 24 + [[data hour] integerValue];
            self.timeLabel.text = [NSString stringWithFormat:@"%ld:%@:%@",hourIndex,[data minute],[data second]];
        }
        else{
      self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",[data hour],[data minute],[data second]];
        }
    }
    if (timer == self.endTimer) {
        if ([[data day] integerValue]>0) {
            NSInteger hourIndex = [[data day] integerValue] * 24 +[[data hour] integerValue];
            self.timeEndLabel.text = [NSString stringWithFormat:@"%ld:%@:%@",hourIndex,[data minute],[data second]];
        }else{
        self.timeEndLabel.text = [NSString stringWithFormat:@"%@:%@:%@",[data hour],[data minute],[data second]];
        }
    }
    if (timer == self.timer && [self.timeLabel.text  isEqual: @"00:00:00"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeResponder)]) {
            [self.delegate endTimeResponder];
        }
    }
    if (timer == self.endTimer && [self.timeEndLabel.text  isEqual: @"00:00:01"]) {
        if (!self.isFirst) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(endTimeReloadData)]) {
                [self.delegate endTimeReloadData];
            }
            self.isFirst = YES;
        }
       
    }
 //   self.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",[data hour],[data minute],[data second]];
}
// 计算两个时间点之间的毫秒数
- (NSTimeInterval)calculateBetweenStartDate:(NSDate *)startDate AndEndDate:(NSDate *)endDate {
    
    NSTimeInterval startTime = [startDate timeIntervalSince1970]*1;
    NSTimeInterval endTime = [endDate timeIntervalSince1970]*1;
    NSTimeInterval value = endTime - startTime;
    return value;
}
- (TCTCountdownTimer *)timer{
    if (!_timer) {
        _timer = [TCTCountdownTimer countdownTimerWithAccuracy:TCTTimerAccuracyHighest timeInterval:5];
        _timer.delegate = self;
        [self.timer start];
    }
    return _timer;
}
- (TCTCountdownTimer *)endTimer{
    if (!_endTimer) {
        _endTimer = [TCTCountdownTimer countdownTimerWithAccuracy:TCTTimerAccuracyHighest timeInterval:5];
        _endTimer.delegate = self;
        [self.endTimer start];
    }
    return _endTimer;
}

- (NSMutableDictionary *)timerDict {
    if (_timerDict == nil) {
        _timerDict = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _timerDict;
}
@end
