module tb_stopwatch;
    
    reg clk;
    reg rst_n;
    reg start;
    reg stop;
    reg reset;
    wire [7:0] minutes;
    wire [5:0] seconds;
    wire [1:0] status;

    initial begin //clk only
        clk = 0;
    end

    initial begin
        $monitor("Simulation Time: %0t | Status: %b | Stopwatch: %02d:%02d", $time, status, minutes, seconds); //monitor
    end

    initial begin
        rst_n = 0; //holding global reset for 20ns (2 clock cycles)
        start = 0;
        stop = 0;
        reset = 0;

        #20;

        rst_n = 1;
        start = 1;
        #10;
        start = 0; //start pressed for 1 clock cycle
        
        #1000; //running for 1000ns
        stop = 1;
        #10;
        stop = 0; //stop pressed for 1 clock cycle

        #100; //stopped for 100ns to display pausing

        start = 1; //start for one clock cycle
        #10;
        start = 0;
        #50; //running for 50ns to show can continue from pause

        reset = 1; //testing of reset functionality
        #10;
        reset = 0;

        #50;

        start = 1;
        #10;
        start = 0;
        #100; //to show reset then start functionality
        $finish;
    end

    always #5 begin //period is 10ns
        clk = ~clk;
    end

    stopwatch_top dut (
        .clk (clk),
        .rst_n (rst_n),
        .start (start),
        .stop (stop),
        .reset (reset),
        .minutes (minutes),
        .seconds (seconds),
        .status (status)
    );

    initial begin //gtkwave
        $dumpfile("stopwatch_simg.vcd");
        $dumpvars(1, tb_stopwatch);
    end

endmodule
