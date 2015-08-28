//
//  RadioView.m
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import "RadioView.h"
#define RadioImgArr @[@"RadioButton-Unselected.png",@"RadioButton-Selected.png"]
@implementation RadioView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"RadioView" owner:self options:nil] lastObject];
    }
    return self;
}

-(void)selectOrUnSelect:(BOOL)isSelect{
    _isSelect =  isSelect;
    _imgRadio.image = [UIImage imageNamed:RadioImgArr[_isSelect]];
}
@end
