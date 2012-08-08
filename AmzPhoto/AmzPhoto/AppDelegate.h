//
//  AppDelegate.h
//  AmzPhoto
//
//  Created by Lee Ramon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPhotoEditorController.h"
#import "PagePhotosDataSource.h"
#import "PagePhotosView.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,AFPhotoEditorControllerDelegate,PagePhotosDataSource>
{
    NSInteger mPageCount;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
