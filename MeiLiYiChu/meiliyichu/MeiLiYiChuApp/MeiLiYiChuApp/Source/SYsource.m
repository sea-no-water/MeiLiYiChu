
//
//  SYsource.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "SYsource.h"

@implementation SYsource

//首页数据获取
+ (void)getLunBoScImg:(block)block WithURL:(NSString *)urlStr
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSString * STR = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",STR);
        block(dic);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}


@end
