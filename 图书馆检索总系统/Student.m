//
//  Student.m
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/28.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import "Student.h"

@implementation Student

@synthesize name,idnumber,ownBook,money;

-(instancetype)initWithName:(NSString *)sname andidNumber:(NSString *)sidnumber{
    name = sname;
    idnumber = sidnumber;
    ownBook = [NSMutableArray array];
    money= 0;
    
    return self;
}

-(BOOL)borrowBook:(Book *)book{
    
    if(book.bookCount >= 1){
        if (money >= 1) {
            
            if (ownBook.count < 5){
                
                if ([ownBook doesContain:book]) {
                    NSLog(@"您已有此书,请勿重复借阅");
                    return NO;
                }
                else{
                    [ownBook addObject:book];
                    NSLog(@"您已成功借阅%@,基本费扣除1元",book.bookName);
                    book.bookCount--;
                    money--;
                    NSLog(@"您的余额为%i",self.checkAccount);
                    book.borrowTime = [NSDate date];
                    return YES;
                }
            }
            else
                NSLog(@"您已借阅5本书，请归还后再借阅");
            return NO;
        }
        else
            NSLog(@"余额不足，请充值");
        return NO;
    }
    else
        NSLog(@"此书已借完");
    return NO;
    
}

-(BOOL)returnBook:(Book *)book{
    double totalTime;
    
    if([ownBook doesContain:book]){
        book.returnTime = [NSDate date];
        totalTime = [book.returnTime timeIntervalSinceDate:book.borrowTime];
        NSLog(@"借阅时长：%.2fs",totalTime);
        if (totalTime > 3) {
            NSLog(@"超时，加收3元");
            if ([self checkAccount] >= 3 ) {
                money -= 3;
                [ownBook removeObject:book];
                book.bookCount++;
                NSLog(@"您的余额为%i",self.checkAccount);
                NSLog(@"您已成功归还%@",book.bookName);
//                NSLog(@"您已借阅此书%.2fh",totalTime/3600);
                return YES;
            }
            else
                NSLog(@"余额不足，请充值");
            return NO;
        }
        [ownBook removeObject:book];
        book.bookCount++;
        NSLog(@"您已成功归还%@",book.bookName);
//        NSLog(@"您已借阅此书%.2fh",totalTime/3600);
        return YES;
    }
    else
        NSLog(@"您并未借阅此书");
    return NO;
}
-(void)checkOwnBook{
    for (Book *book in ownBook) {
        [book bookPrint];
    }
    
    NSLog(@"您已借阅%lu本书，还能借阅%lu本书",(unsigned long)ownBook.count,5-ownBook.count);
    
}

-(void)printInformation{
    NSLog(@"%@同学你好，您的学号是%@，您已借阅%lu本书",self.name,self.idnumber,(unsigned long)ownBook.count);
}

-(void)addMoney:(int)themoney{
    money += themoney;
}

-(int)checkAccount{
    while (self.money<=0) {
        NSLog(@"请及时充值");
    }
    
    return self.money;
}

-(void)ifreturn:(BOOL)b{
    if (b == YES) {
        NSLog(@"成功归还");
    }
    else
    {
        NSLog(@"归还失败");
    }
}
@end
