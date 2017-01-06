//
//  NSArray+RITLPhotoRepresentation.h
//  RITLPhotoDemo
//
//  Created by YueWen on 2017/1/6.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <__covariant ObjectType> (RITLPhotoRepresentation)

+ (instancetype)arrayWithInitializeValue:(ObjectType)value count:(NSUInteger)count;

@end


@interface NSMutableArray<ObjectType> (RITLPhotoRepresentation)

+ (instancetype)arrayWithInitializeValue:(ObjectType)value count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
