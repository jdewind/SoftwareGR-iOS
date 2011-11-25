#import <Foundation/Foundation.h>
#import "JSCloudFaceDocument.h"

@interface JSCloudWrapper : NSObject

@property (nonatomic, readonly, strong) NSURL *cloudURL;
@property (nonatomic, readonly, getter = isCloudAvailable) BOOL cloudAvailable;
- (id)createDocument;

+ (id)shared;
@end
