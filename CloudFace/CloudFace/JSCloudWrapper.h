#import <Foundation/Foundation.h>

@interface JSCloudWrapper : NSObject

@property (nonatomic, readonly, strong) NSURL *cloudURL;
@property (nonatomic, readonly, getter = isCloudAvailable) BOOL cloudAvailable;

+ (id)shared;
@end
