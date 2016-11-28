//
//  KWNetworking.m
//  KinWind
//
//  Created by Baird-weng on 16/6/7.
//  Copyright © 2016年 Baird-weng. All rights reserved.
//

#import "XggNetworking.h"

//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);
//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);
@implementation XggNetworking
+ (instancetype)sharedManager{
    static XggNetworking *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [self manager];
        manager.requestSerializer.timeoutInterval = 60;
    });
    return manager;
}

//-(instancetype)initWithBaseURL:(NSURL *)url
//{
//    self = [super initWithBaseURL:url];
//    if (self) {
//        // 请求超时设定
//        self.requestSerializer.timeoutInterval = 60;
//        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
//        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
//        self.securityPolicy.allowInvalidCertificates = YES;
//    }
//    return self;
//}
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    switch (method) {
        case GET:{
            [self GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
                success(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
-(void)requestWithUpload:(NSString *)path
              WithParams:(id)params WithImage:(NSData *)imageData
 WithUploadProgressBlock:(UploadProgressBlock)Progress
        WithSuccessBlock:(requestSuccessBlock)success
         WithFailurBlock:(requestFailureBlock)failure{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    serializer.timeoutInterval = 60*3;
     NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path
                                    parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
                         [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
                     }];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         success(responseObject);
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         failure(error);
                                     }];
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite){
        Progress(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    [operation start];
}
@end
