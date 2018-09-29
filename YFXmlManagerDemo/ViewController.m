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
    

    
   
    
    
    
}
- (IBAction)localData:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestXML" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    EasyXML *xml = [EasyXML analyseSyncXmlUrl:url jsonsTags:@[@"TITLE"] jsonBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL analyseEnd) {
        NSLog(@"%@",json);
        NSLog(@"索引 idx:%ld",idx);
        if (analyseEnd) {
            NSLog(@"解析完毕");
        }
        
        
        //        YFTestModel *model = [[YFTestModel alloc] init];
        //        [model yy_modelSetWithJSON:json]
        
    }];
    
    _xml = xml;
}
- (IBAction)remoteData:(id)sender {
 
    NSURL *url = [NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/cd_catalog.xml"];

    EasyXML *xml = [EasyXML analyseAsyncXmlUrl:url jsonsTags:@[@"TITLE"] jsonBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL analyseEnd) {
        NSLog(@"%@",json);
        NSLog(@"idx:%ld",idx);
        //        YFTestModel *model = [[YFTestModel alloc] init];
        //        [model yy_modelSetWithJSON:json];

        if (analyseEnd == YES) {
            NSLog(@"解析完毕");
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新UI
            });
        }

    }];
    
    _xml = xml;
}



@end
