//
//  PublicData+Update.m
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "PublicData+Update.h"
#define kUpdateZipFileName @".updateZip.persistent"

const char _updateModel;
@implementation PublicData (User)
- (UpdateModel *)updateModel
{
    UpdateModel *updateModel = GetAssociatedObject(_updateModel);
    if (!updateModel)
    {
        updateModel = [self readUpdateModel];
        if (updateModel)
        {
            SetAssociatedObject(_updateModel, updateModel);
        }
    }
    return updateModel;
}

- (void)setUpdateModel:(UpdateModel *)updateModel
{
    SetAssociatedObject(_updateModel, updateModel);
    
    NSLog(@"setLoginUser: %@", updateModel.description);
    
    [self saveLoginUser:updateModel];
}

- (UpdateModel *)readUpdateModel
{
    return [UpdateModel unarchiveFromDocumentDirectory:kUpdateZipFileName];
}

- (void)saveLoginUser:(UpdateModel *)updateModel
{
    [UpdateModel archive:updateModel toDocumentDirectory:kUpdateZipFileName];
}

@end
