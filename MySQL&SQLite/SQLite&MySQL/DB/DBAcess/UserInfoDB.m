//
//  UserInfoDB.m
//  PPMS
//
//  Created by zyq on 15-9-2.
//  Copyright (c) 2015年 zyq. All rights reserved.
//

#import "UserInfoDB.h"

@implementation UserInfoDB

-(BOOL)AddanUser:(UserInfo *)userinfo
{
    NSString *sql = @"";
    if ([self SelectUserByUserid:userinfo.userid]) {
        //说明已经存在，更新
        sql = @"UPDATE UserInfo set username=?,userid=?,realname=?,password=?,department=?,column=?";
    }else
        sql = @"INSERT INTO UserInfo (username,userid,realname,password,department,column) VALUES(?,?,?,?,?,?)";
    
    if ([self open] == FALSE) {
        return NO;
    }
    
    BOOL result = [self executeUpdate:sql, userinfo.username, [NSNumber numberWithInteger:userinfo.userid], userinfo.realname, userinfo.password, userinfo.department, userinfo.column];
    [self close];

    if (!result) {
        NSLog(@"error to insert data");
    } else {
        NSLog(@"succ to insert data");
        return YES;
    }
    return NO;
}
-(UserInfo *)SelectUserByUserid:(NSInteger )userid
{
    if ([self open]==FALSE) {
        return nil;
    }
    
    UserInfo *userinfo ;
    
    NSString *sql = @"SELECT * FROM UserInfo WHERE userid=?";
    FMResultSet *rs = [self executeQuery:sql,[NSNumber numberWithInteger:userid]];
    while ([rs next]) {
        userinfo = [[UserInfo alloc]init];
        
        userinfo.username = [rs stringForColumn:@"username"];
        userinfo.userid = [rs intForColumn:@"userid"];
        userinfo.realname = [rs stringForColumn:@"realname"];
        userinfo.password = [rs stringForColumn:@"password"];
        userinfo.department = [rs stringForColumn:@"department"];
        userinfo.column = [rs stringForColumn:@"column"];
        
        break;
    }
    
    [self close];
    return userinfo;
}
-(BOOL)DeleteUserByUserid:(NSInteger)userid
{
    if ([self open]==FALSE) {
        return NO;
    }
    
    NSString *sql = @"DELETE FROM UserInfo WHERE userid=?";
    BOOL success = [self executeUpdate:sql,[NSNumber numberWithInteger:userid]];
    
    [self close];
    
    return success;
}

@end
