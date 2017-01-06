//
//  RITLBaseViewModel.h
//  RITLPhotoDemo
//
//  Created by YueWen on 2016/12/28.
//  Copyright © 2017年 YueWen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RITLPublicViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef PhotoBlock          RITLShouldDismissBlock;
typedef PhotoCompleteBlock6 RITLShouldAlertToWarningBlock;
typedef PhotoBlock          RITLShouldReloadBlock;

/// 基础的viewModel
@interface RITLBaseViewModel : NSObject <RITLPublicViewModel>

/// 选择图片达到最大上限，需要提醒的block
@property (nonatomic, copy, nullable)RITLShouldAlertToWarningBlock warningBlock;

/// 模态弹出的回调
@property (nonatomic, copy, nullable)RITLShouldDismissBlock dismissBlock;

/// 刷新的block
@property (nonatomic, copy, nullable)RITLShouldReloadBlock reloadBlock;

/// 选择图片完成
- (void)photoDidSelectedComplete;

@end

NS_ASSUME_NONNULL_END
