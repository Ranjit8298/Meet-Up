#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
// Add the GoogleMaps import.
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Add the following line with your API key.
  [GMSServices provideAPIKey:@"AIzaSyDFbc0EvDfyY8k1ro1phUeISIHqoiNMWiI"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end