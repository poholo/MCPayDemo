//
//  OnlineChargeViewController.m
//  MCCarServiceiPhone
//
//  Created by mac on 15/5/23.
//  Copyright (c) 2015年 mjc. All rights reserved.
//

#import "OnlineChargeViewController.h"
#import "RadioGroup.h"

//------支付宝------
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
//.m使用
#import "DataSigner.h"
//.mm使用
#import "RSADataSigner.h"

//----unionpay----
#import "UPPayPlugin.h"
#import "CustomTextField.h"


/*============================================================================*/
/*=======================支付宝需要填写商户app申请的===================================*/
/*============================================================================*/
static NSString *alipayPartner = @"2088xxxx";
static NSString *alipaySeller = @"";
static NSString *aliPayPrivateKey = @"";



static NSString *alipayNotifServerURL = @"";
static NSString *URLScheme = @"MCPayDemo";

@interface OnlineChargeViewController ()<UITextFieldDelegate,UPPayPluginDelegate>{
    RadioGroup *_radioGroup;
    UIButton *_dotInKeyboardButton;
}
@property (weak, nonatomic) IBOutlet CustomTextField *txtCNY;
@property (weak, nonatomic) IBOutlet UIButton *btnCharge;
//union pay
@property (nonatomic,strong) NSString *tnMode;

@end

@implementation OnlineChargeViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试环境  上线时，请改为“00”
    _tnMode = @"01";
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"在线充值";
    _radioGroup = [[RadioGroup alloc] initWithFrame:CGRectMake(0, 34+(iPhone6Plus||iPhone6?20:10), self.view.frame.size.width, 110)];
    _radioGroup.rdv0.imgIco.image =[UIImage imageNamed:@"icon_yl"];
    _radioGroup.rdv1.imgIco.image = [UIImage imageNamed:@"icon_zfb"];
    _radioGroup.rdv2.imgIco.image = [UIImage imageNamed:@"icon_wf.png"];
    
