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
