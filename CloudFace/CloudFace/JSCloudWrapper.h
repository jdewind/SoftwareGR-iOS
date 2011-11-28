#import <Foundation/Foundation.h>
#import "JSCloudFaceDocument.h"

@interface JSCloudWrapper : NSObject

@property (nonatomic, readonly, strong) NSURL *cloudURL;
@property (nonatomic, readonly, strong) NSURL *cloudDocumentsURL;

@property (nonatomic, readonly, getter = isCloudAvailable) BOOL cloudAvailable;
- (id)createDocument;
- (id)createDocumentWithName:(NSString *)name;
- (id)createDocumentWithImage:(UIImage *)image feature:(CIFaceFeature *)faceFeature title:(NSString *)title;
+ (id)shared;
@end
