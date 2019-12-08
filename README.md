
# OC简单图书馆系统

## 功能介绍：

### 1.图书馆内可以添加、删除书籍。
### 2.图书馆可以查询书籍的信息，包括书名、作者、书籍编号、书籍分类、书籍剩余可借阅量。
### 3.图书馆可以打印出总书单，还可以按照要求查询某一作者或某一类别的书单。
### 4.学生类可以在图书馆中借阅书籍，并可计算借阅时间（书籍的借出时间将归档在你电脑上的某个文件中，直至归还），超时将额外收费。

`#import <Foundation/Foundation.h>`
下面先从Book类开始：

## Book类建立：
@interface：
```
@interface Book : NSObject<NSCoding,NSCopying>
@property(copy,nonatomic) NSString *bookName,*bookWriter,*bookPrice,*sort;
@property int bookCode,bookCount;
@property NSDate *borrowTime,*returnTime;
@property NSString *strborrowtime;
```
Book类属性包括NSString：书名、作者、价格及分类，int：书本编号、书本数量，
NSDate：借出及归还时间，NSString：借出时间的string格式。这里不需要归还时间的string格式，是因为我们只需要储存借出时间。
```
-(instancetype)init;
-(void)setbookName:(NSString * _Nonnull)name andWriter:(NSString * _Nonnull)writer;
-(void)setbookPrice:(NSString * _Nonnull)price andBookCode:(int)code;
-(void)bookPrint;
-(void) setSort:(NSString *)sortname;
-(void)assignbookName:(NSString *)theBookName andWriter:(NSString *)theWriter 
andPrice:(NSString *)thePrice andSort:(NSString *)theSort andBookCount:(int)theCount andBookCode:(int)theCode;
@end
```
建立Book类的实例函数，它包括：初始化方法、设置书籍的书名及作者、
设置书籍的价格及编码（当然可以都归入同一函数中）、打印书本、设置书籍的分类、及将书籍排序方法。下面是每一个函数的具体方法。

@implementation:
```
@implementation Book
@synthesize bookName,bookWriter,bookPrice,bookCode,sort,bookCount,quality,borrowTime,returnTime,strborrowtime;
```
`-(instancetype)init;`在书籍初始化时，所有NSString内容为空，所有int数据为0：
```
-(instancetype)init{
    bookCode = 0;
    bookName = @" ";
    bookPrice = @" ";
    bookWriter = @" ";
    bookCount = 0;
    sort = @" ";
    return self;
}
```

`-(void)setbookName:(NSString * _Nonnull)name andWriter:(NSString * _Nonnull)writer;`
设置书籍的书名及作者：
```
-(void)setbookName:(NSString *)name andWriter:(NSString *)writer
{
    bookName = name;
    bookWriter = writer;
}
```
其余设置函数相同，这里不再写。

`-(void)bookPrint;`将书本打印出来时，相当于打印封面，上面将有书籍的基本信息。
```
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
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208223816714.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2F3ZGFzZGFzZDE=,size_16,color_FFFFFF,t_70)

## Library类的建立：
`#import <Foundation/Foundation.h>`
`#import "Book.h"`

@interface:
```
@interface Library : NSObject<NSCopying,NSCoding>
@property (copy,nonatomic)NSMutableArray *library;
@property (copy,nonatomic)NSString *libraryName;
```
Library类的属性包括：可变数组library（用于添加书籍）、NSString图书馆名称。
在后续用到文件的归解档时，这里需要发生一些小改变。
```
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
```
Library类的实例方法包括：初始化、添加书本、移除书本、打印书单、返回书本总数、
按分类打印书单、添加书本数量、减少书本数量、按关键字搜索书本并列出书单。下面来看每个实例方法的具体代码：

@implementation:
```
@synthesize library,libraryName;
```

` -(instancetype)initWithName;`
```
-(instancetype)initWithName{
    self = [super self];
    if(self){
        libraryName = @"西安工业大学图书馆--书单";
        library = [NSMutableArray array];
    }
    return self;
}
```
由于笔者来自西工院，所以这里直接将图书馆命名为本校，若想修改，只需修改`-(instancetype)initWithName:(NSString *):yourUniversityLibraryName`即可，并在函数内进行替换。同时，初始化一个NSMutableArray可变数组library。

