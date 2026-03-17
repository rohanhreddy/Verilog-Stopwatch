module control_fsm (
    input wire clk,
    input wire rst_n,
    input wire start, //these are
    input wire stop, //controlled by
    input wire reset, //top level module
    output reg [1:0] state, //status in stopwatch_top.v
    output wire enable_counting //links to the enable wires in the other modules
);
    
    localparam IDLE = 2'b00;
    localparam RUNNING = 2'b01;
    localparam PAUSED = 2'b10;

    always @ (posedge clk) begin
        if (!rst_n) begin
            state <= IDLE; //reset forces idle regardless of cases
        end else begin
            case (state)
                IDLE: begin
                    if (start) state <= RUNNING; //single line if control
                end 
                RUNNING: begin
                    if (reset) state <= IDLE;
                    else if (stop) begin
                        state <= PAUSED;
                    end else state <= RUNNING;
                end 
                PAUSED: begin
                    if (reset) state <= IDLE;
                    else if (start) state <= RUNNING;
                end
            endcase
        end
    end

    assign enable_counting = (state == RUNNING);

endmodule
