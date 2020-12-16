//
//  NSUserDefaults+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import "NSUserDefaults+BXH.h"
@implementation NSUserDefaults (BXH)

+ (void)bxh_setData:(id)data forKey:(NSString *)key {
    if (data && key) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)bxh_dataForKey:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return nil;
}

+ (void)bxh_removeDataForKey:(NSString *)key{
    if (key) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

+ (void)bxh_setData:(id)data forKey:(NSString *)key suiteName:(NSString *)suiteName {
    if (data && key) {
        NSUserDefaults *userDefaults = suiteName ? [[NSUserDefaults alloc] initWithSuiteName:suiteName] : [NSUserDefaults standardUserDefaults];
        if ([userDefaults isKindOfClass:[NSUserDefaults class]]) {
            [userDefaults setObject:data forKey:key];
            [userDefaults synchronize];
        }
    }
}


+ (id)bxh_dataForKey:(NSString *)key suiteName:(NSString *)suiteName {
    if (key) {
        NSUserDefaults *userDefaults = suiteName ? [[NSUserDefaults alloc] initWithSuiteName:suiteName] : [NSUserDefaults standardUserDefaults];
        if ([userDefaults isKindOfClass:[NSUserDefaults class]]) {
            return [userDefaults objectForKey:key];
        }
    }
    return nil;
}

+ (void)bxh_removeDataForKey:(NSString *)key suiteName:(NSString *)suiteName {
    if (key) {
        NSUserDefaults *userDefaults = suiteName ? [[NSUserDefaults alloc] initWithSuiteName:suiteName] : [NSUserDefaults standardUserDefaults];
        if ([userDefaults isKindOfClass:[NSUserDefaults class]]) {
            [userDefaults removeObjectForKey:key];
        }
    }
}

@end
