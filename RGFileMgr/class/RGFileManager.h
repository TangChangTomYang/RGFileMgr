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


@end
