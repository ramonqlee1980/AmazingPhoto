//
//  SHSSafariAction.m
//  ShareDemo
//
//  Created by mini2 on 29/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SHSSafariAction.h"

@implementation SHSSafariAction

@synthesize rootViewController,description;

- (BOOL)sendAction:(id)content
{
    NSString *url=content;
    if(url==nil || [url isEqualToString:@""] || ![url hasPrefix:@"http://"])
        return NO;
    else
        return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)dealloc
{
    self.description=nil;
    [super dealloc];
}

@end
