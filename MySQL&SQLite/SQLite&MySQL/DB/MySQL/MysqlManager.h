//
//  MysqlManager.h
//  mySQL_IP
//
//  Created by  apple on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "mysql.h"

@interface MysqlManager : NSObject 
{
    MYSQL *myconnect;
}

+ (id)sharedMysql;

-(NSMutableArray*)query:(NSString *)sql;

-(NSMutableArray*)getRecordFields;

-(void)update:(NSString *)sql;

-(void)remove:(NSString *)sql;

-(void)disconnect;

@end
