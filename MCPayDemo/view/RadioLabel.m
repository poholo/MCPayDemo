//
//  RadioLabel.m
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/26.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import "RadioLabel.h"

@implementation RadioLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        float margin = 5;
        _imgRadio = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, frame.size.height - margin, frame.size.height - margin)];
        _imgRadio.userInteractionEnabled = YES;
        CGRect rect = _imgRadio.frame;
        _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + margin, rect.origin.y , rect.size.width, rect.size.height)];
        
        [self addSubview:_imgRadio];
        [self addSubview:_lbTitle];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [self addGestureRecognizer:tap];
    }
    return self;
}*/
-(void)setSelectArr:(NSArray *)selectArr{
    _selectArr = selectArr;
    _imgRadio.image = [UIImage imageNamed:_selectArr[_isSelect]];
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _imgRadio.image = [UIImage imageNamed:_selectArr[_isSelect]];
}
-(void)tapClick:(id)sender{
    _isSelect = !_isSelect;
    if ([_selectArr count]<2) {
        return;
    }
    _imgRadio.image = [UIImage imageNamed:_selectArr[_isSelect]];
    if ([_delegate respondsToSelector:@selector(switchSelectSome:)]) {
        [_delegate switchSelectSome:(int)self.tag];
    }
}
-(void)awakeFromNib{
    CGRect frame = self.frame;
    float margin = 5;
    _imgRadio = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, frame.size.height - margin, frame.size.height - margin)];
    _imgRadio.userInteractionEnabled = YES;
    CGRect rect = _imgRadio.frame;
    _lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x + rect.size.width + margin, rect.origin.y , rect.size.width*1.5, rect.size.height)];
    
    [self addSubview:_imgRadio];
    [self addSubview:_lbTitle];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    [self addGestureRecognizer:tap];
#if MCMySex
    _imgRadio.layer.borderColor = [UIColor orangeColor].CGColor;
    _imgRadio.layer.borderWidth = 1;
    _lbTitle.layer.borderColor = [UIColor blueColor].CGColor;
    _lbTitle.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 1;

#endif
 
}


@end
