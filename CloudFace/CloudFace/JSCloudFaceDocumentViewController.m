#import "JSCloudFaceDocumentViewController.h"
#import "JSCloudWrapper.h"

@implementation JSCloudFaceDocumentViewController
@synthesize document = _document;
@synthesize imageView = _imageView;

- (id)initWithImage:(UIImage *)image {
  if ((self = [super initWithNibName:@"JSCloudFaceDocumentViewController" bundle:nil])) {
    _image = image;
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  if (self.document.newDocument) {
    self.title = @"New Cloud Face";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTapped)];
  }
  self.imageView.image = _image;
  [super viewDidLoad];
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

@end
