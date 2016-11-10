//
//  SYsource.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 刘文海. All rights reserved.
//


/*
 
    tabBar页面 除精选页面外 的所有数据请求方法类
 
 */

#import <Foundation/Foundation.h>
typedef void(^block)(NSDictionary * dic);
@interface SYsource : NSObject
+ (void)getLunBoScImg:(block)block WithURL:(NSString *)urlstr;
@end
