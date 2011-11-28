#import "JSCloudFacesViewController.h"
#import "UIAlertView+UIAlertViewExtensions.h"
#import "JSCreateCloudFaceDocumentViewController.h"
#import "JSCloudFaceDetailsViewController.h"

@implementation JSCloudFacesViewController
@synthesize cloudWrapper = _cloudWrapper;
@synthesize documents = _documents;
@synthesize documentFinder = _documentFinder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if((self = [super initWithNibName:nil bundle:nil])) {
    self.cloudWrapper = [JSCloudWrapper shared];
    self.title = @"Cloud Faces";
    self.documentFinder = [[JSCloudFaceDocumentFinder alloc] init];
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
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

- (void)viewDidAppear:(BOOL)animated {
  if (!self.cloudWrapper.isCloudAvailable) {
    [UIAlertView js_showCloudNotAvailableAlert];
  } else if(!self.documents){
    [self.documentFinder lookupCloudFaceDocuments:^(NSArray *documents) {
      self.documents = documents;
      [self.tableView reloadData];
    }];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.documents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  JSCloudFaceDocument *document = [self.documents objectAtIndex:indexPath.row];
  cell.textLabel.text = document.baseFilename;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JSCloudFaceDocument *document = [self.documents objectAtIndex:indexPath.row];
  JSCloudFaceDetailsViewController *controller = [[JSCloudFaceDetailsViewController alloc] initWithDocument:document];
  [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
  JSCreateCloudFaceDocumentViewController *documentViewController = [[JSCreateCloudFaceDocumentViewController alloc] initWithImage:image];
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
