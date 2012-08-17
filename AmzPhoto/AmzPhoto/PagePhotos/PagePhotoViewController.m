//
//  PagePhotoViewController.m
//  AmzPhoto
//
//  Created by Lee Ramon on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PagePhotoViewController.h"
#import "PagePhotosView.h"

@interface PagePhotoViewController ()

@end

@implementation PagePhotoViewController

// 有多少页
//
- (int)numberOfPages {
	return mPageCount;
}

// 每页的图片
//
- (UIView *)viewAtIndex:(int)index {
	NSString *imageName = [NSString stringWithFormat:@"1933_%d.jpg", index + 1];
	UIImage* image = [UIImage imageNamed:imageName];
    return [[[UIImageView alloc] initWithImage:image]autorelease];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mPageCount = 2;
	mPagePhotosView = [[PagePhotosView alloc] initWithFrame: [[UIScreen mainScreen]bounds] withDataSource: self];
	[self.view addSubview:mPagePhotosView];    
	[mPagePhotosView release];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
