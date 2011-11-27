#import "JSCloudFaceDocumentFinder.h"
#import "JSCloudFaceDocument.h"

@implementation JSCloudFaceDocumentFinder
@synthesize completionHandler = _completionHandler;

- (void)lookupCloudFaceDocuments:(void (^)(NSArray *))completionHandler {
  if (_query.isStarted) {
    [_query stopQuery];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  }
  _query = [[NSMetadataQuery alloc] init];
  self.completionHandler = completionHandler;
  [_query setSearchScopes:[NSArray arrayWithObjects:NSMetadataQueryUbiquitousDocumentsScope, nil]];
  [_query setPredicate:[NSPredicate predicateWithFormat:@"%K == '*.%@'", NSMetadataItemFSNameKey, CloudFaceDocumentExtension]];
  [[NSNotificationCenter defaultCenter] 
   addObserver:self 
   selector:@selector(documentListRecieved) 
   name:NSMetadataQueryDidFinishGatheringNotification 
   object:nil];
  [[NSNotificationCenter defaultCenter] 
   addObserver:self 
   selector:@selector(documentListRecieved) 
   name:NSMetadataQueryDidUpdateNotification 
   object:nil];
  [[NSNotificationCenter defaultCenter] 
   addObserver:self 
   selector:@selector(applicationDidEnterBackground) 
   name:UIApplicationDidEnterBackgroundNotification object:nil];
  [[NSNotificationCenter defaultCenter] 
   addObserver:self 
   selector:@selector(applicationWillEnterForeground) 
   name:UIApplicationWillEnterForegroundNotification object:nil];
  [_query startQuery];
}

#pragma mark - Callbacks

- (void)documentListRecieved {
  NSMutableArray *documents = [NSMutableArray arrayWithCapacity:[_query resultCount]];
  for (NSMetadataItem *item in [_query results]) {
    JSCloudFaceDocument *document = [[JSCloudFaceDocument alloc] initWithFileURL:[item valueForAttribute:NSMetadataItemURLKey]];
    [documents addObject:document];
  }
  self.completionHandler(documents);
}

- (void)applicationDidEnterBackground {
  [_query stopQuery];
}

- (void)applicationWillEnterForeground {
  [_query startQuery];
}
@end
