//
//  RadioLabel.h
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 mjc. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol RadioTapSelectDelegate <NSObject>

-(void)switchSelectSome:(int)tag;

@end
#import <UIKit/UIKit.h>
@interface RadioLabel : UIView
@property (nonatomic,assign) id<RadioTapSelectDelegate> delegate;
@property (strong, nonatomic)   UIImageView *imgRadio;
@property (strong, nonatomic)   UILabel *lbTitle;
@property (assign,nonatomic) BOOL isSelect;
@property (strong,nonatomic) NSArray *selectArr;
- (void)selectOrUnSelect:(BOOL)isSelect;

@end
