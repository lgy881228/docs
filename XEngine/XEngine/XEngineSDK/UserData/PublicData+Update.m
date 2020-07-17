//
//  PublicData+Update.m
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "PublicData+Update.h"
#define kUpdateZipFileName @".updateZip.persistent"
#import "XEngine.h"
const char _microConfigModel;
@implementation PublicData (User)
- (MicroConfigModel *)microConfigModel
{
    MicroConfigModel *microConfigModel = GetAssociatedObject(_microConfigModel);
    if (!microConfigModel)
    {
        microConfigModel = [self readMicroConfigModel];
        if (microConfigModel)
        {
            SetAssociatedObject(_microConfigModel, microConfigModel);
        }
    }
    return microConfigModel;
}

- (void)setMicroConfigModel:(MicroConfigModel *)microConfigModel
{
    SetAssociatedObject(_microConfigModel, microConfigModel);
    
    NSLog(@"setLoginUser: %@", microConfigModel.description);
    
    [self saveMicroConfigModel:microConfigModel];
}

- (MicroConfigModel *)readMicroConfigModel
{
    return [MicroConfigModel unarchiveFromDocumentDirectory:kUpdateZipFileName];
}

- (void)saveMicroConfigModel:(MicroConfigModel *)microConfigModel
{
    [MicroConfigModel archive:microConfigModel toDocumentDirectory:kUpdateZipFileName];
}

@end
