class mem_transaction;
  rand logic rst;
  rand logic EN;
  rand logic [31: 0] Data_in;
  rand logic [3: 0] Address;
  logic [31: 0] Data_out;
  logic Valid_out;
endclass