//
//  XRSportTracking.h
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 运动类型枚举
typedef enum : NSUInteger {
    XRSportTypeRun,
    XRSportTypeWalk,
    XRSportTypeBike,
} XRSportType;
@interface XRSportTracking : NSObject
/**
 使用运动类型实例化追踪模型
 
 @param type type
 
 @return 追踪模型
 */
- (instancetype)initWithType:(XRSportType)type;

/**
 运动类型
 */
@property (nonatomic, assign, readonly) XRSportType sportType;
@end
