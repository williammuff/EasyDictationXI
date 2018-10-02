@interface UIKeyboardDockItemButton : UIButton
@end

@interface UIDictationController : NSObject
+ (UIDictationController *)sharedInstance;
-(void)startDictation;
-(void)_startDictation;
-(BOOL)dictationStartedFromGesture;
-(int)state;
-(void)switchToDictationInputModeWithTouch:(id)arg1 ;
@end

@interface UIKeyboardDockItem : NSObject
@property (nonatomic,readonly) UIView * view; 
@property (nonatomic,retain) NSString * imageName; 
@property (assign,nonatomic) BOOL enabled; 
-(UIKeyboardDockItemButton *)button;
-(void)setEnabled:(BOOL)arg1 ;
@end

@interface UIKeyboardDockView  : UIView
@property (nonatomic,retain) UIKeyboardDockItem * leftDockItem;                           //@synthesize leftDockItem=_leftDockItem - In the implementation block
@property (nonatomic,retain) UIKeyboardDockItem * rightDockItem;                          //@synthesize rightDockItem=_rightDockItem - In the implementation block
-(void)layoutSubviews;
-(CGSize)intrinsicContentSize;
-(id)_dockItemWithButton:(id)arg1 ;
-(void)_dockItemButtonWasTapped:(id)arg1 withEvent:(id)arg2 ;
-(UIKeyboardDockItem *)leftDockItem;
-(UIKeyboardDockItem *)rightDockItem;
-(void)_configureDockItem:(id)arg1 ;
-(void)setLeftDockItem:(UIKeyboardDockItem *)arg1 ;
-(void)setRightDockItem:(UIKeyboardDockItem *)arg1 ;
@end

@interface UISystemKeyboardDockController : UIViewController
@property (nonatomic,retain) UIKeyboardDockView * dockView;
-(void)keyboardDockView:(id)arg1 didPressDockItem:(id)arg2 withEvent:(id)arg3 ;
-(void)setDockView:(UIKeyboardDockView *)arg1 ;
-(void)updateDockItemsVisibility;
@end

@interface UITouchesEvent : UIEvent 
-(void)_setTimestamp:(double)arg1 ;
@end

@interface UIKBTree : NSObject
@property (nonatomic,retain) NSString * name; 
-(BOOL)disabled;
-(BOOL)visible;
-(void)setVisible:(BOOL)arg1 ;
@end


%hook UIDictationController
	-(void)switchToDictationInputModeWithTouch:(id)arg1 
	{
		NSLog(@"--------UIDictationController-----------");
		NSLog(@"---------switchToDictationInputModeWithTouch->arg1:%@------------",arg1);
		%orig;
	}
%end

/*
//TRYING TO SWAP THE BUTTONS
UIKeyboardDockItem* leftDI;
UIKeyboardDockItem* rhgtDI;
%hook UIKeyboardDockView
	-(void)layoutSubviews{
		%orig;
		leftDI = [self leftDockItem]
		rhgtDI = [self rightDockItem]
		NSLog(@"[LeftyDictation]---------layoutSubviews---------------------------"); 
		NSLog(@"[LeftyDictation]-------------------------leftDockItem:%@-----------------",leftDI.view); 
		NSLog(@"[LeftyDictation]-------------------------rightDockItem:%@-----------------",rhgtDI.view); 
		//[self setLeftDockItem:[self rightDockItem]] ;
		//[self setRightDockItem:[self setLeftDockItem]] ;
	}
	-(id)_dockItemWithButton:(id)arg1 {
		NSLog(@"[LeftyDictation]---------_dockItemWithButton----------arg1:%@-----------------",arg1); 
		%orig;
	}
%end
*/


UIKeyboardDockItem* dictDockItem;
UITouchesEvent* touchEvent;
//UIKeyboardDockView* dockView;
//UIKeyboardDockItem* leftDI;
//UIKeyboardDockItem* rhgtDI;


