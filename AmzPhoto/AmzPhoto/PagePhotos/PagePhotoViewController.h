//
//  PagePhotoViewController.h
//  AmzPhoto
//
//  Created by Lee Ramon on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
#import "PagePhotosView.h"



@interface PagePhotoViewController : UIViewController<PagePhotosDataSource>
{
    NSInteger mPageCount;
    PagePhotosView *mPagePhotosView;
}
@end
