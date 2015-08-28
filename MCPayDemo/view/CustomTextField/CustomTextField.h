//
//  CustomTextField.h
//  CustomTextFieldTest
//
//  Created by  Dogstar on 11-10-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AccessoryView : UIView
{
}
@end

enum ECustomTextFieldType {
	ECustomTextFieldTypeNormal,
	ECustomTextFieldTypeDot,
} ;

@interface CustomTextField : UITextField {
	
	NSInteger textFieldType ;
	NSString* numberPadButtonTitle ;
	NSString* numberPadButtonValue ;

}
-(id)initWithButton:(UIButton*)button ;
-(id)initWithToolbar:(id)target action:(SEL)action ;

-(void)setAsDotNumberPadTextField ;

@end
