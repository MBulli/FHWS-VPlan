//
//  MBLink.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBLink : NSObject
@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSURL *url;

+(MBLink*)linkWithUrlString:(NSString*)urlString andLabel:(NSString*)label;

-(id)initWithUrlString:(NSString*)urlString andLabel:(NSString*)label;
@end
