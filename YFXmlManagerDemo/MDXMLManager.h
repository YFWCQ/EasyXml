//
//  MDXMLManager.h
//  MDXMLManager
//
//  Created by Medalands on 15/5/27.
//  Copyright (c) 2015年 NNTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDXMLManager : NSObject

@property(nonatomic,copy)void (^analyzeSuccess)(NSMutableArray *);

/**
 * 以此标签  给 数据分组
 */
@property(nonatomic,copy)NSString *stringTag;

/**
 * 解析本地XML的文件
 
 
 
 */
-(void)startAnalyzeFileName:(NSString *)name type:(NSString *)type stringTag:(NSString *)stringTag modelClass:(Class)modelClass success:(void(^)(NSMutableArray *))success;

+ (instancetype)sharedInstance;

@end
