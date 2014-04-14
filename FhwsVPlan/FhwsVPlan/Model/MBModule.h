//
//  MBModule.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBModule : NSObject
@property(nonatomic, strong) NSString *number;
@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSArray *lecturers; // TODO
@property(nonatomic, strong) NSArray *events;
@end
