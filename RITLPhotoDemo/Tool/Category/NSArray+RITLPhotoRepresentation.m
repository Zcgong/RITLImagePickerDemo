//
//  NSArray+RITLPhotoRepresentation.m
//  RITLPhotoDemo
//
//  Created by YueWen on 2017/1/6.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import "NSArray+RITLPhotoRepresentation.h"

@implementation NSArray (RITLPhotoRepresentation)

+(instancetype)arrayWithInitializeValue:(id)value count:(NSUInteger)count
{
    return [[NSMutableArray arrayWithInitializeValue:value count:count] copy];
}

@end


@implementation NSMutableArray (RITLPhotoRepresentation)

+(instancetype)arrayWithInitializeValue:(id)value count:(NSUInteger)count
{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:count];
    
    for (NSUInteger i = 0; i < count; i++)
    {
        [array addObject:value];
    }
    
    return array;
}

@end
