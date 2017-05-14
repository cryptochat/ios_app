//
//  RealmDataStore.m
//  mimigram
//
//  Created by Artem Konarev on 21.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "RealmDataStore.h"

#import "UserAuthModel.h"
#import "UserAuthModel+Realm.h"
#import "UserAuthRealm.h"
#import "UserAuthRealm+Model.h"


@implementation RealmDataStore

-(void)removeAll{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

#pragma mark - Banners

-(void)saveUser:(UserAuthModel*)model{
    RLMRealm *realm = [RLMRealm defaultRealm];
    UserAuthRealm* usRealm =  (UserAuthRealm *) [[UserAuthRealm allObjects] firstObject];
    if(!usRealm){
        UserAuthRealm* userRealm = [UserAuthRealm new];
        userRealm = [[UserAuthRealm alloc]initWithModel:model];
        
        [realm beginWriteTransaction];
        [realm addObject:userRealm];
        [realm commitWriteTransaction];
    }else{
        [realm beginWriteTransaction];
        [usRealm updateWithModel:model];
        [realm commitWriteTransaction];
    }
    NSLog(@"RealmDS SaveUser: no Errors");
}

-(void)updateUser:(UserAuthModel*)model{
    RLMRealm *realm = [RLMRealm defaultRealm];
     UserAuthRealm* lastObject =  (UserAuthRealm *) [[UserAuthRealm allObjects] lastObject];
    [realm beginWriteTransaction];
    [lastObject updateWithModel:model];
    [realm commitWriteTransaction];
}

-(UserAuthModel*)getUser{
    UserAuthRealm* lastObject =  (UserAuthRealm *) [[UserAuthRealm allObjects] lastObject];
    if(lastObject){
        UserAuthModel* model = [[UserAuthModel alloc]initWithRealm:lastObject];
        return model;
    }
    return nil;
}

-(void)removeUser{
    RLMRealm *realm = [RLMRealm defaultRealm];
    UserAuthRealm* lastObject =  (UserAuthRealm *) [[UserAuthRealm allObjects] lastObject];
    if(lastObject){
        [realm beginWriteTransaction];
        [realm deleteObject:lastObject];
        [realm commitWriteTransaction];
    }
   
}





@end
