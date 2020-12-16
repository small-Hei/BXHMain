//
//  NSString+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BXH)

#pragma mark - Image相关（宽 高）信息
/**
 *返回当前字符串对应的二维码图像
 *二维码的实现就是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 **/
- (UIImage *)createQRcode;

#pragma mark - Bool 判断相关信息
///是否包含指定的字符串
- (BOOL)isContains:(NSString *)str;

///判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string;

///判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

/// 是否为空字符串
- (BOOL)isEmptyString;

#pragma mark - 计算相关（宽 高）信息
/// 根据高度计算宽度
+ (CGFloat)getRectWidth:(CGFloat)height Font:(NSInteger) fontSize Content:(NSString *)content;
///根据宽度计算高度
+ (CGFloat)getRectHeight:(CGFloat)width Font:(NSInteger) fontSize Content:(NSString *)content;

// 获得字符串尺寸
- (CGSize)getSize:(CGSize)renderSize attributes:(NSDictionary *)attributes;

#pragma mark - 转化相关信息（NSDictionary NSArray）
//获取url里面的参数
- (NSDictionary *)getURLParams;

// JsonToDic 把格式化的JSON格式的字符串转换成字典
- (NSDictionary *)dictionaryWithJSONString;

#pragma mark - 加密
+ (NSString *)md5StringWithString:(NSString *)string;
+ (NSString *)md5StringWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
