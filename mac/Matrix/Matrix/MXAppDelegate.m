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
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:serialOutput selector:@selector(writeShit) userInfo:nil repeats:YES];
    
    
//    [timer ];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//	dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue); //run event handler on the default global queue
//	dispatch_time_t now = dispatch_walltime(DISPATCH_TIME_NOW, 0);
//	dispatch_source_set_timer(timer, now, 140ull * NSEC_PER_MSEC, 5000ull);
//	dispatch_source_set_event_handler(timer, ^{
//		[serialOutput writeShit];
        //		NSLog(@"%d %d %d %d", [yaw intValue], [pitch intValue], [throttleJoystick intValue], [trim intValue]);
//		if ([[NSApp delegate] isSerialPortConnected] == YES) {
//            
//			// set Status to green.
//		} else {
//			[self stopTimer];
//			// set status to red.
//		}
//	});
    
    
	// now that our timer is all set to go, start it
//	dispatch_resume(timer);
}

@end
