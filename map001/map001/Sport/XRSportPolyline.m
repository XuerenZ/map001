//
//  XRSportPolyline.m
//  map001
//
//  Created by acer on 17/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportPolyline.h"

@implementation XRSportPolyline
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color {
    
    XRSportPolyline *polyline = [self polylineWithCoordinates:coords count:count];
    
    polyline.color = color;
    
    return polyline;
}
@end
