//
//  XRSportTracking.m
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportTracking.h"

@implementation XRSportTracking
- (instancetype)initWithType:(XRSportType)type {
    self = [super init];
    if (self) {
        _sportType = type;
    }
    return self;
}
@end
