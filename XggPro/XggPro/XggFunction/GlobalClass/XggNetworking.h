//
//  KWNetworking.h
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);
typedef void (^UploadProgressBlock)(NSUInteger __unused bytesWritten,
                                    long long totalBytesWritten,
                                    long long totalBytesExpectedToWrite);

//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;
@interface XggNetworking : AFHTTPSessionManager
+ (instancetype)sharedManager;
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;

-(void)requestWithUpload:(NSString *)path
              WithParams:(id)params WithImage:(NSData *)imageData
 WithUploadProgressBlock:(UploadProgressBlock)Progress
        WithSuccessBlock:(requestSuccessBlock)success
         WithFailurBlock:(requestFailureBlock)failure;

@end
