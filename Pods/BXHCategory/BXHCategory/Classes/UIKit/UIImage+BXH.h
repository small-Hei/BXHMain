//
//  UIImage+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (BXH)

///根据color修改image的color
+ (UIImage *)tintImage:(UIImage *)image withColor:(UIColor *)color;

///图片压缩(根据屏幕宽度)
+ (UIImage *)compressImage:(UIImage *)image;
///图片压缩(根据宽度)
+ (UIImage *)compressImage:(UIImage *)image withWidth:(CGFloat)compressWidth;
///图片压缩(根据高度)
+ (UIImage *)compressImage:(UIImage *)image withHeight:(CGFloat)compressHeight;

@end

NS_ASSUME_NONNULL_END
