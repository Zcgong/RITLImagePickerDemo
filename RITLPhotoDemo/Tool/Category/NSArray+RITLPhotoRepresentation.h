//
//  NSArray+RITLPhotoRepresentation.h
//  RITLPhotoDemo
//
//  Created by YueWen on 2017/1/6.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <__covariant ObjectType> (RITLPhotoRepresentation)


/**
 一次性初始化数组对象

 @param value 初始化值
 @param count 数组的长度
 @return
 */
+ (instancetype)arrayWithInitializeValue:(ObjectType)value count:(NSUInteger)count;

@end


@interface NSMutableArray<ObjectType> (RITLPhotoRepresentation)


/**
 一次性初始化数组对象

 @param value 初始化值
 @param count 数组的长度
 @return 
 */
+ (instancetype)arrayWithInitializeValue:(ObjectType)value count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
