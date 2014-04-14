//
//  MBEvent.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBLink.h"

@interface MBEvent : NSObject
@property(nonatomic, strong) MBLink *module;

@property(nonatomic, strong) NSString *ident;
@property(nonatomic, strong) NSDate *startdate;
@property(nonatomic, strong) NSDate *enddate;
@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSString *room;
@property(nonatomic, strong) NSString *group;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *additionalinfo;

@property(nonatomic, strong) NSArray *lecturers;
@end
