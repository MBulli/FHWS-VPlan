//
//  MBLecturer.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBLecturer : NSObject

@property(nonatomic, strong) NSString *consultationdate;
@property(nonatomic, strong) NSString *phone;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *lastname;
@property(nonatomic, strong) NSString *firstname;
@property(nonatomic, strong) NSURL *imageurl;
@property(nonatomic, strong) NSArray *modules;

@end
