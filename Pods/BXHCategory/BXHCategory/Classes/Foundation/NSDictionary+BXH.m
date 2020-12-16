//
//  NSDictionary+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import "NSDictionary+BXH.h"

@implementation NSDictionary (BXH)
- (BOOL)containsDictionary:(NSDictionary *)dictionary {
    if ([dictionary isKindOfClass:[NSDictionary class]] && dictionary.count > 0) {
        BOOL result = YES;
        for (NSString *key in dictionary.allKeys) {
            if ([key hasPrefix:@"_"]) {
                continue;
            }
            id value = self[key];
            if (!value || ![value isEqual:dictionary[key]]) {
                result = NO;
                break;
            }
        }
        return result;
    } else {
        return YES;
    }
}


- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *string = [NSMutableString string];
    // 开头有个{
    [string appendString:@"{\n"];
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    // 结尾有个}
    [string appendString:@"}"];
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
    {
        [string deleteCharactersInRange:range];
    }
    return string;
}
@end
