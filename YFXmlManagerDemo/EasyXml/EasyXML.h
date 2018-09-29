//
//  EasyXML.h
//  YFXmlManagerDemo
//
//  Created by FYWCQ on 2018/9/28.
//  Copyright © 2018年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface EasyXML : NSObject

/**
 异线程解析

 @param url url
 @param jsonsTag 根据此Tag 来区分 有多少个 json
 @param jsonBlock block
 @return EasyXML
 */
+ (instancetype)analyseAsyncXmlUrl:(NSString *)url jsonsTag:(NSString *)jsonsTag jsonBlock:(void(^)(NSDictionary *json, NSUInteger idx,BOOL analyseEnd))jsonBlock;
/**
 主线程解析
 
 @param url url
 @param jsonsTag 根据此Tag 来区分 有多少个 json
 @param jsonBlock block
 @return EasyXML
 */
+ (instancetype)analyseSyncXmlUrl:(NSString *)url jsonsTag:(NSString *)jsonsTag jsonBlock:(void(^)(NSDictionary *json, NSUInteger idx,BOOL analyseEnd))jsonBlock;

@end


NS_ASSUME_NONNULL_END
