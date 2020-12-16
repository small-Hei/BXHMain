//
//  NSURL+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (BXH)
/**
 *  替换URL的host
 *
 *  @param host URL的host
 *  @return 替换掉host的URL
 */
- (NSURL *)URLWithChangedHost:(NSString *)host;

/**
 *  获取URL的相对路径+query
 *
 *  @return URL的相对路径+query
 */
- (NSString *)relativeURLString;
@end

NS_ASSUME_NONNULL_END
