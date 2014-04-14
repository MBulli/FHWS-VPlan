//
//  MBWebServiceResponseSerializer.m
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBWebServiceResponseSerializer.h"

#import "Models.h"

@interface MBWebServiceResponseSerializer ()
-(id)mapObject:(id)obj;

-(NSArray*)mapLinkArray:(NSArray*)source;
@end

@implementation MBWebServiceResponseSerializer

-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    id json = [super responseObjectForResponse:response data:data error:error];
    
    return [self mapObject:json];
}

-(id)mapObject:(id)obj
{
    if ([obj valueForKey:@"programs"]) {
        MBSemester *semester = [[MBSemester alloc] init];
        
        semester.label = [obj valueForKey:@"label"];
        semester.year = [obj valueForKey:@"year"];
        semester.programs = [self mapLinkArray:[obj valueForKey:@"programs"]];
        
        NSString *type = [obj valueForKey:@"semestertype"];
        if ([type isEqualToString:@"SS"]) {
            semester.semestertype = MBSemesterTypeSummer;
        } else if ([type isEqualToString:@"WS"]) {
            semester.semestertype = MBSemesterTypeWinter;
        } else {
            semester.semestertype = MBSemesterTypeUnknown;
        }
        
        return semester;
    }
    
    return nil;
}

-(NSArray *)mapLinkArray:(NSArray *)source
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:source.count];
    
    for (id obj in source) {
        NSString *url   = [obj valueForKey:@"url"];
        NSString *label = [obj valueForKeyPath:@"label"];
        MBLink *link = [MBLink linkWithUrlString:url andLabel:label];
        
        [result addObject:link];
    }
    
    return result;
}

@end
