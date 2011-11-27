#import <UIKit/UIKit.h>
#import "JSCloudFaceDocument.h"

@interface JSCreateCloudFaceDocumentViewController : UIViewController {
  __strong UIImage *_image;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CIFaceFeature *feature;
@property (strong, nonatomic) CIImage *ciImage;
@property (strong, nonatomic) MBProgressHUD *hud;

- (id)initWithImage:(UIImage *)image;
@end
