//
//  Library.h
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/25.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface Library : NSObject<NSCopying,NSCoding>
@property (copy,nonatomic)NSMutableArray *library;
@property (copy,nonatomic)NSString *libraryName;
-(instancetype)initWithName;
-(instancetype)init;
-(void)addBook:(Book *)book;
-(void)removeBook:(Book *)book;
-(void)printLibrary;
-(int)bookCount;
-(void)printInSort:(NSString *)sortname;
-(void)addBookCount:(Book *)book andCount:(int)number;
-(void)substractBookCount:(Book *)book andCount:(int)number;
-(void)searchBookByWriter:(NSString *)writer;
-(void)searchBookBySort:(NSString *)sort;
-(void)getBookCount:(Book *)book;

-(void)readFile:(NSString *)filePath;
-(void)writeToFile:(NSString *)filePath;


@end




NS_ASSUME_NONNULL_END