//    _radioGroup.layer.borderColor = [UIColor redColor].CGColor;
//    _radioGroup.layer.borderWidth = 1;
    [_radioGroup tapClick:nil];
    _txtCNY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [self.view addSubview:_radioGroup];
    
    _txtCNY.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self handleKeyboardWillHide:nil];
    _dotInKeyboardButton.hidden = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _dotInKeyboardButton.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCharge:(id)sender {
    [_txtCNY resignFirstResponder];
    if ([_txtCNY.text floatValue]<=0) {
        NSLog(@"请输入充值金额");
        return;
    }
    
    //获取订单编号
//    [[MCManager sharedInstance].userDelegate getOnlineChargeWithChargeType:MC_ONLINE_CHARGE_TYPE[_radioGroup.selectType] usrid:[MCManager sharedInstance].curUser.nm money:_txtCNY.text cleanCarId:nil resultBack:^(MCServiceResult *result, NSArray *items) {

    //****从服务器拉取数据
    
    bool isSuccess = true;
    NSString *tn = @"201508281139266004168";
        if (isSuccess) {
            /*
             *点击获取prodcut实例并初始化订单信息
             */
            
            
            /*
             *商户的唯一的parnter和seller。
             *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
             */
            
            /*============================================================================*/
            /*=======================需要填写商户app申请的===================================*/
            /*============================================================================*/
            
            /*============================================================================*/
            /*============================================================================*/
            /*============================================================================*/
            switch (_radioGroup.selectType) {
                case 0:
                {
                    //union pay
                    [UPPayPlugin startPay:tn mode:self.tnMode viewController:self delegate:self];
                }
                    break;
                case 1:{
                    //alipay
                    //partner和seller获取失败,提示
                    if ([alipayPartner length] == 0 ||
                        [alipaySeller length] == 0 ||
                        [aliPayPrivateKey length] == 0)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                        message:@"缺少partner或者seller或者私钥。"
                                                                       delegate:self
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                        [alert show];
                        return;
                    }
                    
                    /*
                     *生成订单信息及签名
                     */
                    //将商品信息赋予AlixPayOrder的成员变量
                    
                    Order *order = [[Order alloc] init];
                    order.partner = alipayPartner ;
                    order.seller = alipaySeller;
                    order.tradeNO = tn; //订单ID（由商家自行制定）
                    order.productName = [NSString stringWithFormat:@"汽车服务充值-%@",@"支付"]; //商品标题
                    order.productDescription = [NSString stringWithFormat:@"%@:支付宝移动支付充值",@"xxxx"]; //商品描述
                    order.amount = _txtCNY.text; //商品价格
                    order.notifyURL =  alipayNotifServerURL; //回调URL
                    
                    order.service = @"mobile.securitypay.pay";
                    order.paymentType = @"1";
                    order.inputCharset = @"utf-8";
                    order.itBPay = @"30m";
                    order.showUrl = @"m.alipay.com";
                    
                    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                    NSString *appScheme = URLScheme;
                    
                    //将商品信息拼接成字符串
                    NSString *orderSpec = [order description];
                    NSLog(@"orderSpec = %@",orderSpec);
                    
                    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
                    id<DataSigner> signer = //[[RSADataSigner alloc] initWithPrivateKey:orderSpec];
                    
                    CreateRSADataSigner(aliPayPrivateKey);
                    NSString *signedString = [signer signString:orderSpec];
                    
                    //将签名成功字符串格式化为订单字符串,请严格按照该格式
                    NSString *orderString = nil;
                    if (signedString != nil) {
                        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                       orderSpec, signedString, @"RSA"];
                        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSLog(@"reslut = %@",resultDic);
                            if ([resultDic[@"resultStatus"] intValue]==9000) {
                                //进入充值列表页面
                                NSLog(@"支付成功");
                                
                            }
                            else{
                                NSString *resultMes = resultDic[@"memo"];
                                resultMes = (resultMes.length<=0?@"支付失败":resultMes);
                                NSLog(@"%@",resultMes);
                            }
                        }];
                    }

                }
                    break;
                default:
                    break;
            }
            
        }
        else{
            NSLog(@"获取订单编号失败");
        }
    
}

#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{

    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
        [_dotInKeyboardButton removeFromSuperview];
    _dotInKeyboardButton.frame = CGRectZero;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    if (_dotInKeyboardButton == nil)
    {
        _dotInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
     

        _dotInKeyboardButton.adjustsImageWhenHighlighted = NO;
        //图片直接抠腾讯财付通里面的= =!
//        [_dotInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
//        [_dotInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
        [_dotInKeyboardButton setTitle:@"." forState:UIControlStateNormal];
        _dotInKeyboardButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [_dotInKeyboardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dotInKeyboardButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        
        
        [_dotInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        _dotInKeyboardButton.layer.borderColor= [UIColor redColor].CGColor;
        _dotInKeyboardButton.layer.borderWidth = 1;
    }
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _dotInKeyboardButton.frame = CGRectMake(0, screenHeight - 53, screenWidth/3.0, 53);

    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (_dotInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:_dotInKeyboardButton];    // 注意这里直接加到window上
    }
    
}

-(void)finishAction{
    //当包含1个点时隐藏，没有点时再出现
    if ([_txtCNY.text containsString:@"."]) {
        return;
    }
    else{
        _txtCNY.text = [_txtCNY.text stringByAppendingString:@"."];
    }
    
}

#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:@"%@", result];
    NSLog(@"msg%@",msg);
    
    if ([result isEqualToString:@"msgcancel"]) {
        NSLog(@"取消银联支付...");
    }
    else if([result containsString:@"success"]){
        NSLog(@"支付成功");
        
    }
}

#pragma  mark  textview
- (IBAction)But:(id)sender {
    _dotInKeyboardButton.hidden=YES;
}

- (IBAction)NOBut:(id)sender {
    _dotInKeyboardButton.hidden=NO;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
