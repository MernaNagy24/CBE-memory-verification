class mem_env;
  virtual mem_if vif;

  function new(virtual mem_if  vif_top); 
    this.vif = vif_top; 
  endfunction

  mem_transaction tr;
  mem_sequencer seq;
  mem_driver drv;
  mem_monitor mon;
  mem_scoreboard sb;
  //mem_subscriber sub;

  mailbox #(mem_transaction) mbx_seq_drv, mbx_mon_sb, mbx_mon_sub;
  
  task run_env();
    mbx_seq_drv = new(1);//
    mbx_mon_sb = new(1);
    //mbx_mon_sub = new();
    seq = new(mbx_seq_drv);
    drv = new(vif, mbx_seq_drv);
    mon = new(vif, mbx_mon_sb, mbx_mon_sub);
    sb = new(mbx_mon_sb);
    //sub = new(mbx_mon_sub);
    
    fork
      seq.start();
      drv.start();
      mon.start();
      sb.start();
      //sub.start();
    join_any
  endtask

endclass