//
//  RGFileManager.m
//  RGFileMgr
//
//  Created by yangrui on 2018/12/6.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "RGFileManager.h"

@implementation RGFileManager


/** 计算指定文件大小 或 计算指定文件夹内文件的大小
 */
+(long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    if (isExists == NO ) return 0;
    
    if(isDirectory == NO ){
        NSError *err;
        NSDictionary *infoDic = [fileMgr attributesOfItemAtPath:path error:&err];
        return  [infoDic fileSize];
    }
    
    //子路径文件和文件夹 (多级)
    NSArray *subPathArr = [fileMgr subpathsAtPath:path];
    long long totalSize = 0;
    for (NSString *subPath in subPathArr) {
        
        if ([subPath hasSuffix:@"DS_Store"])continue;
        
        isDirectory = NO;
        NSString *subFile = [path stringByAppendingPathComponent:subPath];
        BOOL isExists = [fileMgr fileExistsAtPath:subFile isDirectory:&isDirectory];
        if (isExists == YES && isDirectory == NO) {
            NSError *er;
            NSDictionary *infoDic = [fileMgr attributesOfItemAtPath:subFile error:&er];
            totalSize += [infoDic fileSize];
        }
        
    }
    return totalSize;
}


/** 删除指定文件 或 指定文件夹
 */
+(void)removeFileAtPath:(NSString *)path{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    
    if(isExists == NO) return;
    
    if(isDirectory == NO){
        NSError *err;
        [fileMgr removeItemAtPath:path error:&err];
        return;
    }
    
    NSError *er ;
    //子路径文件和文件夹 (只有一级)
    NSArray *contentArr = [fileMgr contentsOfDirectoryAtPath:path error:&er];
    
    for(NSString *content in contentArr){
        NSString *subPath = [path stringByAppendingPathComponent:content];
        NSError *error ;
        [fileMgr removeItemAtPath:subPath error:&error];
    }
}



+(void)moveFileHasSuffix:(NSString *)suffix  atPath:(NSString *)atPath toDirectory:(NSString *)toDirectory{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    
    BOOL isDirectory = NO;
    BOOL isExists = [fileMgr fileExistsAtPath:atPath isDirectory:&isDirectory];
    if (isExists == NO ) return ;
    
    
    if(isDirectory == NO ){
        if ([[atPath lowercaseString] hasSuffix:[suffix lowercaseString]]) {
            NSString *toPath = [toDirectory stringByAppendingPathComponent:[atPath lastPathComponent]];
            NSError *err = nil;
            [fileMgr moveItemAtPath:atPath toPath:toPath error:&err];
        }
        return ;
    }
    
    
    //子路径文件和文件夹 (多级)
    NSArray *subPathArr = [fileMgr subpathsAtPath:atPath];
    
    for (NSString *subPath in subPathArr) {
        
        if ([subPath hasSuffix:@"DS_Store"])continue;
        
        isDirectory = NO;
        NSString *subFile = [atPath stringByAppendingPathComponent:subPath];
        BOOL isExists = [fileMgr fileExistsAtPath:subFile isDirectory:&isDirectory];
        if (isExists == YES && isDirectory == NO) {
             if ([[subPath lowercaseString] hasSuffix:[suffix lowercaseString]]) {
                 NSString *toPath = [toDirectory stringByAppendingPathComponent:[subFile lastPathComponent]];
                 NSError *err = nil;
                 [fileMgr moveItemAtPath:subFile toPath:toPath error:&err];
             }
        }
        
    }
  
}

@end
