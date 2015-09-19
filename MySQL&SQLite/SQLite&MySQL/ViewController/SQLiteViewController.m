//
//  SQLiteViewController.m
//  LiveShow
//
//  Created by UNISK on 15/9/14.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import "SQLiteViewController.h"

@interface SQLiteViewController ()

@end

@implementation SQLiteViewController

- (id)init
{
    self = [super init];
    self.title = @"SQLite 3";
    self.tabBarItem.title = @"SQLite";
    self.tabBarItem.image = [[UIImage imageNamed:@"sqlite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:250.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Actions
- (void)addUserInfo:(UIButton *)button
{
    UserInfo *userinfo = [[UserInfo alloc]init];
    userinfo.userid = 101;
    userinfo.username = @"张三";
    userinfo.realname = @"张勇强";
    userinfo.password = @"123456";
    userinfo.department = @"研发部";
    userinfo.column = @"iOS组";
    BOOL result = [SqliteUtil AddanUser:userinfo];
    //查看结果
    self.resultLabel.text = [NSString stringWithFormat:@"插入结果：%@\n插入人员信息：%d\n%@\n%@\n%@\n%@\n%@\n",result==true?@"成功":@"失败",(int)userinfo.userid,userinfo.username,userinfo.realname,userinfo.password,userinfo.department,userinfo.column];
}
- (void)deleteUserInfo:(UIButton *)button
{
    UserInfo *userinfo = [SqliteUtil SelectUserByUserid:101];
    if (!userinfo) {
        self.resultLabel.text = @"该用户已经被删除";
    }else
    {
        BOOL result = [SqliteUtil DeleteUserByUserid:101];
        self.resultLabel.text = [NSString stringWithFormat:@"删除结果：%@",result==true?@"成功":@"失败"];
    }
}
- (void)updateUserInfo:(UIButton *)button
{
    UserInfo *userinfo = [[UserInfo alloc]init];
    userinfo.userid = 101;
    userinfo.username = @"李四";
    userinfo.realname = @"李四三";
    userinfo.password = @"123123";
    userinfo.department = @"市场部";
    userinfo.column = @"产品组";
    
    BOOL result = [SqliteUtil AddanUser:userinfo];

    //查看结果
    self.resultLabel.text = [NSString stringWithFormat:@"更新结果：%@\n更新人员信息：%d\n%@\n%@\n%@\n%@\n%@\n",result==true?@"成功":@"失败",(int)userinfo.userid,userinfo.username,userinfo.realname,userinfo.password,userinfo.department,userinfo.column];

}
- (void)selectUserInfo:(UIButton *)button
{
    //查看结果
    UserInfo *newuserinfo = [SqliteUtil SelectUserByUserid:101];
    if (newuserinfo) {
        self.resultLabel.text = [NSString stringWithFormat:@"查询结果：%d\n%@\n%@\n%@\n%@\n%@\n",(int)newuserinfo.userid,newuserinfo.username,newuserinfo.realname,newuserinfo.password,newuserinfo.department,newuserinfo.column];
    }else
        self.resultLabel.text = @"无101号人员";

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
