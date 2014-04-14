//
//  MBSession.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBSession : NSObject
@property(nonatomic, strong) NSString *specialisation;
@property(nonatomic, strong) NSNumber *session;
@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSArray *modules;
@end
