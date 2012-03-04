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
    // Insert code here to initialize your application
    
    serialOutput = [[SerialOutput alloc] init];
    [serialOutput start];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:serialOutput selector:@selector(writeShit) userInfo:nil repeats:YES];
    
    [serialOutput writeShit];

}

- (void)getColor{
    NSMutableData *responseData = [[NSMutableData data] retain];
    NSURL *baseURL = [[NSURL URLWithString:@"http://store.apple.com"] retain];
    
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://store.apple.com"]];
    [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

@end
