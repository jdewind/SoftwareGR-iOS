#import "JSAppDelegate.h"
#import "JSCloudFacesViewController.h"

@implementation JSAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:[[JSCloudFacesViewController alloc] initWithNibName:nil bundle:nil]];
  [self.window addSubview:self.navigationController.view];
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
