//
//  AppDelegate.h
//  AmzPhoto
//
//  Created by Lee Ramon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPhotoEditorController.h"


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,AFPhotoEditorControllerDelegate>
{

    UINavigationController* mNavi;
}
@property (retain, nonatomic) UIWindow *window;

@end
