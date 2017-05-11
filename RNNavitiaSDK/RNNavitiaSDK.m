//
//  BridgeSDK.m
//  ADM
//
//  Created by Johan Rouve on 03/05/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNNavitiaSDK.h"
#import <React/RCTLog.h>

@implementation RNNavitiaSDK

// To export a module named NavitiaSDKBridge
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(init:(NSString *)token)
{
  NavitiaConfiguration *conf =  [[NavitiaConfiguration alloc] initWithToken:token];
  self.sdk = [[NavitiaSDK alloc] initWithConfiguration:conf];
  RCTLogInfo(@"SDK created with token %@", [[self.sdk configuration] token]);
}

RCT_EXPORT_METHOD(endpoint_places:(NSDictionary *)params resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  EndpointPlaces *places = [[self.sdk endpoints] places];
  EndpointRequestBuilderPlaces *queryBuilder = [places newRequestBuilder];

  for (NSString* key in params) {
    id value = [params objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
      value = [value stringValue];
    }
    [queryBuilder addQueryParameterWithKey:key value:value];
  }

  [queryBuilder
    rawGetWithCallback: ^(NSDictionary *results)
  {
    RCTLogInfo(@"SDK places with query %@", [queryBuilder getUrl]);
    resolve(results);
  } errorCallback:^(ResourceRequestError *sdkError)
  {
    RCTLogInfo(@"SDK places fail");
    NSDictionary *userInfo = @{
      @"NSLocalizedDescriptionKey" : sdkError.message
    };
    NSError *error = [NSError errorWithDomain:@"NavitiaSDK" code:sdkError.httpStatusCode userInfo:userInfo];
    reject([@(sdkError.httpStatusCode) stringValue], sdkError.message, error);
  }];
}

@end
