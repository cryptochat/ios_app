//
//  CryptoService.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 23.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CryptType){
    CryptTypeAuth
};

@interface CryptoService : NSObject
-(void)encrypt:(NSDictionary*)dict type:(CryptType)type complete:(void(^)(BOOL isOk, NSDictionary* validDict))complete;

-(void)decrypt:(NSDictionary*)dict type:(CryptType)type complete:(void(^)(BOOL isOk, NSDictionary* validDict))complete;
@end
