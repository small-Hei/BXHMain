//
//  UIImageView+BXH.h
//  BXHCategory
//
//  Created by baishuang on 2020/12/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (BXH)

//通过网络图片url将图片转换成二进制img
-(UIImage *) bxh_getImageFromURL:(NSString *)fileURL;
//保存图片缓存
-(void)bxh_saveImage:(UIImage *)image withImageFileName:(NSString *)imageName ofImageType:(NSString *)imageType;
//读取图片缓存
-(UIImage *) bxh_loadImage:(NSString *)imageFileName ofImageType:(NSString *)imageType;
//读取图片缓存(完整路径)
-(UIImage *)bxh_loadCompleteImage:(NSString *)imageFileName ofImageType:(NSString *)imageType;

#pragma mark - <下载图片>
/**
 *  下载图片
 *  @param imageURL 图片URL地址
 *  @param completion 下载完成回调
 */
- (void)bxh_downloadImageWithURL:(NSString *)imageURL completion:(void(^)(UIImage *image))completion;

/**
 *
 *  @param imageURL 图片URL地址
 *  @param completion 下载完成回调
 */
- (void)bxh_downloadDefaultPlaceholderWithImageURL:(NSString *)imageURL completion:(void (^)(UIImage *))completion;

/**
 *  下载图片默认Placeholder.
 *  @param imageURL 图片URL地址
 *  @param placeholder placeholder图片
 *  @param completion 下载完成回调
 */
- (void)bxh_dowmloadImageWithURL:(NSString *)imageURL placeholder:(UIImage *)placeholder completion:(void(^)(UIImage *image))completion;

/**
 *  图片切圆角
 *  @param cornerRadius 圆角弧度
 */
- (void)bxh_cutRoundedCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