`-(int)bookCount;`要获得书籍总数，只需要将library中所有Book类对象的bookCount进行累加:
```
-(int)bookCount{
    int a = 0;
    for (Book *book in library) {
        a += book.bookCount;
    }
    return a;
}
```

`-(void)addBook:(Book *)book;`添加书本:
```
if ([library containsObject:book]) {
        NSLog(@"请勿重复添加");
    }
    else
        [library addObject:book];
}
```

`-(void)removeBook:(Book *)book;`移除书本：
```
-(void)removeBook:(Book *)book{
    [library removeObject:book];
}
```

`-(void)printLibrary`打印总书单：
```
NSString *name = @"书名";
    NSString *code = @"编码";
    NSString *writer = @"作者";
    NSString *sort = @"类别";
    NSString *number = @"可借阅数量";
    
    NSLog(@"=====================================Contens of :%@ ================================",self.libraryName);
    NSLog(@"%-28s  %-33s %-20s %-20s %-15s", [name UTF8String], 
    [writer UTF8String], [code UTF8String],[sort UTF8String],[number UTF8String]);
    NSLog(@"\n");
    for (Book *book in library) {
        NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String],
        [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
    }
    NSLog(@"======================================================================================================");
}
```

`-(void)addBookCount:(Book *)book andCount:(int)number;`添加书本数量：
```
   if(![library doesContain:book]){
        NSLog(@"新书请登记");
    }
```
前提是馆内已有此书，否则应该使用addBook函数。
```
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
```

`-(void)substractBookCount:(Book *)book andCount:(int)number;`同理，减少书本数量：
```
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
```
`-(void)searchBookByWriter:(NSString *)writer;`通过搜索作者名（可不输完整名），来查找书单：
```
-(void)searchBookByWriter:(NSString *)writer{
    NSLog(@"===============================================Search of :%@ ========================================",writer);
    for (Book *book in library) {
        if ([book.bookWriter containsString:writer]) {
            NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String], 
            [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
        }
        else
            continue;
    }
    NSLog(@"======================================================================================================");
}
```

`-(void)searchBookBySort:(NSString *)sort;`同理，通过搜索类别来查找书籍：
```
-(void)searchBookBySort:(NSString *)sort{
    NSLog(@"===============================================Search of :%@ ========================================",sort);
    for (Book *book in library) {
        if ([book.sort containsString:sort]) {
            NSLog(@"%-25s  %-30s %-20i %-20s %-15i", [book.bookName UTF8String], 
            [book.bookWriter UTF8String], book.bookCode,[book.sort UTF8String],book.bookCount);
        }
        else
            continue;
    }
    NSLog(@"======================================================================================================");
}
```

`-(void)getBookCount:(Book *)book;`获得某一本书的库存量：
```
-(void)getBookCount:(Book *)book;{
    NSLog(@"%s的数量为:%i",[book.bookName UTF8String],book.bookCount);
}
```

## Student类的建立：
`#import <Foundation/Foundation.h>`
`#import "Book.h"`
`#import "Library.h"`

@interface:
student类的属性包括：NSString类型的姓名、学号，NSMutableArray类型的ownbook在借图书，以及余额。
在文件的归解档时，也要在此做小修改。
```
@interface Student : NSObject
@property(copy,nonatomic)NSString *name,*idnumber;
@property(copy,nonatomic)NSMutableArray *ownBook;
@property int money;
```

学生类的实例函数包括：初始化、借书、还书、查看已借书、打印个人信息、充钱、扣钱、查看余额。
```
-(instancetype)initWithName:(NSString *)sname andidNumber:(NSString *)sidnumber;
-(void)borrowBook:(NSString *)bookname from:(Library *)libraryname;
-(void)returnBook:(NSString *)bookname to:(Library *)libraryname;
-(void)checkOwnBook;
-(void)printInformation;
-(void)addMoney:(int)themoney;
-(void)substractMoney:(int)themoney;
-(int)checkAccount;
```

@implementation：
```
@implementation Student

@synthesize name,idnumber,ownBook,money;
```
下面看每个实例方法的具体函数：
`-(instancetype)initWithName:(NSString *)sname andidNumber:(NSString *)sidnumber;`
初始化并设置姓名及ID。
```
-(instancetype)initWithName:(NSString *)sname andidNumber:(NSString *)sidnumber{
    name = sname;
    idnumber = sidnumber;
    ownBook = [NSMutableArray array];
    money= 0;
    return self;
}
```
`-(void)addMoney:(int)themoney;`充钱：
```
-(void)addMoney:(int)themoney{
    money += themoney;
}
```
扣钱同理。

