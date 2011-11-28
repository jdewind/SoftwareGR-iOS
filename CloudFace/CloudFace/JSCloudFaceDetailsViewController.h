#import <UIKit/UIKit.h>
#import "JSCloudFaceDocument.h"

@interface JSCloudFaceDetailsViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic, readonly) JSCloudFaceDocument *document;

- (id)initWithDocument:(JSCloudFaceDocument *)document;
@end
