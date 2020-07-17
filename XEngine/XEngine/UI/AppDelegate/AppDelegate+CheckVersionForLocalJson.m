//
//  AppDelegate+CheckVersionForLocalJson.m
//  XEngine
//
//  Created by edz on 2020/7/10.
//  Copyright © 2020 edz. All rights reserved.
//

#import "AppDelegate+CheckVersionForLocalJson.h"

@implementation AppDelegate (CheckVersionForLocalJson)
- (void)checkLocalVersion
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"microApps"ofType:@"json"]];

    NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",dic);
    UpdateModel *itemData = [[UpdateModel alloc] initWithDictionary:dic error:nil];
    [PublicData sharedInstance].updateModel = itemData;
}
- (NSInteger)getTotalVersion
{
    NSString *prePAth = [NSObject microAppDirectory];
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:prePAth error:nil];
        NSLog(@"%@",files);
    if (files.count == 0)
    {
        return 0;
    }
    NSArray * sortArr = [files sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
             return [obj2 compare:obj1 options:NSCaseInsensitiveSearch];   //obj1在前为升序,obj2在前为降序
        }];
        
        NSLog(@"%@",sortArr);
    NSInteger version = 0;
    NSMutableArray *prefixArray = [NSMutableArray array];
    for (NSString *fileName in sortArr)
    {
        NSArray *subArray = [fileName componentsSeparatedByString:@"."];
        subArray = [subArray subarrayWithRange:NSMakeRange(0, subArray.count -1)];
//        NSLog(@"%@",subArray);
        NSString *prefix  = [subArray componentsJoinedByString:@"."];
        [prefixArray addObject:prefix];
        
    }
    prefixArray = [prefixArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",prefixArray);
    
    //    NSMutableArray
        for (NSString *prefix in prefixArray)
        {
                        
            for (NSString *fileName in sortArr)
            {
                if ([fileName hasPrefix:prefix])
                {
                    NSRange range = [fileName rangeOfString:prefix];
                    NSString *endNumber = [fileName substringFromIndex:range.length + 1];
                    version = version + [endNumber integerValue];
                    break;
                    
                }
            }
        }
    NSLog(@"%ld",version);
    return version;
    
}

- (void)checkOnlineVersion
{
    [XEngineRequest get:MicroAppsVersion params:nil dataModel:UpdateModel.class success:^(id result, NSUInteger code, NSString *message) {
            NSLog(@"%@",result);
            if (0 == code) {
                UpdateModel *onlineModel = (UpdateModel *)result; // 线上的
                UpdateModel *localModel = [PublicData sharedInstance].updateModel; // 本地的
                NSMutableArray *serverURLArray = [NSMutableArray array];
                for (ZipModel *onlineZipModel in onlineModel.data)
                {
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.%@.zip",HostUrl,onlineZipModel.microAppId,onlineZipModel.microAppVersion];
                    [serverURLArray addObject:urlStr];
                }

                [PublicData sharedInstance].updateModel = onlineModel;
                [self downloadZipforServer:serverURLArray success:^(BOOL isUnZip, NSString * _Nonnull filePath) {
                    NSLog(@"%@",filePath);
                }];
            }
    
        } failure:^(NSString *errorString) {
            NSLog(@"%@",errorString);
        }];

}
@end
