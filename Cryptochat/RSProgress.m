//
//  RSProgress.m
//  kupikupon
//
//  Created by Сергей Романков on 02.06.16.
//
//

#import "RSProgress.h"
#import "UiKit/UiKit.h"


static CGFloat heightProgress = 100.f;
static CGFloat widthProgress = 100.f;
static NSTimeInterval defaultDelay = 0.5;

@interface RSProgress()
@property(strong, nonatomic)UIWindow* windowProgress;

@end

@implementation RSProgress{
    BOOL _isNeedShow;
}


+ (RSProgress *)instance {
    static RSProgress *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}

-(void)showProgressWithDefaultDelay{
    [self showProgressWithDelay:defaultDelay];
}

-(void)showProgressWithDelay:(NSTimeInterval)delay{
    _isNeedShow = true;
    if(delay <= 0)
        [self _showProgress];

    [self performSelector:@selector(_showProgress) withObject:self afterDelay:delay];
}

-(void)showProgress{
    _isNeedShow = true;
    [self _showProgress];
}

-(void)_showProgress{
    if(!_isNeedShow)
        return;
    
    // create Window
    _windowProgress = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _windowProgress.windowLevel = UIWindowLevelAlert;
    UIViewController* vc = [UIViewController new];
    _windowProgress.rootViewController = vc;
    [_windowProgress makeKeyAndVisible];
    
    // add shadow
    UIView* viewShadow = [[UIView alloc] initWithFrame:vc.view.frame];
    viewShadow.alpha = 0.3;
    viewShadow.backgroundColor = [UIColor blackColor];
    [vc.view addSubview:viewShadow];
    
    [self addProgressView:vc];
}


-(void)addProgressView:(UIViewController*)vc{
    UIView * progressContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, heightProgress, widthProgress)];
    progressContainer.center = CGPointMake(CGRectGetWidth(vc.view.frame)/2, CGRectGetHeight(vc.view.frame)/2);
    progressContainer.backgroundColor = [UIColor blackColor];
    progressContainer.layer.cornerRadius = 10.f;
    progressContainer.alpha = 0.9;
    [vc.view addSubview:progressContainer];
    
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [vc.view addSubview:indicator];
    indicator.center = CGPointMake(CGRectGetWidth(vc.view.frame)/2, CGRectGetHeight(vc.view.frame)/2);
}

-(void)hideProgress{
    _isNeedShow = false;
    _windowProgress = nil;
}




@end
