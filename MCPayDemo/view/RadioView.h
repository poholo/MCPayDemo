//
//  RadioView.h
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgRadio;
@property (weak, nonatomic) IBOutlet UIImageView *imgIco;
@property (assign,nonatomic) BOOL isSelect;
- (void)selectOrUnSelect:(BOOL)isSelect;

@end
