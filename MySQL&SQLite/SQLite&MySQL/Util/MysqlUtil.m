//
//  MysqlUtil.m
//  LiveShow
//
//  Created by UNISK on 15/9/11.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import "MysqlUtil.h"

@implementation MysqlUtil

+ (BOOL)newMember:(NSMutableDictionary*)memDic
{
    return [UserInfoAccess addUserInfo:memDic];
}

+ (BOOL)deleteMember:(NSInteger)userid
{
    return [UserInfoAccess DeleteUserByUserid:userid];
}

+ (BOOL)UpdateMember:(NSMutableDictionary *)memDic
{
    return [UserInfoAccess addUserInfo:memDic];
}

+ (NSDictionary *)SelectMemByUserid:(NSInteger)userid
{
    return [UserInfoAccess SelectUserByUserid:userid];
}

@end
