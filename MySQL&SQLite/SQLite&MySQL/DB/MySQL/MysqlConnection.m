//
//  MysqlConnection.m
//  mysql_connector
//
//  Created by Karl Kraft on 5/21/08.
//  Copyright 2008-2011 Karl Kraft. All rights reserved.
//

#import "MysqlConnection.h"
#import "MysqlServer.h"

#import "MysqlCommitException.h"
#import "MysqlRollbackException.h"
#import "GC_MYSQL_BIND.h"

@interface MysqlConnection()

+ (MysqlConnection *)connectToServers:(NSArray *)arrayOfServers;

@end
@implementation MysqlConnection

@synthesize transactionsEnabled,server;

+ (void)initialize;
{
  if (sizeof(MYSQL_BIND) != sizeof(GC_MYSQL_BIND) ) {
    [MysqlException raise:@"Failed to initialize" format:@"MYSQL_BIND and GC_MYSQL_BIND differ in size."];
  }
}

+ (MysqlConnection *)sharedConnection
{
    static MysqlConnection *sharedconnectionInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        MysqlServer *sserver = [[MysqlServer alloc]init];
        sharedconnectionInstance = [[self alloc] initWithServer:sserver];
    });
    return sharedconnectionInstance;
}

- (MysqlConnection *)initWithServer:(MysqlServer *)sserver
{
    self = [super init];
    mysql_init(&(self->_connection));
    unsigned int timeout=sserver.connectionTimeout;
    mysql_options(&(self->_connection),MYSQL_OPT_CONNECT_TIMEOUT,&timeout);
    
    MysqlLog(@"Connecting to %@",sserver);
    
    if (!mysql_real_connect(&(self->_connection),
                            [sserver.host UTF8String],
                            [sserver.user UTF8String],
                            [sserver.password UTF8String],
                            [sserver.schema UTF8String],
                            sserver.port,  // default port
                            NULL,  // default socket
                            sserver.flags)) {
        MysqlLog(@"Failed to connect: Error: %s\n",mysql_error(&(self->_connection)));
        return nil;
    } else {
        MysqlLog(@"Connected to %@",sserver);
    }
    if (!mysql_set_character_set(&(self->_connection), "utf8")) {
        MysqlLog(@"Client character set: %s\n", mysql_character_set_name(&(newObject->_connection)));
    }
    self->server = sserver;
    return self;
}

+ (MysqlConnection *)connectToServers:(NSArray *)arrayOfServers;
{
    for (MysqlServer *server in arrayOfServers) {
        MysqlConnection *aConnection=[[self alloc]initWithServer:server];
        if (aConnection) return aConnection;
    }
    return nil;
}

- (MYSQL *)getConnection;
{
  return &_connection;
}

- (void)enableStrictSql;
{
  @synchronized (self) {
    MysqlLog(@"Setting strict sql");
    
    if (mysql_query(&_connection, "set sql_mode=strict_all_tables")) {
      [MysqlException raiseConnection:self 
                           withFormat:@"Could not set sql_mode #%d:%s",mysql_errno(&_connection), mysql_error(&_connection)];
    }
  }
}

- (void)enableTriggers
{
  @synchronized (self) {
    MysqlLog(@"Enabling triggers");
    
    if (mysql_query(&_connection, "set @DISABLE_TRIGGERS = NULL")) {
      [MysqlException raiseConnection:self 
                           withFormat:@"Could not enable triggers #%d:%s",mysql_errno(&_connection), mysql_error(&_connection)];
    }
  }
}

- (void)disableTriggers
{
  @synchronized (self) {
    MysqlLog(@"Disabling triggers");
    
    if (mysql_query(&_connection, "set @DISABLE_TRIGGERS = 1")) {
      [MysqlException raiseConnection:self 
                           withFormat:@"Could not disable triggers #%d:%s",mysql_errno(&_connection), mysql_error(&_connection)];
    }
  }
}

- (void)enableTransactions;
{
  @synchronized (self) {
    MysqlLog(@"Transactions Enabled");
    transactionsEnabled=YES;
    mysql_autocommit(&_connection, 0);
  }
}

- (void)disableTransactions;
{
  @synchronized (self) {
    MysqlLog(@"Transactions Disabled");
    transactionsEnabled=NO;
    mysql_autocommit(&_connection, 1);
  }
}

- (void)commitTransaction;
{
  @synchronized (self) {
    if (mysql_commit(&_connection)) {
      [MysqlCommitException raiseConnection:self withFormat:@"Transaction commit failed (%s)",mysql_error(&_connection)];
    } else {
      MysqlLog(@"Transaction committed");
    }
  }
}

- (void)rollbackTransaction;
{
  @synchronized (self) {
    if (mysql_rollback(&_connection)) {
      [MysqlRollbackException raiseConnection:self withFormat:@"Transaction rollback failed (%s)",mysql_error(&_connection)];
    } else {
      MysqlLog(@"Transaction committed");
    }
  }
}

- (void)sendIdle:(NSTimer *)t;
{
  @synchronized (self) {
    MysqlLog(@"Sending idle");
    mysql_query(&_connection, "select 'MysqlConnect:idleTmer'");
    MYSQL_RES     *theResults = mysql_use_result(&_connection);
    mysql_free_result(theResults);  
  }
}

- (void)startIdle;
{
  [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(sendIdle:) userInfo:nil repeats:YES];
}


- (void)finalize;
{
  mysql_close(&_connection);
  [super finalize];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@ %@/%@/%@/%@",[super description],server.host,server.schema,server.user,server.password];
}

@end
