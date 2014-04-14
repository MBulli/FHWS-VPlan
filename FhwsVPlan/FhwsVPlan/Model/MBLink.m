//
//  MBLink.m
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBLink.h"

@implementation MBLink

+(MBLink *)linkWithUrlString:(NSString *)urlString andLabel:(NSString *)label
{
    return [[MBLink alloc] initWithUrlString:urlString andLabel:label];
}

-(id)initWithUrlString:(NSString *)urlString andLabel:(NSString *)label
{
    self = [super init];
    
    if (self) {
        self.url = [NSURL URLWithString:urlString];
        self.label = label;
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%@)", self.label, self.url];
}

@end
