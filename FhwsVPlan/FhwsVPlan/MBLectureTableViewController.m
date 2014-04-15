//
//  MBLectureTableViewController.m
//  FhwsVPlan
//
//  Created by Markus on 15.04.14.
//  Copyright (c) 2014 MBulli. All rights reserved.
//

#import "MBLectureTableViewController.h"

#import "UIImageView+AFNetworking.h"

#import "Models.h"

@interface MBLectureTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) MBLecturer *lecturer;
@end

@implementation MBLectureTableViewController

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
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 5;
        case 1: return self.lecturer.modules.count;
        default: return 0;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return @"";
        case 1: return @"Module";
        default: return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"subtitleCell" forIndexPath:indexPath];
        
        NSString *title = nil;
        NSString *subTitle = nil;
        switch (indexPath.row) {
            case 0:
                subTitle = @"Name";
                title = [NSString stringWithFormat:@"%@ %@ %@", self.lecturer.title, self.lecturer.firstname, self.lecturer.lastname];
                break;
            case 1:
                subTitle = @"Funktion";
                title = self.lecturer.function;
                break;
            case 2:
                subTitle = @"Sprechstunde";
                title = self.lecturer.consultationdate;
                break;
            case 3:
                subTitle = @"Phone";
                title = self.lecturer.phone;
                break;
            case 4:
                subTitle = @"Mail";
                title = self.lecturer.email;
                break;
            default:
                break;
        }
        
        cell.textLabel.text = title;
        cell.detailTextLabel.text = subTitle;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        MBLink *link = [self.lecturer.modules objectAtIndex:indexPath.row];
        
        cell.textLabel.text = link.label;
    }
    
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
    self.lecturer = [objects firstObject];
    self.title = @"Dozent";
    
    [self.imageView setImageWithURL:self.lecturer.imageurl];

    
    [self.tableView reloadData];
}


@end
