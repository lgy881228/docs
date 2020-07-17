//
//  EntryViewController.m
//  XEngine
//
//  Created by edz on 2020/7/15.
//  Copyright © 2020 edz. All rights reserved.
//

#import "EntryViewController.h"
//#import <MBProgressHUD/MBProgressHUD.h>
@interface EntryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld",indexPath.item];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MicroConfigModel *microConfigModel = [PublicData sharedInstance].microConfigModel;
    ZipModel *model = microConfigModel.data[indexPath.item];
    RecyleWebViewController *webLaderVC = [[RecyleWebViewController alloc] initWithMicroAppId:@"com.zkty.xiaoqu.network" url:[NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion] index:0];
    [self pushViewController:webLaderVC];
    webLaderVC.filePath = [NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion];
    webLaderVC.microAppId = @"com.zkty.xiaoqu.network";
    
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
