//
//  EasyXML.m
//  YFXmlManagerDemo
//
//  Created by FYWCQ on 2018/9/28.
//  Copyright © 2018年 YFWCQ. All rights reserved.
//

#import "EasyXML.h"

@interface EasyXML ()<NSXMLParserDelegate>
@property(nonatomic, copy)NSURL *url;
@property(nonatomic, copy)void(^jsonBlock)(NSDictionary *jsonDic,NSUInteger idx,BOOL analyseEnd);

@property(nonatomic, assign)NSUInteger idx;
/**
 * 以此标签  给 数据分组
 */
@property(nonatomic,strong)NSMutableSet *jsonsTagSet;


@property(nonatomic, strong)NSMutableDictionary *tempJsonDic;

@end


@implementation EasyXML {
    NSString *_currentTagName;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.jsonsTagSet = [NSMutableSet set];
    }
    return self;
}

+ (instancetype)analyseAsyncXmlUrl:(NSURL *)url jsonsTags:(NSArray *)jsonsTags jsonBlock:(void(^)(NSDictionary *json, NSUInteger idx,BOOL analyseEnd))jsonBlock {
    EasyXML *easyXml = [[EasyXML alloc] init];
    easyXml.url = url;
    [easyXml.jsonsTagSet addObjectsFromArray:jsonsTags];
    easyXml.jsonBlock = jsonBlock;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [easyXml analyseXml];
    });
    return easyXml;
}


+ (instancetype)analyseSyncXmlUrl:(NSURL *)url jsonsTags:(NSArray *)jsonsTags jsonBlock:(void(^)(NSDictionary *json, NSUInteger idx,BOOL analyseEnd))jsonBlock {
    EasyXML *easyXml = [[EasyXML alloc] init];
    easyXml.url = url;
    [easyXml.jsonsTagSet addObjectsFromArray:jsonsTags];
    easyXml.jsonBlock = jsonBlock;
    [easyXml analyseXml];
    
    return easyXml;
}


- (void)analyseXml {
    if (_url == nil) {
        NSLog(@"url != nil");
        return;
    }
    
    self.idx = 0;
    
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:self.url];
    parser.delegate = self ;
    [parser parse];

}


//文档开始时触发 ,开始解析时 只触发一次
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    //    NSLog(@"开始解析");
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"错误:%@",parseError);
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    
    //如果名字 是Note就取出 id
    if ([self.jsonsTagSet containsObject:_currentTagName]) {

        if (self.jsonBlock && self.tempJsonDic) {
            self.jsonBlock(self.tempJsonDic, self.idx, NO);
        }
        // 第二个字典 加1
        if (self.tempJsonDic) {
            self.idx ++;
        }
        self.tempJsonDic = [NSMutableDictionary dictionary];
        
    }
    
    
    
}

#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSLog(@"string:%@",string);
    if (string.length == 0 || string == nil || _currentTagName == nil)
    {
        return;
    }
    
    [self.tempJsonDic setObject:string forKey:_currentTagName];
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    
    if (self.jsonBlock) {
        self.jsonBlock(self.tempJsonDic, self.idx, YES);
    }
}

@end
