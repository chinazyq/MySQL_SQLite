//
//  MysqlInsert.m
//  mysql_connector
//
//  Created by Karl Kraft on 6/12/08.
//  Copyright 2008-2011 Karl Kraft. All rights reserved.
//

#import "MysqlInsert.h"
#import "MysqlConnection.h"
#import "NSString_MysqlEscape.h"
#import "MysqlException.h"
#import "GC_MYSQL_BIND.h"
#import "mysqld_error.h"

@implementation MysqlInsert

@synthesize table,rowData,affectedRows,rowid,ignoreDuplicateErrors;

+ (MysqlInsert *)insertWithConnection:(MysqlConnection *)aConnection;
{
  if (!aConnection) {
    [MysqlException raiseConnection:nil withFormat:@"Connection is nil"];
  }
  
  MysqlInsert *newObject=[[self alloc] init];
  newObject->connection = aConnection;
  newObject->rowData = nil;
  return newObject;
}


- (void)execute;
{
  if (!table) {
    [MysqlException raiseConnection:connection withFormat: @"No table specified for insert"];
  }

  if (!rowData) {
    [MysqlException raiseConnection:connection withFormat: @"No rowData specified for insert"];
  }
  
  @synchronized(connection) {
    
    NSArray *keys = [rowData allKeys];
    
    NSMutableString *cmd = [NSMutableString string];
    [cmd appendFormat:@"INSERT INTO %@ ( ",table];
    BOOL firstAdd=YES;
    for (NSString *columnName in keys) {
      if (firstAdd) {
        [cmd appendFormat:@" %@ ",[columnName mysqlEscapeInConnection:connection]];
        firstAdd=NO;
      } else {
        [cmd appendFormat:@", %@ ",[columnName mysqlEscapeInConnection:connection]];
      }
    }
    
    [cmd appendFormat:@" ) values ( ",table];
    
    firstAdd=YES;
    for (NSString *columnName in keys) {
      if (firstAdd) {
        [cmd appendString:@" ? "];
        firstAdd=NO;
      } else {
        [cmd appendString:@", ? "];
      }
    }
    [cmd appendFormat:@" ) "];
    
    MYSQL_STMT *myStatement = mysql_stmt_init(connection.connection);
    const char *utf8EncodedString = [cmd UTF8String];
    if (mysql_stmt_prepare(myStatement, utf8EncodedString,strlen(utf8EncodedString))) {
      [MysqlException raiseConnection:connection withFormat: @"mysql_stmt_prepare failed %@ %s",cmd, mysql_stmt_error(myStatement)];
    }
    
#ifndef __OBJC_GC__
    GC_MYSQL_BIND *binding=calloc(sizeof(GC_MYSQL_BIND),[keys count]);
#else
    GC_MYSQL_BIND *binding=NSAllocateCollectable(sizeof(GC_MYSQL_BIND)*[keys count], NSScannedOption);
#endif
    
    for (NSUInteger x=0; x < [keys count];x++) {
      NSString *key= [keys objectAtIndex:x];
      NSObject *object = [rowData objectForKey:key];
      if ([object isKindOfClass:[NSString class]]) {
        NSString *s = (NSString *)object;
        const char *ch = [s UTF8String];
        binding[x].is_null= 0;
        binding[x].buffer_type = MYSQL_TYPE_STRING; 
        binding[x].buffer = (void *)ch;
        binding[x].buffer_length= strlen(ch);        
      } else if ([object isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)object;
        binding[x].is_null= 0;
        binding[x].buffer_type = MYSQL_TYPE_BLOB; 
        binding[x].buffer = (void *)[data bytes];
        binding[x].buffer_length= [data length];        
      } else if ([object isKindOfClass:[NSNumber class]]) {
        NSString *s = (NSString *)[object description];
        const char *ch = [s UTF8String];
        binding[x].is_null= 0;
        binding[x].buffer_type = MYSQL_TYPE_STRING; 
        binding[x].buffer = (void *)ch;
        binding[x].buffer_length= strlen(ch);        
      } else if ([object isKindOfClass:[NSNull class]]) {
#ifndef __OBJC_GC__
        my_bool *aBool = calloc(1,sizeof(my_bool));
#else
        my_bool *aBool = NSAllocateCollectable(sizeof(my_bool), NSScannedOption);
#endif
        *aBool=1;
        binding[x].is_null= aBool;
      } else {
        NSString *s = (NSString *)[object description];
        const char *ch = [s UTF8String];
        binding[x].is_null= 0;
        binding[x].buffer_type = MYSQL_TYPE_STRING; 
        binding[x].buffer_length= strlen(ch);        
      }
    }
    if (mysql_stmt_bind_param(myStatement,(MYSQL_BIND *)binding)) {
      [MysqlException raiseConnection:connection withFormat:@"mysql_stmt_bind_param failed %s", mysql_stmt_error(myStatement)];
    }
    if (mysql_stmt_execute(myStatement)) {
      if (ignoreDuplicateErrors && mysql_errno(connection.connection)==ER_DUP_ENTRY) {
        NSLog(@"mysql_stmt_execute failure ignore %s", mysql_stmt_error(myStatement));
      } else {
        [MysqlException raiseConnection:connection withFormat:@"mysql_stmt_execute failed %s", mysql_stmt_error(myStatement)];        
      }
    }
    unsigned long long rowCount = mysql_affected_rows(connection.connection);
    affectedRows = [NSNumber numberWithUnsignedLongLong:rowCount];
    rowid=[NSNumber numberWithUnsignedLongLong:mysql_insert_id(connection.connection)];
    MysqlLog(@"Rows inserted == %@ .  New rowid= %@",affectedRows,rowid);
    if (mysql_stmt_close(myStatement)) {
      [MysqlException raiseConnection:connection withFormat:@" mysql_stmt_close failed %s", mysql_stmt_error(myStatement)];
    }
#ifndef __OBJC_GC__
    for (NSUInteger x=0; x < [keys count];x++) {
      NSString *key= [keys objectAtIndex:x];
      NSObject *object = [rowData objectForKey:key];
      if ([object isKindOfClass:[NSNull class]]) {
        free(binding[x].is_null);
      }
    }
    free(binding);
#endif
  }
}

@end
