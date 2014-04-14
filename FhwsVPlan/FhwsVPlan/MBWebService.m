//
//  MBWebService.m
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBWebService.h"

#import "AFNetworking.h"

#import "MBWebServiceResponseSerializer.h"

@interface MBWebService ()
@property(nonatomic, strong) AFHTTPRequestOperationManager *reqManager;

-(void)GET:(NSString*)urlString;

-(void)receivedObject:(id)responseObject withOperation:(AFHTTPRequestOperation*)operation;
-(void)failedToGetObjects:(AFHTTPRequestOperation*)operation withError:(NSError*)error;
@end

@implementation MBWebService

+(MBWebService *)sharedInstance
{
    static dispatch_once_t onceToken;
    static MBWebService *_sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MBWebService alloc] init];
    });
    
    return _sharedInstance;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        self.reqManager = [[AFHTTPRequestOperationManager alloc] init];
        self.reqManager.responseSerializer = [MBWebServiceResponseSerializer serializer];
    }
    
    return self;
}

-(void)loadSemesters
{
    [self GET:@"http://staging.applab.fhws.de:8080/fhwsapi/v1/lectures/ss14"];
}

#pragma mark - private methods
-(void)GET:(NSString *)urlString
{
    [self.reqManager GET:@"http://staging.applab.fhws.de:8080/fhwsapi/v1/lectures/ss14" parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     [self receivedObject:responseObject withOperation:operation];
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     [self failedToGetObjects:operation withError:error];
                 }];
}

-(void)receivedObject:(id)responseObject withOperation:(AFHTTPRequestOperation *)operation
{
    if ([self.delegate respondsToSelector:@selector(webService:didLoadObjects:)]) {
        NSArray *objects = [NSArray arrayWithObject:responseObject];
        
        [self.delegate webService:self didLoadObjects:objects];
    }
}

-(void)failedToGetObjects:(AFHTTPRequestOperation *)operation withError:(NSError *)error
{
    [self.delegate webService:self failedRequest:operation withError:[error copy]];
}

@end
