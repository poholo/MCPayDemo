//
//  RadioGroup.m
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/21.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import "RadioGroup.h"

@implementation RadioGroup

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _rdv0 = [[[NSBundle mainBundle] loadNibNamed:@"RadioView" owner:self options:nil] lastObject];
        _rdv1 = [[[NSBundle mainBundle] loadNibNamed:@"RadioView" owner:self options:nil] lastObject];
        _rdv2 = [[[NSBundle mainBundle] loadNibNamed:@"RadioView" owner:self options:nil] lastObject];
        
        
//        float height = iPhone6Plus||iPhone6?36:30;
//        
//        float split = iPhone6Plus||iPhone6?10:5;
//        float width = ([UIScreen mainScreen].bounds.size.width-split*4)/3.0;
//        _rdv0.frame = CGRectMake(split/3, 0, width, height);
//        _rdv1.frame = CGRectMake(split + _rdv0.frame.origin.x+_rdv0.frame.size.width, _rdv0.frame.origin.y, width, height);
//        _rdv2.frame = CGRectMake(split + _rdv1.frame.origin.x + _rdv1.frame.size.width, _rdv1.frame.origin.y, _rdv1.frame.size.width, height);
        
        
        float height = iPhone6Plus||iPhone6?50:40;
        
        float split = iPhone6Plus||iPhone6?10:5;
        float width = ([UIScreen mainScreen].bounds.size.width-split*4)/2.0;
        
        _rdv1.frame = CGRectMake(width/2.0, 0, width, height);
        _rdv0.frame = CGRectMake(_rdv1.frame.origin.x, _rdv1.frame.origin.y + _rdv1.frame.size.height +split, width, height);
        [self addSubview:_rdv0];
        [self addSubview:_rdv1];
//        [self addSubview:_rdv2];
        
#if  DEBUG&&0
        _rdv0.backgroundColor = [UIColor greenColor];
        _rdv1.backgroundColor = [UIColor orangeColor];
        _rdv2.backgroundColor = [UIColor grayColor];
        self.backgroundColor = [UIColor blueColor];
#endif
        
        UITapGestureRecognizer *tap0 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [_rdv0 addGestureRecognizer:tap0];
        [_rdv1 addGestureRecognizer:tap1];
        [_rdv2 addGestureRecognizer:tap2];
        
        
    }
    
    return self;
}

-(void)tapClick:(UITapGestureRecognizer*)sender{
    if (sender.view==_rdv0) {
        [_rdv0 selectOrUnSelect:YES];
        [_rdv1 selectOrUnSelect:NO];
        [_rdv2 selectOrUnSelect:NO];
        _selectType = 0;
    }
    else if(sender.view==nil||sender.view == _rdv1){
    
        [_rdv0 selectOrUnSelect:NO];
        [_rdv1 selectOrUnSelect:YES];
        [_rdv2 selectOrUnSelect:NO];
        _selectType = 1;
    }
    else if(sender.view == _rdv2){
        [_rdv0 selectOrUnSelect:NO];
        [_rdv1 selectOrUnSelect:NO];
        [_rdv2 selectOrUnSelect:YES];
        _selectType = 2;
    
    }
    else{
        //none
    }
}

@end
