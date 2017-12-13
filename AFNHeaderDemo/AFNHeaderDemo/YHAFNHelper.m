//
//  YHAFNHelper.m
//  即时通讯
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YHAFNHelper.h"

@implementation YHAFNHelper


+ (YHAFNHelper *)sharedManager {
    
    static YHAFNHelper *YHmanager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YHmanager = [YHAFNHelper manager];
        // 设置可接受的类型
        
        YHmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",@"application/vnd.henzfin.api+json", nil];
        

        //默认以json的格式发送        
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        
        //连接超时设置
        requestSerializer.timeoutInterval = 20;
        
        NSString *DefaultToken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiOTg5NDE0YmEtOGFiNy00NGZhLWJjOWEtZDc0Nzk0MDdhODJiIiwidXNlcm5hbWUiOiIxMzA1NTI3OTI0MCIsImV4cCI6MTUxNTc2NDk4MiwiZW1haWwiOiIiLCJvcmlnX2lhdCI6MTUxMTkzODk3Nn0.HSIvu_flVW-4tZ4UhT9E32EYYyW5GLMvrncjzleWT0U";
        
        if (DefaultToken){
            NSString *setToken = [@"JWT " stringByAppendingString:DefaultToken];
            [requestSerializer setValue:setToken forHTTPHeaderField:@"Authorization"];
        }

        //请求头还需要附加这个 Accept
        [requestSerializer setValue:@"application/vnd.henzfin.api+json;version=1.0" forHTTPHeaderField:@"Accept"];
        
        YHmanager.requestSerializer = requestSerializer;
        
        
    });
    
    return YHmanager;
    
}


//get请求:注意传递的url是否是全路径，不是的话在拼接
+ (void )get:(NSString *)url parameter:(id)parameters success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure
{
    
    //GET:url :如果传的是完整的接口就直接用，如果是需要拼接的，再拼接[HOST stringByAppendingString:url]
    [[YHAFNHelper sharedManager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if(responseObject)  {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *ErrorString =[[NSString alloc]initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        
        //AFN3.0 获取 - statusCode
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"get - Http请求错误原因 - %@ , statusCode = %ld, url = %@", ErrorString, (long)statusCode, url);
        
        failure(error);
        
    }];
    
}




@end
