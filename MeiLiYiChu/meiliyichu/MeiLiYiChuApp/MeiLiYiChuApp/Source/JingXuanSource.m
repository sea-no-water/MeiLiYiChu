//
//  JingXuanSource.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JingXuanSource.h"
#import <AFNetworking.h>
#import "JXModel.h"

@implementation JingXuanSource

/**
 *  获取精选页面的数据 block 回调返回一个模型
 */
- (void)getJingXuanSource:(int)count
{
    NSString * urlStr = [NSString stringWithFormat:@"http://vapi.yuike.com/1.0/product/quality.php?mid=457465&type=choice&sid=ed0878d5e830cac1b2de8b780c58f546&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=%d",count];
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableDictionary * mdic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        
        JXModel * jxModel = [[JXModel alloc]initWithDictionary:mdic];
        
//        NSLog(@"%@",[jxModel.data.productsArray[0] taobao_price]);
        self.dicBlock(jxModel);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
@end
