#include <verilated.h>
#include "Vstopwatch_top.h"
#include <iostream>
#include <iomanip>

vluint64_t main_time = 0;

double sc_time_stamp() {
    return main_time;
}

int main(int argc, char** argv) {
    
    Verilated::commandArgs(argc, argv);
    Vstopwatch_top* top = new Vstopwatch_top;

    top->clk = 0;
    top->rst_n = 0;
    top->start = 0;
    top->stop = 0;
    top->reset = 0;

    auto run_ns = [&](int duration_ns) {
        for (int t = 0; t < duration_ns; t += 5) {
            if (Verilated::gotFinish()) return;

            top->clk = !top->clk;
            
            top->eval();
            
            main_time += 5;

            if (top->clk == 1) {
                printf("Time: %4ld nS | Status: %d%d | Stopwatch: %02d:%02d\n", 
                       main_time, 
                       (top->status >> 1) & 1, //to print status in binary
                       top->status & 1,
                       top->minutes, 
                       top->seconds);
            }
        }
    };

    top->rst_n = 0;
    run_ns(20);

    top->rst_n = 1;
    top->start = 1;
    run_ns(10);

    top->start = 0;
    run_ns(1000);

    top->stop = 1;
    run_ns(10);

    top->stop = 0;
    run_ns(100);

    top->start = 1;
    run_ns(10);

    top->start = 0;
    run_ns(50);

    top->reset = 1;
    run_ns(10);

    top->reset = 0;
    run_ns(50);

    top->start = 1;
    run_ns(10);

    top->start = 0;
    run_ns(100);

    top->final();
    delete top;
    return 0;
}
