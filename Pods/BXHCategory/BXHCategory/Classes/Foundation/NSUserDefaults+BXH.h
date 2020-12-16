//
//  NSUserDefaults+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (BXH)
+ (void)bxh_setData:(id)data forKey:(NSString *)key;
+ (id)bxh_dataForKey:(NSString *)key;
+ (void)bxh_removeDataForKey:(NSString *)key;
/**
 巧用SuiteName
 在跨App间通信或者主App与Extension共享数据，都会用到，一般配合使用的是App Groups。
 在App Groups中使用，一般两个App都需要加入同一个Group
 suiteName
 来存储和读取数据，即可实现数据共享
 */
+ (void)bxh_setData:(id)data forKey:(NSString *)key suiteName:(NSString *)suiteName;
+ (id)bxh_dataForKey:(NSString *)key suiteName:(NSString *)suiteName;
+ (void)bxh_removeDataForKey:(NSString *)key suiteName:(NSString *)suiteName;


@end

NS_ASSUME_NONNULL_END
