//
//  XRSportPolyline.h
//  map001
//
//  Created by acer on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface XRSportPolyline : MAPolyline
/**
 构造函数
 
 @param coords 坐标数组
 @param count  坐标数组的容量
 @param color  折线的颜色
 
 @return 折线模型
 */
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;

/**
 折线的颜色
 */
@property (nonatomic, strong) UIColor *color;

@end
