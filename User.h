//
//  User.h
//  pairingTimer
//
//  Created by Hanjo Meyer-Rieke on 08.05.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface User : NSObject {
	NSString *name;
	TISInputSourceRef inputSource;
}

- (id)initWithName:(NSString*)aName;

@property (nonatomic, retain) NSString *name;
@property (nonatomic) TISInputSourceRef inputSource;

@end
