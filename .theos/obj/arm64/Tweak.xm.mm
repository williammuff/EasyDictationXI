#line 1 "Tweak.xm"
@interface UIDictationController : NSObject
+ (UIDictationController *)sharedInstance;
-(void)switchToDictationInputModeWithTouch:(id)arg1 ;
@end

@interface UIKeyboardDockView  : UIView
@end

@interface UISystemKeyboardDockController : UIViewController
@property (nonatomic,retain) UIKeyboardDockView * dockView;
@end


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class UISystemKeyboardDockController; 
static void (*_logos_orig$_ungrouped$UISystemKeyboardDockController$loadView)(_LOGOS_SELF_TYPE_NORMAL UISystemKeyboardDockController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UISystemKeyboardDockController$loadView(_LOGOS_SELF_TYPE_NORMAL UISystemKeyboardDockController* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$UISystemKeyboardDockController$activateDictation(_LOGOS_SELF_TYPE_NORMAL UISystemKeyboardDockController* _LOGOS_SELF_CONST, SEL); 

#line 13 "Tweak.xm"


	static void _logos_method$_ungrouped$UISystemKeyboardDockController$loadView(_LOGOS_SELF_TYPE_NORMAL UISystemKeyboardDockController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd)  {
		_logos_orig$_ungrouped$UISystemKeyboardDockController$loadView(self, _cmd);
		
		
		
		
		UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(activateDictation)] autorelease];
		singleTap.numberOfTapsRequired = 1; 
		[[self dockView] addGestureRecognizer:singleTap];
	}


	static void _logos_method$_ungrouped$UISystemKeyboardDockController$activateDictation(_LOGOS_SELF_TYPE_NORMAL UISystemKeyboardDockController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
		
		[[objc_getClass("UIDictationController") sharedInstance] switchToDictationInputModeWithTouch:nil];
	}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$UISystemKeyboardDockController = objc_getClass("UISystemKeyboardDockController"); MSHookMessageEx(_logos_class$_ungrouped$UISystemKeyboardDockController, @selector(loadView), (IMP)&_logos_method$_ungrouped$UISystemKeyboardDockController$loadView, (IMP*)&_logos_orig$_ungrouped$UISystemKeyboardDockController$loadView);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$UISystemKeyboardDockController, @selector(activateDictation), (IMP)&_logos_method$_ungrouped$UISystemKeyboardDockController$activateDictation, _typeEncoding); }} }
#line 32 "Tweak.xm"
