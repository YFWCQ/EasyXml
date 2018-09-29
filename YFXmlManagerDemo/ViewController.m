//
//  ViewController.m
//  YFXmlManagerDemo
//
//  Created by FYWCQ on 2018/9/28.
//  Copyright © 2018年 YFWCQ. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "YFTestModel.h"
#import "EasyXml/EasyXML.h"


@interface ViewController ()

@end

@implementation ViewController {
    EasyXML *_xml;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSDictionary *dic = @{
//                          @"age":@(1),
//                          @"name":@"name",
//                          @"books":@[@"a",@"d",@"g"]
//                          };
//
//
//    YFTestModel *model = [[YFTestModel alloc] init];
//    [model yy_modelSetWithJSON:dic];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MDXML2" ofType:@"xml"];
    
    path = @"http://www.runoob.com/try/xml/note.xml";
    
    EasyXML *xml = [EasyXML analyseSyncXmlUrl:path jsonsTag:@"title" jsonBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL analyseEnd) {
//        NSLog(@"%@",json);
//        NSLog(@"%ld",idx);
//        NSLog(@"%ld",analyseEnd);
        
        YFTestModel *model = [[YFTestModel alloc] init];
        [model yy_modelSetWithJSON:json];
        
        NSLog(@"title:%@",model.title);
        
    }];
    
    _xml = xml;
    
    
    
    
}


@end
