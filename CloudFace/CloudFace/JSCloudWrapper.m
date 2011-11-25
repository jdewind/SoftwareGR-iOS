#import "JSCloudWrapper.h"

static JSCloudWrapper *gCloudWrapper;

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
@end
