//
//  KaixinSharer.m
//  ShareDemo
//
//  Created by mini2 on 2/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "KaixinSharer.h"
#import "NSMutableURLRequest+FormData.h"
#import "SHSAPIKeys.h"

#define url @"http://api.kaixin001.com/records/add.json"
@implementation KaixinSharer

- (id)init
{
    if(self=[super init])
    {
        self.appKey=KAIXIN_APP_KEY;
        self.secretKey=KAIXIN_SECRET_KEY;
    }
    
    return self;
}

- (void)beginRequestForRequestToken
{
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidBeginVerification:)])
        [self.delegate OAuthSharerDidBeginVerification:self];
    
    OAConsumer *comsumer=[[[OAConsumer alloc] initWithKey:_appKey secret:_secretKey] autorelease];
    OAMutableURLRequest *request=[[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:_requestTokenURL] consumer:comsumer token:nil realm:nil signatureProvider:_signatureProvider];
    
    [request setHTTPMethod:@"GET"];
    
    if(![self.callbackURL isEqualToString:@""])
        [request setOAuthParameterName:@"oauth_callback" withValue:self.callbackURL];
    
    [request setURL:[NSURL URLWithString:[_requestTokenURL stringByAppendingFormat:@"?scope=%@",[@"basic create_records" URLEncodedString]]]];
    [comsumer release];
    
    OAAsynchronousDataFetcher *fetcher=[[OAAsynchronousDataFetcher alloc] initWithRequest:request delegate:self didFinishSelector:@selector(tokenRequestTicket:didFinishWithData:) didFailSelector:@selector(tokenRequestTicket:didFailWithError:)];
    [fetcher start];
    [fetcher release];
}


- (void)shareText:(NSString *)text andImage:(UIImage *)image
{
    self.sharedText=text;
    self.sharedImage=image;
    
    if([self isVerified])
    {
        if([self.delegate respondsToSelector:@selector(OAuthSharerDidBeginShare:)])
            [self.delegate OAuthSharerDidBeginShare:self];
        
        OAConsumer *comsumer=[[[OAConsumer alloc] initWithKey:_appKey secret:_secretKey] autorelease];
        OAMutableURLRequest *request=[[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] consumer:comsumer token:_accessToken realm:nil signatureProvider:_signatureProvider];
        request.shareType=ShareTypeTextAndImage;
        [request setHTTPMethod:@"POST"];
        [request setOAuthParameterName:@"content" withValue:text];
        
        NSDictionary *textField=[NSDictionary dictionaryWithObject:text  forKey:@"content"];
        NSDictionary *fileField=[NSDictionary dictionaryWithObject:UIImageJPEGRepresentation(image, 0.6) forKey:@"pic"];
        [request setFormDataWithTextField:textField withFileField:fileField];
        
        [comsumer release];
        
        OAAsynchronousDataFetcher *fetcher=[[OAAsynchronousDataFetcher alloc] initWithRequest:request delegate:self didFinishSelector:@selector(shareRequestTicket:didFinishWithData:) didFailSelector:@selector(shareRequestTicket:didFailWithError:)];
        [fetcher start];
        [fetcher release];
        
    }
    else
    {
        self.pendingShare=ShareTypeTextAndImage;
        [self beginOAuthVerification];
    }
}

- (void)shareText:(NSString *)text
{
    self.sharedText=text;
    
    if([self isVerified])
    {
        if([self.delegate respondsToSelector:@selector(OAuthSharerDidBeginShare:)])
            [self.delegate OAuthSharerDidBeginShare:self];
        
        OAConsumer *comsumer=[[[OAConsumer alloc] initWithKey:_appKey secret:_secretKey] autorelease];
        OAMutableURLRequest *request=[[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] consumer:comsumer token:_accessToken realm:nil signatureProvider:_signatureProvider];
        [request setHTTPMethod:@"POST"];
        [request setOAuthParameterName:@"content" withValue:text];
        request.shareType=ShareTypeText;
        [comsumer release];
        
        OAAsynchronousDataFetcher *fetcher=[[OAAsynchronousDataFetcher alloc] initWithRequest:request delegate:self didFinishSelector:@selector(shareRequestTicket:didFinishWithData:) didFailSelector:@selector(shareRequestTicket:didFailWithError:)];
        [fetcher start];
        [fetcher release];
        
    }
    else
    {
        self.pendingShare=ShareTypeText;
        [self beginOAuthVerification];
    }
}

- (void)shareRequestTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data
{
    DataStatistic *stat = [[DataStatistic alloc] init];
    [stat sendStatistic:self.sharedUrl site:@"kaixin"];
    [stat release];
    
    NSString *responseStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [responseStr release];
    self.sharedText=nil;
    self.sharedImage=nil;
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidFinishShare:)])
        [self.delegate OAuthSharerDidFinishShare:self];
}

- (void)shareRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error
{
    if([self.delegate respondsToSelector:@selector(OAuthSharerDidFailShare:)])
        [self.delegate OAuthSharerDidFailShare:self];
}
@end
