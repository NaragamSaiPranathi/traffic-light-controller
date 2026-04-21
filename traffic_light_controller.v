module traffic_light_controller(clk, rst, main_out, side_out);
input clk, rst;
output reg [1:0] main_out, side_out;
// Light encoding
parameter RED    = 2'b00;
parameter YELLOW = 2'b01;
parameter GREEN  = 2'b10;
// State encoding
parameter s0 = 2'b00,
          s1 = 2'b01,
          s2 = 2'b10,
          s3 = 2'b11;
reg [1:0] state, next_state;
reg [3:0] count;
reg [3:0] limit;
reg [1:0] prev_state;
//STATE REGISTER
always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= s0;
    else
        state <= next_state;
end
//LIMIT LOGIC (COMBINATIONAL)
always @(*)
begin
    if ((state == s0) || (state == s2))
        limit = 4'd10;
    else
        limit = 4'd3;
end
// COUNTER LOGIC
always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        count <= 0;
        prev_state <= s0;
    end
    else
    begin
        // reset counter when state changes
        if (state != prev_state)
            count <= 0;
        prev_state <= state;
        // normal counting
        if (count == limit - 1)
            count <= 0;
        else
            count <= count + 1;
    end
end
//NEXT STATE + OUTPUT LOGIC
always @(*)
begin
    // defaults
    main_out   = RED;
    side_out   = RED;
    next_state = state;
    case (state)
        s0: begin
            main_out = GREEN;
            side_out = RED;
            if (count == limit - 1)
                next_state = s1;
        end
        s1: begin
            main_out = YELLOW;
            side_out = RED;
            if (count == limit - 1)
                next_state = s2;
        end
        s2: begin
            main_out = RED;
            side_out = GREEN;
            if (count == limit - 1)
                next_state = s3;
        end
        s3: begin
            main_out = RED;
            side_out = YELLOW;
            if (count == limit - 1)
                next_state = s0;
        end
        default: next_state = s0;
    endcase
end
endmodule
