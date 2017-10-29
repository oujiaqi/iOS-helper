//
//  ServerInterface.h
//  Start iOS
//
//  Created by brodyli on 2017/10/28.
//  Copyright © 2017年 stev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ServerInterface : NSObject
-(void)getBug:(NSString*) bid;

//    获取多个bug
//    GET      http://139.199.0.47:8000/bug/get/several?start=0&count=10
//    需要传入参数 start  表示开始的位置最小值为0
//    count  表示传回的个数
//    返回的格式为多个bug的字典，以各自的序列值为键
-(void)getBugs;

-(void)deleteBug:(NSString*)bugid;

-(void)addBug;

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
-(void)updateBug:(NSString*)bid;

//上传图片
//POST     http://139.199.0.47:8000/bug/upload/pic
//需要传入的参数
//{
//    "image": 图片文件
//    "bid": bid
//}
//两个为必传
//只有bid存在的才可以传送成功。上传成功后会返回图片的路径，需要在前面加上地址即可访问。
-(void)uploadPicWithBid:(NSString*)bid;
@end
