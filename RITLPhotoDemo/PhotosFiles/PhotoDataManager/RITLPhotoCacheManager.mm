//
//  RITLPhotoCacheManager.m
//  RITLPhotoDemo
//
//  Created by YueWen on 2016/12/29.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "RITLPhotoCacheManager.h"
#import "NSArray+RITLPhotoRepresentation.h"

@interface RITLPhotoCacheManager ()

/// 是否选择的长度
@property (nonatomic, assign)unsigned long numberOfAssetIsSelectedSignal;

@end

@implementation RITLPhotoCacheManager


-(instancetype)init
{
    if (self = [super init])
    {
        _numberOfSelectedPhoto = 0;
        _maxNumberOfSelectedPhoto = NSUIntegerMax;
    }
    
    return self;
}


+(instancetype)sharedInstace
{
    static RITLPhotoCacheManager * cacheManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cacheManager = [self new];
        
    });
    
    return cacheManager;
}



-(void)allocInitAssetIsSelectedSignal:(NSUInteger)count
{
    
    if (self.assetIsSelectedSignal)
    {
        free(self.assetIsSelectedSignal);
        self.assetIsSelectedSignal = nil;
    }
    
    self.numberOfAssetIsSelectedSignal = count;

    //初始化
    self.assetIsSelectedSignal = new BOOL[count];
    
    memset(self.assetIsSelectedSignal,false,count * sizeof(BOOL));
}


-(void)ritl_allocInitAssetIsSelectedSignal:(NSUInteger)count
{
    //记录
    self.numberOfAssetIsSelectedSignal = count;
    
    self.assetIsSelectedSignalArray = [NSMutableArray arrayWithInitializeValue:@(false) count:count];
}


-(void)allocInitAssetIsPictureSignal:(NSUInteger)count
{
    if (self.assetIsPictureSignal)
    {
        free(self.assetIsPictureSignal);
        self.assetIsPictureSignal = nil;
    }

    self.assetIsPictureSignal = new BOOL[count];
    
    memset(self.assetIsPictureSignal,false,count * sizeof(BOOL));
}




-(void)ritl_allocInitAssetIsPictureSignal:(NSUInteger)count
{
    self.assetIsPictureSignalArray = [NSMutableArray arrayWithInitializeValue:@(false) count:count];
}



-(BOOL)changeAssetIsSelectedSignal:(NSUInteger)index
{
    if (index > self.numberOfAssetIsSelectedSignal)
    {
        return false;
    }
    
    self.assetIsSelectedSignal[index] = !self.assetIsSelectedSignal[index];
    
//    self.assetIsSelectedSignalArray = CFBridgingRelease(self.assetIsPictureSignal);
    
    //修改修改后的状态
    BOOL value = [self.assetIsSelectedSignalArray[index] boolValue];
    [self.assetIsSelectedSignalArray replaceObjectAtIndex:index withObject:@(value)];
    
//    printf("选中状态:%d\n",self.assetIsSelectedSignal[index]);
    printf("选中状态:%d\n",self.assetIsSelectedSignalArray[index].boolValue);
    
    return true;
}



-(void)dealloc
{

}



-(void)freeAllSignal
{
    if (self.assetIsPictureSignal)
    {
        free(self.assetIsPictureSignal);
        self.assetIsPictureSignal = nil;
    }
    
    if (self.assetIsSelectedSignal)
    {
        free(self.assetIsSelectedSignal);
        self.assetIsSelectedSignal = nil;
    }
    
    _numberOfSelectedPhoto = 0;
    _maxNumberOfSelectedPhoto = NSUIntegerMax;
    _numberOfAssetIsSelectedSignal = 0;
    _isHightQuarity = false;
}


//void resetSignal(BOOL ** signal,NSUInteger count, BOOL value)
//{
//    if (*signal)
//    {
//        free(*signal);
//        NSLog(@"signal dealloc");
//    }
//    
//    BOOL * signalreSet = new BOOL[count];
//    
//    memset(signalreSet, value, count * sizeof(BOOL));
//    
//    signal = &signalreSet;
//}
//
//
//-(void)negation:(BOOL *)value
//{
//    //取值
//    BOOL originValue = * value;
//    
//    BOOL negationValue = !originValue;
//    
//    value = &negationValue;
//
//}

@end
