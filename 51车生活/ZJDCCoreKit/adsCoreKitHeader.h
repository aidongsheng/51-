//
//  adsCoreKitHeader.h
//  Pods
//
//  Created by aidongsheng on 2017/8/31.
//
//

#ifndef adsCoreKitHeader_h
#define adsCoreKitHeader_h


#ifdef DEBUG
# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#define BUTTON_TITLE_COLOR(r,g,b,a)   [UIColor colorWithRed:(r)/255.0 green:(b)/255.0 blue:(b)/255.0 alpha:(a)]

#ifdef DEBUG
    // 开发服务器地址
# define baseUrl @""
#else
    // 发布服务器地址
# define baseUrl @""
#endif

#define IOS8 

#endif /* adsCoreKitHeader_h */
