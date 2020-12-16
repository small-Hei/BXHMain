//
//  UIView+BXH.m
//  BXHCategory
//
//  Created by baishuang on 2020/12/14.
//

#import "UIView+BXH.h"
#import <objc/runtime.h>
static char BXH_TapGesture;
static char BXH_TapGestureBlock;
static char BXH_KVO;

@implementation UIView (BXH)
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)left {
    return CGRectGetMaxX(self.frame) - CGRectGetWidth(self.frame);
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setCornerRadius:(CGFloat)radius {
    [self cropCornerRadius:radius];
    self.layer.masksToBounds = YES;
}

- (void)setTapGestureWithBlock:(void (^)(void))block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, &BXH_TapGesture);
    if (!tapGesture) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yit_hanldeTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        objc_setAssociatedObject(self, &BXH_TapGesture, tapGesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &BXH_TapGestureBlock, block, OBJC_ASSOCIATION_COPY);
}

#pragma mark - <处理图片圆角>
- (void)cropCornerRadius:(CGFloat)cornerRadius {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) cornerRadius:cornerRadius];
    maskLayer.path = bezierPath.CGPath;
    
    [self.layer setMask:maskLayer];
}

- (void)setGradienColor:(UIColor *)fromColor to:(UIColor *)toColor {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAGradientLayer class]]) {
            [subLayer removeFromSuperlayer];
            break;
        }
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}

- (UIViewController *)embeddedViewController {
    UIViewController *result = nil;
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass: [UIViewController class]]) {
            result = (UIViewController *)responder;
            break;
        }
    }
    return result;
}

@end
