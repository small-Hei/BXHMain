//
//  UIImage+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/15.
//

#import "UIImage+BXH.h"

@implementation UIImage (BXH)
#pragma mark - <图片颜色>
+ (UIImage *)tintImage:(UIImage *)image withColor:(UIColor *)color {
    return [self image:image withTintColor:color blendMode:kCGBlendModeDestinationIn];
}
+ (UIImage *) image:(UIImage *)image withTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [image drawInRect:bounds blendMode:blendMode alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

#pragma mark - <图片压缩>
///图片压缩(根据屏幕)
+ (UIImage *)compressImage:(UIImage *)image {
    return [self compressImage:image withWidth:[UIScreen mainScreen].bounds.size.width];
}

///图片压缩(根据宽度)
+ (UIImage *)compressImage:(UIImage *)image withWidth:(CGFloat)compressWidth{
    if (image == nil) {
        return nil;
    }
    UIImage *scaledSizeImage = nil;
    CGFloat width, height;
    CGFloat targetWidth = compressWidth;
    if (image.size.width > targetWidth) {
        width = targetWidth;
        height = width * image.size.height / image.size.width;
        scaledSizeImage = [self imageWithImage:image scaledToSize:CGSizeMake(width, height)];
    } else {
        scaledSizeImage = image;
    }
    return scaledSizeImage;
}
///图片压缩(根据高度)
+ (UIImage *)compressImage:(UIImage *)image withHeight:(CGFloat)compressHeight{
    if (image == nil) {
        return nil;
    }
    UIImage *scaledSizeImage = nil;
    CGFloat width, height;
    CGFloat targetHeight = compressHeight;
    if (image.size.height > targetHeight) {
        height = targetHeight;
        width = targetHeight * image.size.width / image.size.height;
        scaledSizeImage = [self imageWithImage:image scaledToSize:CGSizeMake(width, height)];
    } else {
        scaledSizeImage = image;
    }
    return scaledSizeImage;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
