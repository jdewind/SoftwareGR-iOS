#import <UIKit/UIKit.h>

@protocol JSCloudFaceDocumentDelegate <NSObject>

@end

NSString *const CloudFaceDocumentExtension;

@interface JSCloudFaceDocument : UIDocument
@property (nonatomic, strong) CIImage *faceImage;
@property (nonatomic, strong) NSDictionary *facePositions;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic, weak) id<JSCloudFaceDocumentDelegate> delegate;
@end
