//
//  Members.m
//  mysql_connect_objc
//
//  Created by UNISK on 15/9/10.
//  Copyright (c) 2015年 4fly. All rights reserved.
//

#import "UserInfoAccess.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

#define MEMBERTABLE @"tb_userinfo"

@implementation UserInfoAccess

+ (BOOL)addUserInfo:(NSMutableDictionary *)mDic
{
    BOOL successFlag=FALSE;
    //1.首先判断是否存在对应的userid
    MysqlConnection* mc=[MysqlConnection sharedConnection];
    //基本查询
    NSString *sqlString = [NSString stringWithFormat:@"select userid from %@ where userid='%@'",MEMBERTABLE,[mDic valueForKey:@"userid"]];
    NSMutableArray *results = [[MysqlManager sharedMysql]query:sqlString];
    if (results.count>0) {
        //说明已存在
        MysqlUpdate *mu = [MysqlUpdate updateWithConnection:mc];
        [mu setTable:MEMBERTABLE];
        [mu setRowData:mDic];
        [mu setQualifier:[results objectAtIndex:0]];
        [mu execute];
        if (mu.affectedRows>0) {
            successFlag = TRUE;
        }
        
    }else {
        //说明不存在,插入
        MysqlInsert* mi=[MysqlInsert insertWithConnection:mc];
        [mi setTable:MEMBERTABLE];
        [mi setRowData:mDic];
        [mi execute];
        if (mi.affectedRows>0) {
            //说明插入成功
            NSLog(@"%@",mi.rowid);
            successFlag = TRUE;
        }
    }
    
    return successFlag;
}

//查找用户
+(NSDictionary *)SelectUserByUserid:(NSInteger )userid
{
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where userid='%@'",MEMBERTABLE,[NSString stringWithFormat:@"%d",(int)userid]];
    NSMutableArray *results = [[MysqlManager sharedMysql]query:sqlString];
    if (results.count>0) {
        return results[0];
    }
    return nil;
}

//删除用户
+(BOOL)DeleteUserByUserid:(NSInteger )userid
{
    BOOL successFlag=FALSE;
    MysqlConnection* mc=[MysqlConnection sharedConnection];
    MysqlDelete* md=[MysqlDelete deleteWithConnection:mc];
    [md setTableName:MEMBERTABLE];
    [md setQualifier:[NSString stringWithFormat:@"userid = %d",(int)userid]];
    [md execute];
    if (md.affectedRows>0) {
        successFlag = TRUE;
    }
    return successFlag;
}

@end
