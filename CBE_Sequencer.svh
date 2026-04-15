class mem_sequencer;
  mem_transaction  tr;
  mailbox #(mem_transaction) mbx_seq_drv;

  function new (mailbox #(mem_transaction) mbx_from_env);
    this.mbx_seq_drv = mbx_from_env;
  endfunction 

  task start();
    repeat(20) begin
      //$display("Time = %0t --------- Sequencer Start Task Started --------- \n", $realtime);
      tr = new(); 
      assert(tr.randomize());
      mbx_seq_drv.put(tr);
      $display("Time = %0t sequencer done randomization : inputs: Write_en=%0d Address=%0d Data_in=%0d ",
      $realtime, tr.EN, tr.Address, tr.Data_in);
      $display("Time = %0t --------- Sequencer Start Task Ended --------- \n", $realtime);
    end
  endtask
endclass