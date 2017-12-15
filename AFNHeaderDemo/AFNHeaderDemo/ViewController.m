//
//  ViewController.m
//  AFNHeaderDemo
//
//  Created by 梁宇航 on 2017/12/13.
//  Copyright © 2017年 梁宇航. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "YHAFNHelper.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI{

    //leftBtn
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.frame = CGRectMake(50, 200, 100, 40);
    [leftBtn setBackgroundColor:[UIColor orangeColor]];
    [leftBtn setTitle:@"普通get请求" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    //rightBtn
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.frame = CGRectMake(200, 200, 100, 40);
    [rightBtn setBackgroundColor:[UIColor lightGrayColor]];
    [rightBtn setTitle:@"选择图片上传" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}

#pragma mark - btn click
- (void)clickLeftBtn{

    NSString *urlStr = @"https://testapi.henzfin.com/policies?limit=30&offset=30&state=pending+payment@";
    
    [YHAFNHelper get:urlStr parameter:nil success:^(id responseObject) {
        NSLog(@"success -- !,url = %@",urlStr);
    } faliure:^(id error) {
        
    }];
    
}

- (void)clickRightBtn{
    

    //底部弹出选择器
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"选择照片或拍照" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //UIImagePickerController
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.delegate = self;
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //跳转到UIImagePickerController控制器弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            NSLog(@"不支持拍照 - 是模拟器！");
            return ;
        }
        //选择相机时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消！");
        
    }];
    
    [alertC addAction:photoAction];
    [alertC addAction:cameraAction];
    [alertC addAction:cancelAction];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
    
}

#pragma mark - <UIImagePickerDelegate>
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self uploadImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image{

    NSString *urlStr = @"https://testapi.henzfin.com/upload/image";
    
    NSDictionary *body = @{
                           @"file":image
                           };
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",@"application/vnd.henzfin.api+json", nil];
    
    
    //默认以json的格式发送
    AFHTTPRequestSerializer *requestSerializer = [AFPropertyListRequestSerializer serializer];
    
    //连接超时设置
    requestSerializer.timeoutInterval = 20;
    
    NSString *DefaultToken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiOTg5NDE0YmEtOGFiNy00NGZhLWJjOWEtZDc0Nzk0MDdhODJiIiwidXNlcm5hbWUiOiIxMzA1NTI3OTI0MCIsImV4cCI6MTUxNTc2NDk4MiwiZW1haWwiOiIiLCJvcmlnX2lhdCI6MTUxMTkzODk3Nn0.HSIvu_flVW-4tZ4UhT9E32EYYyW5GLMvrncjzleWT0U";
    
    if (DefaultToken){
        NSString *setToken = [@"JWT " stringByAppendingString:DefaultToken];
        [requestSerializer setValue:setToken forHTTPHeaderField:@"Authorization"];
    }
    
    //请求头还需要附加这个 Accept
    [requestSerializer setValue:@"application/vnd.henzfin.api+json;version=1.0" forHTTPHeaderField:@"Accept"];
    
    manager.requestSerializer = requestSerializer;


    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    [manager POST:urlStr parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组

            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
     
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"```上传成功``` %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *ErrorString =[[NSString alloc]initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        
        //AFN3.0 获取 - statusCode
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"post - Http请求错误原因 - %@ , statusCode = %ld", ErrorString, (long)statusCode);
        
    }];

}



@end
