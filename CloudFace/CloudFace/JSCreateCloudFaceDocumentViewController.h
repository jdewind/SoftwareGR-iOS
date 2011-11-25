#import <UIKit/UIKit.h>
#import "JSCloudFaceDocument.h"

@interface JSCreateCloudFaceDocumentViewController : UIViewController {
  UIImage *_image;
}

@property (strong, nonatomic) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithImage:(UIImage *)image;
@end
