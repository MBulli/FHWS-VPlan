//
//  MBLectureTableViewController.h
//  FhwsVPlan
//
//  Created by Markus on 15.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBWebService.h"

@class MBLink;

@interface MBLectureTableViewController : UITableViewController<MBWebServiceDelegate>
@property(nonatomic, strong) MBLink *followLink;
@end
