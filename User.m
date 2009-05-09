//
//  User.m
//  pairingTimer
//
//  Created by Hanjo Meyer-Rieke on 08.05.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize name,inputSource;

- (id)initWithName:(NSString*)aName{
	[super init];
	self.name = aName;
	return self;
}
@end
