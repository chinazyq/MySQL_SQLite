//
//  MysqlUtil.h
//  LiveShow
//
//  Created by UNISK on 15/9/11.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kServerName = @"localhost";
static NSString * const kDbName     = @"zhangyqV1";
static NSString * const kSocket     = @"/private/tmp/mysql.sock";
static const NSInteger  kPort       = 3306;
static NSString * const kUsername   = @"root";
static NSString * const kPassword   = @"12345";

@interface MysqlUtil : NSObject

#pragma mark -用户操作
+ (BOOL)newMember:(NSMutableDictionary*)memDic;
+ (BOOL)deleteMember:(NSInteger)userid;
+ (BOOL)UpdateMember:(NSMutableDictionary *)memDic;
+ (NSDictionary *)SelectMemByUserid:(NSInteger)userid;
@end
