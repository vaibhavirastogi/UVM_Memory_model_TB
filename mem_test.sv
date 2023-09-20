`include "mem_env.sv"
`include "read_sequence.sv"


class mem_test extends uvm_test;

  `uvm_component_utils(mem_test)

  mem_env env;
  read_sequence seq;

  function new(string name = "mem_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = mem_env::type_id::create("env", this);
    seq = read_sequence::type_id::create("seq", this);
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
      seq.start(env.mem_agnt.sequencer);
    phase.drop_objection(this);
  endtask : run_phase

endclass
