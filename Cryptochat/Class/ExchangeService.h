//
//  ExchangeService.h
//  Cryptochat
//
//  Created by Artem Konarev on 25.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransportLayer.h"

@interface ExchangeService : NSObject

- (void)keyExchangeWithCompleteStatus:(void (^)(TransportResponseStatus status))completeResponse;

@end
