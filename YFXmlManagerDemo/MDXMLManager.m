//
//  MDXMLManager.m
//  MDXMLManager
//
//  Created by Medalands on 15/5/27.
//  Copyright (c) 2015年 NNTeam. All rights reserved.
//

#import "MDXMLManager.h"

@interface MDXMLManager ()<NSXMLParserDelegate>

 // 记录当前解析的标签
@property(nonatomic,copy)NSString *currentTagName;

@property(nonatomic,copy)NSMutableArray *notes;

@property(nonatomic,strong)Class modelClass;

@end

@implementation MDXMLManager
{
    NSObject *_currentModel;
    
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static MDXMLManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MDXMLManager alloc] init];
        
    });
    return sharedInstance;
}

// 开始解析
- (void)startAnalyzeFileName:(NSString *)name type:(NSString *)type stringTag:(NSString *)stringTag modelClass:(Class)modelClass success:(void(^)(NSMutableArray *))success{

    
    _modelClass = modelClass;
    
    self.analyzeSuccess = success;
    
    self.stringTag = stringTag;
    
    // 每次解析重新实例化
    _notes = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
        NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:type];
        NSURL * url = [NSURL fileURLWithPath:path];
        
        //开始解析 xml
        NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        parser.delegate = self ;
        
        [parser parse];

        
    });
    
}

//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    
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
    
    
//    NSLog(@"elementName;%@",elementName);
    
    //如果名字 是Note就取出 id
    if ([_currentTagName isEqualToString:_stringTag]) {
        
//        // 实例化一个可变的字典对象,用于存放
        
        
        _currentModel = [[_modelClass alloc] init];
        
        [_notes addObject:_currentModel];
        
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        
//        // 把可变字典 放入到 可变数组集合_notes 变量中
//        [_notes addObject:dict];
        
    }
    
    
    
}

#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (string.length == 0 || string == nil)
    {
        return;
    }
    
    
    [_currentModel setValue:string forKey:_currentTagName];

    
//    if ([_currentTagName isEqualToString:@"title"] && dict) {
//        [dict setObject:string forKey:@"title"];
//        
//        NSLog(@"title:%@",string);
//        
//    }
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentTagName = nil ;
    
//    NSLog(@"解析结束");
    
    //该方法主要是用来 清理刚刚解析完成的元素产生的影响，以便于不影响接下来解析
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.analyzeSuccess)
        {
            self.analyzeSuccess(_notes);
        }
        
        self.analyzeSuccess = nil;
        self.notes = nil;

        //    NSLog(@"解析搞定...");

    });

    
}


@end
