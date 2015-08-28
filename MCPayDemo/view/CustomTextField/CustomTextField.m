//
//  CustomTextField.m
//  CustomTextFieldTest
//
//  Created by  Dogstar on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomTextField.h"


@implementation AccessoryView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	for(UIView* view in [self subviews])
	{
		if(CGRectContainsPoint(view.frame,point))
		{
			return YES ;
		}
	}
	
	return NO ;
}

@end

@implementation CustomTextField

-(id)initWithButton:(UIButton*)button
{
	self = [super init];
	
	AccessoryView* accessoryView =[[AccessoryView alloc] initWithFrame:CGRectMake(0,0,320,30)] ;
	
	button.frame=CGRectMake(320-button.frame.size.width,30-button.frame.size.height,button.frame.size.width,button.frame.size.height) ;
	accessoryView.backgroundColor = [UIColor clearColor];
	
	[accessoryView addSubview:button];
	[self setInputAccessoryView:accessoryView];  
	return self ;
}

-(id)initWithToolbar:(id)target action:(SEL)action
{
	
	self = [super init] ;
	
	UIToolbar* toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 460, 320, 30)];  
	UIBarButtonItem * helloButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(closebutton)]; 
	UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
	UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:target action:action];  
	NSArray * buttonsArray = [NSArray arrayWithObjects:helloButton,btnSpace,doneButton,nil];  
	[toolBar setItems:buttonsArray];
	[self setInputAccessoryView:toolBar];
	return self ;
}

-(void)setAsCustomNumberPadTextField:(NSString*)title value:(NSString*)value
{
	self.keyboardType=UIKeyboardTypeNumberPad ;
	numberPadButtonTitle=title ;
	numberPadButtonValue=value ;
}

-(void)setAsDotNumberPadTextField
{
	[self setAsCustomNumberPadTextField:@"." value:@"."] ;
	textFieldType=ECustomTextFieldTypeDot ;	
}

-(void)closebutton
{
	[self resignFirstResponder] ;
}

-(void)buttonpressed
{
	self.text=[NSString stringWithFormat: @"%@%@",self.text,numberPadButtonValue] ;
}

- (BOOL)resignFirstResponder
{
	BOOL ret = [super resignFirstResponder];
	if(textFieldType!=ECustomTextFieldTypeDot)
	{
		return ret;
	}
	UIView* keyboard ;
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];

	for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
		if ([[keyboard description] hasPrefix:@"<UIKeyboard"]||[[keyboard description] hasPrefix:@"<UIPeripheralHostView"])
		{	
			[[keyboard viewWithTag:1000] removeFromSuperview] ;
		}
	}
	
	return ret ;
}

- (BOOL)becomeFirstResponder
{ 
	BOOL ret = [super becomeFirstResponder];

	UIView* keyboard ;
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];

	if(textFieldType!=ECustomTextFieldTypeDot)
	{
		return ret;
	}
	for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
		if ([[keyboard description] hasPrefix:@"<UIKeyboard"]||[[keyboard description] hasPrefix:@"<UIPeripheralHostView"])
		{	
			UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,162,105,45)];
			button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
			[button setTitle:numberPadButtonTitle forState:UIControlStateNormal];
			[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal] ;
			[button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
			[button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
			[button addTarget:self action:@selector(buttonpressed) forControlEvents:UIControlEventTouchUpInside];
			button.showsTouchWhenHighlighted = YES;
			button.tag=1000 ;			
			
			[[keyboard.subviews objectAtIndex:0] addSubview:button] ;
			
		}
	}
	
	return ret ;
}

@end
