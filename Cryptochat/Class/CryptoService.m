//
//  CryptoService.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 23.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "CryptoService.h"

@implementation CryptoService

-(void)encrypt:(NSDictionary*)dict type:(CryptType)type complete:(void(^)(BOOL isOk, NSDictionary* validDict))complete{
    
    //TODO:
    
    if(type ==CryptTypeAuth){
#warning MOCK DATA
        NSDictionary* validDict = dict;
        complete(YES, validDict);
    }
    

}

-(void)decrypt:(NSDictionary*)dict type:(CryptType)type complete:(void(^)(BOOL isOk, NSDictionary* validDict))complete{
    
    
    //TODO:
    
    if(type ==CryptTypeAuth){
#warning MOCK DATA
        NSDictionary* validDict = dict;
        complete(YES, validDict);
    }

}
@end
