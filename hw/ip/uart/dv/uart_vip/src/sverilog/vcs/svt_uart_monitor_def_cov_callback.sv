
`include "svt_uart_defines.svi"
`include `SVT_SOURCE_MAP_MODEL_SRC_SVI(uart_svt,uart_monitor_svt,O-2018.09,svt_uart_monitor_def_cov_util)

`ifndef GUARD_SVT_UART_MONITOR_DEF_COV_CALLBACK_SV
`define GUARD_SVT_UART_MONITOR_DEF_COV_CALLBACK_SV

/**
 * This class is extended from the coverage data callback class. This class
 * includes default cover groups. The constructor of this class gets
 * #svt_uart_configuration handle as an argument, which is used for shaping
 * the coverage.
 */
class svt_uart_monitor_def_cov_callback extends svt_uart_monitor_def_cov_data_callbacks; 

  /**
   * Covergroup : tx_parity
   *
   * Coverpoints :
   * - tx_parity : Captures the parity value for the payload 
   * .
   *
   */
  covergroup tx_parity @(tx_xact_event);
    option.per_instance = 1;
     
    tx_parity : coverpoint(xact.received_parity[0])
    {
     bins low  = {0};
     bins high = {1};
    }

  endgroup // tx_parity
    
  /**
   * Covergroup : tx_payload
   *
   * Coverpoint :
   * - tx_payload : Captures the value of the payload for the following
   *                scenarios :</br>
   *                1. when all bits across the data width are 0</br>
   *                2. when all bits across the data width are 1</br>
   *                3. when one bit is 0 and all other are 1 across the data
   *                   width</br>
   *                4. when one bit is 1 and all other are 0 across the data
   *                   width   
   * .
   *
   */
  covergroup tx_payload @(tx_xact_event);
    option.per_instance = 1;
     
    tx_payload  :coverpoint(payload_val)
    {
      bins all_zero = {1};
      bins all_one  = {2};
      bins one_hot0 = {3};
      bins one_hot1 = {4};
    }

  endgroup // tx_payload

  /**
   * Covergroup : tx_break_condition
   * 
   * Coverpoint :
   * - tx_break_condition : Captures the occurrence of a break condition
   * .
   *
   */
  covergroup tx_break_condition @(tx_xact_event);
    option.per_instance = 1;
     
    tx_break_condition : coverpoint(xact.break_cond)
    {
      bins break_cond = {1};
    }

  endgroup // tx_break_condition

  /**
   * Covergroup : tx_inter_cycle_delay
   * 
   * Coverpoint :
   * - tx_inter_cycle_delay : Captures the delay between two successive packets
   * .
   *
   */
  covergroup tx_inter_cycle_delay @(tx_xact_event);
    option.per_instance = 1;
     
    tx_inter_cycle_delay : coverpoint(xact.inter_cycle_delay)
    {
      bins zero_delay = {0};
      bins low_range  = {[1:666]};
      bins mid_range  = {[667:1320]};
      bins high_range = {[1321:2000]};
    }

  endgroup // tx_inter_cycle_delay

  /**
   * Covergroup : tx_parity_error
   *
   * Coverpoint :
   * - tx_parity_error : Capture the occurrence of parity error
   * .
   *
   */ 
  covergroup tx_parity_error @(tx_xact_event);
    option.per_instance = 1;

    tx_parity_error : coverpoint(parity_error)
    {bins HIT = {1};}
  endgroup // tx_parity_error 

  /**
   * Covergroup : tx_framing_error
   *
   * Coverpoint :
   * - tx_framing_error : Capture the occurrence of framing error
   * .
   *
   */ 
  covergroup tx_framing_error @(tx_xact_event);
    option.per_instance = 1;

    tx_framing_error : coverpoint(framing_error)
    {bins HIT = {1};}
  endgroup // tx_framing_error 

  /**
   * Covergroup : rx_parity
   *
   * Coverpoints :
   * - rx_parity : Captures the parity value for the payload 
   * .
   *
   */ 
  covergroup rx_parity @(rx_xact_event);
    option.per_instance = 1;
     
    rx_parity : coverpoint(xact.received_parity[0])
    {
     bins low  = {0};
     bins high = {1};
    }

  endgroup // rx_parity

  /**
   * Covergroup : rx_payload
   *
   * Coverpoint :
   * - rx_payload : Captures the value of the payload for the following
   *                scenarios :</br>
   *                1. when all bits across the data width are 0</br>
   *                2. when all bits across the data width are 1</br>
   *                3. when one bit is 0 and all other are 1 across the data
   *                   width</br>
   *                4. when one bit is 1 and all other are 0 across the data
   *                   width   
   * .
   *
   */
  covergroup rx_payload @(rx_xact_event);
    option.per_instance = 1;
     
    rx_payload : coverpoint(payload_val)
    {
      bins all_zero = {1};
      bins all_one  = {2};
      bins one_hot0 = {3};
      bins one_hot1 = {4};
    }

  endgroup // rx_payload

  /**
   * Covergroup : rx_break_condition
   * 
   * Coverpoint :
   * - rx_break_condition : Captures the occurrence of a break condition
   * .
   *
   */
  covergroup rx_break_condition @(rx_xact_event);
    option.per_instance = 1;
     
    rx_break_condition : coverpoint(xact.break_cond)
    {
      bins break_cond = {1};
    }

  endgroup // rx_break_condition

  /**
   * Covergroup : rx_inter_cycle_delay
   * 
   * Coverpoint :
   * - rx_inter_cycle_delay : Captures the delay between two successive packets
   * .
   *
   */
  covergroup rx_inter_cycle_delay @(rx_xact_event);
    option.per_instance = 1;
     
    rx_inter_cycle_delay : coverpoint(xact.inter_cycle_delay)
    {
      bins zero_delay = {0};
      bins low_range  = {[1:666]};
      bins mid_range  = {[667:1320]};
      bins high_range = {[1321:2000]};
    }

  endgroup // rx_inter_cycle_delay

  /**
   * Covergroup : rx_parity_error
   *
   * Coverpoint :
   * - rx_parity_error : Capture the occurrence of parity error
   * .
   *
   */ 
  covergroup rx_parity_error @(rx_xact_event);
    option.per_instance = 1;

    rx_parity_error : coverpoint(parity_error)
    {bins HIT = {1};}
  endgroup // rx_parity_error 

  /**
   * Covergroup : rx_framing_error
   *
   * Coverpoint :
   * - rx_framing_error : Capture the occurrence of framing error
   * .
   *
   */ 
  covergroup rx_framing_error @(rx_xact_event);
    option.per_instance = 1;

    rx_framing_error : coverpoint(framing_error)
    {bins HIT = {1};}
  endgroup // rx_framing_error 

  /**
   * Covergroup : scenario_sequence
   *
   * Coverpoint :
   * - framing_err_followed_by_framing_err_scenario : Captures framing error followed by 
   * framing error scenario in the two successive transactions 
   * 
   * - break_followed_by_break_scenario : Captures break followed by break scenario in 
   * the two successive transactions 
   * .
   *
   */
  covergroup scenario_sequence @(seq_match_event);
    option.per_instance = 1;

    framing_err_followed_by_framing_err_scenario : coverpoint(seq_type)
    { bins framing_err_followed_by_framing_err = {FRAMING_ERR_FOLLOWED_BY_FRAMING_ERR_SEQ}; }

    break_followed_by_break_scenario : coverpoint(seq_type)
    { bins break_followed_by_break = {BREAK_FOLLOWED_BY_BREAK_SEQ}; }                      

  endgroup //scenario_sequence

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new svt_uart_monitor_def_cov_callback instance.
   */
  extern function new(svt_uart_configuration cfg, string name = "svt_uart_monitor_def_cov_callback");

  /**
   * Set the instance name for covergroups
   */
  extern function void set_inst_name();
     
endclass

//vcs_lic_vip_protect
`protected
PIZ+SCg<-N?N,e&,5I)3-]17\cbS,,2B#MRe6BM_\/8@237J2R^@7(-bf9Nc2EB,
4eH5/<3+ZPPVWB8^R]V3.I@L\-GeYZ5G6_/ZacUYaN,d/WcA?^E?5Kc.^XcgZ?5c
&4^A@,>7XY=U8.3UH[dD^>N+RB5)d]\7)JE#AJ=#Ca>><RPGE6?\2SXT.]6Xf;2W
+_U:]5g8YW0&<dM/=_@6(;VASI7L/_b.4aYbCZY#d1SbeceM3>F.6Qg(B)7MHV_7
J]W72A#0T9\B;?.3RVeR\eH8L=aE>W(&\N]DW2WdJ]R3QB<5cR==1FE?dgOI77ZO
S_X.<U=EY1GB3;L_Z4NTR9@1N0@JF7a;LG=QPVg5)B&EL.9OMHMWWfe9?/5UP]YW
NEdHUVZ8ZUM6Y0#E:&&@_f_R:#LHIG3;GYaYQP=2?GDC-0\8QS:_PCM#S88dd>80
I4f=GM>F)aJXCb,\-)-Ef]F@IN&Q(DF;eZ@J&B;[[H+YJaUe_G(>0YRI_)/Y3?Ta
6bYHL2gOLHHEDI[.+=c\4BFH?>#LZ?D-\\WcCEKY_?6P8=(V.AbN383Q:35_>3Pf
RW?A4267JNV320=QLNES##PX:SMd]-0.@KVTF5>Ea#=78Kd^N07d:2AVe\3Sdc8G
WbOdd-.2;YSaJ2Q0]Y_RG#GDTK<a(G.G]RX02/6_d0P]7eZFRD(Q+&UYb/+.f:1Q
ON@6.U23<@8WCVO#>:W_1&:HdO?OJ?d?J#N&JI-=H^H)Eg>0+MZ?67-C\R4dKR1+
3a]A:<KY46Tc(aW(6SCB)FX/I8;BeLQY.:H=bHXd^W)KA@X_^GVg8K[5B4OJ<V^b
+1FY]cHF8Q,>b1[^Z;&(VG=F)F33.<M)I5?+M#2U6=8>&gW^[09DL&<JXSf_?O=W
F2V[ZZGGI4V;62RSYA>T<T_/(g&RKPPSJDCTPW_03MC=G4&.=6b<a#.#;T_Wfbc_
)I[Dcd-95[EHJU:.^/RXWJEY3ZdWY_PDKA)UQLO)gBQ82OTIcB1AOCgI5=_/E(9(
.?](;#;c:1)@A]W0YB)[95[#;fEA3:LMM7N,3MN__ME5OE-IL[c95HX/P]KU2Q1/
6K<c5Ye_=d^OT&21GD;+1F)8?),Da=>:T\BTRB]:L=b?4/G9=BMAZAfZ)0][GWM(
>&fQH=RZHH^\b)#M_72GKFDJMU3]O_.@+EJ>H8/Qf9X7GC2>TDBY\Q3F8\OIV>Sa
D)2\@37B4)FU_1.5P4N@;PO3XE1[?KBg?[P1QV=69UFK8.DVbB?9O/;V:O+M>O@=
:Ua;Q\_N/JRZ_GOa4^?,AFUPS[Z05Kg6d:gQ@4T^7]2X\b6cX,:MU38;PSZ#<J<E
KZc+2c>QGf=A.34HZ=@VJH?)U+ccM>-;+WTL3/?=JEc;J=4MOUASWL8cL=]++.XR
]d,D<&&YZ1J)DbM3<FPK-:#-,C@K[;e<#IK7S7BRJ\ZDV&DOS2W&0&&=G++:EC(7
C]0,H6X9HbVMSH;&?aJ>8e0A;R;E7>7O_fLR^>UL=S2aKT6)<]X-N1>MEVG9>29G
_9-=4]LcO^:;N_FV#JcX[(,VT9I;e=>AMgZV4gJEE[M];=S3[B6@V&E>[Zb=91R[
@DJ=I0;@d<V4\:#-3-.SS#c^##;6gKG-+@a-aX:EdZV7Rf6&TETDW.22V1/2H__\
;6L;GF/E)YU5N&>C<I/Y-GFF[U>/.\3.I-9GT9^(P7@M\:P_b)]e@eI2g@D[]#C#
7Q:^NeG1?Cc3QV/]>dO.?CX@YAZ,_R26#=3,.YS..?;cPbeS?E/DD<2d9Ree9XB+
BCXUcT6.0dI#:_Ud499cI+]WZL3FW[3LLT:I29MOFbfLd.3QS&.Ya9^MF:3@8B6Y
gd@CX5(c-ZXNeWXQ+FKJR5RJNMRQTQ4G9H-_CS1CAfb;8&cUT_Z2Q)g;FX=gdD.4
Z/,be/)-JQO3U&UVXJ[g8.=_95[G8dd?+DBE?>KG&958-^I^XL<8;5gU.L0GgSS^
-0&MJ/EWNO]cTD/\-D(@Jg;:>7#<NMO)DIBM3RS]#J#bL>;=CN^ROW#@IIK>B/]\
bQW3NeCS9YK2M>]U4(DA&T;_W,,>];B\QTb5dJ:]F=a[A-:PDINV<JESfO,3[><=
aQ#U7,D<VLAKHKJNb9X..=7J#eNKgf4[#_1F]I,72]_dcNcJ66Ie/B+b?,X.AT[#
bU0eDA55;aWXBNE1&K2=C3N0XASd6?+E;T5I4STRC=eAg6FJ/YG.Y7S\J&.3bLbB
@Ka/g@SX0K;[K;JI#P,7:@5#R],8R4^J,?d[3:5P#0)#H66OYJYC4.R>W/G:ObH5
cgY\Q-eFNG04KJ257_KTdB;d-a@->7Z)-PDdS?1E#=/>Y5VTg75]12bZJN7E_J?0
ccC91bbN]L7RUG_4\?<6>1-OHOf]9QR3T@<9^UZ)4UTEa_JOZ?6:f_F+E_G\N>R^
_ETg:Qd]T3dK9+5/DeGfAAKA\>&^@(IIa>eO+fGU]?#NFX#2YD=^Yeg=6\TfLP_T
YSU;@.4)(d;>0dP>R:#@a8KA4$
`endprotected


`endif
