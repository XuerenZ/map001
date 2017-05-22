//
//  XRSportMapViewController.m
//  map001
//
//  Created by acer on 17/5/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportMapViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface XRSportMapViewController ()<MAMapViewDelegate>

@end

@implementation XRSportMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMapView];
}
#pragma mark - 设置界面
/**
 设置地图视图
 */
- (void)setupMapView {
    
    // 1. 实例化地图视图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    // 2. 添加到根视图
    [self.view addSubview:mapView];
    
    // 3. 隐藏比例尺
    mapView.showsScale = NO;
    
    // 4. 关闭相机旋转 - 能够降低能耗，省电
    mapView.rotateCameraEnabled = NO;
    
    // 5. 显示用户的位置
    mapView.showsUserLocation = YES;
    
    // 6. 跟踪用户的位置 - 可以将用户定位在地图的中心，并且放大地图，有的时候，速度会有些慢！
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    // 7. 允许后台定位 - 保证 Background Modes 中的 Location updates 处于选中状态
    mapView.allowsBackgroundLocationUpdates = YES;
    
    // 8. 不允许系统暂停位置更新
    mapView.pausesLocationUpdatesAutomatically = NO;
    
    // 9. 设置代理
    mapView.delegate = self;
}

#pragma mark -MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

@end
