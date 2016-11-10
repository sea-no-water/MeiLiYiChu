//
//  QT_headerModel_data_category_list.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QT_headerModel_data_category_list : NSObject
/**
 *  图片链接
 */
@property (nonatomic, strong)NSString * pic_url;
/**
 *  标题
 */
@property (nonatomic, strong)NSString * title;
/**
 *  菜单类别
 */
@property (nonatomic, strong)NSString * cids;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
