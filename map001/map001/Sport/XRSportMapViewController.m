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
{
    /// 起始位置
    CLLocation *_startLocation;
}

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
/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 0. 判断 `位置数据` 是否变化 - 不一定是经纬度变化！
    if (!updatingLocation) {
        return;
    }
    
    // 大概 1s 更新一次！
    NSLog(@"%@ %p", userLocation.location, userLocation.location);
    
    // 判断起始位置是否存在
    if (_startLocation == nil) {
        _startLocation = userLocation.location;
        
        // 1. 实例化大头针
        MAPointAnnotation *annotaion = [MAPointAnnotation new];
        
        // 2. 指定坐标位置
        annotaion.coordinate = userLocation.location.coordinate;
        
        // 3. 添加到地图视图
        [mapView addAnnotation:annotaion];
    }
}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"%f %f", coordinate.latitude, coordinate.longitude);
    
    // 开始画线
    // 1. 建立结构体的数组
    CLLocationCoordinate2D coords[2];
    
    coords[0] = coordinate;
    coords[1] = _startLocation.coordinate;
    
    // 2. 构造折线对象
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:2];
    
    // 3. 添加到地图
    [mapView addOverlay:polyline];
}
/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    // 1. 判断 overlay 的类型
    if (![overlay isKindOfClass:[MAPolyline class]]) {
        return nil;
    }
    
    // 2. 实例化折线渲染器
    MAPolylineRenderer *renderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
    
    // 3. 设置显示属性
    renderer.lineWidth = 5;
    renderer.strokeColor = [UIColor greenColor];
    
    return renderer;
}
/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 选中的annotation views
 */
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
