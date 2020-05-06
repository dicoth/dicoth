module app.task.Scheduler;

import hunt.concurrency.Executors;
import hunt.concurrency.Scheduler;
import hunt.concurrency.ScheduledThreadPoolExecutor;

import std.concurrency : initOnce;

private __gshared ScheduledThreadPoolExecutor _executor;

ScheduledThreadPoolExecutor taskExecutor() {
    return initOnce!_executor({
        return cast(ScheduledThreadPoolExecutor) Executors.newScheduledThreadPool(3);
    }());
}


void stopScheduler() {
    if (_executor !is null) {
        _executor.shutdown();
    }
}