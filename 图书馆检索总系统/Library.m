//
//  Library.m
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/25.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import "Library.h"

@implementation Library
@synthesize library,libraryName;

-(instancetype)initWithName{
    self = [super self];
    if(self){
        libraryName = @"西安工业大学图书馆--书单";
        library = [NSMutableArray array];
    }
    return self;
}

-(instancetype)init{
    libraryName = @"无";
    library = [NSMutableArray array];
    
    return self;
}

-(int)bookCount{
    int a = 0;
    for (Book *book in library) {
        a += book.bookCount;
    }
    return a;
}



-(void)addBook:(Book *)book{
    if ([library containsObject:book]) {
        NSLog(@"请勿重复添加");
    }
    else
        [library addObject:book];
    
}

-(void)removeBook:(Book *)book{
    [library removeObject:book];
}

-(void)printLibrary{
    NSString *name = @"书名";
    NSString *code = @"编码";
    NSString *writer = @"作者";
    NSString *sort = @"类别";
    NSString *number = @"可借阅数量";
    
    NSLog(@"=====================================Contens of :%@ ================================",self.libraryName);
    NSLog(@"%-28s  %-33s %-20s %-20s %-15s", [name UTF8String], [writer UTF8String], [code UTF8String],[sort UTF8String],[number UTF8String]);
    NSLog(@"\n");
    for (Book *book in library) {
        NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String], [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
    }
    NSLog(@"======================================================================================================");
}

-(void)printInSort:(NSString *)sortname{
    NSLog(@"=================================Contens of :%@ =================================",sortname);
    NSLog(@"\n");
    
    for (Book *book in library) {
        if (book.sort == sortname) {
            NSLog(@"%-25s  %-30s %-20i %-20s ", [book.bookName UTF8String], [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String]);
        }
    }
    NSLog(@"==================================================================================");
}

-(void)addBookCount:(Book *)book andCount:(int)number{
    if(![library doesContain:book]){
        NSLog(@"新书请登记");
        
    }
    else{
        for (Book *thebook in library) {
            if (thebook == book) {
                thebook.bookCount += number;
                break;
            }
            else
                continue;
            
        }
    }
}

-(void)substractBookCount:(Book *)book andCount:(int)number{
    
    for (Book *thebook in library) {
        if (thebook == book && thebook.bookCount >= number) {
            thebook.bookCount -= number;
        }
        else
            continue;
    }
    NSLog(@"库存不足");
}

-(void)searchBookByWriter:(NSString *)writer{
    NSLog(@"===============================================Search of :%@ ========================================",writer);
    for (Book *book in library) {
        if ([book.bookWriter containsString:writer]) {
            NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String], [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
        }
        else
            continue;
    }
    NSLog(@"======================================================================================================");
}
-(void)searchBookBySort:(NSString *)sort{
    NSLog(@"===============================================Search of :%@ ========================================",sort);
    for (Book *book in library) {
        if ([book.sort containsString:sort]) {
            NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String], [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
        }
        else
            continue;
    }
    NSLog(@"======================================================================================================");
}

-(void)getBookCount:(Book *)book;{
    
    
    NSLog(@"%s的数量为:%i",[book.bookName UTF8String],book.bookCount);
    
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:library forKey:@"Library"];
    [encoder encodeObject:libraryName forKey:@"LibraryName"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    library = [decoder decodeObjectForKey:@"Library"];
    libraryName = [decoder decodeObjectForKey:@"LibraryName"];
    
    return self;
}

-(void)readFile:(NSString *)filePath{
    
    NSData *dataArea;
    NSKeyedUnarchiver *unarciver;
    
    dataArea = [NSData dataWithContentsOfFile:filePath];
    unarciver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataArea];
    
    self.library = [unarciver decodeObjectForKey:@"Library"];
    self.libraryName = [unarciver decodeObjectForKey:@"LibraryName"];
    
    [unarciver finishDecoding];
}

-(void)writeToFile:(NSString *)filePath{
    
    NSMutableData *dataArea;
    NSKeyedArchiver *archiver;
    
    dataArea = [NSMutableData data];
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataArea];
    [archiver encodeObject:libraryName forKey:@"LibraryName"];
    [archiver encodeObject:library forKey:@"Library"];
    [archiver finishEncoding];
    
    if ([dataArea writeToFile:filePath atomically:YES] == YES) {
        NSLog(@"成功导出文件");
    }
    else
        NSLog(@"导出文件失败");
    
}


@end
