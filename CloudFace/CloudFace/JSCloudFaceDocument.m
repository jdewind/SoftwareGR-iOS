#import "JSCloudFaceDocument.h"

NSString *const CloudFaceDocumentExtension = @"cloudface";

@implementation JSCloudFaceDocument
@synthesize faceImage = _faceImage;
@synthesize caption = _caption;
@synthesize features = _features;
@synthesize delegate = _delegate;
@synthesize fileWrapper = _fileWrapper;

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
  return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
  return nil;
}
@end
