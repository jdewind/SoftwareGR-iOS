#import <UIKit/UIKit.h>

@protocol JSCloudFaceDocumentDelegate <NSObject>

@end

NSString *const CloudFaceDocumentExtension;

@interface JSCloudFaceDocument : UIDocument
@property (nonatomic, strong) CIImage *faceImage;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *features;
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic, weak) id<JSCloudFaceDocumentDelegate> delegate;
@end
