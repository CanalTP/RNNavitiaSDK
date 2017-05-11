//
//  RNNavitiaSDK.h
//  RNNavitiaSDK
//
//  Created by Johan Rouve on 10/05/2017.
//  Copyright © 2017 Johan Rouve. All rights reserved.
//

#ifndef RNNavitiaSDK_h
#define RNNavitiaSDK_h

#import <React/RCTBridgeModule.h>
#import <NavitiaSDK/NavitiaSDK-swift.h>

@interface RNNavitiaSDK : NSObject <RCTBridgeModule>

@property (nonatomic, strong) NavitiaSDK *sdk;

@end

#endif /* RNNavitiaSDK_h */


