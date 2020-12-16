//
//  NSString+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import "NSString+BXH.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BXH)
- (UIImage *)createQRcode {
    //1.实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //1.1>设置filter的默认值
    //因为之前如果使用过滤镜，输入有可能会被保留，因此，在使用滤镜之前，最好恢复默认设置
    [filter setDefaults];
    //2将传入的字符串转换为NSData
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //3.将NSData传递给滤镜（通过KVC的方式，设置inputMessage）
    [filter setValue:data forKey:@"inputMessage"];
    //4.由filter输出图像
    CIImage *outputImage = [filter outputImage];
    //5.将CIImage转换为UIImage
    UIImage *qrImage = [UIImage imageWithCIImage:outputImage];
    //6.返回二维码图像
    return qrImage;
}

#pragma mark - Bool 判断相关信息
//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//判断是否为整型：
+(BOOL)isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)isEmptyString {
    return (!self || self.length <1  || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]);
}
/*!
 *  @brief  是否包含指定的字符串
 */
- (BOOL)isContains:(NSString *)str {
    if (nil == str || [str length] < 1) {
        return NO;
    }
    return [self rangeOfString:str].location != NSNotFound;
}

#pragma mark - 计算相关（宽 高）信息
/// 根据高度计算宽度
+ (CGFloat)getRectWidth:(CGFloat)height Font:(NSInteger) fontSize Content:(NSString *)content{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}
///根据宽度计算高度
+ (CGFloat)getRectHeight:(CGFloat)width Font:(NSInteger) fontSize Content:(NSString *)content{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}

// 获得字符串尺寸
- (CGSize)getSize:(CGSize)renderSize attributes:(NSDictionary *)attributes {
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    CGSize size = [self boundingRectWithSize:renderSize options:options attributes:attributes context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

#pragma mark - 转化相关信息（NSDictionary NSArray）
//获取url里面的参数
- (NSDictionary *)yit_getURLParams {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSRange range1  = [self rangeOfString:@"?"];
    NSRange range2  = [self rangeOfString:@"#!"];
    NSRange range3  = [self rangeOfString:@"#"];
    NSRange range;
    if (range1.location != NSNotFound) {
        range = NSMakeRange(range1.location, range1.length);
    } else if (range2.location != NSNotFound){
        range = NSMakeRange(range2.location, range2.length);
    } else if (range3.location != NSNotFound){
        range = NSMakeRange(range3.location, range3.length);
    }else{
        range = NSMakeRange(-1, 1);
    }
    
    if (range.location != NSNotFound && range.location+ range.length < self.length) {
        NSString * paramString = [self substringFromIndex:range.location+ range.length];
        NSArray * paramCouples = [paramString componentsSeparatedByString:@"&"];
        for (NSUInteger i = 0; i < [paramCouples count]; i++) {
            NSString *oneParamString = [paramCouples objectAtIndex:i];
            NSRange separatedRange = [oneParamString rangeOfString:@"="];
            if (NSNotFound != separatedRange.location) {
                NSString *key = [oneParamString substringToIndex:separatedRange.location];
                NSString *value = [oneParamString substringFromIndex:(separatedRange.location + separatedRange.length)];
                [dic setValue:[value stringByRemovingPercentEncoding] forKey:key];
            }
        }
        return dic;
    }
    return nil;
}
/**
 把格式化的JSON格式的字符串转换成字典
 @return 返回字典
 */
- (NSDictionary *)dictionaryWithJSONString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)md5StringWithString:(NSString *)string {
    return [self md5StringWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)md5StringWithData:(NSData *)data {
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return [output copy];
}

@end
