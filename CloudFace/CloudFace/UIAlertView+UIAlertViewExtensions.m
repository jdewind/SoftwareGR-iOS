#import "UIAlertView+UIAlertViewExtensions.h"

@implementation UIAlertView (UIAlertViewExtensions)

+ (id)js_showCloudNotAvailableAlert {
  UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"iCloud Not Available" message:@"We won't be able to save your faces to the cloud!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
  [view show];
  return view;
}

@end
