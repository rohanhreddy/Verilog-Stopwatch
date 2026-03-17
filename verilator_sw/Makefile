VERILATOR = verilator
CXX = g++

RTL_DIR = ../rtl
OBJ_DIR = obj_dir

TOP_MODULE = stopwatch_top
CPP_SRC = main.cpp
VERILOG_SRC = $(RTL_DIR)/$(TOP_MODULE).v $(RTL_DIR)/control_fsm.v $(RTL_DIR)/seconds_counter.v $(RTL_DIR)/minutes_counter.v

V_FLAGS = -cc --exe -I$(RTL_DIR) --trace -Wno-CASEINCOMPLETE
CXX_FLAGS = -std=c++14

all: $(TOP_MODULE)

$(TOP_MODULE): $(VERILOG_SRC) $(CPP_SRC)

	$(VERILATOR) $(V_FLAGS) $(VERILOG_SRC) $(CPP_SRC)
	
	make -j -C $(OBJ_DIR) -f V$(TOP_MODULE).mk V$(TOP_MODULE)

	cp $(OBJ_DIR)/V$(TOP_MODULE) stopwatch_exec

clean:
	rm -rf $(OBJ_DIR) stopwatch_exec stopwatch.vcd