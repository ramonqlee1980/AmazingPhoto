//
//  AppDelegate.m
//  AmzPhoto
//
//  Created by Lee Ramon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "PhotoViewController.h"

@implementation AppDelegate

@synthesize window = _window;
#pragma mark AFPhotoEditorControllerDelegate
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    // Handle the result image here
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    // Handle cancelation here
}

-(void)pageScrollDone
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    //remove current view and add new view
    mPagePhotosView.hidden = YES;
    
    NSLog(@"retainCount:%d",self.window.retainCount);
    self.window.backgroundColor = [UIColor whiteColor];
#if 0
    // Override point for customization after application launch.
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    UIImage *imageToEdit = [UIImage imageNamed:@"Default.png"];
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    //[self presentModalViewController:editorController animated:YES];
    self.window.rootViewController = editorController;
    [editorController release];
#else 
    // Override point for customization after application launch.
    PhotoViewController* rootViewController = [[PhotoViewController alloc] initWithNibName:nil bundle:nil];
    rootViewController.view.frame = [[UIScreen mainScreen] bounds];
    [self.window addSubview:rootViewController.view];
    self.window.rootViewController = rootViewController;
    [rootViewController release];
#endif
    [self.window makeKeyAndVisible];    
}
// 有多少页
//
- (int)numberOfPages {
	return mPageCount;
}

// 每页的图片
//
- (UIImage *)imageAtIndex:(int)index {
	NSString *imageName = [NSString stringWithFormat:@"1933_%d.jpg", index + 1];
	return [UIImage imageNamed:imageName];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window release];
    //add observer for page scroll done event
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pageScrollDone) name:kPageScrollDone object:nil];
    
    mPageCount = 5;
	mPagePhotosView = [[PagePhotosView alloc] initWithFrame: [[UIScreen mainScreen]bounds] withDataSource: self];
	[self.window addSubview:mPagePhotosView];    
	[mPagePhotosView release];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)dealloc
{
    self.window = nil;
    [super dealloc];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
