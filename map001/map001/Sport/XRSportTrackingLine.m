//
//  XRSportTrackingLine.m
//  map001
//
//  Created by acer on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportTrackingLine.h"

@implementation XRSportTrackingLine
- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation {
    self = [super init];
    if (self) {
        _startLocation = startLocation;
        _endLocation = endLocation;
    }
    return self;
}
- (double)speed {
    // m / s => km / hour
    // m / s => 1000 * m / 3600 * s
    // (3600 * m) / (s * 1000)  =>  km / hour
    return (_startLocation.speed + _endLocation.speed) * 0.5 * 3.6;
}

- (NSTimeInterval)time {
    return [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

- (double)distance {
    return [_endLocation distanceFromLocation:_startLocation] * 0.001;
}
- (XRSportPolyline *)polyline {
    
    CLLocationCoordinate2D coords[2];
    
    coords[0] = _startLocation.coordinate;
    coords[1] = _endLocation.coordinate;
    
    // `临时`设置放大比例因子
    CGFloat factor = 8;
    CGFloat red = factor * self.speed / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:1 blue:0 alpha:1];
    
    // 测试两点间的运动数据
    NSLog(@"速度 %f 时间 %f 距离 %f", self.speed, self.time, self.distance);
    
    return [XRSportPolyline polylineWithCoordinates:coords count:2 color:color];
}
@end
