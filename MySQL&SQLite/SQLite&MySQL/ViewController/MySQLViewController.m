//
//  MySQLViewController.m
//  LiveShow
//
//  Created by UNISK on 15/9/14.
//  Copyright (c) 2015年 ZYQ. All rights reserved.
//

#import "MySQLViewController.h"

@interface MySQLViewController ()
@end

@implementation MySQLViewController

- (id)init
{
    self = [super init];
    self.title = @"MySQL";
    self.tabBarItem.title = @"MySQL";
    self.tabBarItem.image = [[UIImage imageNamed:@"mysql"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:254.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUserInfo:(UIButton *)button
{
     BOOL result = [MysqlUtil newMember:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                          @101,@"userid",
                          @"Zhangsan",@"username",
                          @"123456",@"password",
                          @"Zhang Yongqiang",@"realname",
                          @"Develop",@"department",
                          @"iOS Group",@"tb_userinfo.column",nil]];//注：因为column是系统关键字
    NSDictionary *memdic = [MysqlUtil SelectMemByUserid:101];
    self.resultLabel.text = [NSString stringWithFormat:@"插入结果：%@\n插入人员信息：%@",result==true?@"成功":@"失败",memdic];

}

- (void)deleteUserInfo:(UIButton *)button
{
    BOOL result = [MysqlUtil deleteMember:101];
    self.resultLabel.text = [NSString stringWithFormat:@"删除结果：%@",result==true?@"成功":@"失败"];

}
- (void)updateUserInfo:(UIButton *)button
{
    NSMutableDictionary *newMem = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @101,@"userid",
                                   @"Lisi",@"username",
                                   @"123123",@"password",
                                   @"Li Si",@"realname",
                                   @"Develop",@"department",
                                   @"Android",@"tb_userinfo.column",nil];
    BOOL result = [MysqlUtil UpdateMember:newMem];
    self.resultLabel.text = [NSString stringWithFormat:@"更新结果：%@\n更新人员信息：%@",result==true?@"成功":@"失败",newMem];

}
- (void)selectUserInfo:(UIButton *)button
{
    NSDictionary *memdic = [MysqlUtil SelectMemByUserid:101];
    if (memdic) {
        self.resultLabel.text = [NSString stringWithFormat:@"查询结果：%@",memdic];
    }else
        self.resultLabel.text = @"无101号人员";

}

#pragma mark -Getter and Setter

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
