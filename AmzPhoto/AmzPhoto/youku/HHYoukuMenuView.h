//
//  HHYoukuMenuView.h
//  youku
//
//  Created by Eric on 12-3-12.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHYoukuMenuViewDelegate <NSObject>
- (void)meunButtonDown:(id)sender;
@end


#define  kButtonNum  11
@interface HHYoukuMenuView : UIView
{
    UIImageView *rotationView;
    UIImageView *bgView;
    CGRect rect[kButtonNum];
    NSMutableArray *arrayButtonIcon;
    BOOL rotationViewIsNomal;//NO 为不显示状态 
    BOOL isMenuHide;
    id<HHYoukuMenuViewDelegate> mDelegate;
}
@property (nonatomic, retain)  UIImageView *rotationView;
@property (nonatomic, retain)  UIImageView *bgView;
@property (nonatomic, retain)   NSMutableArray *arrayButtonIcon;
-(void)setDelegate:(id<HHYoukuMenuViewDelegate>)delegate;
+ (CGRect)getFrame;
- (BOOL)getisMenuHide;
- (void)showOrHideMenu;
@end
