//
//  MBProgressHUD+Toast.m
//  XEngine
//
//  Created by edz on 2020/7/17.
//  Copyright © 2020 edz. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD (Toast)
+ (MBProgressHUD *)showToastWithTitle:(NSString *)title image:(UIImage *)image time:(NSTimeInterval)time
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[Unity topView] animated:YES];
    hud.animationType = MBProgressHUDAnimationFade;
    if (image)
    {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }else
    {
        hud.mode = MBProgressHUDModeText;
    }
    hud.label.text = title;
    hud.minShowTime = time;
    return hud;
}
@end
