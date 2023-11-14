using System.Collections.Generic;
using System;
using System.Threading;
using System.Diagnostics;

internal class ThreadSafeQueue<T>
{
    /// <summary>Used as a lock target to ensure thread safety.</summary>
    private readonly Object _Locker = new Object();

    private readonly PriorityQueue<QueueObject, float> _Queue = new PriorityQueue<QueueObject, float>(100);

    /// <summary></summary>
    public void Enqueue(QueueObject queueObject, float prio)
    {
        lock (_Locker)
        {
            _Queue.Enqueue(queueObject, prio);
        }
    }

    /// <summary>Enqueues a collection of items into this queue.</summary>
    /// 
    /*
    public virtual void EnqueueRange(IEnumerable<T> items)
    {
        lock (_Locker)
        {
            if (items == null)
            {
                return;
            }

            foreach (T item in items)
            {
                _Queue.Enqueue(item);
            }
        }
    }*/

    /// <summary></summary>
    public QueueObject Dequeue()
    {
        lock (_Locker)
        {
            return _Queue.Dequeue();
        }
    }

    /// <summary></summary>
    public void Clear()
    {
        lock (_Locker)
        {
            _Queue.Clear();
        }
    }

    /// <summary></summary>
    public int Count
    {
        get
        {
            lock (_Locker)
            {
                return _Queue.Count;
            }
        }
    }

    
    public bool TryDequeue(out QueueObject item)
    {
        lock (_Locker)
        {
            if (_Queue.Count > 0)
            {
                item = _Queue.Dequeue();
                return true;
            }
            else
            {
                item = default(QueueObject);
                return false;
            }
        }
    }
    
}