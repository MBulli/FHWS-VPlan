//
//  MBSemesterViewControllerTableViewController.m
//  FhwsVPlan
//
//  Created by Markus on 14.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBSemesterViewController.h"

#import "Models.h"

@interface MBSemesterViewController ()
@property(nonatomic, strong) MBSemester *semester;
@end

@implementation MBSemesterViewController

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
    
    [[MBWebService sharedInstance] setDelegate:self];
    [[MBWebService sharedInstance] loadSemesters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.semester.programs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MBLink *link = [self.semester.programs objectAtIndex:indexPath.row];
    
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
    self.semester = [objects firstObject];
    self.title = self.semester.label;
    
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
