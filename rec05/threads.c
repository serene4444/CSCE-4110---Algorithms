#include <pthread.h>
#include <stdio.h>
#include <string.h>

static void *thread1(void *arg)
{
    (void)arg;
    puts("Thread 1 in action");
    return NULL;
}

static void *thread2(void *arg)
{
    (void)arg;
    puts("Thread 2 in action");
    return NULL;
}

int main(void)
{
    pthread_t first;
    pthread_t second;
    int result;

    result = pthread_create(&first, NULL, thread1, NULL);
    if (result != 0) {
        fprintf(stderr, "Could not create thread 1: %s\n", strerror(result));
        return 1;
    }

    result = pthread_create(&second, NULL, thread2, NULL);
    if (result != 0) {
        fprintf(stderr, "Could not create thread 2: %s\n", strerror(result));
        pthread_join(first, NULL);
        return 1;
    }

    result = pthread_join(first, NULL);
    if (result != 0) {
        fprintf(stderr, "Could not join thread 1: %s\n", strerror(result));
        return 1;
    }

    result = pthread_join(second, NULL);
    if (result != 0) {
        fprintf(stderr, "Could not join thread 2: %s\n", strerror(result));
        return 1;
    }

    puts("Both threads have finished");
    return 0;
}
