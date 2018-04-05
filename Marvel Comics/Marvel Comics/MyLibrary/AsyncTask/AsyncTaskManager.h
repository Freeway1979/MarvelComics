//
//  AsyncTaskManager.h
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncTaskManager : NSObject
/**
 *  execute a task on worker thread with block and priority
 *
 *  @param block execute code
 *  @param priority priority
 */
+ (void) executeAsyncTask:(dispatch_block_t) block
             withPriority:(NSInteger) priority;

/**
 *  execute a task on worker thread with block
 *
 *  @param block execute code
 */
+ (void) executeAsyncTask:(dispatch_block_t) block;
/**
 *  execute a task on main thread with block
 *
 *  @param block execute code
 */
+ (void) executeAsyncTaskOnMainThread:(dispatch_block_t) block;
/**
 *  execute a task on main thread with block and delay
 *
 *  @param block execute code
 *  @param delayInSeconds delay seconds
 */
+ (void) executeAsyncTaskOnMainThread:(dispatch_block_t) block
                            withDelay:(NSTimeInterval)delayInSeconds;
/**
 *  execute a task on worker thread with block and delay
 *
 *  @param block execute code
 *  @param delayInSeconds delay seconds
 */
+ (void) executeAsyncTask:(dispatch_block_t) block
                withDelay:(NSTimeInterval)delayInSeconds;

@end
