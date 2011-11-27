#import <Foundation/Foundation.h>

@interface JSCloudFaceDocumentFinder : NSObject {
  NSMetadataQuery *_query;
}

@property (nonatomic, copy) void(^completionHandler)(NSArray *);

- (void)lookupCloudFaceDocuments:(void (^)(NSArray *))completionHandler;
@end
