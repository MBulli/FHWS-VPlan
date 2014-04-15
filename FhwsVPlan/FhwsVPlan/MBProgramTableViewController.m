//
//  MBProgramTableViewController.m
//  FhwsVPlan
//
//  Created by Markus on 15.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBProgramTableViewController.h"

#import "MBSessionTableViewController.h"
#import "Models.h"

@interface MBProgramTableViewController ()
@property(nonatomic, strong) MBProgram *program;
@end

@implementation MBProgramTableViewController

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
    if ([segue.identifier isEqualToString:@"segSession"]) {
        MBSessionTableViewController *dest = segue.destinationViewController;
        
        int row = [[self.tableView indexPathForSelectedRow] row];
        dest.followLink = self.program.sessions[row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.program.sessions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MBLink *link = [self.program.sessions objectAtIndex:indexPath.row];
    
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
    self.program = [objects firstObject];
    self.title = self.program.name;
    
    [self.tableView reloadData];
}


@end
