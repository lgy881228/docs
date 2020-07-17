//
//  JSAlertModule.m
//  XEngine
//
//  Created by edz on 2020/7/14.
//  Copyright © 2020 edz. All rights reserved.
//

#import "JSAlertModule.h"

@implementation JSAlertModule
- (NSString *) presentcontroller: (NSString *) msg
{
     UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"test" preferredStyle:UIAlertControllerStyleAlert];
                                    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
                                    
    [alertVC addAction:cancelAction];
                                    
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"马上更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             
                                   
    }];
    [alertVC addAction:updateAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    return nil;
}
@end
