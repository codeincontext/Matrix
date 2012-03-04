//
//  MXAppDelegate.m
//  Matrix
//
//  Created by Adam Howard on 03/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MXAppDelegate.h"

@implementation MXAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    serialOutput = [[SerialOutput alloc] init];
    [serialOutput start];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(pollForContent) userInfo:nil repeats:YES];
    [self pollForContent];
}

- (void)pollForContent{
    responseData = [[NSMutableData data] retain];
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://matrix.skatty.me/api"]];
    [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail");

    [[NSAlert alertWithError:error] runModal];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Once this method is invoked, "responseData" contains the complete result
    NSLog(@"it's all finished loading innit");
//    NSString *stringToPrint = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError *jsonError = nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
    NSLog(@"parsingdinished");

    if (jsonError) {
        NSLog(@"error in parsing");

        NSLog(@"JSON error %@", [jsonError description]);
    } else {
        NSLog(@"no error in json parsing");

        NSString *stringToPrint = [responseDict objectForKey:@"text"];
        if (stringToPrint.length > 0) {
            NSLog(@"string to print: %@", stringToPrint);
            [serialOutput writeString:stringToPrint];
        } else {
            [serialOutput writeValue:[responseDict objectForKey:@"value"]];
        }

    }
//    

}

@end
