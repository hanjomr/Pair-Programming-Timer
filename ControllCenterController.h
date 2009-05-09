#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface ControllCenterController : NSWindowController {
	IBOutlet NSTextField *zeitEingabe;
	IBOutlet NSTextField *durchlaufEingabe;
	IBOutlet NSTextField *elapsedTimeLabel;
	IBOutlet NSTextField *durchlaufLabel;
	IBOutlet NSTextField *messageLabel;
	IBOutlet NSButton *goButton;
	IBOutlet NSPanel *alertWindow;
	IBOutlet NSPopUpButton *ersterKeyboardPopUp;
	IBOutlet NSPopUpButton *zweiterKeyboardPopUp;
	IBOutlet NSTextField *ersterName;
	IBOutlet NSTextField *zweiterName;
	
	TISInputSourceRef erstesKeboardLayout;
	NSArray *users;
	NSWindow *mainWindow;
	NSTimer *ticker;
	NSDate *startDate;
	int time;
	NSNumber *timeObject;
	int durchlaeufe;
}

- (void)toggleInterface;
- (void)hideWindow;
- (IBAction)weiter:(id)sender;
- (IBAction)genug:(id)sender;
- (void)startTimer;
- (IBAction)startTimer:(id) sender;
- (void)switchUser;
- (void)tick:(NSTimer *)theTimer;
- (void)startTicker;
- (void)setTimeLabelTo:(int)minutes and:(int)seconds;

@property (nonatomic,retain) NSNumber *timeObject;
@property (nonatomic,retain) NSArray *users;
@end
