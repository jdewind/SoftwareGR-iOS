#import "JSCloudFacesViewController.h"
#import "UIAlertView+UIAlertViewExtensions.h"
#import "JSCloudFaceDocumentViewController.h"

@implementation JSCloudFacesViewController
@synthesize cloudWrapper = _cloudWrapper;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if((self = [super initWithNibName:nil bundle:nil])) {
    self.cloudWrapper = [JSCloudWrapper shared];
    self.title = @"Cloud Faces";
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  if (!self.cloudWrapper.isCloudAvailable) {
    [UIAlertView js_showCloudNotAvailableAlert];
  }
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCloudFaceButtonTapped)];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  JSCloudFaceDocumentViewController *documentViewController = [[JSCloudFaceDocumentViewController alloc] initWithImage:image];
  [picker pushViewController:documentViewController animated:YES];
}

#pragma mark - Callbacks

- (void)addCloudFaceButtonTapped {
  UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
  pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  pickerController.delegate = self;
  [self presentModalViewController:pickerController animated:YES];
}

@end
