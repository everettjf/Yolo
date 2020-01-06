//
//  ThreadPool.h
//  ThreadPoolSample
//
//  Created by everettjf on 2018/8/10.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>

class ThreadPool {
public:
    ThreadPool(size_t);
    template<class F>
    void enqueue(F f);
    ~ThreadPool();
private:
    void Task();

    // need to keep track of threads so we can join them
    std::vector< std::thread > workers;
    
    // the task queue
    std::deque< std::function<void()> > tasks;
    
    // synchronization
    std::mutex queue_mutex;
    std::condition_variable condition;
    bool stop;
};

// add new work item to the pool
template<class F>
void ThreadPool::enqueue(F f)
{
    { // acquire lock
        std::unique_lock<std::mutex> lock(queue_mutex);
        
        // add the task
        tasks.push_back(std::function<void()>(f));
    } // release lock
    
    // wake up one thread
    condition.notify_one();
}
