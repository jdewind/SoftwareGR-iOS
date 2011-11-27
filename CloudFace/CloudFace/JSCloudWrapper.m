#import "JSCloudWrapper.h"

static JSCloudWrapper *gCloudWrapper;

@interface JSCloudWrapper()
- (NSURL *)localDocumentsDirectoryURL;
@end

@implementation JSCloudWrapper

@synthesize cloudURL = _cloudURL;
@dynamic cloudAvailable;

+ (void)initialize {
  if (self == [JSCloudWrapper class]) {
    gCloudWrapper = [[JSCloudWrapper alloc] init];
  }
}

+ (id)shared {
  return gCloudWrapper;
}

- (id)init {
  if ((self = [super init])) {
    _cloudURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
  }
  
  return self;
}

- (BOOL)isCloudAvailable {
  return _cloudURL != nil;
}

- (id)createDocument {
  NSURL *documentURL = [[self localDocumentsDirectoryURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", [[NSProcessInfo processInfo] globallyUniqueString], CloudFaceDocumentExtension]];
  return [[JSCloudFaceDocument alloc] initWithFileURL:documentURL];
}

- (id)createDocumentWithImage:(CIImage *)image feature:(CIFaceFeature *)faceFeature title:(NSString *)title {
  JSCloudFaceDocument *document  = [self createDocument];
  document.faceImage = image;
  document.title = title;
  NSMutableDictionary *facePositions = [NSMutableDictionary dictionary];
  if (faceFeature.hasLeftEyePosition) {
    [facePositions setObject:NSStringFromCGPoint(faceFeature.leftEyePosition) forKey:@"leftEyePosition"];
  }
  if (faceFeature.hasRightEyePosition) {
    [facePositions setObject:NSStringFromCGPoint(faceFeature.rightEyePosition) forKey:@"rightEyePosition"];
  }
  if (faceFeature.hasMouthPosition) {
    [facePositions setObject:NSStringFromCGPoint(faceFeature.mouthPosition) forKey:@"mouthPosition"];
  }
  document.facePositions = facePositions;
  return document;
}


#pragma mark - Private

- (NSURL *)localDocumentsDirectoryURL {
  static NSURL *localDocumentsDirectoryURL = nil;
  if (localDocumentsDirectoryURL == nil) {
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,
                                                                            NSUserDomainMask, YES ) objectAtIndex:0];
    localDocumentsDirectoryURL = [NSURL fileURLWithPath:documentsDirectoryPath];
  }
  return localDocumentsDirectoryURL;
}

@end
