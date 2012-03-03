//
//  SerialOutput.m
//  MacLight
//
//  Created by Adam Howard on 14/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SerialOutput.h"

@implementation SerialOutput

//- (id) init
//{
//    self = [super init];
//    myMember = [AnotherClass new];
//    return self;
//}

-(void)start{
    
	// we don't have a serial port open yet
	serialFileDescriptor = -1;
	
	[self loadSerialPortList];
    
    for (NSString *serialPort in serialPortList) {
        NSLog(@"Found a port: %@", serialPort);
        if ([serialPort rangeOfString:@"usbserial"].location != NSNotFound || [serialPort rangeOfString:@"usbmodem"].location != NSNotFound) {
            selectedSerialPort = serialPort;
            NSLog(@"Found an arduino: %@", serialPort);
        }
    }
    [self openSerialPort: selectedSerialPort baud:9600];
}

// open the serial port
//   - nil is returned on success
//   - an error message is returned otherwise
- (NSString *) openSerialPort: (NSString *)serialPortFile baud: (speed_t)baudRate {
	int success;
	
	// close the port if it is already open
	if (serialFileDescriptor != -1) {
		close(serialFileDescriptor);
		serialFileDescriptor = -1;
        
		// re-opening the same port REALLY fast will fail spectacularly... better to sleep a sec
		sleep(0.5);
	}
	
	// c-string path to serial-port file
	const char *bsdPath = [serialPortFile cStringUsingEncoding:NSUTF8StringEncoding];
	
	// Hold the original termios attributes we are setting
	struct termios options;
	
	// receive latency ( in microseconds )
	unsigned long mics = 3;
	
	// error message string
	NSString *errorMessage = nil;
	
	// open the port
	//     O_NONBLOCK causes the port to open without any delay (we'll block with another call)
	serialFileDescriptor = open(bsdPath, O_RDWR | O_NOCTTY | O_NONBLOCK );
	
	if (serialFileDescriptor == -1) { 
		// check if the port opened correctly
		errorMessage = @"Error: couldn't open serial port";
	} else {
		// TIOCEXCL causes blocking of non-root processes on this serial-port
		success = ioctl(serialFileDescriptor, TIOCEXCL);
		if ( success == -1) { 
			errorMessage = @"Error: couldn't obtain lock on serial port";
		} else {
			success = fcntl(serialFileDescriptor, F_SETFL, 0);
			if ( success == -1) { 
				// clear the O_NONBLOCK flag; all calls from here on out are blocking for non-root processes
				errorMessage = @"Error: couldn't obtain lock on serial port";
			} else {
				// Get the current options and save them so we can restore the default settings later.
				success = tcgetattr(serialFileDescriptor, &gOriginalTTYAttrs);
				if ( success == -1) { 
					errorMessage = @"Error: couldn't get serial attributes";
				} else {
					// copy the old termios settings into the current
					//   you want to do this so that you get all the control characters assigned
					options = gOriginalTTYAttrs;
					
					/*
					 cfmakeraw(&options) is equivilent to:
					 options->c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
					 options->c_oflag &= ~OPOST;
					 options->c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
					 options->c_cflag &= ~(CSIZE | PARENB);
					 options->c_cflag |= CS8;
					 */
					cfmakeraw(&options);
					
					// set tty attributes (raw-mode in this case)
					success = tcsetattr(serialFileDescriptor, TCSANOW, &options);
					if ( success == -1) {
						errorMessage = @"Error: couldn't set serial attributes";
					} else {
						// Set baud rate (any arbitrary baud rate can be set this way)
						success = ioctl(serialFileDescriptor, IOSSIOSPEED, &baudRate);
						if ( success == -1) { 
							errorMessage = @"Error: Baud Rate out of bounds";
						} else {
							// Set the receive latency (a.k.a. don't wait to buffer data)
							success = ioctl(serialFileDescriptor, IOSSDATALAT, &mics);
							if ( success == -1) { 
								errorMessage = @"Error: couldn't set serial latency";
							}
						}
					}
				}
			}
		}
	}
	
	// make sure the port is closed if a problem happens
	if ((serialFileDescriptor != -1) && (errorMessage != nil)) {
		close(serialFileDescriptor);
		serialFileDescriptor = -1;
	}
	
	return errorMessage;
}

- (void) writeColor: (NSColor *) color {
    [self writeByte:0x55];    
    [self writeByte:0xAA];
    
    int val;
    val = [color redComponent]*255*0.9;
    [self writeByte:val];
    
    val = [color greenComponent]*255;
    [self writeByte:val];
    
    val = [color blueComponent]*255;
    [self writeByte:val];
}

- (void) writeByte: (int)val {
	if(serialFileDescriptor!=-1) {
		write(serialFileDescriptor, &val, 1);
	} else {
		NSLog(@"Tried to write byte but no Serial Port found");
	}
}

- (void) loadSerialPortList {
	io_object_t serialPort;
	io_iterator_t serialPortIterator;
	
	serialPortList = [[NSMutableArray alloc] init];
	
	// ask for all the serial ports
	IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching(kIOSerialBSDServiceValue), &serialPortIterator);
	
	// loop through all the serial ports and add them to the array
	while ((serialPort = IOIteratorNext(serialPortIterator))) {
		[serialPortList addObject:
         [(NSString*)IORegistryEntryCreateCFProperty(serialPort, CFSTR(kIOCalloutDeviceKey),  kCFAllocatorDefault, 0) autorelease]];
        
		IOObjectRelease(serialPort);
	}
    
	IOObjectRelease(serialPortIterator);
}

//// action sent when serial port selected
//- (IBAction) serialPortSelected: (id) cntrl {
//	// open the serial port
//	NSString *error = [serialOutput openSerialPort: selectedSerialPort baud:9600];
//	
//	if(error!=nil) {
//		NSLog(error);
//	} else {
//	}
//}

@end
