//
//  RPUserModel.h
//  RedPacket
//
//  Created by 李找乐 on 2020/1/13.
//  Copyright © 2020 李找乐. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPUserModel : JSONModel
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *sex;
//@property (nonatomic,copy) NSString *apnsToken;

@end

NS_ASSUME_NONNULL_END
