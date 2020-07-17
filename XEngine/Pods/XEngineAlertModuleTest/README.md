# XEngineAlertModuleTest
测试模块功能 
创建vc时 传入模块名称就可以调用模块功能
RecyleWebViewController *vc = [[RecyleWebViewController alloc] initWithModel:zipmodel url:需要加载的URL地址 index:0 parentRecyleWebViewController:nil]；
vc.modules = @[@"XEngineAlertModuleTest"];
