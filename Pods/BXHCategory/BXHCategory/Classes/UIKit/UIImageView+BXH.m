//
//  UIImageView+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/15.
//

#import "UIImageView+BXH.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+BXH.h"

@implementation UIImageView (BXH)
//通过网络图片url将图片转换成二进制img
- (UIImage *) bxh_getImageFromURL:(NSString *)fileURL {
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    UIImage * result = [UIImage imageWithData:data];
    return result;
}

//保存图片缓存
-(void) bxh_saveImage:(UIImage *)image withImageFileName:(NSString *)imageName ofImageType:(NSString *)imageType {
    NSString * directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if ([@"png" isEqualToString:[imageType lowercaseString]]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([@"jpg" isEqualToString:[imageType lowercaseString]] || [@"jpeg" isEqualToString:[imageType lowercaseString]]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
    }
}
//读取图片缓存
-(UIImage *) bxh_loadImage:(NSString *)imageFileName ofImageType:(NSString *)imageType {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0];
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", documentsDirectory, imageFileName, imageType]];
    return result;
}
//读取图片缓存(完整路径)
-(UIImage *) bxh_loadCompleteImage:(NSString *)imageFileName ofImageType:(NSString *)imageType {
    NSString *documentsDirectory2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0]; //path数组里貌似只有一个元素
    //字符串拼接得到文件完整路径
    NSString *filestr = [NSString stringWithFormat:@"/%@.%@",imageFileName,imageType];
    NSString *newstr = [documentsDirectory2 stringByAppendingString:filestr];
    NSData *dd = [NSData dataWithContentsOfFile:newstr];
    UIImage *img=[UIImage imageWithData:dd];
    return img;
}

#pragma mark - <下载图片>

- (void)bxh_downloadImageWithURL:(NSString *)imageURL completion:(void(^)(UIImage *image))completion {
    [self bxh_dowmloadImageWithURL:[self imageURL:imageURL imageMogr2Parameter:nil]
                  placeholder:nil
                   completion:completion];
}

/// Show default placeholder image
- (void)bxh_downloadDefaultPlaceholderWithImageURL:(NSString *)imageURL completion:(void (^)(UIImage *))completion {
    [self bxh_dowmloadImageWithURL:[self imageURL:imageURL imageMogr2Parameter:nil]
                  placeholder:[UIImage imageNamed:@"yit_placeholder_16_9"]
                   completion:completion];
}

- (void)bxh_dowmloadImageWithURL:(NSString *)imageURL placeholder:(UIImage *)placeholder completion:(void(^)(UIImage *image))completion {
    __weak typeof(self) weakself = self;
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
            placeholderImage:placeholder
                   completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                       if (image && cacheType == SDImageCacheTypeNone) {
                           CATransition *transition = [CATransition animation];
                           transition.type = kCATransitionFade;
                           transition.duration = 0.3;
                           transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                           [weakself.layer addAnimation:transition forKey:nil];
                       }
                       if (completion) {
                           if (!error) {
                               completion(image);
                           } else {
                               completion(nil);
                           }
                       }
                   }];
}
#pragma mark - Private
/* Appending imagemogr2 parameter
 * https://developer.qiniu.com/dora/manual/1270/the-advanced-treatment-of-images-imagemogr2
 */
- (NSString *)imageURL:(NSString *)urlString imageMogr2Parameter:(NSString *)parameter {
    NSString *newURLString = [urlString copy];
//    可以处理一些拼接的参数
//    if ([parameter isEmptyString]) {
//        parameter = @"";
//    }
//    if ([newURLString isEmptyString]) {
//        NSURL *imageURL = [NSURL URLWithString:newURLString];
//        if (imageURL) {
//            BOOL alreadyHasQuery = imageURL.query.length > 0;
//            newURLString = [newURLString stringByAppendingFormat:@"%@imageMogr2/strip%@", (alreadyHasQuery? @"&" : @"?"), parameter];
//        }
//    }
    return newURLString;
}

/**
 *  图片切圆角
 *  @param cornerRadius 圆角弧度
 */
- (void) bxh_cutRoundedCornerRadius:(CGFloat)cornerRadius {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    [self.layer setMask:maskLayer];
}



@end
