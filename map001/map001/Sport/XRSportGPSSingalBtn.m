//
//  XRSportGPSSingalBtn.m
//  map001
//
//  Created by acer on 17/6/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportGPSSingalBtn.h"
#import "XRSportTracking.h"
@implementation XRSportGPSSingalBtn
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsChanged:) name:XRSportGPSSignalChangedNotification object:nil];
}

- (void)dealloc {
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)gpsChanged:(NSNotification *)notification {
    
    // 1. 从通知中获取 GPS 强度信号
    XRSportGPSSignalState state = [notification.object integerValue];
    
    //    NSLog(@"信号强度 %zd", state);
    // 2. 根据 state 设置按钮的图像和标题
    NSString *imageName = (_isMapButton) ? @"ic_sport_gps_map_" : @"ic_sport_gps_";
    NSString *title;
    
    switch (state) {
        case XRSportGPSSignalStateDisconnect:
            title = @"  GPS已经断开";
            imageName = [imageName stringByAppendingString:@"disconnect"];
            break;
        case XRSportGPSSignalStateBad:
            title = @"  请绕开高楼大厦";
            imageName = [imageName stringByAppendingString:@"connect_1"];
            break;
        case XRSportGPSSignalStateNormal:
            imageName = [imageName stringByAppendingString:@"connect_2"];
            break;
        case XRSportGPSSignalStateGood:
            imageName = [imageName stringByAppendingString:@"connect_3"];
            break;
    }
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 根据是否存在标题设置右侧的内容间距
    UIEdgeInsets insets = self.contentEdgeInsets;
    insets.right = (title == nil) ? 4 : 8;
    self.contentEdgeInsets = insets;
}


@end
