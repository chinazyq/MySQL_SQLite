//
//  MysqlManager.m
//  mySQL_IP
//
//  Created by  apple on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MysqlManager.h"
#import "mysql.h"

@implementation MysqlManager

+ (id)sharedMysql
{
    static MysqlManager *sharedMysqlManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMysqlManagerInstance = [[self alloc] init];
    });
    return sharedMysqlManagerInstance;
}

- (id)init
{
    self = [super init];
    
    [self initWithconnectHost:kServerName connectUser:kUsername connectPassword:kPassword connectName:kDbName];
    
    return self;
}

-(void)initWithconnectHost:(NSString *)host connectUser:(NSString *)user connectPassword:(NSString *)password connectName:(NSString *)name
{
    myconnect = mysql_init(nil);
    myconnect = mysql_real_connect(myconnect,[host UTF8String],[user UTF8String],[password UTF8String],[name UTF8String],MYSQL_PORT,NULL,0);
    
	if(!myconnect)
    {
		printf("error code=%i",mysql_errno(myconnect));
	}
    
    NSLog(@"connected to Mysql");
}

-(NSMutableArray*)query:(NSString *)sql
{
    if(!myconnect)
    {
        NSLog(@"Please connect first");
        return nil;
    }
    NSMutableArray *recordsArray = [[NSMutableArray alloc] init];
    
    mysql_query(myconnect, [sql UTF8String]);
    MYSQL_RES* result = mysql_store_result(myconnect);
    if (!result) {
        return nil;
    }
    int num_rows = mysql_num_rows(result);
    int num_fields = mysql_num_fields(result);
    
    
    for(int i=0;i<num_rows;i++)
    {
        MYSQL_ROW row = mysql_fetch_row(result);
        MYSQL_FIELD *fields = mysql_fetch_fields(result);
        NSMutableDictionary *record = [[NSMutableDictionary alloc]init];
        for(int j=0;j<num_fields;j++)
        {
            NSString*key = [NSString stringWithUTF8String:fields[j].name];
            //此处需加上对NULL和空字符串的判断
            NSString *value = @"";
            if (row[j]==NULL) {
                value=@"";
            }else
                value= [NSString stringWithUTF8String:row[j]];
            [record setValue:value forKey:key];
        }
        
        [recordsArray addObject:record];
    }
    return recordsArray;
}

-(NSMutableArray*)getRecordFields
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    MYSQL_RES* result = mysql_store_result(myconnect);
    MYSQL_FIELD *fields = mysql_fetch_field(result);
    
    int num_fields = mysql_num_fields(result);
    
    for(int j=0;j<num_fields;j++)
    {
        NSString* field= [NSString stringWithUTF8String: fields[j].name];
        [array addObject:field];
    }
    return array;
}

-(void)update:(NSString *)sql
{
    if(myconnect)
    {
        mysql_query(myconnect, [sql UTF8String]);
    }
    else
    {
         NSLog(@"Please connect to DB first");
        return;
    }
}

-(void)remove:(NSString *)sql
{
    if(myconnect)
    {
        mysql_query(myconnect, [sql UTF8String]);
    }
    else
    {
        NSLog(@"Please connect to DB first");
        return;
    }
}

-(void)disconnect
{
    mysql_close(myconnect);
    NSLog(@"Close From Mysql");
}

@end
