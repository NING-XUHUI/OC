//
//  main.m
//  图书馆检索总系统
//
//  Created by 宁旭晖 on 2019/11/25.
//  Copyright © 2019 宁旭晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "Library.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//
//        Book *book1 = [[Book alloc] init];
//        Book *book2 = [[Book alloc] init];
//        Book *book3 = [[Book alloc] init];
//        Book *book4 = [[Book alloc] init];
//        Book *book5 = [[Book alloc] init];
//        //        Book *book6 = [[Book alloc] init];
//
//        [book1 setbookName:@"Objective-C" andWriter:@"Stephen·G"];
//        [book1 setbookPrice:@"23.99" andBookCode:11043901];
//        [book1 setSort:@"CS"];
//        [book1 setBookCount:10];
//
//        [book2 setSort:@"CS"];
//        //        [book2 setBookCode:11053874];
//        [book2 setbookName:@"C++" andWriter:@"JR·Will"];
//        [book2 setbookPrice:@"35.99" andBookCode:11053874];
//
//        [book3 setbookPrice:@"19.99" andBookCode:17383499];
//        [book3 setbookName:@"Keep Healthy" andWriter:@"Judy·Phibby"];
//        [book3 setSort:@"Healthy"];
//
//        [book4 setbookName:@"IRON MAN" andWriter:@"OXford"];
//        [book4 setbookPrice:@"199.99" andBookCode:18495333];
//        [book4 setSort:@"Movie"];
//        [book4 setBookCount:13];
//
//        [book5 setbookPrice:@"47.99" andBookCode:29908787];
//        [book5 setbookName:@"JESSUS" andWriter:@"LEON·NING"];
//        [book5 setSort:@"Movie"];
//        [book5 setBookCount:8];
//
//
//
//        Library *xatu = [[Library alloc] initWithName];
//
//        [xatu addBook:book1];
//        [xatu addBook:book2];
////        [xatu addBook:book3];
////        [xatu addBook:book4];
////        [xatu addBook:book5];
//        [book3 setBookCount:10];
//        [book3 setBookCount:10];
//
//        [xatu printLibrary];
//
//        [xatu writeToFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/xatulibrary.arc"];

        Library *xatu = [[Library alloc] init];

        [xatu readFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/xatulibrary.arc"];
        [xatu printLibrary];
    }
    
    return 0;

}
