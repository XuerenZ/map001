//
//  XRSportCameraViewController.m
//  map001
//
//  Created by acer on 17/6/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface XRSportCameraViewController ()
/**
 预览视图
 */
@property (weak, nonatomic) IBOutlet UIView *previewView;
/**
 水印图像视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *waterprintImageView;
/**
 距离标签
 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

/**
 快门约束数组
 */
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *maskViewConstraints;

@end

@implementation XRSportCameraViewController{
    /// 拍摄会话
    AVCaptureSession *_captureSession;
    /// 输入设备 - 摄像头
    AVCaptureDeviceInput *_inputDevice;
    /// 图像输出
    AVCapturePhotoOutput *_imageOutput;
    /// 取景框 - 预览图层
    AVCaptureVideoPreviewLayer *_previewLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置拍摄会话
    [self setupCaptureSession];
}

/**
 设置拍摄会话
 */
- (void)setupCaptureSession {
    
    // 0. 具体的设备 - 摄像头／麦克风(模拟器没有摄像头，应该使用真机测试)
    AVCaptureDevice *device = [self captureDevice];
    
    // 1. 输入设备 - 可以添加到拍摄会话
    _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    
    // 2. 输出图像
    _imageOutput = [AVCapturePhotoOutput new];
    
    // 3. 拍摄会话
    _captureSession = [AVCaptureSession new];
    
    // 4. 将输入／输出添加到拍摄会话
    // 为了避免因为客户手机的设备故障以及其他原因，通常需要判断设备能否添加到会话
    if (![_captureSession canAddInput:_inputDevice]) {
        NSLog(@"无法添加输入设备");
        
        return;
    }
    
    if (![_captureSession canAddOutput:_imageOutput]) {
        NSLog(@"无法添加输出设备");
        
        return;
    }
    
    [_captureSession addInput:_inputDevice];
    [_captureSession addOutput:_imageOutput];
    
    // 5. 设置预览图层
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    
    // 指定图层的大小 - 模态展现的，在 viewDidLoad 方法中，视图的大小还没有确定
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height -= 130;
    _previewLayer.frame = rect;
    
    // 添加图层到预览视图
    [_previewView.layer insertSublayer:_previewLayer atIndex:0];
    
    // 设置取景框的拉伸效果 - 在实际开发中，统一使用 AVLayerVideoGravityResizeAspectFill
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // 6. 开始拍摄
    [self startCapture];
}
#pragma mark - 相机相关方法

/**
 开始拍摄
 */
- (void)startCapture {
    [_captureSession startRunning];
}

/**
 停止拍摄
 */
- (void)stopCapture {
    [_captureSession stopRunning];
}

/**
 切换摄像头
 
 @return 如果 _inputDevice 有值，要根据对应的摄像头对调，如果没有值，返回后置摄像头
 */
- (AVCaptureDevice *)captureDevice {
    
    // 1. 获得当前输入设备的镜头位置
    AVCaptureDevicePosition position = _inputDevice.device.position;
    
    position = (position != AVCaptureDevicePositionBack) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    
    // 2. 具体的设备 - 摄像头／麦克风(模拟器没有摄像头，应该使用真机测试)
    // 返回摄像头的数组，前置／后置
    NSArray *array = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    // 遍历数组获取后置摄像头
    AVCaptureDevice *device;
    for (AVCaptureDevice *obj in array) {
        if (obj.position == position) {
            device = obj;
            
            break;
        }
    }
    
    return device;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
