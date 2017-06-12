//
//  XRSportMapModelViewController.h
//  map001
//
//  Created by acer on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface XRSportMapModelViewController : UIViewController
/**
 选中地图类型
 */
@property (nonatomic, copy) void (^didSelectedMapMode)(MAMapType mapType);

/**
 当前地图显示类型
 */
@property (nonatomic, assign) MAMapType currentType;
@end
