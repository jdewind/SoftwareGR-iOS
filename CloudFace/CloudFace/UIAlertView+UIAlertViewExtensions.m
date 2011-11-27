#import "UIAlertView+UIAlertViewExtensions.h"

@implementation UIAlertView (UIAlertViewExtensions)

+ (id)js_showCloudNotAvailableAlert {
  UIAlertView *view = [[UIAlertView alloc] 
                       initWithTitle:@"iCloud Not Available" 
                       message:@"We won't be able to save your faces to the cloud!" 
                       delegate:nil 
                       cancelButtonTitle:nil 
                       otherButtonTitles:@"Okay", nil];
  [view show];
  return view;
}

+ (id)js_showFaceNotDetectedAlert {
  UIAlertView *view = [[UIAlertView alloc] 
                       initWithTitle:@"Face Not Detected" 
                       message:@"We were unable to detect a face. Tap back and try again.X" 
                       delegate:nil 
                       cancelButtonTitle:nil 
                       otherButtonTitles:@"Okay", nil];
  [view show];
  return view;  
}
@end
