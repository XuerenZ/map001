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

@end
