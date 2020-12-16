//
//  NSDate+BXH.m
//  AFNetworking
//
//  Created by yit on 2020/12/10.
//

#import "NSDate+BXH.h"

@implementation NSDate (BXH)

//获取当前时间时间戳
+ (NSString *_Nullable)getStringDateNowTimeInterval{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    return tempTime;
}

+ (NSString *)stringFromCurrentDate:(BXH_FromDateFormat)dateFormat{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = [[self class] dateFormatToString:dateFormat];
    NSString *selfStr = [fmt stringFromDate:currentDate];
    return selfStr;
}

+ (NSString *)stringFromDateWithTimeInterval:(NSTimeInterval)stamp withStringFormat:(BXH_FromDateFormat)dateFormat{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat =  [[self class] dateFormatToString:dateFormat];
    NSString *selfStr = [fmt stringFromDate:currentDate];
    return selfStr;
}

- (BOOL)isEarlierThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

// 日期显示（timestamp second, format）
+ (NSString *)formattedTime:(long long)timestampSec format:(NSString *)format {
    NSDate *ndate = [NSDate dateWithTimeIntervalSince1970:timestampSec];
    NSString *dateStr = [[self class] stringOfDate:ndate format:format];
    return dateStr;
}
// formatted date string(return string)
+ (NSString *)stringOfDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

// 日期显示（timestamp second, format）
+ (NSString *)formattedTime:(long long)longTimes dateFormat:(BXH_FromDateFormat)dateFormat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longTimes];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    dateFormatter.dateFormat = [[self class] dateFormatToString:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString*)dateFormatToString:(BXH_FromDateFormat)dateFormat {
    switch (dateFormat) {
        case BXH_FromDateFormatYear:
            return  @"yyyy";
            break;
        case BXH_FromDateFormatYearMonth:
            return@"yyyy-MM";
            break;
        case BXH_FromDateFormatYearMonthDay:
            return @"yyyy-MM-dd";
            break;
        case BXH_FromDateFormatYearMonthDayTime:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            return @"yyyy-MM-dd HH:mm:ss";
            break;
    }
}


@end
