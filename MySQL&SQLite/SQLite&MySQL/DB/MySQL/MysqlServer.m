//
//  MysqlServer.m
//  mysql_connector
//
//  Created by Karl Kraft on 3/19/11.
//  Copyright 2011 Karl Kraft. All rights reserved.
//

#import "MysqlServer.h"
#import "mysql.h"


@implementation MysqlServer

@synthesize host,user,password,schema;
@synthesize port,flags,connectionTimeout;


- init;
{
  self=[super init];
  self.host= kServerName;
  self.user= kUsername;
  self.password= kPassword;
  self.schema= kDbName;
  self.port=3306;
  self.flags=CLIENT_FOUND_ROWS;
  self.connectionTimeout=30;
  return self;
}

- (NSString *)description;
{
  return [NSString stringWithFormat:@"MysqlServer: %@:%d as user %@",host,port,user];
}
@end
