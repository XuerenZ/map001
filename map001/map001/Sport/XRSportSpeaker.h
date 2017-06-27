//
//  XRSportSpeaker.h
//  map001
//
//  Created by acer on 17/6/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRSportTracking.h"
@interface XRSportSpeaker : NSObject
/**
 修改运动状态
 
 @param state 运动状态
 */
- (void)sportStateChanged:(XRSportState)state;
/**
 开始指定类型的运动
 
 @param type 运动类型
 */
- (void)startSportWithType:(XRSportType)type;
/**
 单位距离
 */
@property (nonatomic, assign) double unitDistance;

/**
 整单位距离的播报
 
 @param distance 距离
 @param time     时间
 @param speed    速度
 */
- (void)reportWithDistance:(double)distance time:(NSTimeInterval)time speed:(double)speed;@end
