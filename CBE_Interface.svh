interface mem_if (input logic Clk, rst);
    logic [31: 0] Data_in;
    logic [3: 0] Address;
    logic EN;
    logic [31: 0] Data_out;
    logic Valid_out;

    // Driver Clocking Block 
	clocking Driver_cb @(posedge Clk);
		default output #1step;
		output Address;
		output EN;
		output Data_in;	
	endclocking

    // Monitor Clocking Block
	clocking Monitor_cb @(posedge Clk);
		default input #0;
		input  Address;
		input  EN;
		input  Data_in;
		input  Data_out;
		input  Valid_out;	
	endclocking
endinterface