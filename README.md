EasyXml
================
* EasyXML can let you use data like json


#### CocoaPods

With [CocoaPods](http://cocoapods.org/), add this line to your `Podfile`.

```
pod 'EasyXml'
```

and run `pod install`, then you're all done!

#### Manually
1. Download and drop ```/EasyXml```folder in your project.  
2. Congratulations! 

## How to use

#### 主线程

```
NSString *path = [[NSBundle mainBundle] pathForResource:@"TestXML" ofType:@"xml"];
NSURL *url = [NSURL fileURLWithPath:path];
    
_xml = [EasyXML analyseSyncXmlUrl:url jsonsTags:@[@"TITLE"] jsonBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL analyseEnd) {
        NSLog(@"%@",json);
        NSLog(@"索引 idx:%ld",idx);
        if (analyseEnd) {
            NSLog(@"解析完毕");
        }
    }];
   
```

#### 异线程 

```
NSURL *url = [NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/cd_catalog.xml"];
_xml = [EasyXML analyseAsyncXmlUrl:url jsonsTags:@[@"TITLE"] jsonBlock:^(NSDictionary * _Nonnull json, NSUInteger idx, BOOL analyseEnd) {
        NSLog(@"%@",json);
        NSLog(@"索引idx:%ld",idx);
        
        if (analyseEnd == YES) {
            NSLog(@"解析完毕");
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新UI
            });
        }

    }];

```
