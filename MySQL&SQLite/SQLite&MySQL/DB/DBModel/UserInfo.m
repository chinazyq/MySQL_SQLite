//
//  UserInfo.m
//  PPMS
//
//  Created by zyq on 15-9-2.
//  Copyright (c) 2015年 zyq. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize username,userid,realname,password,department,column;

-(UserInfo*)init
{
    self = [super init];
    self.username = @"";
    self.userid = 0;
    self.realname = @"";
    self.password = @"";
    self.department = @"";
    self.column = @"";
  
    return self;
}
@end
