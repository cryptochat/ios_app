//
//  RSProgress.h
//  kupikupon
//
//  Created by Сергей Романков on 02.06.16.
//
//

#import <Foundation/Foundation.h>

@interface RSProgress : NSObject

+ (RSProgress *)instance;

-(void)showProgressWithDefaultDelay;
-(void)showProgressWithDelay:(NSTimeInterval)delay;
-(void)showProgress;

-(void)hideProgress;

@end
