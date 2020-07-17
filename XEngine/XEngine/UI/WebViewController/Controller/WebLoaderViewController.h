//
//  WebLoaderViewController.h
//  XEngine
//
//  Created by edz on 2020/7/7.
//  Copyright © 2020 edz. All rights reserved.
//

#import "WebBridgeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebLoaderViewController : WebBridgeViewController
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) ZipModel *microAppModel;
@end

NS_ASSUME_NONNULL_END
