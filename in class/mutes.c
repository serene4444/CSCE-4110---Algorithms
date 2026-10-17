#include<stdio.h>
#include<pthread.h>
int counter = 0;
pthread_mutex_t lock;
void * increment(void *arg)
{
    pthread_mutex_lock(&lock);
    for(int i = 0; i < 5; i++)
    {
        counter++;
        printf("Thread %ld incremented counter to %d\n", (long)pthread_self(), counter);
    }
    pthread_mutex_unlock(&lock);
    return NULL;
}

// what did we do: 
// 2. We declared a global counter variable and a mutex lock to protect access to the counter.
// 3. We defined a function increment that will be executed by each thread. Inside this function, we lock the mutex, increment the counter five times, print the current value of the counter, and then unlock the mutex.


int main()
{
    pthread_t t1, t2;
    pthread_mutex_init(&lock, NULL);
    pthread_create(&t1, NULL, increment, NULL);
    pthread_create(&t2, NULL, increment, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_mutex_destroy(&lock);
    printf("Final counter value: %d\n", counter);
    return 0;
}