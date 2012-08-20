//
//  HHYoukuMenuView.m
//  youku
//
//  Created by Eric on 12-3-12.
//  Copyright (c) 2012年 Tian Tian Tai Mei Net Tech (Bei Jing) Lt.d. All rights reserved.
//

#import "HHYoukuMenuView.h"
#import <QuartzCore/QuartzCore.h>
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


@implementation HHYoukuMenuView
@synthesize rotationView,arrayButtonIcon,bgView;


- (void)dealloc
{
    [bgView release];
    [arrayButtonIcon release];
    [rotationView release];
    [super dealloc];
}

+ (CGRect)getFrame
{
    return CGRectMake((320.0 - 296.0)/2.0,460.0 - 148.0 + 14,296.0,148.0);
}

+ (CGRect)getHideFrame
{
    return CGRectMake((320.0 - 296.0)/2.0,500,296.0,148.0);;//CGRectMake((320.0 - 296.0)/2.0,460.0,296.0,148.0);
}

- (void)setButtonsFrame
{
    rect[0] =  CGRectMake(251,93,25,25);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mvideo.png",@"nomal",
                         @"mvideoh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[1] =  CGRectMake(224,52,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mserial.png",@"nomal",
                         @"mserialh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[2] =  CGRectMake(186,22,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mmovie.png",@"nomal",
           @"mmovieh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[3] =  CGRectMake(136,10,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mrank.png",@"nomal",
           @"mrankh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[4] =  CGRectMake(85,22,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mcartoon.png",@"nomal",
           @"mcartoonh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[5] =  CGRectMake(43,52,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"menter.png",@"nomal",
           @"menterh.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[6] =  CGRectMake(18,93,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mmusic.png",@"nomal",
           @"mmusich.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
    
    //////////////////////////////////////////////////////////////////////////////
    
    rect[7] =  CGRectMake(207,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mmyi.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[8] =  CGRectMake(136,54,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mmenu.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[9] =  CGRectMake(63,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"msearch.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    ///////////////////////////////////////////////////////////////////////////////
    rect[10] =  CGRectMake(134,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"mhome.png",@"nomal",
           @"mhomel.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
}

- (void)initView
{
    bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu1.png"]];
    bgView.frame = CGRectMake(53.0,49.0,191.0, 86.0);
    [self addSubview:bgView];
    [bgView release];
    
    rotationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu2.png"]];
    rotationView.frame = CGRectMake(0.0, 0.0+ 148.0/2.0,296, 148);
    rotationView.userInteractionEnabled = YES;
    rotationView.layer.anchorPoint = CGPointMake(0.5,1.0);
    if (rotationViewIsNomal)
    {
        rotationView.layer.transform = CATransform3DIdentity;
    }
    else
    {
        rotationView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(180),0.0, 0.0, 1.0);;
    }
    [self addSubview:rotationView];
    [rotationView release];
    
    for (int i = 0;i<7;i++) 
    {
        NSDictionary *dic = [arrayButtonIcon objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect[i];
        if ([dic objectForKey:@"nomal"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"nomal"]] forState:UIControlStateNormal];
        }
        if ([dic objectForKey:@"high"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"high"]] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(meunButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.showsTouchWhenHighlighted = YES;
        [rotationView  addSubview:button];
    }
    
    for (int i = 7;i < 11 ;i++ )
    {
        NSDictionary *dic = [arrayButtonIcon objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect[i];
        if ([dic objectForKey:@"nomal"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"nomal"]] forState:UIControlStateNormal];
        }
        if ([dic objectForKey:@"high"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"high"]] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(meunButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.showsTouchWhenHighlighted = YES;
        [self  addSubview:button];
    }
}


- (void)meunButtonDown:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 8)
    {
        //kIsAdShow;
        button.userInteractionEnabled = NO;
        [UIView beginAnimations:@"present-countdown" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDidStopSelector:@selector(rotationAnimationStop)];
        CGFloat angle = rotationViewIsNomal ? 180.0:0.0;
        rotationView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(angle),0.0, 0.0, 1.0);
        [UIView commitAnimations];
    }
    else if(button.tag == 10)
    {
        [self showOrHideMenu];
    }
}

- (void)rotationAnimationStop
{
    UIButton *menuButton =  (UIButton *)[self viewWithTag:8];
    menuButton.userInteractionEnabled = YES;
    rotationViewIsNomal = !rotationViewIsNomal;
}

- (void)hideMenuAnimationStop
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        rotationViewIsNomal = NO;
        isMenuHide = NO;
        arrayButtonIcon = [[NSMutableArray alloc]init];
        [self setButtonsFrame];
        [self initView];
    }
    return self;
}

- (void)showOrHideMenu
{
    [UIView beginAnimations:@"present-countdown" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideMenuAnimationStop)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    if (!isMenuHide) 
    {
        self.frame = [HHYoukuMenuView getHideFrame];
    }
    else
    {
        self.frame = [HHYoukuMenuView getFrame];
    }
    isMenuHide = !isMenuHide;
    [UIView commitAnimations];
}

- (BOOL)getisMenuHide
{
    return isMenuHide;
}


@end
