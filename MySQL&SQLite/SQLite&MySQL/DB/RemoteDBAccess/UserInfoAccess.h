//
//  MembersAccess.h
//  mysql_connect_objc
//
//  Created by UNISK on 15/9/10.
//  Copyright (c) 2015年 4fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoAccess : NSObject
//添加用户
+ (BOOL)addUserInfo:(NSMutableDictionary *)uDic;
//查找用户
+(NSDictionary *)SelectUserByUserid:(NSInteger )userid;

//删除用户
+(BOOL)DeleteUserByUserid:(NSInteger )userid;

@end