`-(int)checkAccount;`查看余额：
```
-(int)checkAccount{
    while (self.money<=0) {
        NSLog(@"请及时充值");
    }
    
    return self.money;
}
```
`-(void)printInformation;`打印个人信息:
```
-(void)printInformation{
    NSLog(@"%@同学你好，您的学号是%@，您已借阅%lu本书",self.name,self.idnumber,(unsigned long)ownBook.count);
}
```

`-(void)checkOwnBook;`查看已借书籍（假设没人最多同时借5本）:
```
-(void)checkOwnBook{
    for (Book *book in self.ownBook) {
        [book bookPrint];
    }
    
    NSLog(@"您已借阅%lu本书，还能借阅%lu本书",(unsigned long)ownBook.count,5-ownBook.count);
    
}
```

接下来是最重要的借书与还书函数：
首先借书：
`-(void)borrowBook:(NSString *)bookname from:(Library *)libraryname;`这里实现的是根据书名来借书。
只有借书成功了，才会有文字提示。需要注意的是string类型的比较，这里用到了`isEqualToString`而不是`==`。
```
-(void)borrowBook:(NSString *)bookname from:(Library *)libraryname{
    for (Book *rbookname in libraryname.library) {
        if ([rbookname.bookName isEqualToString: bookname] && rbookname.bookCount > 0 ) {
            [self.ownBook addObject:rbookname];
            rbookname.bookCount--;
            [self substractMoney:1];
            break;
        }
        else
        {
            continue;
        }
    }
    
    
}
```

`-(void)returnBook:(NSString *)bookname to:(Library *)libraryname;`还书。
```
-(void)returnBook:(NSString *)bookname to:(Library *)libraryname{
double totalTime;

    for (Book *rbookname in self.ownBook) {
     
    if ([rbookname.bookName isEqualToString:bookname]) {
        for (Book *b in libraryname.library) {
            if ([b.bookName isEqualToString:rbookname.bookName]) {
                [b addBookCount:1];
            }
        }
        NSLog(@"成功归还");
        [self.ownBook removeObject:rbookname];
    }
    else{
        continue;

    }
}

```

至此一个较为完整的图书馆就建立完成了。下面开始讲解如何计算借阅时间。
先讲讲思路，给书添加两个NSDate属性，分别是借出时间和归还时间，最后用timeInterval函数求出间隔时间即是借阅时间。
当借阅时间大于规定时间时，则额外收费。

在计算节约时间之前，我们先来将图书馆和学生进行文件归档。先来了解一下不同的归档方式。
方式1:
```
[NSKeyedArchiver archiveRootObject:id toFile:String * (.arch)]; 

id = [NSKeyedUnarchiver unarchiveObjectWithFile:String *(.arch) ]; 
```
方式2：利用NSData
```
NSMutableData *dataArea;
NSkeyedArchiver *archiver;
id *id;

dataArea = [NSMutableData data]; //设置数据区

archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataArea];

[archiver encodeObject:id forKey:String * ];

[archiver finishEncoding];

[dataArea writeToFile:String * automically:YES];


NSData *dataArea;
NSKeyedUnArchiver *unarchiver;
id *id;

dataArea = [NSData dataWithContentsOfFile:String * ];
unarchiver = [[NSKeyedUnArchiver alloc] initForReadingWithData:dataArea];

id = [unarchiver decodeObjectForKey:String *];

[unarchiver finishingDecoding];

```
在这里我们选择方式二
首先对Book类对象编写编码和解码函数：
```
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.bookName forKey:@"BookName"];
    [encoder encodeObject:self.bookWriter forKey:@"BookWriter"];
    [encoder encodeObject:self.sort forKey:@"Sort"];
    [encoder encodeObject:self.bookPrice forKey:@"BookPrice"];
    [encoder encodeInt:self.bookCount forKey:@"BookCount"];
    [encoder encodeInt:self.bookCode forKey:@"BookCode"];
    [encoder encodeObject:self.strborrowtime forKey:@"BorrowTime"];

}
-(id)initWithCoder:(NSCoder *)decoder{
    bookName = [decoder decodeObjectForKey:@"BookName"];
    bookWriter = [decoder decodeObjectForKey:@"BookWriter"];
    sort = [decoder decodeObjectForKey:@"Sort"];
    bookPrice = [decoder decodeObjectForKey:@"BookPrice"];
    bookCount = [decoder decodeIntForKey:@"BookCount"];
    bookCode = [decoder decodeIntForKey:@"BookCode"];
    strborrowtime = [decoder decodeObjectForKey:@"BorrowTime"];

    return self;
}
```
这里需要注意的是，不同类型在编解码时，应使用不同的编解码方式。例如：
NSString 可以使用
`[encoder encodeObject:self.bookName forKey:@"BookName"];`
` bookName = [decoder decodeObjectForKey:@"BookName"];`
而到了Int时，应使用
` [encoder encodeInt:self.bookCount forKey:@"BookCount"];`
` bookCount = [decoder decodeIntForKey:@"BookCount"];`
如果不区分这里，编译器并不会报错，但在解码时，Int型会发生错误。

