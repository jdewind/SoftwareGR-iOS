#import <UIKit/UIKit.h>
#import "JSCloudWrapper.h"
#import "JSCloudFaceDocumentFinder.h"

@interface JSCloudFacesViewController : UITableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) JSCloudWrapper *cloudWrapper;
@property (nonatomic, strong) NSArray *documents;
@property (nonatomic, strong) JSCloudFaceDocumentFinder *documentFinder;
@end
