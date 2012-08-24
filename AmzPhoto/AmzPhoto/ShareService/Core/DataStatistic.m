//
//  DataStatistic.m
//  ShareDemo
//
//  Created by Buzzinate Buzzinate on 12-2-28.
//  Copyright (c) 2012年 Buzzinate Co. Ltd. All rights reserved.
//

#import "DataStatistic.h"
#import "SHSAPIKeys.h"

@implementation DataStatistic

- (NSString*)URLEncodedString:(NSString*)input  
{  
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,  
                                                                           (CFStringRef)input,  
                                                                           NULL,  
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),  
                                                                           kCFStringEncodingUTF8);  
    [result autorelease];  
    return result;  
} 

- (void)sendStatistic:(NSString *)url site:(NSString *)site {
    NSString *publisherUuid = PUBLISHER_UUID;
    if (!publisherUuid) {
        publisherUuid = @"";
    }
    if (!url){
        url =@"";
    }
    NSString *template = @"http://api.bshare.cn/share/stats.json?site=%@&publisherUuid=%@&url=%@&type=11";
    
    NSString *myRequestString = [NSString stringWithFormat:template, site, publisherUuid, [self URLEncodedString:url]];

    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: myRequestString]];
    [ request setHTTPMethod: @"GET" ]; 
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSString* aStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                               NSLog(@"aStr = %@",aStr);
                               [aStr release];
                           }];

   
    [request release];
}



@end
