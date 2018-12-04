#import "CirrusReadQrPlugin.h"
#import <cirrus_read_qr/cirrus_read_qr-Swift.h>

@implementation CirrusReadQrPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCirrusReadQrPlugin registerWithRegistrar:registrar];
}
@end
