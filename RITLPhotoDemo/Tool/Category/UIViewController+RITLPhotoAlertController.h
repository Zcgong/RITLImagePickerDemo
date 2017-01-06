//
//  UIViewController+RITLPhotoAlertController.h
//  RITLPhotoDemo
//
//  Created by YueWen on 2016/12/29.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (RITLPhotoAlertController)


- (void)presentAlertController:(NSUInteger)maxNumberOfSelectedPhotos;

@end

NS_ASSUME_NONNULL_END
