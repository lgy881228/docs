//
//  CommonDefines.h
//  XEngine
//
//  Created by edz on 2020/7/8.
//  Copyright © 2020 edz. All rights reserved.
//

#ifndef CommonDefines_h
#define CommonDefines_h

#define OffLineHtmlFilePathKey @"htmlFilePathKey"
//#define OffLinePreferencesPathKey @"PreferencesPath"
#define ObjErrorCheck(obj)             [NSString stringWithFormat:@"%@", (obj && ![obj isKindOfClass:[NSNull class]]) ? obj : @""]

#define SetAssociatedObject(key, value) objc_setAssociatedObject(self, &key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define GetAssociatedObject(key)        objc_getAssociatedObject(self, &key)
// User Defaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define USER_DEFAULT_SETTER(obj,key) \
[USER_DEFAULT setObject:obj forKey:key];\
\
[USER_DEFAULT synchronize];

#define WeakObj(o) __weak typeof(o) Weak##o = o;


#endif /* CommonDefines_h */
