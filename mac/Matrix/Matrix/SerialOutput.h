//
//  SerialOutput.h
//  MacLight
//
//  Created by Adam Howard on 14/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// import IOKit headers
#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>

@interface SerialOutput : NSObject{
    NSString *selectedSerialPort;
    NSMutableArray *serialPortList;
    
	struct termios gOriginalTTYAttrs; // Hold the original termios attributes so we can reset them on quit ( best practice )
	int serialFileDescriptor; // file handle to the serial port
}

- (NSString *) openSerialPort: (NSString *)serialPortFile baud: (speed_t)baudRate;
- (void) loadSerialPortList;
- (void) writeColor: (NSColor *)color;
- (void) writeByte: (int) val;
- (void) start;
@end