编写完Book类的编解码函数后，下面来处理Library，我直接将归解档分别编入了一个函数，如下：

```
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
    [archiver encodeObject:library forKey:@"Library"];
    [archiver encodeObject:libraryName forKey:@"LibraryName"];
    [archiver finishEncoding];
    
    if ([dataArea writeToFile:filePath atomically:YES] == YES) {
        NSLog(@"成功导出文件");
    }
    else
        NSLog(@"导出文件失败");
    
}
```
相当于利用字典，将待处理的值和对应的键一起储存起来，所以，对应值的key一定要相同。

同理，Student类也可以用相同的方法。

```
-(void)readFile:(NSString *)filePath{
    NSData *dataArea;
    NSKeyedUnarchiver *unarciver;
    
    dataArea = [NSData dataWithContentsOfFile:filePath];
    unarciver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataArea];
    
    self.name = [unarciver decodeObjectForKey:@"Name"];
    self.idnumber = [unarciver decodeObjectForKey:@"IDNumber"];
    self.ownBook = [unarciver decodeObjectForKey:@"OwnBook"];
    self.money = [unarciver decodeIntForKey:@"Money"];
    
    [unarciver finishDecoding];
}

-(void)writeToFile:(NSString *)filePath{
    NSMutableData *dataArea;
    NSKeyedArchiver *archiver;
    
    dataArea = [NSMutableData data];
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataArea];
    
    [archiver encodeObject:name forKey:@"Name"];
    [archiver encodeObject:idnumber forKey:@"IDNumber"];
    [archiver encodeInt:money forKey:@"Money"];
    [archiver encodeObject:ownBook forKey:@"OwnBook"];
    
    [archiver finishEncoding];
    
    if ([dataArea writeToFile:filePath atomically:YES] == YES) {
        NSLog(@"成功导出文件");
    }
    else
        NSLog(@"导出文件失败");
}
```

好了，现在可以处理计算借阅时间了。我也想把借书时间归档进文件中，但是编解码中，
没有适当的函数对NSDate数据进行处理，所以，这里我们将新建一个NSString来和NSDate进行相互转换。
我们不需要储存归还时间，当然只是针对我想实现的功能。
首先在Book类里添加3个属性：

```
@property NSDate *borrowTime,*returnTime;
@property NSString *strborrowtime;
```
显然，borrowTime在学生类的borrowBook函数中能用到,当学生成功借到一本书时，这本书的borrowTime即记录当地时间。
修改学生类的借书函数：
```
for (Book *rbookname in libraryname.library) {
       if ([rbookname.bookName isEqualToString: bookname] && rbookname.bookCount > 0 ) {
           [self.ownBook addObject:rbookname];
           NSLog(@"同学你好，你已成功借到%@，基础费用一元，七天后归还加收三元。",rbookname.bookName);
           rbookname.bookCount--;
           [self substractMoney:1];
           rbookname.borrowTime = [NSDate date];
           NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
           [f1 setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
           rbookname.strborrowtime = [f1 stringFromDate:rbookname.borrowTime];
           NSLog(@"借书成功");
           break;
       }
       else
       {
           continue;
       }
   }
```
在学生借到书后，borrowTime获取时间，并将时间以一个格式传给strborrowtime。这样我们就可以把strborrowtime一起归档。
```
rbookname.borrowTime = [NSDate date];
NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
[f1 setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
rbookname.strborrowtime = [f1 stringFromDate:rbookname.borrowTime];
```

下面修改学生的还书函数。

