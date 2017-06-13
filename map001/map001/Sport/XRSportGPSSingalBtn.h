//
//  XRSportGPSSingalBtn.h
//  map001
//
//  Created by acer on 17/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 GPS信号强度提示按钮
 
 IB_DESIGNABLE 表示该视图可以在 IB 中设置属性
 */
IB_DESIGNABLE

@interface XRSportGPSSingalBtn : UIButton

/**
 是否地图界面按钮
 */
@property (nonatomic, assign) IBInspectable BOOL isMapButton;
@end
