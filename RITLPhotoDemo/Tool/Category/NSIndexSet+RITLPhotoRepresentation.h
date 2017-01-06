//
//  NSIndexSet+RITLPhotoRepresentation.h
//  RITLPhotoDemo
//
//  Created by YueWen on 2017/1/6.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexSet (RITLPhotoRepresentation)

/**
 枚举完成之后的便利回调

 @param completeBlock 完成的回调
 */
- (void)enumerateIndexesComplete:(void(^)(NSArray <NSNumber *> *))completeBlock;

@end

NS_ASSUME_NONNULL_END
