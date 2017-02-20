//
//  NSFileManager+BPVExtensions.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BPVExtensions)

+ (NSString *)applicationDataPathWithFolderName:(NSString *)folderName;

+ (NSString *)documentDirectoryPath;
+ (NSString *)libraryDirectoryPath;

+ (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory;
+ (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory;

@end
