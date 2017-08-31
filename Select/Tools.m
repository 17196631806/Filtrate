//
//  Tools.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/30.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (NSString *)getDateModel {
    //获取公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取当前日期
    NSDate *date = [NSDate date];
    //定义一个时间字段标识,年 月 天 时 分 秒 星期
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    //获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:date];
    
    return [NSString stringWithFormat:@"%ld",(long)comp.year];

}

@end
