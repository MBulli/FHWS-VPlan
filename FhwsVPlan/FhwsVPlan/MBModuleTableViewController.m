//
//  MBModuleTableViewController.m
//  FhwsVPlan
//
//  Created by Markus on 15.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBModuleTableViewController.h"

#import "MBLectureTableViewController.h"
#import "Models.h"

@interface MBModuleTableViewController ()
@property(nonatomic, strong) MBModule *module;
@end

@implementation MBModuleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.followLink) {
        [[MBWebService sharedInstance] loadUrl:self.followLink.url withDelegate:self];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segLecturer"]) {
        MBLectureTableViewController *dest = segue.destinationViewController;
        
        int row = [[self.tableView indexPathForSelectedRow] row];
        dest.followLink = self.module.lecturers[row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return self.module.lecturers.count;
        case 1: return self.module.events.count;
        default: return 0;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return @"Dozenten";
        case 1: return @"Events";
        default: return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MBLink *link = nil;
    
    if (indexPath.section == 0) {
        link = [self.module.lecturers objectAtIndex:indexPath.row];
    } else {
        link = [self.module.events objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = link.label;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
         [self performSegueWithIdentifier:@"segLecturer" sender:self];
    }
}

#pragma mark - MBWebServiceDelegate
-(void)webService:(MBWebService *)service failedRequest:(AFHTTPRequestOperation *)request withError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:[error description]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(void)webService:(MBWebService *)service didLoadObjects:(NSArray *)objects
{
    self.module = [objects firstObject];
    self.title = self.module.label;
    
    [self.tableView reloadData];
}


@end
