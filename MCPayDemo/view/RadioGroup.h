//
//  RadioGroup.h
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioView.h"
@interface RadioGroup : UIView
@property (strong, nonatomic)  RadioView *rdv0;
@property (strong, nonatomic)  RadioView *rdv1;
@property (strong, nonatomic)  RadioView *rdv2;
-(void)tapClick:(UITapGestureRecognizer*)sender;
@property (nonatomic,assign) int selectType;

@end
