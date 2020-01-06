//
//  ThreadPool.m
//  ThreadPoolSample
//
//  Created by everettjf on 2018/8/10.
//  Copyright © 2018 everettjf. All rights reserved.
//

#import "ThreadPool.h"

void ThreadPool::Task()
{
    std::function<void()> task;
    while(true)
    {
        {   // acquire lock
            std::unique_lock<std::mutex>
            lock(this->queue_mutex);
            
            // look for a work item
            while(!this->stop && this->tasks.empty())
            { // if there are none wait for notification
                this->condition.wait(lock);
            }
            
            if(this->stop) // exit if the pool is stopped
                return;
            
            // get the task from the queue
            task = this->tasks.front();
            this->tasks.pop_front();
            
        }   // release lock
        
        // execute the task
        task();
    }
}
// the constructor just launches some amount of workers
ThreadPool::ThreadPool(size_t threads)
:   stop(false)
{
    for(size_t i = 0;i<threads;++i){
        workers.push_back(std::thread([this]{this->Task();}));
    }
}

// the destructor joins all threads
ThreadPool::~ThreadPool()
{
    // stop all threads
    stop = true;
    condition.notify_all();
    
    // join them
    for(size_t i = 0;i<workers.size();++i){
        workers[i].join();
    }
}
