#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
@class User;
@interface ControllCenterController : NSWindowController {
	IBOutlet NSTextField *zeitEingabe;
	IBOutlet NSTextField *durchlaufEingabe;
	IBOutlet NSTextField *elapsedTimeLabel;
	IBOutlet NSTextField *durchlaufLabel;
	IBOutlet NSTextField *messageLabel;
	IBOutlet NSTextField *currentUserLabel;
	IBOutlet NSButton *goButton;
	IBOutlet NSPanel *alertWindow;
	IBOutlet NSPopUpButton *ersterKeyboardPopUp;
	IBOutlet NSPopUpButton *zweiterKeyboardPopUp;
	IBOutlet NSTextField *ersterName;
	IBOutlet NSTextField *zweiterName;
	
	NSArray *users;
	NSWindow *mainWindow;
	NSTimer *ticker;
	NSDate *startDate;
	NSInteger time;
	int durchlaeufe;
	NSUInteger iteration;
}

- (void)gatherDataFromUI;
- (void)toggleInputElements;

- (void)hideAlert;
- (void)showAlert;

- (IBAction)weiter:(id)sender;
- (IBAction)genug:(id)sender;
- (IBAction)go:(id) sender;

- (void)startTimer;
- (void)tick:(NSTimer *)theTimer;

- (void)setTimeLabelTo:(int)minutes and:(int)seconds;
- (void)nextUser;

@property (nonatomic,retain) NSArray *users;
@end
