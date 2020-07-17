//
//  ServerHostDefines.h
//  ECEJ
//
//  Created by jia on 16/5/23.
//  Copyright © 2016年 ECEJ. All rights reserved.
//

#ifndef ServerHostDefines_h
#define ServerHostDefines_h

#define RequestURL(server, interface)  [NSString stringWithFormat:@"%@%@", server, interface]
#if DEBUG || ADHOC
// 🤙🤙🤙 可以根据需要来设置，注释掉了会走选择环境的流程
//#define HostUrl  @"https://zqzapi.jiantuiad.com"
//#define HostUrl  @"http://192.168.3.211:8000" //192.168.31.236家里的
//#define HostUrl  @"http://192.168.31.237:8000" //192.168.31.237家里的
#define HostUrl  @"http://192.168.3.178:8000" //192.168.31.236家里的/Archive999

#else
// ⚠️ 这里请勿修改，AppStore始终走release环境
#define HostUrl  @"http://192.168.3.211:8000"
#endif
#endif /* ServerHostDefines_h */
