//
//  NSDate+BXH.h
//  AFNetworking
//
//  Created by yit on 2020/12/10.
//

typedef enum : NSUInteger {
    BXH_FromDateFormatYear = 0,
    BXH_FromDateFormatYearMonth,
    BXH_FromDateFormatYearMonthDay,
    BXH_FromDateFormatYearMonthDayTime,
} BXH_FromDateFormat;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BXH)
//获取当前时间时间戳
+ (NSString *_Nullable)getStringDateNowTimeInterval;

+ (NSString *)stringFromCurrentDate:(BXH_FromDateFormat)dateFormat;

+ (NSString *)stringFromDateWithTimeInterval:(NSTimeInterval)stamp withStringFormat:(BXH_FromDateFormat)dateFormat;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;

- (BOOL)isLaterThanDate:(NSDate *)aDate;

@end

NS_ASSUME_NONNULL_END
