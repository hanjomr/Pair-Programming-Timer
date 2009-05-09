#import "ControllCenterController.h"
#import "User.h"

@implementation ControllCenterController
@synthesize users;

- (void)awakeFromNib {
	NSLog(@"laoding");
	NSDictionary *properties = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@", kTISTypeKeyboardLayout] forKey:(NSString*)kTISPropertyInputSourceType];
	CFArrayRef a = TISCreateInputSourceList((CFDictionaryRef)properties, NO);
	NSArray *ary = [NSArray arrayWithArray:(NSArray*)a];
	NSMenu *menu1 = [[NSMenu alloc] initWithTitle:@"KeyboardLayout"];
	NSMenu *menu2 = [[NSMenu alloc] initWithTitle:@"KeyboardLayout"];
	for (id loopItem in ary) {
		TISInputSourceRef ips = (TISInputSourceRef)loopItem;
		NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:TISGetInputSourceProperty(ips, kTISPropertyLocalizedName) action:NULL keyEquivalent:@""];
		NSMenuItem *item2 = [[NSMenuItem alloc] initWithTitle:TISGetInputSourceProperty(ips, kTISPropertyLocalizedName) action:NULL keyEquivalent:@""];
		NSImage *i = [[NSImage alloc] initWithIconRef:TISGetInputSourceProperty(ips, kTISPropertyIconRef)];
		[item1 setRepresentedObject:loopItem];
		[item2 setRepresentedObject:loopItem];
		[item1 setImage:i];
		[item2 setImage:i];
		[menu1 addItem:item1];
		[menu2 addItem:item2];
	}
	[ersterKeyboardPopUp setMenu:menu1];
	[zweiterKeyboardPopUp setMenu:menu2];
	[alertWindow setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
}

#pragma mark -
#pragma mark Actions

- (IBAction)go:(id) sender {
	if ([sender state] == NSOnState) {
		[self gatherDataFromUI];
		[self startTimer];
		[self nextUser];
	} else {
		[ticker invalidate];
		[self genug:self];
	}
}

- (IBAction)weiter:(id)sender{
	[self hideAlert];
	[self startTimer];
}

- (IBAction)genug:(id)sender{
	[goButton setState:NSOffState];
	[self hideAlert];
	[self toggleInputElements];
	[NSObject cancelPreviousPerformRequestsWithTarget:self]; 
}

- (void)nextUser{
	iteration++;
	User *u = [users objectAtIndex:iteration%2];
	TISSelectInputSource(u.inputSource );
	[messageLabel setStringValue:[NSString stringWithFormat:@"Jetzt ist %@ dran!",u.name]];
	[currentUserLabel setStringValue:[NSString stringWithFormat:@"%@ ist gerade dran",u.name]];
}

-(void)gatherDataFromUI{
	time = [zeitEingabe intValue] * 60;
	durchlaeufe = [durchlaufEingabe intValue];
	User *u1 = [[User alloc] initWithName:[ersterName stringValue]];
	u1.inputSource = (TISInputSourceRef) [[ersterKeyboardPopUp selectedItem] representedObject];
	User *u2 = [[User alloc] initWithName:[zweiterName stringValue]];
	u2.inputSource = (TISInputSourceRef) [[zweiterKeyboardPopUp selectedItem] representedObject];
	self.users = [NSArray arrayWithObjects:u1,u2,nil];
}

-(void)startTimer{
	[self toggleInputElements];
	[durchlaufLabel setIntValue:durchlaeufe];
	[self performSelector:@selector(showAlert) withObject:nil afterDelay:time];
	ticker = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(tick:) userInfo:nil repeats:YES]; 
	startDate = [[NSDate date] retain]; 
	[ticker fire];
}

- (void)toggleInputElements {
	BOOL enabled = ![zeitEingabe isEnabled];
	[zeitEingabe setEnabled:enabled];
	[durchlaufEingabe setEnabled:enabled];
	[ersterKeyboardPopUp setEnabled:enabled];
	[zweiterKeyboardPopUp setEnabled:enabled];
	[ersterName setEnabled:enabled];
	[zweiterName setEnabled:enabled];
	
}

- (void)showAlert{
	[ticker invalidate];
	if (durchlaeufe > 0) {
		durchlaeufe--;
		[self nextUser];
	} else {
		durchlaeufe = [durchlaufEingabe intValue];
		[messageLabel setStringValue:@"Zeit für ne Pause!"];
	}
	
	[alertWindow makeKeyAndOrderFront:nil];
}

- (void)hideAlert{
	[alertWindow orderOut:nil];
}

- (void)tick:(NSTimer *)theTimer {
    NSTimeInterval myInterval = -[startDate timeIntervalSinceNow];
    int seconds = ((int) myInterval) % 60;
    int minutes = ((int) (myInterval - seconds) / 60) % 60;
	[self setTimeLabelTo:minutes and:seconds];
    
}

- (void) setTimeLabelTo:(int)minutes and:(int)seconds{
	int minute = (time/60) - minutes - 1;
	int second = 60 - seconds - 1;
	[elapsedTimeLabel setStringValue:[NSString stringWithFormat:@"%.2d:%.2d", minute, second]];
}
@end
