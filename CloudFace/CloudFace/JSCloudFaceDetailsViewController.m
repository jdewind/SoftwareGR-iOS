//
//  JSCloudFaceDetailsViewController.m
//  CloudFace
//
//  Created by Justin DeWind on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JSCloudFaceDetailsViewController.h"

@interface JSCloudFaceDetailsViewController()
- (void)processFacePositions;
@end

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
      [self processFacePositions];
    }
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
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

#pragma mark - Private

- (void)processFacePositions {
  NSDictionary *facePositions = self.document.facePositions;
  
  CGFloat widthScale = self.imageView.image.size.width / self.imageView.frame.size.width;
  CGFloat heightScale = self.imageView.image.size.height / self.imageView.frame.size.height;
  CGRect faceBounds = CGRectFromString([facePositions objectForKey:@"faceBounds"]);

  NSArray *positions = [NSArray arrayWithObjects:@"leftEyePosition", @"rightEyePosition", @"mouthPosition", nil];
  NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor greenColor], nil];
  NSUInteger index = 0;
  for (NSString *key in positions) {
    if ([facePositions objectForKey:key]) {
      CGPoint point = CGPointFromString([facePositions objectForKey:key]);
      CGFloat heightAndWidth = 60.0f;
      
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(
                                                              (point.x - faceBounds.origin.x) / widthScale - (heightAndWidth / 2.0f), 
                                                              self.view.frame.size.height - ((point.y - faceBounds.origin.y) / heightScale) - (heightAndWidth / 2.0f), 
                                                              heightAndWidth, 
                                                              heightAndWidth)];
      view.backgroundColor = [colors objectAtIndex:index];
      view.alpha = 0.75;
      index++;
      [self.view addSubview:view];
      [self.view bringSubviewToFront:view];
    }    
  }
}

@end
