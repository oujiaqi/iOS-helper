//
//  ServerInterface.m
//  Start iOS
//
//  Created by brodyli on 2017/10/28.
//  Copyright © 2017年 stev. All rights reserved.
//

#import "ServerInterface.h"
#import "Bug.h"
extern  NSString *SERVER_IP = @"139.199.0.47";
extern NSString *SERVER_PORT = @"8000";
@implementation ServerInterface
//    获取一个指定的bug
//    GET    http://139.199.0.47:8000/bug/get/one?bid=
-(void)getBug:(NSString*) bid
{
    
    
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/get/one?bid=%@",SERVER_IP,SERVER_PORT,bid]];
    
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //4.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            for (NSString *key in dict) {
                id value = dict[key];
                NSLog(@"Value: %@ for key: %@", value, key);
            }
            NSLog(@"%@",dict);
        }
    }];
    
    //5.执行任务
    [dataTask resume];
}






//修改某个bug
//POST      http://139.199.0.47:8000/bug/modify
//可传入的参数
//{
//    "title": "title",
//    "description": "description",
//    "answer": "answer",
//    "url": "url",
//    "category": "category",
//    "errorCode": "errorCode",
//    "correctedCode": "correctedCode",
//    "picture": "picture",
//}
//另外还需要传入bid作为bug的特殊识别
-(void)updateBug:(NSString*)bid
{
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/modify",SERVER_IP,SERVER_PORT]];
    
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
    
    request.HTTPBody = [[NSString stringWithFormat: @"title=%@&category=%@&answer=%@&bid=%@",@"1",@"2",@"3" ,bid] dataUsingEncoding:NSUTF8StringEncoding];
    //    request.HTTPBody = [@"{'title'='test3'}" dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
    }];
    
    //7.执行任务
    [dataTask resume];
}

//上传图片
//POST     http://139.199.0.47:8000/bug/upload/pic
//需要传入的参数
//{
//    "image": 图片文件
//    "bid": bid
//}
//两个为必传
//只有bid存在的才可以传送成功。上传成功后会返回图片的路径，需要在前面加上地址即可访问。
-(void)uploadPicWithBid:(NSString*)bid
{
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/bug/upload/pic?bid=%@",SERVER_IP,SERVER_PORT,bid]]];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:20];
    
    NSURL *url = [NSURL URLWithString: @"http://blog.pic.xiaokui.io/1009e3ee4bc0919e11d32e00ccf55cdf"];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    NSData * imagedata = UIImageJPEGRepresentation(image,1.0);
    
    //    request.HTTPBody = [[NSString stringWithFormat: @"bid=%@", bid] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionUploadTask * uploadtask = [session uploadTaskWithRequest:request fromData:imagedata completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //        NSString * htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        UploadImageReturnViewController * resultvc = [self.storyboard instantiateViewControllerWithIdentifier:@"resultvc"];
        //        resultvc.htmlString = htmlString;
        //        [self.navigationController pushViewController:resultvc animated:YES];
        //        self.progressview.hidden = YES;
        //        [self.spinner stopAnimating];
        //        [self.spinner removeFromSuperview];
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        for (NSString *key in dict) {
            id value = dict[key];
            NSLog(@"Value: %@ for key: %@", value, key);
        }
    }];
    [uploadtask resume];
    
}

@end
