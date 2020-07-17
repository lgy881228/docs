//
//  MBProgressHUD+Toast.h
//  XEngine
//
//  Created by edz on 2020/7/17.
//  Copyright © 2020 edz. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>



@interface MBProgressHUD (Toast)
+ (MBProgressHUD *)showToastWithTitle:(NSString *)title image:(UIImage *)image time:(NSTimeInterval)time;
@end


