
//  PublicData+User.m
//  SpeedJob
//
//  Created by 李找乐 on 2019/7/19.
//  Copyright © 2019 李找乐. All rights reserved.
//

#import "PublicData+User.h"

#define kLoginUseFileName @".user.persistent"

const char _loginUser;
@implementation PublicData (User)
- (RPUserModel *)loginUser
{
    RPUserModel *loginUser = GetAssociatedObject(_loginUser);
    if (!loginUser)
    {
        loginUser = [self readLoginUser];
        if (loginUser)
        {
            SetAssociatedObject(_loginUser, loginUser);
        }
    }
    return loginUser;
}

- (void)setLoginUser:(RPUserModel *)loginUser
{
    SetAssociatedObject(_loginUser, loginUser);
    
    NSLog(@"setLoginUser: %@", loginUser.description);
    
    [self saveLoginUser:loginUser];
}

- (RPUserModel *)readLoginUser
{
    return [RPUserModel unarchiveFromDocumentDirectory:kLoginUseFileName];
}

- (void)saveLoginUser:(RPUserModel *)loginUser
{
    [RPUserModel archive:loginUser toDocumentDirectory:kLoginUseFileName];
}

@end
