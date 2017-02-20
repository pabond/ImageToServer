//
//  NSFileManager+BPVExtensions.m
//  iOSProject
//
//  Created by Bondar Pavel on 8/22/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "NSFileManager+BPVExtensions.h"

#import "BPVMacro.h"

@implementation NSFileManager (BPVExtensions)

+ (NSString *)applicationDataPathWithFolderName:(NSString *)folderName {
    NSString *dataPath = [[self libraryDirectoryPath] stringByAppendingPathComponent:folderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    if (![fileManager fileExistsAtPath:dataPath]) {
        [fileManager createDirectoryAtPath:dataPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        NSLog(@"%@", error);
    }

    return dataPath;
}

+ (NSString *)documentDirectoryPath {
    BPVReturnOnce(NSString, documentDirectory, ^{ return [self pathWithDirectory:NSDocumentDirectory]; });
}

+ (NSString *)libraryDirectoryPath {
    BPVReturnOnce(NSString, libraryDirectory, ^{ return [self pathWithDirectory:NSLibraryDirectory]; });
}

+ (NSString *)pathWithDirectory:(NSSearchPathDirectory)directory {
    return [[self pathsWithDirectory:directory] firstObject];
}

+ (NSArray *)pathsWithDirectory:(NSSearchPathDirectory)directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
}

@end
