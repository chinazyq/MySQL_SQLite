//
//  MysqlConnection.h
//  mysql_connector
//
//  Created by Karl Kraft on 5/21/08.
//  Copyright 2008-2011 Karl Kraft. All rights reserved.
//


#import "mysql.h"

@class MysqlServer;

@interface MysqlConnection : NSObject {
  MYSQL _connection;
  BOOL transactionsEnabled;
  MysqlServer *server;
}

@property(readonly,getter=getConnection) MYSQL *connection;
@property(readonly) BOOL transactionsEnabled;
@property(readonly)MysqlServer *server;

+ (MysqlConnection *)sharedConnection;

- (void)enableTransactions;
- (void)disableTransactions;
- (void)commitTransaction;
- (void)rollbackTransaction;

- (void)enableStrictSql;

- (void)enableTriggers;
- (void)disableTriggers;

- (void)startIdle;

@end





