//
//  RootViewController.h
//  LiveShow
//
//  Created by UNISK on 15/6/2.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic,strong)UILabel *resultLabel;

- (void)addUserInfo:(UIButton *)button;
- (void)deleteUserInfo:(UIButton *)button;
- (void)updateUserInfo:(UIButton *)button;
- (void)selectUserInfo:(UIButton *)button;
@end
