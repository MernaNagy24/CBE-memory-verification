class mem_driver;
  virtual mem_if vif;
  mem_transaction tr;
  mailbox #(mem_transaction ) mbx_seq_drv;

  function new(virtual mem_if vif_env, mailbox #(mem_transaction ) mbx_from_env);
    this.vif = vif_env;
    this.mbx_seq_drv = mbx_from_env;
  endfunction
  /*
  task reset();
    wait(!vif.rst)
    $display("Time = %0t --------- Drivier Reset Task Started --------- \n", $realtime);
    vif.Driver_cb.Data_in <= 'b0; //
    vif.Driver_cb.Address <= 'b0;
    vif.Driver_cb.EN <= 'b0; 
    wait(vif.rst)
    $display("Time = %0t --------- Drivier Reset Task Ended   --------- \n", $realtime);
  endtask
*/

  task start();
    //reset();
    forever begin
      $display("Time = %0t --------- Drivier Start Task Started --------- \n", $realtime);
      mbx_seq_drv.get(tr); 
      $display("Time = %0t Driver: inputs: rst=%0d Write_en=%0d Address=%0d Data_in=%0d outputs: Data_out=%0d Valid_out=%0d",
      $realtime, vif.rst, tr.EN, tr.Address, tr.Data_in, tr.Data_out, tr.Valid_out);  
      @(posedge vif.Driver_cb);
      vif.Driver_cb.Data_in <= tr.Data_in;
      vif.Driver_cb.Address <= tr.Address;
      vif.Driver_cb.EN <= tr.EN;  
      $display("Time = %0t --------- Drivier Start Task Ended --------- \n", $realtime);
      end
    endtask
endclass

    