class mem_scoreboard;
  // Reference memory
  logic [31:0] ref_mem [0:15]; // 16 locations
  int correct_data, wrong_data;
  int correct_valid, wrong_valid;

  mailbox #(mem_transaction) mbx_mon;

  // Constructor
  function new(mailbox #(mem_transaction) mbx_mon_in);
    mbx_mon = mbx_mon_in;
    correct_data = 0;
    wrong_data = 0;
    correct_valid = 0;
    wrong_valid = 0;
    foreach(ref_mem[i]) ref_mem[i] = 32'hx;
  endfunction

  // Start task (nonblocking, mailbox-driven)
  task start();
    mem_transaction tr;
    forever begin
      mbx_mon.get(tr);  // Wait for transaction from monitor

      // Update reference memory if EN is high (write)
      if (tr.EN) begin
        ref_mem[tr.Address] = tr.Data_in;
      end

      // Check Data_out if valid
      if (tr.Valid_out) begin
        if (tr.Data_out === ref_mem[tr.Address]) begin
          correct_data++;
          $display("Time=%0t: Correct Data at Address %0d = %0h", $time, tr.Address, tr.Data_out);
        end else begin
          wrong_data++;
          $display("Time=%0t: Wrong Data at Address %0d = %0h, Expected=%0h", $time, tr.Address, tr.Data_out, ref_mem[tr.Address]);
        end
        correct_valid++;
      end else begin
        wrong_valid++;
        $display("Time=%0t: Valid_out = 0 for Address %0d", $time, tr.Address);
      end
    end
  endtask

  // Summary display (optional, call at end of simulation)
  task display_summary();
    $display("========================================");
    $display("Correct Data = %0d, Wrong Data = %0d", correct_data, wrong_data);
    $display("Correct Valid = %0d, Wrong Valid = %0d", correct_valid, wrong_valid);
    $display("========================================");
  endtask

endclass

