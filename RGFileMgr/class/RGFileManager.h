//
//  RGFileManager.h
//  RGFileMgr
//
//  Created by yangrui on 2018/12/6.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGFileManager : NSObject

/** 计算指定文件大小 或 计算指定文件夹内文件的大小
 */
+(long long)fileSizeAtPath:(NSString *)path;

/** 删除指定文件 或 指定文件夹
 */
+(void)removeFileAtPath:(NSString *)path;


/**  移动目录(或文件)  下 包含 xxx后缀的所有文件   到 toDirectory目录
     suffix 文件后缀
     atPath 源目录或文件
     toDirectory 目标目录路径
 */
+(void)moveFileHasSuffix:(NSString *)suffix  atPath:(NSString *)atPath toDirectory:(NSString *)toDirectory;


@end
