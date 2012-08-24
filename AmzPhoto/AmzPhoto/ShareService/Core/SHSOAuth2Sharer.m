//
//  SHSOAuth2Sharer.m
//  ShareDemo
//
//  Created by tmy on 11-11-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "SHSOAuth2Sharer.h"
#import "SHSAuthorization2Controller.h"

@implementation SHSOAuth2Sharer
@synthesize oauthType,name,delegate,rootViewController,autherizeURL=_autherizeURL,callbackURL,appKey=_appKey,secretKey=_secretKey,accessToken=_accessToken,pendingShare,sharedText,sharedImage, sharedUrl;


- (id)init
{
    if(self=[super init])
    {
        self.pendingShare=-1;
    }
    
    return self;
}

- (void)dealloc
{
    self.appKey=nil;
    self.secretKey=nil;
    self.autherizeURL=nil;
    self.callbackURL=nil;
    self.accessToken=nil;
    [super dealloc];
}

- (void)beginOAuthVerification
{
    [self beginRequestForAccessToken];
}

- (void)beginRequestForAccessToken
{
//    SHSAuthorization2Controller *authorizationController=[[SHSAuthorization2Controller alloc] init];
//    authorizationController.authorizationURL=[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=token",_autherizeURL,_appKey,self.callbackURL];
//    authorizationController.authorizationDelegate=self;
//    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:authorizationController];
//    if(self.rootViewController)
//        [self.rootViewController presentModalViewController:navController animated:YES];
//    [authorizationController release];
//    [navController release];
}

- (void)SaveToken
{

#ifdef TARGET_IPHONE_SIMULATOR
    [[NSUserDefaults standardUserDefaults] setValue:_accessToken.key forKey:[NSString stringWithFormat:@"%@_%@",self.name,@"accessToken"]];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:_expireTime] forKey:[NSString stringWithFormat:@"%@_%@",self.name,@"expireTime"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
#else
    [SFHFKeychainUtils storeUsername: [NSString stringWithFormat:@"%@_%@",self.name,@"accessToken"] andPassword:_accessToken.key forServiceName: _name updateExisting: YES  error: nil];
    [SFHFKeychainUtils storeUsername: [NSString stringWithFormat:@"%@_%@",self.name,@"expireTime"] andPassword: [NSString stringWithFormat:@"%f",_expireTime] forServiceName: _name updateExisting: YES  error: nil]; 
#endif
}


- (BOOL)isVerified
{
    NSString *accessToken=nil;
    NSTimeInterval expireTime=0;
    NSTimeInterval now=[NSDate timeIntervalSinceReferenceDate];
#ifdef TARGET_IPHONE_SIMULATOR
    accessToken= [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",self.name,@"accessToken"]];
    expireTime= [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",self.name,@"expireTime"]] floatValue];
#else
    accessToken= [SFHFKeychainUtils getPasswordForUsername: [NSString stringWithFormat:@"%@_%@",self.name,@"accessToken"] andServiceName: _name error:nil];
    expireTime= [[SFHFKeychainUtils getPasswordForUsername:[NSString stringWithFormat:@"%@_%@",self.name,@"expireTime"] andServiceName: _name error:nil] floatValue];
#endif
    
    if(accessToken!=nil && expireTime!=0 && now<expireTime)
    {
        _accessToken=[[OAToken alloc] initWithKey:accessToken secret:@""];
        _expireTime=expireTime;
        return YES;
    }
    else
        return NO;
}


- (void)shareText:(NSString *)text
{
    
}

- (void)shareText:(NSString *)text andImage:(UIImage *)image
{
    
}

#pragma mark - AuthorizationDelegate


- (void)authorizationDidFinishWithAccessToken:(NSString *)token withExpireTime:(NSTimeInterval)expire
{
    _accessToken=[[OAToken alloc] initWithKey:token secret:@""];
    _expireTime=[NSDate timeIntervalSinceReferenceDate]+expire;
    [self SaveToken];
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidFinishVerification:)])
        [self.delegate OAuthSharerDidFinishVerification:self];
    
    switch (self.pendingShare) {
        case ShareTypeText:
            [self shareText:self.sharedText];
            break;
        default:
            break;
    }
    self.pendingShare=-1;
}



- (void)authorizationDidCancel
{
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidCancelVerification:)])
        [self.delegate OAuthSharerDidCancelVerification:self];
}

- (void)authorizationDidFail
{
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidFailInVerification:)])
        [self.delegate OAuthSharerDidFailInVerification:self];
}


@end
