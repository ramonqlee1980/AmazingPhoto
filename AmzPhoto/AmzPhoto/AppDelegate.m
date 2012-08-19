//
//  AppDelegate.m
//  AmzPhoto
//
//  Created by Lee Ramon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PagePhotoViewController.h"
#import "PhotoViewController.h"
#import "ShowcaseFilterViewController.h"

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
    [mNavi popToRootViewControllerAnimated:YES];
    NSLog(@"retainCount:%d",self.window.retainCount);
    self.window.backgroundColor = [UIColor whiteColor];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window release];
    //add observer for page scroll done event
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pageScrollDone) name:kPageScrollDone object:nil];    
#if 0
    // Override point for customization after application launch.
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    UIImage *imageToEdit = [UIImage imageNamed:@"Default.png"];
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    [editorController setDelegate:self];
    mNavi = [[UINavigationController alloc]initWithRootViewController:editorController];
    //[self presentModalViewController:editorController animated:YES];
    //self.window.rootViewController = editorController;
    [editorController release];
#else 
    // Override point for customization after application launch.
    //PhotoViewController* rootViewController = [[PhotoViewController alloc] initWithNibName:nil bundle:nil];
    ShowcaseFilterViewController *rootViewController = [[ShowcaseFilterViewController alloc] initWithFilterType:GPUIMAGE_SATURATION];
    rootViewController.view.frame = [[UIScreen mainScreen] bounds];
    mNavi = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    //[self.window addSubview:rootViewController.view];
    //self.window.rootViewController = rootViewController;
    [rootViewController release];
#endif
    mNavi.navigationBarHidden = YES;
    
    //PagePhotoViewController* page = [[PagePhotoViewController alloc]init];        
    //[mNavi pushViewController:page animated:NO];
    //[page release];  
    
    [self.window addSubview:mNavi.view];    
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)dealloc
{
    self.window = nil;
    [mNavi release];
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
