//
//  YFTestModel.h
//  YFXmlManagerDemo
//
//  Created by FYWCQ on 2018/9/28.
//  Copyright © 2018年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//NS_ASSUME_NONNULL_BEGIN

@interface YFTestModel : NSObject

@property(assign)CGFloat age;
@property(copy)NSString *description;
@property(copy)NSString *hint;
@property(copy)NSString *input;
@property(copy)NSString *item;
@property(copy)NSString *memory_limit;
@property(copy)NSString *output;
@property(copy)NSString *sample_input;
@property(copy)NSString *sample_output;
@property(copy)NSString *solution;
@property(copy)NSString *source;
@property(copy)NSString *test_input;
@property(copy)NSString *test_output;
@property(copy)NSString *time_limit;
@property(copy)NSString *title;

@property(strong)NSArray *books;

@end

//NS_ASSUME_NONNULL_END
