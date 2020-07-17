//
//  EntryViewController.m
//  XEngine
//
//  Created by edz on 2020/7/9.
//  Copyright © 2020 edz. All rights reserved.
//

#import "EntryViewController.h"
#import "WebLoaderViewController.h"
@interface EntryViewController ()
@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)server1:(UIButton *)sender {
    
    UpdateModel *updateModel = [PublicData sharedInstance].updateModel;
    ZipModel *model = updateModel.data[0];
//    self.serverDict = [[NSUserDefaults standardUserDefaults] objectForKey:OffLineHtmlFilePathKey];
    WebLoaderViewController *webLaderVC = [[WebLoaderViewController alloc] init];
    webLaderVC.filePath = [NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion];
    webLaderVC.microAppModel = model;
    [self pushViewController:webLaderVC];
    
    
}
- (IBAction)server2:(UIButton *)sender {
    
     UpdateModel *updateModel = [PublicData sharedInstance].updateModel;
        ZipModel *model = updateModel.data[1];
    //    self.serverDict = [[NSUserDefaults standardUserDefaults] objectForKey:OffLineHtmlFilePathKey];
        WebLoaderViewController *webLaderVC = [[WebLoaderViewController alloc] init];
        webLaderVC.filePath = [NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion];
        webLaderVC.microAppModel = model;
        [self pushViewController:webLaderVC];
}
- (IBAction)server3:(UIButton *)sender {
    
     UpdateModel *updateModel = [PublicData sharedInstance].updateModel;
        ZipModel *model = updateModel.data[2];
    //    self.serverDict = [[NSUserDefaults standardUserDefaults] objectForKey:OffLineHtmlFilePathKey];
//        RecyleWebViewController *webLaderVC = [[RecyleWebViewController alloc] initWithTitle:@"345678" url:[NSString stringWithFormat:@"%@/%@.%@",[NSObject preferencesDirectory], model.microAppId,@"0"] index:1 parentRecyleWebViewController:nil];
    RecyleWebViewController *webLaderVC = [[RecyleWebViewController alloc] initWithModel:model url:[NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion] index:0 parentRecyleWebViewController:nil];
        webLaderVC.filePath = [NSString stringWithFormat:@"%@/%@.%@",[NSObject microAppDirectory], model.microAppId,model.microAppVersion];
        webLaderVC.microAppModel = model;
        webLaderVC.modules = @[@"JSFuction",@"XEngineAlertModuleTest"];
        [self pushViewController:webLaderVC];
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
