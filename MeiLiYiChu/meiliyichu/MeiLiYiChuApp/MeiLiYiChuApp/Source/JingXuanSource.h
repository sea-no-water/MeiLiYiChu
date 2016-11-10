//
//  JingXuanSource.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXModel.h"
@interface JingXuanSource : NSObject

- (void)getJingXuanSource:(int)count;


/**
 *  block回调
 */
@property (nonatomic,copy)void(^dicBlock)(JXModel *);

@end
