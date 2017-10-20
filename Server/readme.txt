1、添加一个bug
POST      http://139.199.0.47:8080/bug/add
传入格式（json格式）如下
{
    "title": "title",
    "description": "description",
    "answer": "answer",
    "url": "url",
    "category": "category",
    "errorCode": "errorCode",
    "correctedCode": "correctedCode",
    "picture": "picture",
}
上面的参数不用全传，根据需要传即可，成功会会返回一个序列值，该序列值为该bug的身份识别


2、获取一个bug
GET       http://139.199.0.47:8080/bug/get/one?bid=
需要传入参数   bid，也就是上面的序列值
返回一个json格式的bug信息


3、获取多个bug
GET      http://139.199.0.47:8080/bug/get/several?start=0&count=10
需要传入参数 start  表示开始的位置最小值为0
           count  表示传回的个数

返回的格式为多个bug的字典，以各自的序列值为键



