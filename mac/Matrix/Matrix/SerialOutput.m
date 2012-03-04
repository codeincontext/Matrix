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

- (void) writeString:(NSString *)string {
    stringToWrite = [[NSString stringWithFormat:@"%@   ",  string] retain];
    if (timer){
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(writeLetter) userInfo:nil repeats:YES];
}

- (void) writeLetter {
    [self writeByte:0x55];    
    [self writeByte:0xAA];
    int index = currentPos++ % [stringToWrite length];
    unichar letter = [stringToWrite characterAtIndex:index];
    
    NSArray *bytes = [self getCharacterBytes:letter];
    
    for (int i=0;i<[bytes count];i++){
        [self writeByte:[[bytes objectAtIndex:i] intValue]];
    }
}

- (NSArray *) getCharacterBytes:(unichar)character {
    
    NSLog(@"char is %c", character);
    if (character == 'a') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'b') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'c') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'd') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111100],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b11111100],nil];
    }
    if (character == 'e') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'f') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'g') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10011111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'h') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'i') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'j') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b11111000],nil];
    }
    if (character == 'k') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b10000100],
                [NSNumber numberWithInt:0b10011000],
                [NSNumber numberWithInt:0b11100000],
                [NSNumber numberWithInt:0b10011000],
                [NSNumber numberWithInt:0b10000110],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'l') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'm') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11000011],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'n') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11000001],
                [NSNumber numberWithInt:0b10100001],
                [NSNumber numberWithInt:0b10010001],
                [NSNumber numberWithInt:0b10001001],
                [NSNumber numberWithInt:0b10000101],
                [NSNumber numberWithInt:0b10000011],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'o') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'p') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'q') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10001001],
                [NSNumber numberWithInt:0b10000101],
                [NSNumber numberWithInt:0b10000011],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'r') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b10110000],
                [NSNumber numberWithInt:0b10001100],
                [NSNumber numberWithInt:0b10000011],nil];
    }
    if (character == 's') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 't') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],nil];
    }
    if (character == 'u') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'v') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],nil];
    }
    if (character == 'w') {
        return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:0b10000001],
            [NSNumber numberWithInt:0b10000001],
            [NSNumber numberWithInt:0b10000001],
            [NSNumber numberWithInt:0b10000001],
            [NSNumber numberWithInt:0b10011001],
            [NSNumber numberWithInt:0b10100101],
            [NSNumber numberWithInt:0b11000011],
            [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'x') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'y') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00010000],[NSNumber numberWithInt:0b00100000],[NSNumber numberWithInt:0b01000000],[NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'z') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b11111111],[NSNumber numberWithInt:0b00000010],[NSNumber numberWithInt:0b00000100],[NSNumber numberWithInt:0b00001000],[NSNumber numberWithInt:0b00010000],[NSNumber numberWithInt:0b00100000],[NSNumber numberWithInt:0b01000000],[NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == '.') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b11000000],nil];
    }
    if (character == ',') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '!') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '#') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],nil];
    }
    if (character == '@') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10011110],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b01111111],nil];
    }
    if (character == ':') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '/') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000010],
                [NSNumber numberWithInt:0b00000100],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00010000],
                [NSNumber numberWithInt:0b00100000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == ';') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '>') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b00110000],
                [NSNumber numberWithInt:0b00001100],
                [NSNumber numberWithInt:0b00000011],
                [NSNumber numberWithInt:0b00000011],
                [NSNumber numberWithInt:0b00001100],
                [NSNumber numberWithInt:0b00110000],
                [NSNumber numberWithInt:0b11000000],nil];
    }

    
    NSLog(@"no match");
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],nil];}
     
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
