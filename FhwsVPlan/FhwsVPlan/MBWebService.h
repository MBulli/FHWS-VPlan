//
//  MBWebService.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBWebService;
@class AFHTTPRequestOperation;

@protocol MBWebServiceDelegate <NSObject>
-(void)webService:(MBWebService*)service failedRequest:(AFHTTPRequestOperation*)request withError:(NSError*)error;

@optional
-(void)webService:(MBWebService*)service didLoadObjects:(NSArray*)objects;
@end

@interface MBWebService : NSObject

+(MBWebService*)sharedInstance;

@property(nonatomic, weak) id<MBWebServiceDelegate> delegate;

-(void)loadSemesters;
@end
