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
    } else if ([obj valueForKey:@"sessions"]) {
        MBProgram *program = [[MBProgram alloc] init];
        
        program.name = [obj valueForKey:@"name"];
        program.sessions = [self mapLinkArray:[obj valueForKey:@"sessions"]];
        
        return program;
    } else if([obj valueForKey:@"session"]) {
        MBSession *session = [[MBSession alloc] init];
        
        session.specialisation = [obj valueForKey:@"specialisation"];
        session.session = [obj valueForKey:@"session"];
        session.label = [obj valueForKey:@"label"];
        session.modules = [self mapLinkArray:[obj valueForKey:@"modules"]];
        
        return session;
    } else if([obj valueForKey:@"events"]) {
        MBModule *module = [[MBModule alloc] init];
        
        module.number = [obj valueForKey:@"number"];
        module.label = [obj valueForKey:@"label"];
        module.lecturers = [self mapLinkArray:[obj valueForKey:@"lecturers"]];
        module.events = [self mapLinkArray:[obj valueForKey:@"events"]];
        
        return module;
    } else if([obj valueForKey:@"imageurl"]) {
        MBLecturer *lecturer = [[MBLecturer alloc] init];
        
        lecturer.consultationdate = [obj valueForKey:@"consultationdate"];
        lecturer.phone = [obj valueForKey:@"phonenumber"];
        lecturer.title = [obj valueForKey:@"title"];
        lecturer.email = [obj valueForKey:@"email"];
        lecturer.lastname = [obj valueForKey:@"lastname"];
        lecturer.firstname = [obj valueForKey:@"firstname"];
        lecturer.function = [obj valueForKey:@"functions"];
        lecturer.imageurl = [NSURL URLWithString:[obj valueForKey:@"imageurl"]];
        lecturer.modules = [self mapLinkArray:[obj valueForKey:@"modules"]];
        
        return lecturer;
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
