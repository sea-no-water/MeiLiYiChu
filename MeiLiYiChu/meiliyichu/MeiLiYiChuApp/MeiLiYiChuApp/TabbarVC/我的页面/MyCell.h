//
//  MyCell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/9.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fontImageView;
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;


@property (nonatomic, strong) UIImageView * FontImageView;
@property (nonatomic, strong) UIImageView * BackImageView;
@property (nonatomic, strong) UILabel * FontLab;
@property (nonatomic, strong) UILabel * BackLab;
@property (nonatomic, strong) UILabel * LineLab;

/**
 *  5个按钮的cell
 */
@property (nonatomic, strong) UIView * isFiveView;
@end
