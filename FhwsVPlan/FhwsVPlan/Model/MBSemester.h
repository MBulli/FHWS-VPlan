//
//  MBSemester.h
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MBSemesterTypeUnknown,
    MBSemesterTypeSummer,
    MBSemesterTypeWinter
} MBSemesterType;

@interface MBSemester : NSObject
@property(nonatomic, assign) MBSemesterType semestertype;
@property(nonatomic, strong) NSString *label;
@property(nonatomic, strong) NSNumber *year;
@property(nonatomic, strong) NSArray *programs;
@end
