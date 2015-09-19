//
//  UserInfoDB.h
//  PPMS
//
//  Created by zyq on 15-9-2.
//  Copyright (c) 2015年 zyq. All rights reserved.
//

#import "FMDatabase.h"
#import "UserInfo.h"

@interface UserInfoDB : FMDatabase

//添加用户
-(BOOL)AddanUser:(UserInfo *)userinfo;

//查找用户
-(UserInfo *)SelectUserByUserid:(NSInteger )userid;

//删除用户
-(BOOL)DeleteUserByUserid:(NSInteger )userid;

@end
