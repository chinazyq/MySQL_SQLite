//
//  UserInfo.h
//  PPMS
//
//  Created by zyq on 15-9-2.
//  Copyright (c) 2015年 zyq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERNAME @"UserName"
#define USERID   @"UserId"
#define REALNAME @"RealName"
#define PASSWORD @"Password"
#define COLUMN   @"Column"
#define DEPARMENT @"Department"

@interface UserInfo : NSObject

@property (nonatomic,copy) NSString *username;//用户名
@property (nonatomic,assign) NSInteger userid;//id
@property (nonatomic,copy) NSString *realname;//真名
@property (nonatomic,copy) NSString *password;//密码
@property (nonatomic,copy) NSString *department;//部门
@property (nonatomic,copy) NSString *column;//

@end
