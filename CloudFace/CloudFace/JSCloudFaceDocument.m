#import "JSCloudFaceDocument.h"

NSString *const CloudFaceDocumentExtension = @"cloudface";

static NSString *const TitleFileName = @"Title.data";
static NSString *const FaceImageFileName = @"FaceImage.png";
static NSString *const FacePositionsFileName = @"FacePositions.data";

@implementation JSCloudFaceDocument
@synthesize faceImage = _faceImage;
@synthesize facePositions = _facePositions;
@synthesize title = _title;
@synthesize fileWrapper = _fileWrapper;
@dynamic baseFilename;

- (NSString *)baseFilename {
  return [[self.fileURL lastPathComponent] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", CloudFaceDocumentExtension] withString:@""];
}

- (UIImage *)faceImage {
  if (!_faceImage) {
    self.faceImage = [UIImage imageWithData:[[self.fileWrapper.fileWrappers objectForKey:FaceImageFileName] regularFileContents]];
  }
  return _faceImage;
}

- (NSString *)title {
  if (!_title) {
    self.title = [[NSString alloc] initWithData:[[self.fileWrapper.fileWrappers objectForKey:TitleFileName] regularFileContents] encoding:NSUTF8StringEncoding];    
  }
  return _title;
}

- (NSDictionary *)facePositions {
  if (!_facePositions) {
    self.facePositions = [NSPropertyListSerialization propertyListWithData:[[self.fileWrapper.fileWrappers objectForKey:FacePositionsFileName] regularFileContents]
                                                                   options:NSPropertyListImmutable 
                                                                    format:NULL 
                                                                     error:nil];    
  }
  return _facePositions;
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
  self.fileWrapper = (NSFileWrapper *)contents;
  return self.fileWrapper != nil;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
  if (self.fileWrapper == nil) {
    self.fileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:nil];
  }
  
  NSDictionary *fileWrappers = self.fileWrapper.fileWrappers;
  
  if (![fileWrappers objectForKey:TitleFileName] && self.title) {
    NSFileWrapper *titleWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:[self.title dataUsingEncoding:NSUTF8StringEncoding]];
    [titleWrapper setPreferredFilename:TitleFileName];
    [self.fileWrapper addFileWrapper:titleWrapper];
  }

  if (![fileWrappers objectForKey:FacePositionsFileName] && self.facePositions) {
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.facePositions 
                                                              format:NSPropertyListBinaryFormat_v1_0 
                                                             options:0 
                                                               error:nil];
    NSFileWrapper *facePositionsWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
    [facePositionsWrapper setPreferredFilename:FacePositionsFileName];
    [self.fileWrapper addFileWrapper:facePositionsWrapper];
  }
  
  if (![fileWrappers objectForKey:FaceImageFileName] && self.faceImage) {    
    NSFileWrapper *faceImageWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:UIImagePNGRepresentation(self.faceImage)];
    [faceImageWrapper setPreferredFilename:FaceImageFileName];
    [self.fileWrapper addFileWrapper:faceImageWrapper];
  }  

  return self.fileWrapper;
}
@end
