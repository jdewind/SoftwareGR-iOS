#import "JSCreateCloudFaceDocumentViewController.h"
#import "JSCloudWrapper.h"

@implementation JSCreateCloudFaceDocumentViewController
@synthesize imageView = _imageView;
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
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTapped)];
  self.imageView.image = _image;
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
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

@end
