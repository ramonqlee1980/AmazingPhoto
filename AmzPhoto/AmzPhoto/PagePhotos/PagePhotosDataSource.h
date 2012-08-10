//
//  PagePhotosDataSource.h
//  PagePhotosDemo
//
//  Created by junmin liu on 10-8-23.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kPageScrollDone @"kPageScrollDone"

@protocol PagePhotosDataSource

// 有多少页
//
- (int)numberOfPages;

// 每页的图片
//
- (UIImage *)imageAtIndex:(int)index;

@end
