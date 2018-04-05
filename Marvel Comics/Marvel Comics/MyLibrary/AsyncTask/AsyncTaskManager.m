//
//  AsyncTaskManager.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "AsyncTaskManager.h"

@implementation AsyncTaskManager
/**
 *  execute a task on worker thread with block and priority
 *
 *  @param block execute code
 *  @param priority priority
 */

+ (void) executeAsyncTask:(dispatch_block_t) block
             withPriority:(NSInteger) priority
{
    //1.global queue
    dispatch_queue_t queue =  dispatch_get_global_queue(priority, 0);
    //gcd async thread
    dispatch_async(queue, ^{
        block();
    });
}

/**
 *  execute a task on worker thread with block
 *
 *  @param block execute code
 */
+ (void) executeAsyncTask:(dispatch_block_t) block
{
    [self executeAsyncTask:block withPriority:DISPATCH_QUEUE_PRIORITY_DEFAULT];
}
/**
 *  execute a task on main thread with block
 *
 *  @param block execute code
 */
+ (void) executeAsyncTaskOnMainThread:(dispatch_block_t) block
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/**
 *  execute a task on main thread with block and delay
 *
 *  @param block execute code
 *  @param delayInSeconds delay seconds
 */
+ (void) executeAsyncTaskOnMainThread:(dispatch_block_t) block
                            withDelay:(NSTimeInterval)delayInSeconds
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
/**
 *  execute a task on worker thread with block and delay
 *
 *  @param block execute code
 *  @param delayInSeconds delay seconds
 */
+ (void) executeAsyncTask:(dispatch_block_t) block
                withDelay:(NSTimeInterval)delayInSeconds
{
    //schedule a timer
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //execute with delay
    dispatch_queue_t concurrentQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, block);
}

@end
