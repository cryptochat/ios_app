//
//  SocketService.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SocketServiceDelegate <NSObject>

@optional
-(void)chatServiceSocketOpenSocket;
-(void)chatServiceSocketCloseSocket;
-(void)chatServiceInComingMessage:(NSDictionary*)message;
-(void)chatServiceInComingError:(NSError*)error;

@end


@interface SocketService : NSObject
-(instancetype)initWithURL:(NSURL*)URL delegate:(id <SocketServiceDelegate>)delegate;

-(void)sendMessage:(id)message;
-(void)openSocket;
-(void)closeSocket;
@end
