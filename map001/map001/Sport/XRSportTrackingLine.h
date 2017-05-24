//
//  XRSportTrackingLine.h
//  map001
//
//  Created by acer on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRSportPolyline.h"
@interface XRSportTrackingLine : NSObject


/**
 使用起始点和结束点，实例化线条模型
 
 @param startLocation 起始点
 @param endLocation   结束点
 
 @return 轨迹追踪线条模型
 */
- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation;
/**
 起始点
 */
@property (nonatomic, strong, readonly) CLLocation *startLocation;
/**
 结束点
 */
@property (nonatomic, strong, readonly) CLLocation *endLocation;
/**
 描述起始点和结束点之间的折线模型
 */
@property (nonatomic, readonly) XRSportPolyline *polyline;
@end
