//
//  NSDate+EDExtension.h
//  EDFoundationExtension
//
//  Created by Prewindemon on 16/7/28.
//  Copyright © 2016年 Prewindemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZbCoreExtension)
/**
 *  获取指定格式的UTC日期
 *
 *  @param dateString yyyy/MM/dd Date String
 *
 */
+ (NSDate *)zbcore_dateWithFormat: (NSString *)formatString FromString: (NSString *)dateString;

/**
 *  获取指定格式的日期
 *
 *  @param dateString yyyy/MM/dd Date String
 *
 */
+ (NSDate *)zbcore_dateFromYYYYMMdd:(NSString *)dateString;
/**
 *  获取指定格式的UTC日期字符串
 *
 *
 */
+ (NSString *)zbcore_dateStringWithFormat: (NSString *)formatString FromDate: (NSDate *)date;
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
+ (NSDate *)zbcore_dateWithYear: (NSInteger)year WithMonth: (NSInteger)month WithDay: (NSInteger)day WithHour: (NSInteger)hour WithMinute: (NSInteger)minute WithSecone: (NSInteger)second;
/**
 *  获取指定日期
 *
 *  @param year   年
 *  @param month  月
 *  @param day    日
 *
 */
+ (NSDate *)zbcore_dateWithYear: (NSInteger)year WithMonth: (NSInteger)month WithDay: (NSInteger)day;

/**
 *  获取当前时间
 */
+ (NSDate *)zbcore_date;

/**
 *  获取本周周一的日期
 */
+ (NSDate *)zbcore_thisWeekMonday;
/**
 *  是否今天
 *
 *  @param date 日期
 *
 */
+ (Boolean)zbcore_isDateInToday: (NSDate *)date;
/**
 *  是否昨天
 *
 *  @param date 日期
 *
 */
+ (Boolean)zbcore_isDateInYesterday: (NSDate *)date;
/**
 *  是否明天
 *
 *  @param date 日期
 *
 */
+ (Boolean)zbcore_isDateInTomorrow: (NSDate *)date;

/**
 *  是否本周内的日期
 *
 *  @param date 日期
 *
 */
+ (Boolean)zbcore_isSelfWeekday: (NSDate *)date;

/**
 *  Self是否本周内日期
 *
 */
- (Boolean)zbcore_isSelfWeekday;
/**
 *  Self是否七天内日期
 *
 */
- (Boolean)zbcore_isSelfIn7Days;
/**
 *  获取day天前的日期 00：00：00
 *
 *  @param day 天数
 *
 */
+ (NSDate *)zbcore_dateWithPastDay: (NSInteger) day;

/**
 *  是否七天内的日期
 *
 *  @param date 日期
 *
 */
+ (Boolean)zbcore_isDateIn7Days: (NSDate *)date;

//按时间修改内容
+ (NSString *)zbcore_displayDateString:(long long) miliSeconds;
@end
