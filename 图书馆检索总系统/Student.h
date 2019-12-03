//
//  Student.h
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/28.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "Library.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
@property(copy,nonatomic)NSString *name,*idnumber;
@property(copy,nonatomic)NSMutableArray *ownBook;
@property int money;


-(instancetype)initWithName:(NSString *)sname andidNumber:(NSString *)sidnumber;

-(BOOL)borrowBook:(Book *)book;
-(BOOL)returnBook:(Book *)book;
-(void)checkOwnBook;
-(void)printInformation;
-(void)addMoney:(int)themoney;
-(int)checkAccount;
-(void)ifreturn:(BOOL)b;

@end

NS_ASSUME_NONNULL_END
