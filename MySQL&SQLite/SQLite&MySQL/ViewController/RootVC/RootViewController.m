//
//  RootViewController.m
//  LiveShow
//
//  Created by UNISK on 15/6/2.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import "RootViewController.h"

#define BTNWIDTH 80.0f
#define BTNHEIGHT 40.0f

@interface RootViewController ()
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *addbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:addbtn];
    [addbtn setTitle:@"增加" forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(addUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [addbtn makeConstraints:^(MASConstraintMaker *make) {
        UIView *topLayoutGuide = (id)self.topLayoutGuide;
        make.top.equalTo(topLayoutGuide.bottom).offset(20);
        make.right.equalTo(self.view.centerX).offset(-20);
        make.width.equalTo(BTNWIDTH);
        make.height.equalTo(BTNHEIGHT);
    }];
    UIButton *deletebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:deletebtn];
    [deletebtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletebtn addTarget:self action:@selector(deleteUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [deletebtn makeConstraints:^(MASConstraintMaker *make) {
        UIView *topLayoutGuide = (id)self.topLayoutGuide;
        make.top.equalTo(topLayoutGuide.bottom).offset(20);
        make.left.equalTo(self.view.centerX).offset(20);
        make.width.equalTo(BTNWIDTH);
        make.height.equalTo(BTNHEIGHT);
    }];
    UIButton *updatebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:updatebtn];
    [updatebtn setTitle:@"更新" forState:UIControlStateNormal];
    [updatebtn addTarget:self action:@selector(updateUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [updatebtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addbtn.bottom).offset(20);
        make.right.equalTo(self.view.centerX).offset(-20);
        make.width.equalTo(BTNWIDTH);
        make.height.equalTo(BTNHEIGHT);

    }];
    UIButton *selectbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:selectbtn];
    [selectbtn setTitle:@"查找" forState:UIControlStateNormal];
    [selectbtn addTarget:self action:@selector(selectUserInfo:) forControlEvents:UIControlEventTouchUpInside];
    [selectbtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deletebtn.bottom).offset(20);
        make.left.equalTo(self.view.centerX).offset(20);
        make.width.equalTo(BTNWIDTH);
        make.height.equalTo(BTNHEIGHT);

    }];
    
    
    [self.view addSubview:self.resultLabel];
    [self.resultLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(updatebtn.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(20);
        make.right.equalTo(self.view.right).offset(-20);
        UIView *bottomLayoutGuide = (id)self.bottomLayoutGuide;
        make.bottom.equalTo(bottomLayoutGuide.top).offset(-20);

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Actions
- (void)addUserInfo:(UIButton *)button
{
    
}
- (void)deleteUserInfo:(UIButton *)button
{
    
}
- (void)updateUserInfo:(UIButton *)button
{
    
}
- (void)selectUserInfo:(UIButton *)button
{
    
}


#pragma mark -Getter and Setter
- (UILabel *)resultLabel
{
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _resultLabel.numberOfLines = 0;
        _resultLabel.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _resultLabel;
}
@end
