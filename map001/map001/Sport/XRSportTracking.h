//
//  XRSportTracking.h
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRSportPolyline.h"
#import "XRSportTrackingLine.h"
/// 运动类型枚举
typedef enum : NSUInteger {
    XRSportTypeRun,
    XRSportTypeWalk,
    XRSportTypeBike,
} XRSportType;
/// 运动状态枚举
typedef enum : NSUInteger {
    XRSportStatePause,
    XRSportStateContinue,
    XRSportStateFinish,
} XRSportState;
/// GPS信号状态
typedef enum : NSUInteger {
    XRSportGPSSignalStateDisconnect,
    XRSportGPSSignalStateBad,
    XRSportGPSSignalStateNormal,
    XRSportGPSSignalStateGood
} XRSportGPSSignalState;

/// GPS 信号变化通知
extern NSString *const XRSportGPSSignalChangedNotification;
@interface XRSportTracking : NSObject
/**
 使用运动类型实例化追踪模型
 
 @param type type
 
 @return 追踪模型
 */
- (instancetype)initWithType:(XRSportType)type state:(XRSportState)state;
/**
 运动图像
 */
@property (nonatomic, strong, readonly) UIImage *sportImage;
/**
 运动类型
 */
@property (nonatomic, assign, readonly) XRSportType sportType;
/**
 运动状态
 */
@property (nonatomic, assign) XRSportState sportState;
/**
 追加用户当前位置，返回折线模型
 
 @param location location
 
 @return 折线模型
 */
- (XRSportPolyline *)appendLocation:(CLLocation *)location;
/**
 平均速度
 */
@property (nonatomic, readonly) double avgSpeed;
/**
 最大速度
 */
@property (nonatomic, readonly) double maxSpeed;
/**
 总时长
 */
@property (nonatomic, readonly) double totalTime;
/**
 总时长 00:00:00 格式的字符串
 */
@property (nonatomic, readonly) NSString *totalTimeStr;
/**
 总距离
 */
@property (nonatomic, readonly) double totalDistance;
@end
