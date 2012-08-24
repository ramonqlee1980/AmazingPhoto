//
//  SHSAction.h
//  ShareDemo
//
//  Created by tmy on 11-11-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SHSActionProtocol <NSObject>

@property (nonatomic,retain) NSString *description;
@property (nonatomic,assign) UIViewController *rootViewController;

- (BOOL)sendAction:(id)content;

@end