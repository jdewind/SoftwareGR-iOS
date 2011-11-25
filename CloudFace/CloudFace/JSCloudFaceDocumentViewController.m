#import "JSCloudFaceDocumentViewController.h"
#import "JSCloudWrapper.h"

@implementation JSCloudFaceDocumentViewController
@synthesize document = _document;

- (id)initWithDocument:(JSCloudFaceDocument *)document {
  if ((self = [super initWithNibName:nil bundle:nil])) {
    self.document = document;
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
