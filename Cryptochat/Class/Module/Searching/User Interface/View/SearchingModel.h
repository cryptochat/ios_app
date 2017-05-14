//
//  SearchingModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchingModel : NSObject
@property(strong, nonatomic)NSData* photoData;
@property(strong, nonatomic)NSString* name;
@property(assign, nonatomic)int index;
@end
