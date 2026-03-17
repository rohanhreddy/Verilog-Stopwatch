module stopwatch_top (
    input wire clk,
    input wire rst_n, //active low global reset
    input wire start,
    input wire stop,
    input wire reset, //user reset, 2nd priority
    output wire [7:0] minutes,
    output wire [5:0] seconds,
    output wire [1:0] status //state in fsm
);

    wire sec_rollover; //to control incremeneting minutes
    wire timer_enable; //links fsm to seconds_counter

    control_fsm fsmtin (
        .clk (clk),
        .rst_n (rst_n),
        .start (start),
        .stop (stop),
        .reset (reset),
        .state (status),
        .enable_counting (timer_enable)
    );

    seconds_counter sectin (
        .clk (clk),
        .rst_n (rst_n),
        .reset (reset),
        .enable (timer_enable),
        .count (seconds),
        .max_second (sec_rollover)
    );

    minutes_counter mintin (
        .clk (clk),
        .rst_n (rst_n),
        .reset (reset),
        .enable (sec_rollover),
        .minutes (minutes)
    );

endmodule