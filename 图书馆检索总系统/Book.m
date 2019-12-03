//
//  Book.m
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/25.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import "Book.h"

@implementation Book
@synthesize bookName,bookWriter,bookPrice,bookCode,sort,bookCount,quality,borrowTime,returnTime;


-(instancetype)init{
    bookCode = 0;
    bookName = @" ";
    bookPrice = @" ";
    bookWriter = @" ";
    bookCount = 0;
    sort = @" ";
    quality = YES;
    
    return self;
}

-(void)setbookPrice:(NSString *)price andBookCode:(int)code
{
    bookPrice = price;
    bookCode = code;
}
-(void)setbookName:(NSString *)name andWriter:(NSString *)writer
{
    bookName = name;
    bookWriter = writer;
}
-(void)bookPrint{
    NSLog(@"=============================");
    NSLog(@"|        %-19@|",bookName);
    NSLog(@"|                           |");
    NSLog(@"|        %-20@|",bookWriter);
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|                           |");
    NSLog(@"|          $%-16@|",bookPrice);
    NSLog(@"|         %-18i|",bookCode);
    NSLog(@"=============================");
    
}
-(void)setSort:(NSString *)sortname{
    sort = sortname;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:bookName forKey:@"BookName"];
    [encoder encodeObject:bookWriter forKey:@"BookWriter"];
    [encoder encodeObject:sort forKey:@"Sort"];
    [encoder encodeObject:bookPrice forKey:@"BookPrice"];
    [encoder encodeObject:@(bookCount) forKey:@"BookCount"];
    [encoder encodeObject:@(bookCode) forKey:@"BookCode"];
}
-(id)initWithCoder:(NSCoder *)decoder{
    bookName = [decoder decodeObjectForKey:@"BookName"];
    bookWriter = [decoder decodeObjectForKey:@"BookWriter"];
    sort = [decoder decodeObjectForKey:@"Sort"];
    bookPrice = [decoder decodeObjectForKey:@"BookPrice"];
    bookCount = [decoder decodeObjectForKey:@"BookCount"];
    bookCode = [decoder decodeObjectForKey:@"BookCode"];
    
    return self;
}
@end
