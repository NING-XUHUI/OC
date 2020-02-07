//
//  Book.h
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/25.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject<NSCoding,NSCopying>
@property(copy,nonatomic) NSString *bookName,*bookWriter,*bookPrice,*sort;
@property int bookCode,bookCount;
@property BOOL quality;
@property NSDate *borrowTime,*returnTime;


-(instancetype)init;
-(void)setbookName:(NSString * _Nonnull)name andWriter:(NSString * _Nonnull)writer;
-(void)setbookPrice:(NSString * _Nonnull)price andBookCode:(int)code;
-(void)bookPrint;
-(void) setSort:(NSString *)sortname;
-(void)assignbookName:(NSString *)theBookName andWriter:(NSString *)theWriter andPrice:(NSString *)thePrice andSort:(NSString *)theSort andBookCount:(int)theCount andBookCode:(int)theCode;
@end

NS_ASSUME_NONNULL_END
