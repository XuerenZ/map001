//
//  XRSportMapModelViewController.m
//  map001
//
//  Created by acer on 17/6/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XRSportMapModelViewController.h"

@interface XRSportMapModelViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapButtons;
@end

@implementation XRSportMapModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置按钮的初始选中状态
    for (UIButton *btn in _mapButtons) {
        // 判断按钮的 tag 是否和 当前地图类型一致
        btn.selected = (btn.tag == _currentType);
    }
}

- (IBAction)selectedMapMode:(UIButton *)sender {
    
    // 0. 判断按钮的 tag 是否与当前的地图类型一致
    if (sender.tag == _currentType) {
        return;
    }
    _currentType = sender.tag;
    
    // 1. 设置地图类型
    if (_didSelectedMapMode != nil) {
        _didSelectedMapMode(_currentType);
    }
    
    // 2. 设置按钮的选中状态
    for (UIButton *btn in _mapButtons) {
        // 判断和参数按钮是否一致
        btn.selected = (btn == sender);
    }
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