```
double totalTime;
   
       for (Book *rbookname in self.ownBook) {
        
       if ([rbookname.bookName isEqualToString:bookname]) {
           for (Book *b in libraryname.library) {
               if ([b.bookName isEqualToString:rbookname.bookName]) {
                   [b addBookCount:1];
               }
           }
           rbookname.returnTime = [NSDate date];
           NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
           [f1 setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
           
           NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"CUT"];
           [f1 setTimeZone:zone];
           rbookname.borrowTime = [f1 dateFromString:rbookname.strborrowtime];
           totalTime = [rbookname.returnTime timeIntervalSinceDate:rbookname.borrowTime];
           NSLog(@"您的借阅时长为%.2f。",totalTime);
           if (totalTime > 3) {
               NSLog(@"加收三元");
               [self substractMoney:3];

           }
           NSLog(@"成功归还");
           
           [self.ownBook removeObject:rbookname];
       }
       else{
           continue;
   
       }
   }
```

这里需要用到NSTimeZone，并设置时区，将储存后又被取出的strborrow重新赋给borrowTime。
再利用函数求出totalTime。
```
double totalTime;

rbookname.returnTime = [NSDate date];
NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
[f1 setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];

NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"CUT"];
[f1 setTimeZone:zone];
rbookname.borrowTime = [f1 dateFromString:rbookname.strborrowtime];
totalTime = [rbookname.returnTime timeIntervalSinceDate:rbookname.borrowTime];
```

代码部分全部完成，下面来实际操作一下。

首先建立一本书，并设置基本信息。
```
Book *book1 = [[Book alloc] init];
[book1 setbookName:@"Objective-C" andWriter:@"Stephen·G"];
[book1 setbookPrice:@"23.99" andBookCode:11043901];
[book1 setSort:@"CS"];
[book1 setBookCount:10];
```

然后建立一个图书馆。
```
 Library *xatu = [[Library alloc] initWithName];
 [xatu addBook:book1];
```

接着建立一个学生。
```
Student *s1 = [[Student alloc] initWithName:@"NING" andidNumber:@"1704****113"];
[s1 setMoney:10];
```
我们先来看看图书馆的书单
```
[xatu printLibrary];
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208224012464.png)
接着看看学生的借书情况
```
[s1 checkOwnBook];
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208224024547.png)
接下来我们来借书并查看借书情况
```
[s1 borrowBook:@"Objective-C" from:xatu];
[s1 checkOwnBook];
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208224041409.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2F3ZGFzZGFzZDE=,size_16,color_FFFFFF,t_70)
然后学生离去，数据都将归档,填写路径。

```
[xatu writeToFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/xatulibrary.arc"];
[s1 writeToFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/student.arc"];
```

此后，在对Library和Student要做出更新时，都可以新建对象，并从文件中获得数据。
比如现在刚刚那位借书的同学来还书了，但我们不可能记住每个人的信息。

我们可以新建一个图书馆和一个学生，在一个全新的main中,导入信息。
```
Library *xatu = [[Library alloc] init];
Student *s1 = [[Student alloc] init];

 [xatu readFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/xatulibrary.arc"];
 [s1 readFile:@"/Users/ningxuhui/Desktop/code/Objective-C/图书馆检索总系统/图书馆检索总系统/student.arc"];
```
我们来验证一下
```
[xatu printLibrary];
[s1 checkOwnBook];
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208223940419.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2F3ZGFzZGFzZDE=,size_16,color_FFFFFF,t_70)
果然，没有问题，那么现在进行还书操作
```
[s1 returnBook:@"Objective-C" to:xatu];
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208223858543.png)
从刚刚同学借书开始，到我重新解码帮他还书之间，总共过了306.16秒。为了效果，我将规定时间设置成了3秒，所以他将被额外收费。

还书后，我们来看看图书馆和学生的信息
```
[xatu printLibrary];
[s1 checkOwnBooks];
NSLog(@"余额为%d"，[s1 checkAccount);
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20191208224620943.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2F3ZGFzZGFzZDE=,size_16,color_FFFFFF,t_70)
完全正确。

最后一个问题，所有NSMutableArray在解码后，均无法再进行添加和移除操作。问题就在：
```
@property (copy,nonatomic)NSMutableArray *library;
@property(copy,nonatomic)NSMutableArray *ownBook;
```
只需要把copy全部更改成strong，就解决了。
