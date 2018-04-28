names: Nicole Lin, Jonathan Gao
netIDs: nl392, jg992

Our testing procedure included running the iram instructions provided by the ECE2300 staff (2E). Using this program, we examined the waveforms of the relevant signals in our modules. We looked at OP and FUNCT to see where the HALT instruction was being executed, then from there, we looked at the HALT, H, and EN_L signals. Our HALT stays high, which means that no other instruction is being executed (to make HALT low). We also verified that our H signal (enable for PC) only turned from 0 to 1 when EN_L makes a transition from 1 to 0 (active low). If EN_L is already high, our H remains 0. 

We are failing some test cases involving branching, but decided it was okay to wait to implement that in the lab session. 