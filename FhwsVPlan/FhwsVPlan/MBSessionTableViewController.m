//
//  MBSessionTableViewController.m
//  FhwsVPlan
//
//  Created by Markus on 15.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBSessionTableViewController.h"

#import "MBModuleTableViewController.h"
#import "Models.h"

@interface MBSessionTableViewController ()
@property(nonatomic, strong) MBSession *session;
@end

@implementation MBSessionTableViewController

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
    if ([segue.identifier isEqualToString:@"segModule"]) {
        MBModuleTableViewController *dest = segue.destinationViewController;
        
        int row = [[self.tableView indexPathForSelectedRow] row];
        dest.followLink = self.session.modules[row];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.session.modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MBLink *link = [self.session.modules objectAtIndex:indexPath.row];
    
    cell.textLabel.text = link.label;
    
    return cell;
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
    self.session = [objects firstObject];
    self.title = self.session.label;
    
    [self.tableView reloadData];
}


@end
