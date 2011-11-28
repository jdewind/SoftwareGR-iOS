#import "JSCreateCloudFaceDocumentViewController.h"
#import "JSCloudWrapper.h"

@interface JSCreateCloudFaceDocumentViewController()
- (void)processFeatures;
@end

@implementation JSCreateCloudFaceDocumentViewController
@synthesize imageView = _imageView;
@synthesize feature = _feature;
@synthesize ciImage = _ciImage;
@synthesize hud = _hud;

- (id)initWithImage:(UIImage *)image {
  if ((self = [super initWithNibName:@"JSCloudFaceDocumentViewController" bundle:nil])) {
    _image = image;
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  self.title = @"New Cloud Face";
  self.imageView.image = _image;
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  self.hud.labelText = @"Detecting Faces";  
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSDictionary *detectorOptions = [[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyHigh, CIDetectorAccuracy, nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    self.ciImage = [CIImage imageWithCGImage:_image.CGImage];
    self.feature = [[detector featuresInImage:self.ciImage] lastObject];
    [self processFeatures];
  });
  
  [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
  [self setImageView:nil];
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  NSString *title = [alertView textFieldAtIndex:0].text;
  JSCloudFaceDocument *document = [[JSCloudWrapper shared] createDocumentWithImage:self.imageView.image feature:self.feature title:title];
  self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  self.hud.labelText = @"Saving..";  

  [document saveToURL:document.fileURL 
     forSaveOperation:UIDocumentSaveForCreating 
    completionHandler:^(BOOL success) {
      JSCloudWrapper *cloudWrapper = [JSCloudWrapper shared];
      if (success && cloudWrapper.isCloudAvailable) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          NSError *error = nil;
          NSURL *url = [cloudWrapper.cloudDocumentsURL URLByAppendingPathComponent:[document.fileURL lastPathComponent]];
          BOOL success = [[NSFileManager defaultManager] setUbiquitous:YES 
                                                             itemAtURL:document.fileURL 
                                                        destinationURL:url 
                                                                 error:&error];          
          if (!success) {
            NSLog(@"Error saving document: %@", error);
          }
          
          dispatch_sync(dispatch_get_main_queue(), ^{
            [[NSFileManager defaultManager] removeItemAtURL:document.fileURL error:nil];
            [self.navigationController dismissModalViewControllerAnimated:YES];
          });
        });
      }
    }];  
}

#pragma mark - Callbacks

- (void)saveTapped {
  UIAlertView *alertView = [[UIAlertView alloc] 
                            initWithTitle:@"Save" 
                            message:@"Provide a name" 
                            delegate:self 
                            cancelButtonTitle:nil 
                            otherButtonTitles:@"Save", nil];
  alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  [alertView show];
}

#pragma mark - Private

- (void)processFeatures {
  if (self.feature) {
    dispatch_sync(dispatch_get_main_queue(), ^{
      self.hud.labelText = @"Cropping";        
    });
    self.ciImage = [self.ciImage imageByCroppingToRect:self.feature.bounds];
    CIContext *context = [CIContext contextWithOptions:nil];    
    CGImageRef cgImage = [context createCGImage:self.ciImage fromRect:[self.ciImage extent]];        
    dispatch_sync(dispatch_get_main_queue(), ^{
      [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
      self.imageView.image = [UIImage imageWithCGImage:cgImage];
      CGImageRelease(cgImage);
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemSave 
                                                target:self 
                                                action:@selector(saveTapped)];
    });
  } else {
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [UIAlertView js_showFaceNotDetectedAlert];
  }
}
@end
