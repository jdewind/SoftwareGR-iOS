#import <UIKit/UIKit.h>
#import "JSCloudFaceDocument.h"

@interface JSCloudFaceDocumentViewController : UIViewController
@property (nonatomic, strong) JSCloudFaceDocument *document;
- (id)initWithDocument:(JSCloudFaceDocument *)document;
@end
