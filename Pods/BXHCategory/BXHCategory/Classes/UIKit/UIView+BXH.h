//
//  UIView+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BXH)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

/// 设置边角弧度
- (void) setCornerRadius:(CGFloat)radius;

- (void)setTapGestureWithBlock:(void(^)(void))block;
/**
 *  页面切圆角
 *
 *  @param cornerRadius 圆角弧度
 */
- (void)cropCornerRadius:(CGFloat)cornerRadius;

/**
 设置渐变背景色
 */
- (void)setGradienColor:(UIColor *)fromColor to:(UIColor *)toColor;

/// 获取当前View所在的ViewController
- (nullable UIViewController *)embeddedViewController;

@end

NS_ASSUME_NONNULL_END
