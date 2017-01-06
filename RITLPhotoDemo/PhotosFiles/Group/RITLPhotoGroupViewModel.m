//
//  RITLPhotoGroupViewModel.m
//  RITLPhotoDemo
//
//  Created by YueWen on 2016/11/29.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import "RITLPhotoGroupViewModel.h"

#import "PHAssetCollection+RITLPhotoRepresentation.h"

@interface RITLPhotoGroupViewModel ()

@property (nonatomic, strong) RITLPhotoStore * photoStore;

@property (nonatomic, strong) NSArray<PHAssetCollection *> * groups;

@property (nonatomic, strong) PHFetchResult * smartFetchResult;
@property (nonatomic, strong) PHFetchResult * topLevelFetchResult;

@end

@implementation RITLPhotoGroupViewModel

-(instancetype)init
{
    if (self = [super init])
    {
        _photoStore = [RITLPhotoStore new];
        
        
        __weak typeof(self) weakSelf = self;
        
        //记录外部图片变化
        _photoStore.photoStoreHasChanged = ^(PHChange * change){
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            //检测变化
            [strongSelf ritl_checkChangedDetail:change];
        };
        
    }
    
    return self;
}


-(void)dealloc
{
#ifdef RITLDebug
    NSLog(@"Dealloc %@",NSStringFromClass([self class]));
#endif
}




-(NSUInteger)numberOfGroup
{
    return 1;
}


-(NSUInteger)numberOfRowInSection:(NSUInteger)section
{
    return self.groups.count;
}


-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //回调当前的PHAssetCollection
//    if (self.selectedBlock)
//    {
//        self.selectedBlock([self assetCollectionIndexPath:indexPath],indexPath);
//    }
}


-(void)ritl_didSelectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animate
{
    if (self.selectedBlock)
    {
        self.selectedBlock([self assetCollectionIndexPath:indexPath],indexPath,animate);
    }
}


-(PHAssetCollection *)assetCollectionIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    
    if (row > self.groups.count)
    {
        return nil;
    }
    
    return self.groups[row];
}




-(void)dismissGroupController
{
    if (self.dismissGroupBlock) self.dismissGroupBlock();
}




-(void)fetchDefaultGroups
{
    __weak typeof(self) weakSelf = self;
    
    
    [_photoStore fetchDefaultAllPhotosGroupReponseChanged:^(NSArray<PHAssetCollection *> * _Nonnull groups, PHFetchResult * _Nonnull smartResult, PHFetchResult * _Nonnull topResult) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.groups = groups;
        
        strongSelf.smartFetchResult = smartResult;
        strongSelf.topLevelFetchResult = topResult;
        
        //进行回调
        if (strongSelf.fetchGroupsBlock)  strongSelf.fetchGroupsBlock(strongSelf.groups);
        
    }];
    
    /******************************************************************************************
    
    [_photoStore fetchDefaultAllPhotosGroup:^(NSArray<PHAssetCollection *> * _Nonnull groups, PHFetchResult * _Nonnull collections) {
      
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.groups = groups;
        
        //进行回调
        if (strongSelf.fetchGroupsBlock)  strongSelf.fetchGroupsBlock(strongSelf.groups);
        
    }];
    
    
   [_photoStore fetchPhotosGroup:^(NSArray<PHAssetCollection *> * _Nonnull groups) {
      
       __strong typeof(weakSelf) strongSelf = weakSelf;
       
       strongSelf.groups = groups;
       
       //进行回调
       if (strongSelf.fetchGroupsBlock)  strongSelf.fetchGroupsBlock(strongSelf.groups);

   }];
     
     ******************************************************************************************/
}


-(CGSize)imageSize
{
    if (_imageSize.width == 0 && _imageSize.height == 0)
    {
        return CGSizeMake(60, 60);
    }
    
    return _imageSize;
}



-(void)loadGroupTitleImage:(NSIndexPath *)indexPath
             complete:(PhotoGroupMessageBlock)competeBlock
{
    PhotoGroupMessageBlock complete  = [competeBlock copy];
    
    //获取对象
    PHAssetCollection * collection = [self assetCollectionIndexPath:indexPath];
    
    
    [collection representationImageWithSize:self.imageSize complete:^(NSString * _Nonnull title, NSUInteger count, UIImage * _Nullable image) {
        
        //
        NSString * appendTitle = [NSString stringWithFormat:@"%@(%@)",NSLocalizedString(title,@""),@(count)];
        
        complete(title,image,appendTitle,count);
        
    }];
    
}




-(PHFetchResult *)fetchPhotos:(NSIndexPath *)indexPath;
{
    return [PHAsset fetchAssetsInAssetCollection:[self assetCollectionIndexPath:indexPath] options:[[PHFetchOptions alloc]init]];
}


-(NSString *)title
{
    return @"相册";
}



#pragma mark - Change



/**
 检测相册所有数据的变化

 @param change 变化对象
 */
- (void)ritl_checkChangedDetail:(PHChange *)change
{
    if ([[NSThread currentThread] isMainThread])
    {
        [self fetchDefaultGroups]; return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self fetchDefaultGroups];
        
    });
}




/**
 检测智能分组是否发生变化

 @param changeDetails 详细对象
 */
- (void)ritl_smartChangeCheck:(PHFetchResultChangeDetails *)changeDetails
{
    
}



/**
 其他分组是否发生变化

 @param changeDetails 详细对象
 */
- (void)ritl_topLevelChangeCheck:(PHFetchResultChangeDetails *)changeDetails
{
    // 如果没有变化
    if (!changeDetails.hasIncrementalChanges)
    {
        return;
    }
    
    [self fetchDefaultGroups];
}


@end
