#import <UIKit/UIKit.h>
#import "JSCloudFaceDocument.h"

@interface JSCloudFaceDocumentViewController : UIViewController {
  UIImage *_image;
}

@property (nonatomic, strong) JSCloudFaceDocument *document;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithImage:(UIImage *)image;
@end
