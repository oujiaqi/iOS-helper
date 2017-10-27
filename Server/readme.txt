1、添加一个bug
POST      http://139.199.0.47:8000/bug/add
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
GET       http://139.199.0.47:8000/bug/get/one?bid=
需要传入参数   bid，也就是上面的序列值(必须传送，否则无有效返回)
返回一个json格式的bug信息


3、获取多个bug
GET      http://139.199.0.47:8000/bug/get/several?start=0&count=10
需要传入参数 start  表示开始的位置最小值为0
           count  表示传回的个数

返回的格式为多个bug的字典，以各自的序列值为键


4、修改某个bug
POST      http://139.199.0.47:8000/bug/modify
可传入的参数
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

另外还需要传入bid作为bug的特殊识别

5、删除某个bug
GET      http://139.199.0.47:8000/bug/del/one
传入 bid

6、上传图片
POST     http://139.199.0.47:8000/bug/upload/pic

需要传入的参数
{
	"image": 图片文件
	"bid": bid
}
两个为必传
只有bid存在的才可以传送成功。上传成功后会返回图片的路径，需要在前面加上地址即可访问。

