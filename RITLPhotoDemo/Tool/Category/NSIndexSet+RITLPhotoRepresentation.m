//
//  NSIndexSet+RITLPhotoRepresentation.m
//  RITLPhotoDemo
//
//  Created by YueWen on 2017/1/6.
//  Copyright © 2017年 YueWen. All rights reserved.
//  Github:https://github.com/RITL/RITLImagePickerDemo
//

#import "NSIndexSet+RITLPhotoRepresentation.h"

@implementation NSIndexSet (RITLPhotoRepresentation)

-(void)enumerateIndexesComplete:(void (^)(NSArray<NSNumber *> * _Nonnull))completeBlock
{
    void(^complete)(NSArray <NSNumber *> *) = [completeBlock copy];
    
    __block NSMutableArray <NSNumber *> * completeArray = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
       
        [completeArray addObject:@(idx)];
        
        if (completeArray.count == self.count)
        {
            complete(completeArray);
        }
        
    }];
}

@end
