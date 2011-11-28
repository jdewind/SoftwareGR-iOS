#import <UIKit/UIKit.h>

NSString *const CloudFaceDocumentExtension;

@interface JSCloudFaceDocument : UIDocument
@property (nonatomic, strong) UIImage *faceImage;
@property (nonatomic, strong) NSDictionary *facePositions;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic, strong) NSString *baseFilename;
@end
