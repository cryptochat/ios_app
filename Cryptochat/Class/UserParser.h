//
//  UserParser.h
//  Cryptochat
//
//  Created by Artem Konarev on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InterlocutorModel;

@interface UserParser : NSObject

- (NSArray<InterlocutorModel *> *) createInterlocutorModelsArrayFromDictionary:(NSDictionary *)dictionary;

@end
