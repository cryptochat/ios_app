//
//  AuthorizationAuthorizationViewController.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationViewController.h"
#import "AuthViewModel.h"
#import "Constants.h"

@interface AuthorizationViewController()<UITextFieldDelegate>
@property(weak, nonatomic)IBOutlet UIView* containView;
@property(weak, nonatomic)IBOutlet UITextField* emailTextField;
@property(weak, nonatomic)IBOutlet UITextField* passTextField;
@property(weak, nonatomic)IBOutlet UIButton* loginButton;
@property(weak, nonatomic)IBOutlet UIButton* regButton;
@property(weak, nonatomic)IBOutlet UIScrollView* scrollView;

-(IBAction)onLogin:(id)sender;
-(IBAction)onReg:(id)sender;
@end

static CGFloat ALPHA = 0.5;
static NSString* PLACEHOLDER_PASS = @"ВВЕДИТЕ ПАРОЛЬ";
static NSString* PLACEHOLDER_EMAIL = @"ВВЕДИТЕ EMAIL";


@implementation AuthorizationViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.presenter viewInit];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    [self configTextField:_emailTextField];
    [self configTextField:_passTextField];
    
   
}

-(void)configTextField:(UITextField*)textField{
    textField.delegate = self;
    textField.alpha = ALPHA;
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    if([textField isEqual:_passTextField]){
        _passTextField.text = PLACEHOLDER_PASS;
    }
    
    if([textField isEqual:_emailTextField]){
        _emailTextField.text = PLACEHOLDER_EMAIL;
    }
}

- (void)dismissKeyboard{
    [_emailTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];

}

#pragma mark - Actions

-(IBAction)onLogin:(id)sender{
    if([self NSStringIsValidEmail:_emailTextField.text]){
        if(![_passTextField.text isEqualToString:@""] && ![_passTextField.text isEqualToString:PLACEHOLDER_PASS]){
            
           //SUCCESS CASE
            [self.presenter authUserWithModel:[self createViewModel]];
        }else{
             [self showAlertMessage:INVALID_PASSWORD];
        }
        
    }else{
        [self showAlertMessage:INVALID_EMAIL_MASK];
    }
    
}
-(IBAction)onReg:(id)sender{
    
}

- (void)keyboardWasShown:(NSNotification *)aNotification{
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.frame.size.width, self.view.frame.size.height + 158)];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    self.scrollView.scrollEnabled = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    if([_emailTextField.text isEqualToString:@""]){
        _emailTextField.text = PLACEHOLDER_EMAIL;
        _emailTextField.alpha = ALPHA;
    }
    
    if([_passTextField.text isEqualToString:@""]){
        _passTextField.text = PLACEHOLDER_PASS;
        _passTextField.alpha = ALPHA;
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    if([textField isEqual:self.emailTextField]){
        if([textField.text isEqualToString:PLACEHOLDER_EMAIL]){
            self.emailTextField.text = @"";
            self.emailTextField.alpha = 1;
        }
    }
    
    if([textField isEqual:self.passTextField]){
        if([textField.text isEqualToString:PLACEHOLDER_PASS]){
            self.passTextField.text = @"";
            self.passTextField.alpha = 1;
        }
    }

}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)showAlertMessage:(NSString *)message{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(AuthViewModel*)createViewModel{
    AuthViewModel* authModel = [AuthViewModel new];
    authModel.email = _emailTextField.text;
    authModel.password = _passTextField.text;
    return authModel;
}


#pragma mark - AuthorizationViewInterfaceOutputView <NSObject>



@end
