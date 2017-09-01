//
//  NSDate+EDExtension.m
//  EDFoundationExtension
//
//  Created by Prewindemon on 16/7/28.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import "NSDate+ZbCoreExtension.h"

@interface NSDate ()

@end

@implementation NSDate (ZbCoreExtension)


/**
 *  获取指定格式的UTC日期
 *
 *
 */
+ (NSDate *)zbcore_dateWithFormat: (NSString *)formatString FromString: (NSString *)dateString{
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = zone;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.dateFormat = formatString;
    
    return [dateFormatter dateFromString:dateString];
}

/**
 *  获取指定格式的日期
 *
 *  @param dateString yyyy/MM/dd Date String
 *
 */
+ (NSDate *)zbcore_dateFromYYYYMMdd:(NSString *)dateString{
    return [NSDate zbcore_dateWithFormat: @"yyyy/MM/dd" FromString: dateString];
}
/**
 *  获取指定格式的UTC日期字符串
 *
 *
 */
+ (NSString *)zbcore_dateStringWithFormat: (NSString *)formatString FromDate: (NSDate *)date{
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = zone;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.dateFormat = formatString;
    
    return [dateFormatter stringFromDate: date];
}

/**
 *  获取指定日期
 *
 *  @param year   年
 *  @param month  月
 *  @param day    日
 *  @param hour   时
 *  @param minute 分
 *  @param second 秒
 *
 */
+ (NSDate *)zbcore_dateWithYear: (NSInteger)year WithMonth: (NSInteger)month WithDay: (NSInteger)day WithHour: (NSInteger)hour WithMinute: (NSInteger)minute WithSecone: (NSInteger)second{
    NSString *dateString = [NSString stringWithFormat: @"%ld-%ld-%ld %ld:%ld:%ld:", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
    return [NSDate zbcore_dateWithFormat: @"yyyy-MM-dd HH:mm:ss" FromString: dateString];
}
/**
 *  获取指定日期
 *
 *  @param year   年
 *  @param month  月
 *  @param day    日
 *
 */
+ (NSDate *)zbcore_dateWithYear: (NSInteger)year WithMonth: (NSInteger)month WithDay: (NSInteger)day{
    NSString *dateString = [NSString stringWithFormat: @"%ld/%ld/%ld", (long)year, (long)month, (long)day];
    return [NSDate zbcore_dateFromYYYYMMdd: dateString];
}

/**
 *  获取当前时间
 */
+ (NSDate *)zbcore_date{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

/**
 *  获取本周周一的日期
 */
+ (NSDate *)zbcore_thisWeekMonday{
    NSDateComponents *componentsNow = [[NSCalendar currentCalendar] componentsInTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"] fromDate: [NSDate zbcore_date]];
    return [NSDate zbcore_dateWithPastDay: [componentsNow weekday] - 2];
}
/**
 *  是否今天
 *
 *  @param date 日期
 *
 */
+(Boolean)zbcore_isDateInToday: (NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [calendar isDateInToday: date];
}
/**
 *  是否昨天
 *
 *  @param date 日期
 *
 */
+(Boolean)zbcore_isDateInYesterday: (NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [calendar isDateInYesterday: date];
}
/**
 *  是否明天
 *
 *  @param date 日期
 *
 */
+(Boolean)zbcore_isDateInTomorrow: (NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [calendar isDateInTomorrow: date];
}

/**
 *  是否本周内的日期
 *
 *  @param date 日期
 *
 */
+(Boolean)zbcore_isSelfWeekday: (NSDate *)date{
    return [date timeIntervalSince1970] >= [[NSDate zbcore_thisWeekMonday] timeIntervalSince1970];
}

/**
 *  Self是否本周内日期
 *
 */
-(Boolean)zbcore_isSelfWeekday{
    return [NSDate zbcore_isSelfWeekday: self];
}
/**
 *  Self是否七天内日期
 *
 */
-(Boolean)zbcore_isSelfIn7Days{
    return [NSDate zbcore_isDateIn7Days: self];
}

/**
 *  获取day天前的日期 00：00：00
 *
 *  @param day 天数
 *
 */
+ (NSDate *)zbcore_dateWithPastDay: (NSInteger) day{
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = zone;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSDateComponents *componentsNow = [[NSCalendar currentCalendar] componentsInTimeZone: zone fromDate: [NSDate zbcore_date]];
    
    NSDate *date = [NSDate zbcore_dateFromYYYYMMdd: [NSString stringWithFormat: @"%ld/%ld/%ld", (long)[componentsNow year], (long)[componentsNow month], (long)[componentsNow day]]];
    NSTimeInterval time = [date timeIntervalSince1970];
    
    
    NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970: time - day * 24 * 3600];
    
    return pastDate;
}

/**
 *  是否七天内的日期
 *
 *  @param date 日期
 *
 */
+(Boolean)zbcore_isDateIn7Days: (NSDate *)date{
    return [date timeIntervalSince1970] >= [[NSDate zbcore_dateWithPastDay: 7] timeIntervalSince1970];
}

+ (NSString *)zbcore_displayDateString:(long long)miliSeconds{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[ NSDateFormatter alloc ] init ];
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    } else {
        if (nowCmps.day==myCmps.day) {
            dateFmt.dateFormat = @"今天 HH:mm:ss";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.dateFormat = @"昨天 HH:mm:ss";
        } else {
            dateFmt.dateFormat = @"MM-dd HH:mm:ss";
        }
    }
    return [dateFmt stringFromDate:myDate];
}
@end
