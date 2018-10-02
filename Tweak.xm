@interface UIDictationController : NSObject
+ (UIDictationController *)sharedInstance;
-(void)switchToDictationInputModeWithTouch:(id)arg1 ;
@end

@interface UIKeyboardDockView  : UIView
@end

@interface UISystemKeyboardDockController : UIViewController
@property (nonatomic,retain) UIKeyboardDockView * dockView;
@end

%hook UISystemKeyboardDockController
	-(void)loadView 
	{
		%orig;
		//NSLog(@"[LeftyDictation]----UISystemKeyboardDockController->loadView----------------------------------------");
		//NSLog(@"[LeftyDictation]--------------------self:%@---------------------------------------------------------",self);
		//NSLog(@"[LeftyDictation]--------------------[self dockView]:%@----------------------------------------------",[self dockView]);
		
		UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activateDictation)] autorelease];
		singleTap.numberOfTapsRequired = 1; 
		[[self dockView] addGestureRecognizer:singleTap];
	}
%new
	- (void)activateDictation//:(UITapGestureRecognizer *)recognizer {
		{
		//NSLog(@"[LeftyDictation]--------------------activateDictation---------------------------------");
		[[objc_getClass("UIDictationController") sharedInstance] switchToDictationInputModeWithTouch:nil];
	}
%end