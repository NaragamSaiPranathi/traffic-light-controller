module tb_traffic_light_controller;
reg clk, rst;
wire [1:0] main_out, side_out;
// Instantiate DUT
    traffic_light_controller tfc(clk,rst,main_out,side_out);
// Clock generation
always #5 clk = ~clk;
// Stimulus
initial begin
    clk = 0;
    rst = 1;
    repeat(2) @(posedge clk);
    rst = 0;
    #300 $finish;
end
// Monitor signals
initial begin
    $monitor("Time=%0t | state=%b | main=%b | side=%b | count=%d",
             $time, uut.state, main_out, side_out, uut.count);
end
// Waveform dump
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_tfc.clk);
    $dumpvars(0, tb_tfc.rst);
    $dumpvars(0, tb_tfc.main_out);
    $dumpvars(0, tb_tfc.side_out);
    $dumpvars(0, tb_tfc.uut.state);
    $dumpvars(0, tb_tfc.uut.next_state);
    $dumpvars(0, tb_tfc.uut.count);
    $dumpvars(0, tb_tfc.uut.limit);
end
endmodule
