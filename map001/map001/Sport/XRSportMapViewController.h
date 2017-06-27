//
//  XRSportMapViewController.h
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XRSportTracking.h"
@class XRSportMapViewController;
@protocol XRSportMapViewControllerDelegate <NSObject>
/**
 运动地图控制器数据变化
 
 @param vc 运动地图控制器
 */
- (void)sportMapViewControllerDidChangedData:(XRSportMapViewController *)vc;

@end

@interface XRSportMapViewController : UIViewController

/**
 代理
 */
@property (nonatomic, weak) id <XRSportMapViewControllerDelegate> delegate;
/**
 本次运动轨迹追踪模型
 */
@property (nonatomic, strong) XRSportTracking *sportTracking;
/**
 地图视图
 */
@property (nonatomic, weak, readonly) MAMapView *mapView;
@end
