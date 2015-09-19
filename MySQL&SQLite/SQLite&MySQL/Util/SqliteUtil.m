//
//  SqliteUtil.m
//  LiveShow
//
//  Created by UNISK on 15/9/19.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import "SqliteUtil.h"
#import "UserInfoDB.h"

@implementation SqliteUtil
//添加用户
+(BOOL)AddanUser:(UserInfo *)userinfo
{
    return [[UserInfoDB sharedDatabase] AddanUser:userinfo];
}

//查找用户
+(UserInfo *)SelectUserByUserid:(NSInteger )userid
{
    return [[UserInfoDB sharedDatabase] SelectUserByUserid:userid];
}

//删除用户
+(BOOL)DeleteUserByUserid:(NSInteger )userid
{
    return [[UserInfoDB sharedDatabase] DeleteUserByUserid:userid];
}

@end
