#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM! Exiting gracefully...\n");
    exit(0);
}

void handle_sigint(int sig) {
    printf("\nParent received SIGINT! Just a warning, still running...\n");
}

int main() {
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    pid_t child1 = fork();
    if (child1 == 0) {
        sleep(5);
        kill(getppid(), SIGTERM); // send SIGTERM to parent
        exit(0);
    }

    pid_t child2 = fork();
    if (child2 == 0) {
        sleep(10);
        kill(getppid(), SIGINT); // send SIGINT to parent
        exit(0);
    }

    printf("Parent PID: %d running. Waiting for signals...\n", getpid());

    // Parent runs indefinitely
    while(1) {
        pause(); // wait for signals
    }

    return 0;
}
