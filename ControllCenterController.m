#import "ControllCenterController.h"


@implementation ControllCenterController
@synthesize timeObject;

- (IBAction)startTimer:(id) sender {
	NSLog(@"%d",[sender state]);
	if ([sender state] == NSOnState) {
		time = [zeitEingabe intValue] * 60;
		durchlaeufe = [durchlaufEingabe intValue];
		NSLog(@"%d",time);
		[self startTimer];
	} else {
		[ticker invalidate];
		[self genug:self];
	}
}

-(void)startTimer{
	[self toggleInterface];
	[durchlaufLabel setIntValue:durchlaeufe];
	[self performSelector:@selector(switchUser) withObject:nil afterDelay:time];
	[self startTicker];
	
}

- (void)toggleInterface {
	[zeitEingabe setEnabled:![zeitEingabe isEnabled]];
	[durchlaufEingabe setEnabled:![durchlaufEingabe isEnabled]];
}

- (void)switchUser{
	[ticker invalidate];
	if (durchlaeufe > 0) {
		durchlaeufe--;
		[messageLabel setStringValue:@"Der nächste Bitte!"];
	} else {
		durchlaeufe = [durchlaufEingabe intValue];
		[messageLabel setStringValue:@"Zeit für ne Pause!"];
	}
	[alertWindow makeKeyAndOrderFront:nil]; 
}

- (IBAction)weiter:(id)sender{
	[self hideWindow];
	[self startTimer];
}

- (IBAction)genug:(id)sender{
	[self hideWindow];
	[self toggleInterface];
	[NSObject cancelPreviousPerformRequestsWithTarget:self]; 
}

- (void)hideWindow{
	[alertWindow orderOut:nil];
}

- (void)startTicker{
	ticker = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(tick:) userInfo:nil repeats:YES]; 
	startDate = [[NSDate date] retain]; 
	[ticker fire];
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
