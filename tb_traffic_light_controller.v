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
             $time, tfc.state, main_out, side_out, tfc.count);
end
// Waveform dump
initial begin
    $dumpfile("wave.vcd");
  $dumpvars(0, tb_traffic_light_controller.clk);
  $dumpvars(0, tb_traffic_light_controller.rst);
  $dumpvars(0, tb_traffic_light_controller.main_out);
  $dumpvars(0, tb_traffic_light_controller.side_out);
  $dumpvars(0, tb_traffic_light_controller.tfc.state);
  $dumpvars(0, tb_traffic_light_controller.tfc.next_state);
  $dumpvars(0, tb_traffic_light_controller.tfc.count);
  $dumpvars(0, tb_traffic_light_controller.tfc.limit);
end
endmodule
