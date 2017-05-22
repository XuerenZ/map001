//
//  XRSportMapViewController.h
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XRSportTracking.h"
@interface XRSportMapViewController : UIViewController
/**
 本次运动轨迹追踪模型
 */
@property (nonatomic, strong) XRSportTracking *sportTracking;
@end
