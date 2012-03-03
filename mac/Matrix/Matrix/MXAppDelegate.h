//
//  MXAppDelegate.h
//  Matrix
//
//  Created by Adam Howard on 03/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "SerialOutput.h"

@interface MXAppDelegate : NSObject <NSApplicationDelegate>{
@private
    SerialOutput *serialOutput;
}

@property (assign) IBOutlet NSWindow *window;

@end
