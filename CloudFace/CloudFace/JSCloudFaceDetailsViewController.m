//
//  JSCloudFaceDetailsViewController.m
//  CloudFace
//
//  Created by Justin DeWind on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JSCloudFaceDetailsViewController.h"

@implementation JSCloudFaceDetailsViewController
@synthesize imageView;
@synthesize document = _document;

- (id)initWithDocument:(JSCloudFaceDocument *)document {
  if ((self = [super initWithNibName:@"JSCloudFaceDetailsViewController" bundle:nil])) {
    _document = document;
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  hud.labelText = @"Downloading..";
  [self.document openWithCompletionHandler:^(BOOL success) {
    if (success) {
      self.imageView.image = self.document.faceImage;
      self.title = self.document.title;
      [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }
  }];
}

- (void)viewDidLoad
{
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