%hook UISystemKeyboardDockController
	/*
	-(void)updateDockItemsVisibility
	{
		
		NSLog(@"[LeftyDictation]----UISystemKeyboardDockController->updateDockItemsVisibility----------------------------------------");
		dockView = [self dockView];
		leftDI = [dockView leftDockItem];
		rhgtDI = [dockView rightDockItem];
		NSLog(@"[LeftyDictation]--------------------[leftDI enabled]:%@----------------------------------------------",[leftDI enabled] ? @"YES" : @"NO");
		NSLog(@"[LeftyDictation]--------------------[rhgtDI enabled]:%@----------------------------------------------",[rhgtDI enabled] ? @"YES" : @"NO");
		if ([leftDI enabled] && [rhgtDI enabled]) 
		{
			NSLog(@"--------BOTH SET DO WORK------------");
			[dockView setLeftDockItem: rhgtDI];
			[dockView setRightDockItem: leftDI];
		}
		
		//-(void)setLeftDockItem:(UIKeyboardDockItem *)arg1 ;
		//-(void)setRightDockItem:(UIKeyboardDockItem *)arg1 ;
		%orig;
	}
	*/

	-(void)loadView 
	{
		%orig;
		NSLog(@"[LeftyDictation]----UISystemKeyboardDockController->loadView----------------------------------------");
		NSLog(@"[LeftyDictation]--------------------self:%@---------------------------------------------------------",self);
		NSLog(@"[LeftyDictation]--------------------[self dockView]:%@----------------------------------------------",[self dockView]);
		NSLog(@"[LeftyDictation]--------------------touchEvent:%@---------------------------------------------------",touchEvent);
		
		
		UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activateDictation)] autorelease];
		singleTap.numberOfTapsRequired = 1; 
		[[self dockView] addGestureRecognizer:singleTap];
		
		//UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(activateDictation:)];
		//[leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
		//[[self dockView] addGestureRecognizer:leftSwipe];
		
		dictDockItem = MSHookIvar<UIKeyboardDockItem *>(self, "_dictationDockItem");
		NSLog(@"[LeftyDictation]--------------------dictDockItem:%@---------------------------------------------------------",dictDockItem);
	}

%new
	- (void)activateDictation//:(UITapGestureRecognizer *)recognizer {
		{
		NSLog(@"[LeftyDictation]--------------------activateDictation---------------------------------");
		NSLog(@"[LeftyDictation]--------------------dictDockItem:%@---------------------------------------------------------",dictDockItem);
		NSLog(@"[LeftyDictation]--------------------touchEvent:%@---------------------------------------------------------",touchEvent);
		
		//[self dictationItemButtonWasPressed:dictDockItem withEvent:touchEvent];
		//[touchEvent _setTimestamp:1.00];
		[[objc_getClass("UIDictationController") sharedInstance] switchToDictationInputModeWithTouch:nil];
		//[self keyboardDockView:[self dockView] didPressDockItem:dictDockItem withEvent:touchEvent];
	}
%end

	//grab touch event
%hook UITapGestureRecognizer
	//-(void)touchesEnded:(id)arg1 withEvent:(id)arg2 
	-(void)touchesBegan:(id)arg1 withEvent:(id)arg2 
	{		
		%orig;
		if(touchEvent == nil){
			touchEvent = arg2;
			[touchEvent _setTimestamp:1.00];
		} 
	}
%end

/*
UIKeyboardDockItem* dictDockItem;
UITouchesEvent* touchEvent;
%hook UISystemKeyboardDockController
	-(void)loadView 
	{
		%orig;
		NSLog(@"[LeftyDictation]--------------------init---------------------------------");
		
		UITapGestureRecognizer *doubleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activateDictation)] autorelease];
		doubleTap.numberOfTapsRequired = 2; 
		[[self dockView] addGestureRecognizer:doubleTap];
		dictDockItem = MSHookIvar<UIKeyboardDockItem *>(self, "_dictationDockItem");
	}
	
					//STRICLY FOR LOGGING-
					-(void)keyboardDockView:(id)arg1 didPressDockItem:(id)arg2 withEvent:(id)arg3 
					{
						NSLog(@"[LeftyDictation]-------------------arg1:%@-----------------",arg1); 
						NSLog(@"[LeftyDictation]-------------------arg2:%@-----------------",arg2); 
						NSLog(@"[LeftyDictation]-------------------arg3:%@-----------------",arg3); 
						%orig;
					}
			
%new

	- (void)activateDictation {
		NSLog(@"[LeftyDictation]--------------------activateDictation---------------------------------");
		//[self keyboardDockView:[self dockView] didPressDockItem:dictDockItem withEvent:touchEvent];
	}
%end

%hook UITapGestureRecognizer
-(void)touchesEnded:(id)arg1 withEvent:(id)arg2 {
	
	NSLog(@"[LeftyDictation]--------------------touchesEnded---------------------------------");
	NSLog(@"[LeftyDictation]-------------------arg1:%@-----------------",arg1); 
	NSLog(@"[LeftyDictation]-------------------arg2:%@-----------------",arg2); 
	touchEvent = arg2;
		%orig;
}
%end
*/