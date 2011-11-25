#import <UIKit/UIKit.h>
#import "JSCloudWrapper.h"

@interface JSCloudFacesViewController : UITableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) JSCloudWrapper *cloudWrapper;
@end
