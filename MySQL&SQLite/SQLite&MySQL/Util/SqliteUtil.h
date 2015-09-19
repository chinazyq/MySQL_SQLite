//
//  SqliteUtil.h
//  LiveShow
//
//  Created by UNISK on 15/9/19.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteUtil : NSObject
//添加用户
+(BOOL)AddanUser:(UserInfo *)userinfo;

//查找用户
+(UserInfo *)SelectUserByUserid:(NSInteger )userid;

//删除用户
+(BOOL)DeleteUserByUserid:(NSInteger )userid;

@end
