class mem_monitor;
  mem_transaction tr;
  virtual mem_if vif;
  mailbox #(mem_transaction ) mbx_mon_sb, mbx_mon_sub;

  function new (virtual mem_if  vif_env,
    mailbox #(mem_transaction) mbx_to_sb,
    mailbox #(mem_transaction) mbx_to_sub);
    this.vif = vif_env;
    this.mbx_mon_sb = mbx_to_sb;
    this.mbx_mon_sub = mbx_to_sub;
  endfunction

  task start();
  forever begin
    $display("Time = %0t --------- Monitor Start Task Started --------- \n", $realtime);
    tr = new();
    $display("Time = %0t Monitor: inputs: rst=%0d Write_en=%0d Address=%0d Data_in=%0d outputs: Data_out=%0d Valid_out=%0d",
    $realtime, vif.rst, vif.Monitor_cb.EN, vif.Monitor_cb.Address, vif.Monitor_cb.Data_in,
    vif.Monitor_cb.Data_out, vif.Monitor_cb.Valid_out);    
    @(posedge vif.Monitor_cb);
    tr.rst <= vif.rst;
    tr.Data_in <= vif.Monitor_cb.Data_in;
    tr.Address <= vif.Monitor_cb.Address;
    tr.EN <= vif.Monitor_cb.EN;  
    tr.Data_out <= vif.Monitor_cb.Data_out;
    tr.Valid_out <= vif.Monitor_cb.Valid_out;
    mbx_mon_sb.put(tr);
    //mbx_mon_sub.put(tr);
    $display("Time = %0t --------- Monitor Start Task Ended --------- \n", $realtime);
  end
  endtask
endclass
