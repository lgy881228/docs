//
//  PublicData+Update.h
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "PublicData.h"
#import "MicroConfigModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PublicData (Update)
@property (nonatomic, strong) MicroConfigModel *microConfigModel;
@end

NS_ASSUME_NONNULL_END
