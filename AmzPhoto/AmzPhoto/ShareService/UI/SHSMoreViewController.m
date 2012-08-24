//
//  MoreViewController.m
//  ShareDemo
//
//  Created by tmy on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SHSMoreViewController.h"
#import "SHSRedirectViewController.h"

@implementation SHSMoreViewController
@synthesize moreActions,redirectServices,parentController;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.redirectServices=nil;
    self.moreActions=nil;
    [_tableView release];
}

#pragma mark - View lifecycle


- (void)loadView
{
    _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.view=_tableView;
    
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelMoreView)];
    self.navigationItem.rightBarButtonItem=cancelBtn;
    [cancelBtn release];
}



- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)cancelMoreView
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num=0;
    if(self.moreActions && [self.moreActions count]>0)
        num+=1;
    if(self.redirectServices && [self.redirectServices count]>0)
        num+=1;
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return [self.moreActions count];
    else
        return [self.redirectServices count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"moreCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    if(indexPath.section==0) {
        cell.textLabel.text=((id<SHSActionProtocol>)[self.moreActions objectAtIndex:indexPath.row]).description;
    } else {
        cell.textLabel.text=((SHSRedirectSharer *)[self.redirectServices objectAtIndex:indexPath.row]).title;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    id item=indexPath.section==0?[self.moreActions objectAtIndex:indexPath.row]:[self.redirectServices objectAtIndex:indexPath.row];
    if([[[item class] description] hasSuffix:@"Action"])
    {
        [item setRootViewController:self];
        [item sendAction:self.parentController.sharedText];
    }
    else
    {
       NSString *url= [((SHSRedirectSharer *)item) getShareUrlWithTitle:self.parentController.sharedtitle withText:self.parentController.sharedText withURL:self.parentController.sharedURL withImageURL:self.parentController.sharedImageURL];
        
        UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:[[[SHSRedirectViewController alloc] initWithUrl:url] autorelease]];
        [self presentModalViewController:navController animated:YES];
        [navController release];
    }
}


@end
