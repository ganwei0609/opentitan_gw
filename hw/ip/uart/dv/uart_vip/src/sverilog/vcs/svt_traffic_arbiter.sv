//--------------------------------------------------------------------------
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_TRAFFIC_ARBITER_SV
`define GUARD_SVT_TRAFFIC_ARBITER_SV

/**
 * Traffic arbiter class that arbitrates between the traffic transactions 
 * that it retreives from the traffic profiles. This class calls the DPIs
 * that process the traffic profile xml files. The values returned by the DPIs
 * are used to populate svt_traffic_profile_transaction objects. When all
 * traffic profiles are retreived, the arbiter arbitrates between the traffic
 * transactions 
 */
class svt_traffic_arbiter extends svt_component;

  /** Event pool for all the input events across all traffic profiles */
  svt_event_pool input_event_pool;

  /** Event pool for all the output events across all traffic profiles */
  svt_event_pool output_event_pool;

`ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which traffic profile transactions are put */ 
  uvm_tlm_fifo#(svt_traffic_profile_transaction)  traffic_profile_fifo;
`elsif SVT_OVM_TECHNOLOGY
  tlm_fifo#(svt_traffic_profile_transaction) traffic_profile_fifo;
`else
   // Currently does not support VMM 
`endif

  /** Queue with profiles of current group */
  protected svt_traffic_profile_transaction curr_group_xact_q[$];

  /** Queue of write fifo rate control configs */
  protected svt_fifo_rate_control_configuration write_fifo_rate_control_configs[$];

  /** Queue of read fifo rate control configs */
  protected svt_fifo_rate_control_configuration read_fifo_rate_control_configs[$];

  /** Queue of traffic profile transactions from all components */
  protected svt_traffic_profile_transaction traffic_q[$];

  /** Wrapper for calls to DPI implementation of VCAP methods */
  local static svt_vcap vcap_dpi_wrapper;

  `svt_xvm_component_utils(svt_traffic_arbiter)

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new component instance, passing the appropriate argument
   * values to the uvm_component parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   */
  extern function new(string name = "svt_traffic_arbiter", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM build phase */
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Gets the handle to the VCAP DPI wrapper */
  extern function svt_vcap get_vcap_dpi_wrapper();

  // ---------------------------------------------------------------------------
  /** Gets traffic transactions through DPI 
   * The DPI gets the inputs as a byte stream from the traffic profile file
   * The byte stream is unpacked into traffic profile, synchronization and fifo control information
   */
  extern task get_traffic_transactions();

  // ---------------------------------------------------------------------------
  /** 
   * Adds synchronization data to the traffic profile transaction 
   * @param xact The traffic profile transaction to which synchronization data must be added
   * @param group_name The group to which this traffic profile transaction belongs
   * @param group_seq_number The group sequence number corresponding to the group to which this class belongs 
   */
  extern task add_synchronization_data(svt_traffic_profile_transaction xact,string group_name, int group_seq_number);

  // ---------------------------------------------------------------------------
  /** Starts traffic based on the received traffic profile transactions 
   * Send traffic profile objects to the layering sequence
   * Traffic transactions are sent in groups. One group is sent
   * after all xacts of the previous group is complete.
   * 1. Get traffic objects with the current group sequence number,
   * basically get all the objects within a group
   * 2. Send transactions and wait until all transactions of that group end
   * 3. Repeat the process for the next group
   */
  extern task svt_start_traffic();

  // ---------------------------------------------------------------------------
  /** 
   * Tracks the output event corresponding to ev_str 
   * Wait for an output event to be triggered on a transaction
   * When it triggers, get a list of transactions which has the same
   * event as an input event (ie, these transactions wait on the event before 
   * they get started)
   * @param ev_str The string corresponding to the output event on which this task must wait
   * @param xact The transaction on which tracking of output event must be done
   */
  extern task track_output_event(string ev_str, svt_traffic_profile_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the xacts with the event corresponding to ev_str as an input event 
   * @param ev_str The string corresponding to the input event
   * @param input_xact_for_output_event_q The list of transactions which have ev_str as an input event
   */
  extern function void get_input_xacts_for_output_event(string ev_str, output svt_traffic_profile_transaction input_xact_for_output_event_q[$]);

  // ---------------------------------------------------------------------------
  /** 
   * Sends traffic transaction 
   * @param xact Handle to the transaction that must be sent
   * @param item_done Indicates that the transaction is put into the output FIFO
   */
  extern task send_traffic_transaction(svt_traffic_profile_transaction xact, ref bit item_done);

  // ---------------------------------------------------------------------------
  /** Waits for any of the input events in the transaction to be triggered */
  extern task wait_for_input_event(svt_traffic_profile_transaction xact);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the WRITE FIFO rate control configuration with a given group_seq_number 
   * @param group_seq_number The group sequence number for which the WRITE FIFO rate control configurations must be retreived
   * @param rate_control_configs The list of WRITE FIFO rate control configurations corresponding to the group sequence number
   */
  extern function bit get_write_fifo_rate_control_configs(int group_seq_number, output svt_fifo_rate_control_configuration rate_control_configs[$]);

  // ---------------------------------------------------------------------------
  /** 
   * Gets the READ FIFO rate control configuration with a given group_seq_number 
   * @param group_seq_number The group sequence number for which the READ FIFO rate control configurations must be retreived
   * @param rate_control_configs The list of WRITE FIFO rate control configurations corresponding to the group sequence number
   */
  extern function bit get_read_fifo_rate_control_configs(int group_seq_number, output svt_fifo_rate_control_configuration rate_control_configs[$]);
  // ---------------------------------------------------------------------------

  /**
   * Gets the resource profiles corresponding to a sequencer and adds it to the internal data structure
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   * @param sequencer_full_name The full name of the sequencer 
   * @param sequencer_name The name of the sequencer 
   */
  extern virtual task get_resource_profiles_of_sequencer(int group_seq_number, string group_name, string sequencer_full_name, string sequencer_name);

  // ---------------------------------------------------------------------------
  /**
   * Gets the traffic profiles corresponding to a sequencer and adds it to the interal data structure
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   * @param sequencer_full_name The full name of the sequencer 
   * @param sequencer_name The name of the sequencer 
   */
  extern virtual task get_traffic_profiles_of_sequencer(int group_seq_number, string group_name, string sequencer_full_name, string sequencer_name);

  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronisation profile corresponding to a group
   * @param group_seq_number The sequence number corresponding to the group of this sequencer
   * @param group_name The name of the group corresponding to the sequencer
   */
  extern virtual task get_group_synchronisation_spec(int group_seq_number, string group_name);

  //---------------------------------------------------------------------------------------
  /**
   * Gets the name of the current group
   * @param group_name Name of the current group
   * @output Returns 0 if there are no more groups to retreive, else returns 1
   */
  extern virtual function int get_group(output string group_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the name of the current sequencer 
   * @param inst_path Name of the instance to the current sequencer 
   * @param sequencer_name Name of the current sequencer
   * @output Returns 0 if there are no more sequencers to retreive, else returns 1
   */
  extern virtual function int get_sequencer(output string inst_path, output string sequencer_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the name of the current sequencer resource profile
   * @param path Name of the path to the current resource profile 
   * @output Returns 0 if there are no more sequencer profiles to retreive, else returns 1
   */
  extern virtual function int get_sequencer_resource_profile(output string path);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the current
   * sequencer profile. 
   * @output Returns the number of attributes in the current sequencer profile 
   */
  extern virtual function int get_sequencer_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the sequencer resource profile 
   * @param rate_cfg Handle to the resource profile configuration
   * @param name Name of the resource profile attribute
   * @param value The value retreived for the resource profile attribute
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_sequencer_resource_profile_attr(svt_fifo_rate_control_configuration rate_cfg, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next traffic profile
   * @param path Path to the traffic profile
   * @param profile_name Name of the traffic profile
   * @param component The sequencer corresponding to the traffic profile
   * @param protocol The protocol corresponding to the profile
   */
  extern virtual function int get_traffic_profile(output string path, output string profile_name, output string component, output string protocol);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the
   * current traffic profile.
   * @output Returns the number of attributes in the current traffic profile 
   */
  extern virtual function int get_traffic_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the traffic profile 
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_profile_attr(svt_traffic_profile_transaction xact, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next traffic resource profile
   * @param path Path to the traffic resource profile
   * @output Returns 0 if there are no more profiles to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_resource_profile(output string path);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the total number of attributes to be retreived from the
   * current traffic resource profile.
   * @output Returns the number of attributes in the current traffic resource profile 
   */
  extern virtual function int get_traffic_resource_profile_attr_count();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next name-value pair from the traffic resource profile 
   * @output Returns 0 if there are no more values to be retreived, else returns 1. 
   */
  extern virtual function int get_traffic_resource_profile_attr(svt_traffic_profile_transaction xact, output string name, output bit[1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the next synchronization spec 
   * @output Returns 0 if there are no more synchronization specs to be retreived, else returns 1. 
   */
  extern virtual function int get_synchronization_spec();
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronization spec input events
   * @param event_name Name of the event
   * @param sequencer_name Name of the sequencer corresponding to the event
   * @param traffic_profile_name Name of the traffic profile corresponding to the event
   */
  extern virtual function int get_synchronization_spec_input_event(output string event_name,
                                                                   output string sequencer_name,
                                                                   output string traffic_profile_name);
  
  // ---------------------------------------------------------------------------
  /**
   * Gets the synchronization spec output events
   * @param event_name Name of the event
   * @param sequencer_name Name of the sequencer corresponding to the event
   * @param traffic_profile_name Name of the traffic profile corresponding to the event
   * @param output_event_type Indicates type of the output event.
   */
  extern virtual function int get_synchronization_spec_output_event(output string event_name,
                                                                    output string sequencer_name,
                                                                    output string traffic_profile_name,
                                                                    output string output_event_type,
                                                                    output string frame_size,
                                                                    output string frame_time);
  //---------------------------------------------------------------------------------------
  /**
   * Creates the correct type of protocol transaction based on the
   * protocol field argument
   * @param protocol String indicating the protocol
   * @output New transaction handle of type corresponding to protocol
   */
  extern virtual function svt_traffic_profile_transaction create_traffic_profile_transaction(string protocol);

  //---------------------------------------------------------------------------------------
endclass

//==============================================================================

`protected
a3S4>b4<EH)YZVBWcP_aX2<O0?]-aTf_A#NT1=>9GRKSa;_dc.=-()G&&=/#5794
WM/XMYM,F3JWf@H@<77dS<U],>O@a=E9e^D7\ZP49^DBN[Y0@?VOT[2XV^g<f8dS
g+=-DgT7,F^FF@D?f,XW.U^4Eg5I^J0Ud_YH0/_g,Qg7cVJb\)-<H=EVC&IfGPTe
=g,cV=><-=^d30+]Zf-_9)c,-Ld8:T[dJZFf@=32[,#(J-Jc,T9T,,Y2b1C@8D[Q
\1D;aFN-\G>UZ,ZQRCJXKF2>_ERK\aP1&QW34^,LVU<574U2X:8DU+c<Mg4)Kf[0
]&+g>Z?f=E/46(e\O&fI@LLO\MELdcD6^VFeNe0^f5.I_00M]fNf-N>M2aFZQfG]
1/@BT@2TcCT-04GDOF^HP5&e<;S#AGX7@9BJ=E?D+QC<<OcgaFWa2:)WgV#8QaX\
89+&=&Q_RNZUAPccIeEJ5)UgOg^S24;MP&Hg.?7<;MI=4/aA)g?ETVICQ8&NFB-.
EDK6U(4X#&U/WcNb:Yb<8A7-W7^ZZ-EG_Na^.,1<@(BT68YACVMg2JYTZ.E5GXW/
7;A-D;fYN@(HTG[RJEPJ8e]Z7[L?QR2W:E5eITT^HI^;=6e?/CFR.PW<46--K0-a
()8C97ff.E,8/<E]f]W_C8ebDK,@3119eg@,H4(T@:D@U?60Z4Bb,]F(,AaN9^b_
e@3d@4_L2NXH5=3DNEd0IS.dVY#E37^\bSaf?^]eQ)2ZQ^PK1&Y8#5da&3#c:=(D
D:;8Fd7Ic>T?/fY.37JM[7J_GN0AD[AeIWeX=S.>4=WX\bO#R4c[QT85Jdd/G&a5
c=UR=_??.507R^USX31fMd,COB\Q(Y3GO-9aec@B23:KIcCQ2e.>5N920;Va\5?P
O^7:Sc\3fe:b\MD85YM3I[d;Z[8TOQB.V#D-Wb@RJb:gUaH#AV=6B(VdeAR,^:)Z
>UOK).^e697f1XN-[OP]289/01Y1bM>UJ_:Bf=\#U3If=fL9^4&gM\0V(^/4SO&G
g.F\RdTgZb:(2?cVNS.@O0ZAMJUT#H88ecRK(7[T,-#6gF+-fcU;I4bZG<Ma;#(E
DaQ#Y>WR3PCPJH.X0fO2/\AA[#W^)9MILA2R=IKU&c^<<B:N3=;<_Dcf(;K^[D(F
_@4W+V[>6]Q\K?<N0::#@L;d&=bP.R(915f=_Ug6VH/XZ(&CLC><f<DO2Q;8U<5,
H#5:YS(T6B-\(ULaXO.V=6W:<YJC/bCY(=d)EZBDER/g=>PFcG\bd,6PNUSV-5W;
,2=9UdBUeC?dZ&QcEDSX9cY7)ZMS])#dgZeOI\fO#MN]e:>=MG.4V0&X6,N=E66E
H)0IH+Q[_B_ce7cf_L=COD]<a1J7O4B/\bO@Z8GH]X[[NUPIGdK/cURNeO)G<OMZ
73L-,8P.2_W.12#H9g5aYL6E\E?Z15W[=XbdG_ae8?f)gWYQ:e.SZ090@Q_dQB6.
..e.WQ)5B5W+]3a-c1B3#gBI8eV@e(,V&LC,INA1;dG8I9\XZ.#&,MaaEWV1)/=c
50<[bEO[??2d=A-D9C5dK4IDBRfb8P5]NKR4bFBGMITE<)7fDVEW_^g;Z?&+4V_<
;//UG#US=[\3NA8)YP35Y5+2WcD[(d:78EfY_MQCX,(8);AKH34Y&e@aRK:9FK\c
G8MQ@JXMUL4cLQ2:PWOVg3--XQ^0EQKfFYG?)bAf5\LeO:YG?6@+CTGYVgLMLZ=K
c8+gfbbedc]4c/KA]\3bF>8eg#+AHO:KA^WP^OZb12O1LM:CT?,=_eC[e?LGU:IK
IRYEX(^L+-;7D=DY&fOZXBXC1BO#D8F[>M\(?T0-_.>cE]A/2dUc??1-Vbd.>gWW
)B&MNJS>Y2VJCdCA73QV11V/&E\=#,\-Y0^>WG49cMJ=V(?4[.^2&(1U?-<7?(fP
T_7659A.>[Y\1X,XE=B0PJ;BcV>>6YOCE/;]O1D3Q5LA:FQHHW]f,I+D#,:>4^O@
d]:#+)M]7=AW+.NA3JAQ<R[5.#^XTL[fd<V]#OZcAb,/c#CV4D.C5OSUT2\9P:73
]Uc#??7d6KFfS>Ob61V#]6T;+B(@O&>;22cR-T5L&I3J>&;\R_BG?@<3W3GX],5-
QT#D]5_JTGPdRH[R]]H0gD::d8g4dW4NP[a7/CS3NP^<;]R;8064.V=2]ZN;ZCQe
=_Q3O5.LQ<0a]gF&?T@NK@U0U@P#N2)65A_3IAHGK\#JG8cGQI1\EG+B-V=_We\W
S8,8II\;JcC;fe]H,474edgA.FdW5SL-8Z#b[7B6>T9P<e+>(=EV+?9aTE1b]S,5
CC.X35EA9#/_;K7T05S]\bdg>bO(IVF4YG+<UVOT?H)A)@GA6eX10J3GIAV-@]0)
=BX6=ZF(2=,#9]0a?=J?M-U053-Bc?M[[ecMNE3g[Me+5RF2eAMI@^aNX1DM-fBI
\(Iea7,)5]fR6QC=GX40A&[41H^]M54OeIRbO(FLb7bJeTc8I<a+YG@H\QQ7TWQ/
W1K0DV-8b)O+LTQV.[gH:C=2U5+/eV6:;X^F1^XYcG]JWc09Ya(YPJ_5?&E]^_E7
(RJdFFH=)^SPBZX6/.&SKT[deNccVRD?5S<2;7CF0D#M#:^,_T:IY3gVfU&M3:fE
6TVd)8#^GGCEL5(Ca6D<OU]&B0KQ3VR#?U4f4Jf866:>GPg,3cZAMLBb<bK:A)H3
cVC^>WW6UgSaQPMXa0a[9<7YbU^4Q]<-,HNIDRA+#8GD0EaF7e9]M??O;=8)7M--
4A6HJ,_(^fH]EF?d\Z1C6KfFD(<[\@/Ya9A:.g9Z81dCT+E)M.\WI:@<ART5gdVH
4[F2C&?:BM2,JW:6+B<UG495X+3Y@5VBD7b.#8V#UgLW^:S]f9Q7V\WR<7:T,)[4
#P0-M]GT/FaYa@LaZ^;+cY;^T9]g?AWFMdFGK5:C11]X@STPY(+GBd=WOXgVbPP6
8:]9-0LX/d5/U3[)9C^VX?=e\OJc463VUBB@UafCS0E1T60W85E]B<<A<-c)=3_-
B31#WRJ?YIHN+e0WAH36MB;Z7>HHK5YPQD>b)JG@e+S;66H,G2a&:N.IaOFV5]K[
:U0fT=bG/Z)b([E.IfACF?ST&]YfLBWTc>g-Ke6AdQ1LD^Q@W_eB\6ABNcc,EZAc
BdAdV6OY\7S\#9>UHN1_6SNc7+L5C.(Q4J?FB<ORM.U@L(/A=]e10N)R;G876^CK
S)H>Sa:3BG_,fd9Tc,QDC0(9?Y>0-L215:b\A/eJ0&/#MJa\\#>MSB.J86e9Db=V
+HE:@J@e>>SYG7f4bX<-:ZY7/58;X(MPfYI2dgd2>KdAO:dHHIIAOD_@BK6&[8K:
=_64.F1NVd#,=E3F6de-G;fCK//J7B(WN60Y1AFL(PKSEARQW91X#S1S9U</-I^&
9TR0&QWV[a/3YaNeT[Kf\K.YWH=LN-R8NUBMEU\PKf9,()_=N3:RcX,_:M0QZA6#
8gZS2U=33-dX^:+C&Y=4GUSM/WCP@=b3FG+aWJ>5S=B+J];[gK2<aRTO+ed8Ka@&
CBF-Y=e@H7N30.O_5QUDXXg5QKU2e(;GW563RZZ(V4GO1,.4RH8T.)ZTg+)bbWX3
7:R[U58>\,cfd/SFZZE_HK93TaKZPKC4B2f2cTeRF;1LXWIE9f.W-.cV8+U2KI+X
/M9I69<QK@f]N-[8>7H2JcD=V?Sd_+3C>1Q?#H7P.6+O,7T70RP^Gb1,&E[7,=?-
_Y=#M8R;E6FdQWbcC8:dTH-MV5U(5Q+;6T-W)3TF\[CcWTZF6>SJ<A0M-?>3BW0M
L6T6/^F6>W,::>I=S5f^S7FJL<0LR8[+1\ANUEVfETS2O^FFM,IYW&EXLH0N[9DC
L1MI/T/SG1W=JNG[EJBZW4E)Ub<:H02.a9@_J38g1Q+R^PTg1]W\I(c)/(g(8K#H
)=gUG(<R,#6)_M/,+7JP#bLUQ0f,:NJ[OF<7gZK305Q1A4g=X[N;+<ZQ2c5QaD(5
a\C?4f43M#>,3gVA.(8SXegNU]EcFe=cKUH_fbeUbH&d6CD+W^_GOGENGbIaR,15
T4d]EQX5R&MJGfJD-[FFD1&#QOS?e\Q1&.6b<_,XP:]E:[cN4>d:(,\NCIE;;VZ]
,dP4M)WbYbU=(4(X-4E.QD9<N4c6^B^A<c#W@cAX0F8M8&24>&IXf))WQDGDgI@A
@5T81aD=I/3aa6I2Ka-8OO-UIgN_[d)LDe?L5>Egf\eP:OdG-+8D92Uf,SHO=B)U
WJ/86UbD3c:P/--b7E4XNcQ=QVE4=7#:QYUc7M;92QA.8KaIO9A>.(QVPPcI]MXf
5AW[8IN+)Z3.eFP/K.Lf53YPCbPOKOUI^IE_+FZ>C(Ga_XAND9b6F;R_NBJWUK(I
3EXC+U+)Ld4^c>XJOM.=V+9KO[Z9Xd>KM33K=R0b5:,=dbOAM?Of2fMDE\/\SPb_
AbD>:0]-4\_[PEe2[SYQ)d[DGW^g^fCXQU3:+-0TU(]W#G6W5B=N2]T.bCK;RQPV
)1(PLKFN3gPe@_Z:8VF?S+/E9UfJW3ZHU+XG#K5XS<&E.>W5<OgDZfOba9e&SEGG
^[Pa<g>=A2R(1JTC54WN_;c>(b&Y0#QP_gLdR9E?E]BVO45HF,&QIH7Pd5@@(U59
I.ZW2fI.48BMZ)L06<Y:2<11[#CgT0?-:UB:e:=7cP.N)T^;CM;G_FbFPZ<VJN2;
AdU)DKB/Z3(f8)0N1a?/.U301GA,c(P])F02Z]3SXSEN1g^TS5f)HB&I9f&<=G[R
R#6+8<3:ec.SP34c1C)a;O1Ff7bOP;RK>XZ&&,Q:?JI(8JPQ4^ZU>ER1YaJ,a(Yf
a2>B7gG5Q<RCWA\NP7:F=[2c4TD6YH+C0_<]1M/g63(B&g(,L/\9R=;=K8PWGBUN
V?\QIZA;[WL+4XCE&[M+#;Ee-#;C+J5X-9Ce(U#g9G1&,.#/B6>f=VB8^E&W68SF
+ARg30Z.HK9EJ,\)7c-]KI>VaX/<eR3f//QW\[NPZ?6NPU,cVbN;Og]^]0[3R]12
)e<fbVX,MX]]:XT>EK-;C1TXWa34F7>6cL#60^X>T?4L,eQD_dd]Z.]0\:\d<=gB
PT,g.gP&PUOAUJe)+WDJL7HP=^Zc9=E5dHK/d?WF::41Q/@_#)89bST6KR<G7=VR
0/7ZBH0fdE?&I_.]:3T8?fVAefOKSP;.[[GPYG7e?L0R^UB?#NcU^)HOEQ[dA-,[
JDEQ>W-fdH[#;78(6be;A6[G2d0+C(fSO?73T5M\gF(Wa#Y&<7K@8dK1>O=G?9_U
&IPC?.75\[bgIO>IQ/1\D=.M0&-#RB]@^,\HB-Te5R80JF4Gb88,\-1/@6R(@9ZZ
;\>&7bXBO3)cI-I27^;ZC]d:989C/YH1+a/U[fgUFM2W?(D^c.TV:7,;<V0HLER1
10?94CDfALHK_J(ed@[a;K(eA#866A>C\IfRZ4IT7a-,>?.9>&:,P3,]&ALX0,1F
46XeTQ,K]?6a-gA9P+5]egL?,8H90BT,0_gW7?]Q/aEdX)NcY:1Y#;:D]D#L++[+
Pc@e<H08RB@HAL[+</,IG7AE2\#?0^K5:\[5LT]^MWBID3-e^K#6DcQXC_Gd:&]d
\9I&791e[KEOJ>g[9=Y=T&b0QI)8-KXP]TYJUbKgIM2ZABPR9M)e[ZIA<\:e35cP
\c_=GD:5N9E:4fW5YM)KXNT?@C1FH4VDf@4:ZK7VcYWEW=-0(NY71/X).;_a.(LP
=IOPZUPZC]W&9#9_.M[(-\^OUGaNedQI;SRD59VQIR;ZEe+TSXKYIQ()0WG\^K,(
8/H:7>d-<Q0?a1-8J_X3?.DI0Q1=H_E4@Q=T>18C+(K55,<Kg?=9UdYP:^e^&6eU
?ZF/G5JS]db&QLfJR_fJTB8T;;_,f?ND^_Q]@J<_<cR@.AcFE>_a0QTD87QQW73Q
Y?LH/O,YST9_)BWa3X/97=/T5@Z3(2BYN-ZT0[[P?B:,TNg^MPK])dbc\-SU#S37
C?6+FI+d#aI@YTR2N?W4=0)_1O7IWIRDG/47g+/L0=<];Y#LK\M8+2=6&9W3J0)F
1d8Y,,PWHeb(\]d?;_SN6I23A(F1gX9eR4dP+IbfYA8CSb3>=N)MF//=8HA@+Q_J
BY>1T^c,0.-[G[ab<M^19.IP(F)#(QbJ5Dd3f&=ZAD=:EBZ<;WU8eZ/?fL=L;G;\
;.P1fb^8;UBQg_f;Q/Bb:Uf5RR(YB66X//c^U@/+d-6)cY/;]1fd#>7R4N>],(:b
E049@X9a:DNg=HGT@I<c^K-A1c[R.&BB6[B.J(NVF+3;)>5\GXT9#c8Z^W;ZVZD9
4HW6V91LgJPcFO\H-V8,(bID?7/]F,2E8H&e4DG>1\@7,2Q=>ed31a]]3ZgFg-E]
E+CRL;QR-F:[g&=4FXE5_E#:RF71MaMg<^K[3-<;/IVQJG4][>9Wdf3N,KODc\.R
H;Z^01.6N7GW\J:RN.VRVV,JaeNO;HLJ[NAbW7-[=53Z]V+/SV0\9T.[@\.eDD5U
J4;ZYO,A0e.]+:1-A=S,7?LV1c3BI-Z6T6-1T,:[-L=;([<AC<Qd1-_I^:.&T>47
:G/@DI@RU:cTVUAMFB(-J94;XQFQ/-4:=8cBK#]Y?\9/W/2RH(IL/)5M@=[UT;G+
C=7-_P1b+DKF<-,Z1F/cU>BAa215/SAS-UH/9O(6NREV<d.JaE3VM<ff#YR]PTR>
OO/)+Y[=gREDC=B)4:F7Y(QORR>;#19Oe9K?:_?f5,\3E+0>NJZ3-dPc;]SK\4\b
Lg\ga/,@;@A3c0ZYQbL3UZT+@^?_Kc^Z?Z;E9C5(0e?\[;JW@GePR<2cgU_f[AOH
b1&a09,F:#QR/CD=I020M\;Ne>3QJQ.LFFGYF?c1gJL,D/&ac>G[O_<,>BGU]+GT
&[(aZG:]]PY:S;E,WW5fLXN?<H6P[HDFOU:2-E0_YKXJ^Z&B<Q#MXX)_b^ag]=_S
[M?;F9bg&gZ1(AZ#3SV[K(81G\e6<@V@fC=3#-T>f5,5\Q^H-JccPUWA;_;JC9UZ
1/)RWJQ3_5dDA<#AeMLN:B4^g1C&\JYIAggb25Dd6+<Bb::JY(:FcY+Z3T9V;FL-
GD<<A_cD7N,Z;GJO]W]Q.2GJF7IX<74P<)&XT-=^]9<b54a1#[\]\a_7T62TAbK1
M_X(SQQ7g82SNA_CL7MRV\a^g86W]fcSRS.,/3X_FD&2GeMKO]XFK/L]]V\=;TR&
>KZ;MGUF3\gN)O?,BI(=C<&CRV&))efUDD-I&P,D4JW;;N@,C7Bg[TKRdEB=FD3c
Y@7RS>f&0[]Z+63GfZ4CW+U.Z/I,g+AS0#_;3[TR@+RI3CSa)^C>#dCa,Qf:=S6d
60WHNHFM<INJ#D@/?ZTWa8K>5HJJ<QfM&cF^f#Y:f;>f:9cB?=fX.1K35TL#R2?C
/++-UIS1;CS:C)b:X^B)5#F/_7b6R([Ufbe0=RL9=U-CS3V&PcW/L8d-RZW+cJOE
Ze0Lg./7)HD_7-R]7]7#6GG_^YC-F]:;D(CT[;@=GCCQ\>)FaIW^2O@W2<RRfCN.
aR:[;@B&(X5[f8GPcDWT0M@D/BYgO,\:1(b>]N0I608F1dJdOPQ@74>PXdIePJC3
&R-[S_WgKcS-,)>3WJ<aEL^(S)PZMYO6AJObA2@NKTFBf70(4ZY)A9HU^#ecDDPZ
6I.R-eR1Ra)?.4@WE2V/3<YMbYKPO&f;4f<HT-41.B4^-<N#2P#IP&(ffK-8X&=[
F,XU2&TCfS_;>-9O6?P#a)1Z+YQ<3L]E0:Ad=)T8Za\/>;ABB]UYCaFCIVQ83EB2
BXW1FYG[FGPL^P,6YD;PWY:WO5R@C]@[B4I]NA5ST\;;^(MK58O1[5OFW)T&f[d,
N]R&2=2eR@OL#F&29YHY6aZC+9O,FR5Kf5\]#E&Y;X_4_0]3<fMbMH6Z2ZTFH:).
T>G,g0S&D;@LYH.8KDBTcaRM5d.b)4TM(;@EAL437\);WO,QdcdgCHRZ>Wg[P&[7
G\+eQF,<A3[aV35RB;<^MK72Z\P9e&]AR&U_#.;15HZ^?)B.@85<SJAZF^M&bF+B
T^&2_(T3[UI#E73O8)g(E,bY(0ABLCDGBC],4^OP:e)VM?-6?[9<[M.A^;IeE4EF
Q4484F&81d7QIKT\L6KFK1GQX4b6b\,;LG=ZKBWF8(1W+L#?P\Z<&O@HL&7/E,c)
6a^=/4aI&.7Bg,.@[+13P-:2+/Y;;+G)V[W=3/&V5[>]C8:4S1Ha24e:)=U[T]]M
B39&7POR:=UZIK^F^.?D@0?04NO[>\c[7/9G,g&AdACN[BOTNF@Ub3a.5GEc,a1G
BTW:E8#A+]H&ESTAX[LP?b9,&&,PM39ZW<#=@;KNZeLA?Q&N,(>Jebe2L_=7H6b1
S92[@-Y4L>1F\FYe@2U6g/.2&/X<,_N:)DJ<],_gJUH6E^DfRD_PT\UGBb^5=]I^
))3Q/@]ga+Z?N+=K3<8?#+>a+KUKS)F>B/@<]/J5I/gU<]+Q,>,^IHOI9f/;KL?I
?K9-ZAAVC^SIS#=bb)B.#5Y\D:T1<-5dD7F-62LYW3.JU.+KA.e]Y9((WB^92EO@
UQO8;=-KAN,&5C(1R8.3LLeQ&.e]@Le(+E>cJL]P>5/3GH=G-gAaX)>R\_9b]ae/
:M4/A:/AFb9M517)O.+ad:IHE1C2I8CQ(89<-@=O7VVZ[_E@aX4b-aKb[/F?fU3]
e62,S92>]6+9P&#cBV3ND[7E8Vg^;4<AJ3ALDOf_LL(@K5=C213/BMSQ;C>,^]S_
)c.8.[NM5T[=,5ZKXM-GKN3IeR.G[DTgZ<Ud@TBW,?#;4@1a(cb^17.c15S:5eKD
@2:YK7bMGC@D:>(?c8ZbFDI7WO>@1\09)5DA#8B2bdCM#MYTP^?0:F2K<G55RH=/
)..<]<JCD1KTRe-DJ=9(A7K>#W\+M=ba0-VfOXU&PZB^+?J.ffFTb4S6CA8GW_Y)
:5F:R,gS1&I>=HQ&[f9CYD[K_4d]DS+Y7VW<Xa8^):]]A5RPMUFV3PIcP+(O1]K1
CG,=f6@1\.[HRK(K,<CC/+Z:W78+&Z2H=II^,(N==eD3N1E9ZMI,4,3=8^a>aK5U
=N\PY.2J]-P@3/K553NGB#L55E=RF9;O[[D[4QG94Ug8RWeBP_UfB#Jb\H4L0]bC
)/d1SK,23A#5;-G:4a=<<;NdFQG.:g+OOT6EcH7Gf9K,UXa2J2E/&H7^QEbS/DQS
LW2F]50;edA0-^]GI_d;@BP54K73[A8:3gTTaO#=/NF=RUBa)DafY7)\VMgG\dgA
VWg3Lf0C0VdR]f0e=F=U4e7&;Ba2Q[_#[BaNQ1?JBMIJT)F672\E4eU&ZUE(C(dT
BJ<ZX;FgS#\CD@@aSIH5O:?.:017>YT^54Sf8\-Q3NYI(9P@#cc29Vd+5,;^@H\L
EK:bHS/X(Pd=[@7KQ2HB,_E<BcU9D&U=5=1TZ7\?g1e369+AL6<1XKQ2&6?(\+<-
ZPEPNWUJ>#fMb9Og-NJ.N&N10dd&YLJ:&5;:RHeU&-7(BLX]O)dB?]K-G=Z@LYX1
#J56[RY[(_CRb=5,d&[M->_HIMB?[<N+IVB,DTfGV(Z.DaDXJ8]Od#F>J1_.21^.
:+E6;@?,^>dPEN@OXLOD&9<>>WfUgUI7#,=5U;4M.Q>AQ]-19g<ILb[c.32YDcN@
[P=0459E:Fc_eIJfH&[f0(4gU)/eV/40=\_]/&#8MD9Z6f),D5)D7dN8aS0&69a0
_.N17X:.=ece]8^#eUf]6<ZSaMTOHBAFf<LRI1^OL_DF.&>SY>9,[XVGPbC@=Ef@
JTX=-J;\f[Q:AeUZZ8LQ(3;ab=7A\?(>e=gP-/&P;I9M.c6MaVK2?MSO,MKI2E=X
.-PABO0\YJ1HF(Q81#I/[8SVFE+&C;g_YdY)>c/=@;H3&BeV;.,R/@6UVC(::#da
c#&.gc.CgGD.O#e@0>@Wf;ec2V89AE93.L6;X2V/Z,E5]T[a7cM?eU1#8Ge_..3I
L>NMF:@IQ,C7@B-40ZZ]=6BI90RQ)Q/7,JHW-CQ;(fIE.AD]C,LPbQX,50/-J.L\
S47cga,[?6XV&<JaQ?[0HI5#Q,/\;fb]IE^Y:Y9MAe5SBEZYab+>WX,c@[/>DIT:
WZD/MeC]cdFg?^;(b#PN8A[b\@c,c873VTJ&MW5I\/KYETSQaKdL1/_VSX&\CF;]
,A(L0@Eb^M>c301/MM4;G30SD:c?dD?H5B\f4;<HD,XRS6c;JE:Ng2-9=g@3X2/,
Se56)7gHOe(\VU8O2bCKZ>6f1MCR\75&&]WF2TY:=&&Z@YM7dcPF^>E@<=f4O,4d
LC<fY?Y?E:[LZA</AAIJ8Se+^5I0C\V@5cX+URU)H7,1T9RL:O-Md9b:K>EGJTEd
5ZXM_>S9?FI;L3&RWgUM1X4Z?Z#H9_R;,U2=TP_FecH;;a:+]UQ&[#;YSb,.ACI0
TB44[#^gc7K&NgFF9E01I+f@/6PMgATJ^2AH.S6._:L<[)SAEJI_C9^_&&C4.-X+
9c9-_7A>38ZA\+#V#T,\^8b5M/H,P#5ZVE)/,VWJR(DK&>N8A<eX:B:RJ2D.::^\
Q>+P7&_d)3=Q10;5\-SW[BB&RQGd]HM[)J.OXeGTJEV(,/CDG>GRGYK9VaM:cQ\P
FK;caL-+Dg+CQB1GG>J/&<OY8WEG)XCX-[2S28F]bU)8YdfV:.Q_)TX-AOL6#Y7N
0Y)O42Yf.e>.c\,WVZQ</&;)c7@EM,3K&Ga+Z[^Q^7#.RDRBLZ)?Ye0<@^8,GP\^
3D;^]/7@WPWH7g<abA#SD,2-Y&AeEC;[2CGg@(/PWYBa[1HR4Xggd^E2ELfKWH?E
a_a=Se:CJUOMNVHEQH2(_[X\Xg&C&RT>H8O?:G_U6K;?<:D.29K?F&\Ld2R7;BbT
a:&6_JcU@B\L55KDACGEF6YF=aU<8QH^=6PJ17JR):R)UQgIRMEL-^.+#8-6&KK4
S;GY;H2<4I45N=dWHHZcHJg))(.Hd-HScRQDGdG@G,0,^EI&VPg\:E>-V-YC(bJD
R7YK;+_ccJCH[f3B_/5d2,]:,FNNUB.R?c5L#J:G9(H=5(4)&_,R?\8D<aFW^\.a
O)^ZZB;01?eJ)Q[8YeBEREf<4>V7Q-;<?WCP]Id3N.N7,NU)bdCN1?:&1=#Wbg;B
P_L49G4CUS9<]PFTFL2XeZ3QMbMT=7/B[,L4-E@Q_IRU#OGA94L0^J##@g\>FVZV
7(N7EERCIG@HN4UPd>9B.ODBX:[g;CJ6T\0bO8.M\4]OCb_?&)7.[PQ5.T3M#:[^
d/[dZD(LNFRO(eBffQ7:NP_B#:=&Ua@SO(M?__Fg.VR@eH9P8-F6/R41\+7=.?ND
XFVW:]R<@L\5L26U]_R<)O7faX(_?+-[Mg(\gOg1)=Y6#R;<&]#/.bHX&BGIG=5C
0fVf,EI:ACR9K:5[bM^CY1?2(GIeHa^HaDGVS6_32TX,:d)e^(Wddf=T0+I<Y#BF
HUEMBcb[O:L79H<](A_X5I5#4WM)EO36JCNNe9SD_YW:PN+&^EZ)>^K)JM6b#f\d
fZ:1M_<WW?D\gUCYE22I1&A7^6c#b&1-bEOKK,AT_UW&ZaM^G?8LRC:H])_RJcN4
U76?PcbIY;)]\X;+NOF?.Tf[AAH550\[_0U)f>HNMR&M3&YeIF?K1SQ<(gfa0ZIS
S<;ZD1(,bb7@TKP>0@S<\(gf)/cNbcX^&&,S/L#V1&\b,Mb:6-7b0]IN?XSa58IV
B_Dbae+[#L1SMFVa^EBE)[0I5c\4A?@=KRZ@TD<D@Vg\)RBVf<A..d7M^FUTIN8+
(+S-,WDYG]M@9MZNgL1&08#bf2SD-ZT,,=^</7Q6Wb4W.=7SW+I)G/9B^&;Ec,_8
,_@NeWg4:?43)AabUPOB)PYe.&3&O<G8]GQG]4E0S2J7.-DNaYWY1R+^.^4PUeW[
LB,;JVe9=g()Ma7beEgN,bS)<Wc<BURP?R6e&4[8Q_XZa_,E[(QUfdHOVdR0HS1L
I+]TVe)4.N))P]>XKC88Ad4>,Y(7b(?9)a0D5;&\e2A,2a^cRg=&7]I1TKNNYKMa
-WF6/F_CP+/&>,>0D(QbW](\(Gb,3S)S[<I<8OIg#(M,BOI]^KUdA13:17J]]aUX
>F^Ie\f&(]a8b01]46#DRP@R@0:IL0)UBYB=)_U#8H\/&>P5[_E1?f0O/KfMP,]L
MZFKb>3>HM.#:HX;fcf+C&7\UgYTb\G+-VHKM^+_D\L@)MT2+b&QLbHI(.URSL0G
5NZQODH^:D2NRRRI4;0#9(Z;,JA0DY2Kb;GZC?>?[f28W)fM-_]eYSg9/#Te?K&7
&Z72EF@/2)<>C0@>L[OI?GY&cFU1aQ^X?Pa7YQ?#T5AN=]4a39I]H,(PH&ROEHe)
BVW?AEeeRg>;[:8^GMS4\&O6a/OIN9g@(ZY6fd?YEd+V/N6dDeB)Z6MDXGK5MG(E
QUX=1BeaY<7H^aRM)1A5JS-SOA.<7Zd[+P3MeH.16?UO?4P-7b=/Cc.R-F<8=]SS
ZU_UM52W.;NIV=TOeGR3:=6Pb;W^af:C;V8f6LaAH5Q\,U75CVA>.XHH2D(&0PV:
<OMeT1J>;B2@PMY&3^N25<)\@-Q,98V/]=^BNFO:bLQ/\CTge)1b&90Da^ZL:CKL
#5\-MV1]KP-RK)D:\dF\A:+Yd9T0.a4HO#X6>RKL<Gb)RQ3-^_45_^X2@1G5f+:D
0^58YHEJNdC;N[b(aP/9YGcaM<P3O]]0\::.YJ[a[b,?.,-Gb>GWIQG)aeFe;9<^
M]J-?8@](dU9-JUQT6/70HeN>#TN&;/2?<d=L2b4dHQ+Y,[1(P\gBV&MVQYF)E7d
Wg[<eO#L+RQc_E18DZ[]C.CdLH(Z-d@+CLV\-3:DFHC3LJQ6;R=T.D;F<c)MX2WB
J+Ef:.M;[N\5Vg\X@T>L>E2D2ge&DXYf=5fXH/?;ARY28gRWAFJAZc20&Xd_fM^Z
AIg:eL-P4FLbK2c8JU(T?7^-;^R#T_a\G<?00[NUe+[<7aH5E.;UYI=PE(,I&K8F
I-WTU;OOYG/@6TW[<4XX=@67.YT\6G,c=NSd?(Y3[#Z@GGdK54L[JLBGXQMP77e2
V720M_S)((DD5-9RG?=c9;eW3G[]Qc^T<P..;NI)UfL(J)f8\+3Q?ePH<dc6@AV-
QaG\3b)g0bA6H\>Yg&1O(D1-G4L8CTb;d]=QANQ_b+;_MA)=L\5(Y>+bY1(d>^HF
2AO@[R/\d9LZ;BU=P@M7ZeF\X(QK[Z+FYJ9/7C2&.)ZS:gAb@0M7c8T;FO<E\2a:
DF9U@-9:E-5Y8,;)AO@;5Z7+[KdICbc6GQ:_]VX_9,5F]TPJfSVe-4/JUaS-DR8=
(XI)[,[Q>B[d<<d6)9J1aMZ#Wgd#=U6]H@.4^GPYRER<3PC^,8A7aEA4]?GS+Af5
[YL/1Y_MXVaN(OVd,91\0=BKR1G#Z#]H;C/bW4bcA.H.F[MgH<K,-\N[YA,T;+@F
>5QED[9I4Y[5BAe6N&/MeSSQQ4&A?1?P1.X/^AOE?95:5R=K:TX9#(,;3L:Cg#LN
J[1Z9(-RZNEIAR5HbUFg;/8D+YDIUc0f,/+69fHG6B-J0&][Ba0W\[b7(Lf[FdMQ
HVY=[)7bCS&=JKT^^+H]]7E>Jc05:7.#b#]H(fb)Gd7G^G2\^;\,0EbZ#Y<DDcNL
>(M;eAXeOI-X(4W.e46MS1>(ES5L8\\dUI0bP7RM_WJ&\;^&@e8LeY7BS:.@PD8O
gHA/W^3cH?Qc-]P,aS6B/Z+A&UM<PS^]21d2V3X7fQ7)6^1C-^Q/+=3FQc5^B0eP
J>Q0?_Qd#-\>>e<-AJ+V)#>W7#DJeJa[[[#Z&CL.A7G+VOC=ZeCRG,R1_>_XB/=Q
Tf,f/\[M^A=VVS_(][aS&SM8e_1W+8B<@05cS3W-W5d=196J#6]Qe_V,^/(7,=bV
&_e:<<[J1W1VEC.R&b5))^Md^e\L(N2G]-G2?BDIW0:BY?Sg)4XK50?[5dM)dLP5
?D\07W8;<ZRU>K+N)<gGVG]eHH(=SOb3T,)2..C;Qagd8OE#8<(IZ#HP54Y:MAQM
T)>FTAcK,)06@e,Ge=aPea8<]L;T#M\DAfBLHD^Q.=F.:B64Z2c+(?PE5]gJP1G^
RX2<HXMF+^UVLM:5+]/0OC12(Y4&eQa5N-QJc5a9NBeaX,gN_YgFUG/,^c-#59:)
;X0O.67-DSM+,68?a/F7XQH;^R0C-KgBG,>NP]]BeQ&GLH[KAI#F=3;]_N].-X6a
D5L(?d],N]3]IN[K[NS6)R4FdK11L\M182#AT71E7G=Y-;3MSGGV\Qb8;<&\-b[)
:HPTd89Lbc[8J/F<dRXH]Pd0S-?P]JU#E/TY8E0f-J^?\A#RaYTD[Z/-IR@3?XJ^
_A5LNPaC4^3LJ@&2O+:IW:E/55PQgN([4?H0PZI9FfKJ)R#g7D?_.LM7I.O1BKL_
0DFQS\,fWKLg2^ff+AY<IRVe\#U_3A&Q,:]U/,+Wa[gHS+/::ZXH7-8:-DS09E@g
\ISW+67@9e./)aMTKdS53EEc0;&Gab&X89@(/H#,+\H5GPfM=]UM3#@.P<)4OFO5
-^MB+X0[a)POEa)<FBKdEf&5M&T@^-@X-KRJJ:#A:):TK9COH(6\RG,B8+e4=-0b
P6&T]-:C[aL><EbGU,8AI:5W^cEfEN-H1Y8.DH/21b8BR(VV#f,g+SI5+URJ-3gK
<=P94Fc&S3?aW^:0::<B9#O(L1@@dHOfZ?7fY#6J+e>J>e(KV8J0X;2=^T+&<;,E
TP3g7XKaO<9f]g8g-\J<8_;UU]<.T\)JJJfFK(dRD:8Fcf<7P:/,,80UP-YYC7KW
<10fL<:MT8]808X6O064BV;^&GC5^EHYZ-f]>I(D)7g/&+F;8+LT2M3W@#Y6+63a
^d.cS=K?QH0(7;934\aQTN=dGL>>?8S3C-58\WY4/6=J/)(<LT^ST0&J=YXY<^R7
&N[SWQ95W@(TRfUM>;-H@)LRDW7G0FgQ3=P=VNdHf[LH00M;G=PO>(I]\GFG@)XT
/+92e/&08J?A?J=-2c(cTM:O5&a^fcM5Zg@E,I#Z3283f-]8C8ZR42g#<8_PTg1g
DI_SA-bXcL#YB3KM/03(\PG:[0Y>X9+HcT;[#Q/-f;B8029,?:Jb+fN<F_R08RKG
18+/a?H:@8BMATg(0:K=+=@;O/H]9#IY/YQS,A3]N,S@,1Zb77Dfe.:Ccg<+2<_a
VV?/E]LGKM+2NeeIUOabLO7#7Z?1&;F13+\T^.S6C9/A>IVZB0Dc=J2T+TY@;YEY
Z)CE1W/.)3(aH^7+I?)@^U4@fP)CE@N=BXP3#&[U[PY1-\ARg_C,O/bKX0QH]M&b
6YAa#\5HK,2QBKLdF22?^):JET6D+,a1PAfRSK5\IMfZaRf.F_L,YF<bR(8Ka<-9
,>0QK]H7_eg7CQ8=7H0^^68V,IPI(gUDS@QBD1?H0FO-[W983a)PK;4FIJ??Nf.0
A>HIJ&PQV:B34)I@cCA)0.W6GNSH7H^ZFQGbc#9C?c?QN?-WIMVR;F&F3eN==DC[
XNVT9^#F17Z<AC@-+&YBH_7[/T@A1ST-BT7.f2MCLQEFgU#C?WPJ&HB-TJ8ZOWBY
#&[>c3<LDZ760O,U88f)b-[PAW#6RS^_cU86\KO=fVgW8M)ZO\.a3_4H_@0\_FC2
S.^6/)2a1Q1<;[baLQY:CYZ?;L-,OdI&8f=g:.ab:b5d^ePAWUB>#edP,g67Q5XC
XdB>1H;I<7H3Gb?B;/?+Rc]VR+A4)-IeU5GT?V\1CGK<-9gQ44a7eP:K/02/#R3<
OOIHP#\A7;bCdVR?8KffWeD,/.SeVbZRdRU60RPMZ7W8(/39V73S>SZ6MK(cG>A?
-HYO#QO>;&GKQP,]WR[^]e+;\cA19,H6[H6D,&:J.]GZb-,;0Z=CET[+bV&=2?G9
^VEH5NHZ<OX?g+OdGa;IA6G<754_E,(1(DE7;7PdbU_5^1?5([F#b.2WM#2?XZZJ
ZJ4I;PO4.<1T@5RR<R56X?McALc^bM@SN3UHA2\^b78>3cdSH)X05H<J51:VVRQ&
DcQ#bf@&\GfSLCK:?LZ0]WAgf#--aST00e\L2;])Bd:35R:&8FPcd<Q#:1_S3;@@
d\#-6]Ff4F7BcPV@X]4g;V#aW,MS<(D1DN&/_UOX0=dXI0N):\:H/T:.@/ZSJ4a+
d\0&51HD\S1^])f/J\866IWK2[VFYBAEDa@Fe<7OXgLD663dfIJOF(N3HQJ)&W)(
6#0;<XK-^[EaUJ;R;8Q5S6HJNIJb+K/<0E=0KAK:=#<LIMfg?fA]H;VRQ@cDYH)U
aIUF513#NZQLZ+9S;WRPbL?GN_Y&+>?BQ_88F7d:-=:C2@()F;&5HfZ@U)>?\R\0
CFB7>KL8B\I\P-BUQ4^dDM^gTAW5T&@2I1)+^BL1gSUDa]9MRSO?/AGJgE/CB@5&
M:-.?L@#;#-N@_QS=UIa;71UEBBRGNd[a@.4-^a4ee^,f1_]KOU@6#VJfCNbS9+;
M[35W:=#1\(3JO9TDK,Bef4bRa:OJD]E?4S8c:P##8,c_^#TK_,,1U@(A()-1_5M
OK?/c,\N\@,P>JBcSGKbEOX8eYTTX[B-b[82abZLXRXC/H\fQWG?ZU]MYgEa&D.<
d;6c3I_:1&aTC6,[+-a#E)X.c@\?>6=?;[D8gda&KOTUC8gaWW47A]:]0fDC2>c&
OF#+D@0VgYCc;&V1_a^CEg53OBcb]]0;ZS99L,>Z4QM)8,KY<FD2bXW2YYK(3[&g
14];5J<aAa2D:QcDM_A(@7UdAEcJ-F&KSN4e,^VF67+_2J82TUAH6VC<?:NNE>:3
T^;9S\.P&I8^&_/7C)2ZZeXG3B5L])cTAI7-?05c0OdI)^/A9ZV7edOVOHDFEH.K
Z^2SG;de\^NW5]6>IB+)];d5@Lb\H4M9L(>eGM:969TYAI2/O1ALOKL+b+7<7E08
J(c:^a\I&,6WXeO/W?O17.:=FFDO.bcW:IaM^#)3EYJLb70B)9LB]:8a\,QJ(I[e
6Q-MMQ<EI1+,VAHITTH)A1934C3_bHY6J3TBgMcU6;C#)B\,^:#(BWO#->_H,_\N
)VSS@(^&3/F40fW]GaZ3LTO8N(Lf(?L#[MHD?GgWW\.?/)HNTUC7+6D;6DZbM)L.
I+EJ.J3USGMQ--;HLMTJ/-1gDCTP[@\3NXS8Eg=/f?6E;39<AM4UK5VcAQL?.dAf
@L(X-;DZ,?6RF7MG)VG2+V])LP0=>O6XMSXUH32Z^:ZC@\D0V-@X54;B#X=N:01R
6N.RbBb&E_J/9>SaXbAY3<?dC/E#I3bab<8)8P^0XBdA,0^8ST?F<e;=+^YV:2]S
c;4;;8ZeJ)CJB_Q29/c=bF@=O>_+KB0M6+N]\X(_B5[2b#^,.GI7B@J7@a=^3N?d
[=_\/(82X,)#6gAX\42&Q0Ee]207-e)I<=RTFCXVU#L/)F_eb),T(^]E9C7?eZ:>
gCFfadG(IbEJ:dbVB,CNVW(e1HY7D-5P8.Ic1\f.F;H&4E690.[C2M+ZF3KY<(]7
NOXb<Fg>=KG,P)QAT>gJ[T4AfU\(3^gGc#I,)S5NK6T9f5_C@&-PC=fQR2(fEdUO
BKKg:+Nbdg6eR++ef:VP(>T/6b==Y#Q;SQ[BfJ&R9dRW,]E86&3H\SK-aCd;-NfT
.IFVM]M,PP/UUf#L+5&TW3Y08deP@/fZV7H#bJ(MF.T#f\R&Yc+gEQMSXeL^XeZ\
@L3?9E4&&03YOc9Q:b:V:M>=bgZ5RgHP.8(:#D9(<\#]:&2KOA&fMSR0JG6CFBJE
B:#+DON4QT;/L>E728\O:([6-b>g_X-NQ@:&5-8fbW^@:@Q]>^J69gXC7Q@&5D3_
R@[>T/GO#OA?J\9<&H>[N^.:-3#TKX[^P,>_I^b(E2):5_e.J,]N8TWXZdVP4[MH
IFJF/J#W9Mb8IO58GTK7QMD?Dg&SfD33,+CZOM&GFeE4.]9Tde(4#[=[c:XHW1OO
F?DM0+D6L67_aS(-9,D?a^XDV7VU+Hb/)>Q@dY4>1AAQdVA/W:J,BQJgc;<;FO1g
LH5O/TFCDM\I^0E&?[67[FBY9[Xa627fPN6f&VaM8D?db)7(-V;6egOC;aeU?X?3
?Ad_M\5+=;#fM4REQKK@5]UI]dHf]),U;F15IIS4_gZ]GPC53+E\&571^08Hf\)9
5/dO&_S6+30RbH=\MFI9GW.YDEEIB<2_1<7U6A8N+H+-=4K7IRYCBKfZEc989dS9
IXO4?L;4:EEg2R@]YT5CeDAN[,S3?+O\XKNL&>FUa-ZC#7DY7@//SR@G&FP9?Wf^
.3\,fFH]12.J-TS_NRdZ?#J0?Q_[5?RZJY2<.P:V3<cU][FFOW#@WbcGS+7>,P[a
CSF1f,]Q(RN^^f-@WBb/GY0LD_(&G;KaJQ?OJCRFVEN:GQ/ABc<Q#4Z3AAX+0?_1
UU.9bC9^c?aGC(PgW;bQ&IVO>dO-3@.8&#LRKf;MPN]X7X8B8:N3C:10G/#[P(c>
VbXE2&FA>dUI\=+88?H8#?Ba:=K^.f+BZ=cN-B\RH:W#U^^51:24IT+3]58F<Hcd
9f@fC\?INK+:]=U2/4/c1.6d02Je.YM4FP/[a=OLc75e1\b\GCF^cD/YE)QUSfSK
def-_6;#a4eS9Q1JE0W:+HDO/H:BCe+R(>)C,G5(JX..HY&DE:PELPD6_)FF&3R&
EC\a6>C6T4e9/G5CX96(VLY@.6eRc;YfQd#FF0:ec^)?9f?CWAE2-J5-)fT1SbNa
IgRgg66/Mfd^&O/43.9B,;MF]V2F5Sg\C4?0,Vdb\A@GMdMQ3TB7I+&VG<;)I^N#
9aSX9ReBd2fNBA1-dcH8)bg/b#[]UA=\8.E.I^O?e41V&<S=F-CTQQ.?WXI,X-]F
Z#E7:BKLM&4RgfCW\>MY--<d5=DHcD(6>.U\3T^bJDX3.J?4H_2Ja:Q#@BZVHX[b
^aSF;NH<M3SC9fb+LgC)?SMZYMHR,&fN=b;CL)-3>/?UN/WEGbGTJYQ+_4?aU;2/
0,?@X:ZaW1FU]VX1PYMG:/g;IWGLZQ=fCFUN;I<BV:9A9\9]WI@M[TbV1W_1+,,P
YTH;909Te_JAJ[Y7Wc)9NV,MVU\R_3(OB6M+\7T[\[PNKRL36N0cG7NMafbP)4/T
<Z,7b,W6AM?TV4Ha8-[M[EJ>E_:,82LH?NPF=(;a6KbB3/:Kd80G#fLX2cG7^b?a
-dB0QB-67/M-Z2G19.RC:I3Cd984^O4RER]aH8]7SMA^dJ=FGY/HD:bNFf0I@aO]
8Y1;B5Ec+PXT1DdH+YN2P;[ZLf4PYM5\Q/>:X9X=7O#XRO(^EH+cdO]J:T<=@.gQ
24D@[K/[c&YE:>(S.I^J4c+cZ;OGKJ-DW2D\)E+PRQ@a/52[ZS<^\>dQTB]S&[aW
:<59N9-,X,L<6b1?eQMD,^U<3fbce8FOU.,O^##0<fMN(SUJ3bK];d]Q9A59<Xg=
,X;9-Ye;g]H44g?PUSaBU^#M7g8FVS_3_H/[XK+f_LIJ.-3#V\;FdA\[.N(1YW:-
cC,Y&S=#0WKC9]2fM8)3G35HY_673\/ZZ<18_\+2S=ZE<R&-)TY;6D5P6;K-gZOF
g5;<#3[YQ)4e>LfX?3&X]#037/((_#X>8B+\=;:dd^=e&>(F4;BM_-U5BZ.A?@&R
^Ee_3L]+][US-K(dK4QH^8ISN27Ff+@]T^5.Z&;P@K6>YU/9]V,F=<6@b1^8Z>)f
&9Q\V;0E?D]6?aH4eG4.T@@U/eBN8QbE_E0?Fa9Mb)?6gg.)99E(\9OJ/9NfX]PD
a]);W5AY/M;];&,D,_-5fBQ=6YAVGgf@F^GCO3JdN2L=K&MA.,]<]U\@V2gD^#7(
]#PPD2fN^LaK9LJ2ULSPH+_._:[08=:6]gZQ2e+A=-^WG;61-b)Xd6#dA3>8+Y:G
d8J4Ic2>HX3BUF<.AgP\@]M->_NT3LL3#2gBW1NgSW]@VNM5WPY3ZF:G\M@DEH+A
Na,=<UCG>V>)Q#R17_C;OgK7L-@7PI5LO5LXa4A4_BL4A:LBVdP(3V>LKR><eWC)
_X7:Y/;O.\W9UW)I&dO-_V#8d:<-6[<g5+S\[4)R\8>fWVBG)^+S+(1F:(LZ[FcI
=&Y(@Kcd=VV,^.8<8f7G;/PJP>NPH[/B6Pac9g./.];X=QFOWVF@WUBQ_U/Q&[[a
BUWW]cSV<fJMQUWP)B@5bW/6,aC6U#3bD4X1685Y7LP0?/>\?9:(T4_[8T:TG&3R
+bV(b_&D(+9If]/4ZA/P40+[CNJ;&WIU2<0_<eU/0/HSLCDBF]JZ=Te]4.9_+&:<
:NF.9Z613R@eGT178:RIS\LVe.Kd5M_#/A?B8NWBJ@3aQO.-C(=0b5B#QVQAP_VD
;WZ,9Od]SL>EDRAZ9LJ?9F-(,0BMK^IH=aDRJeF1RZ_)gbWYLIBPD32+d6:Y4K5X
(fd38T65/+f_IM,gQD1O.--+;:((9(1K&35XeB8Q/5VVd00DFVZO+6XHGUc,^7\Q
;=;_VS9PH&8S<cQ[]M;75=RH^B01,UFB;.:FAVV=Df\^fZARfX^c(T>.>TS.7]:V
=V7;Yg>B#3R9LFbQ#B:29ONEH:3?<YRXH/MNSCD[bfT.CKH6C=&=]062VS5.XD(,
[Z#-EUe1d3DPJS#ZE-Z+e1E7aGLe_Y-T#])=.=59O&fU;;a4-6#VG_QV_8(>R_MQ
FUUK[^[:MaMH\=.0BX[YdED;<@D_29gW.AQ1]G_dK?AKU^/Sg4VQ]UR\6\/E_G>d
^.0_]DYg<8a&0T3;9J/J>5B3)5af<OGIeF:7;c7gHLH8C75bdSKF65@XJI_c4#dU
L[N[U:YOYP[3F6Q/Y6R9YQ_N)7BfRM#_QBW;CF_V5FU]/]@5G\L^#0B+PN-Y6BJQ
D@QP1/0;0@Sf<EMC/=1KIZ5P8<3.A#&69[TPgAS,0,[C4SU6CV,1U9>ST/6/5HeK
ABTHDOH3),BaeB]J7Z#&SW4_F,Da7A>:+SD7cVY1S)fYL@>0.fYC>D.H&A_a^W.>
S73A0eJZ8d<;DLTZdc]9=O=N\:6Q@\Y_9@M9BeC@1GBQ#OD&;QUDT3KC@\G0ZP^g
L?81=J.VTPX342(2;@@B<fS&4+ZZbP_SU/O6d>VP^NZR1T51K_Z&)-X4CA<7aL2W
VV5E0H]LXFO5cCR]R&+:3c/]J\>g2=QR[__dF4YD4G7??\1&LU_;>OA]52RIgMeV
>S_,2T3N@Va-J<X6e\RRe0NEf5)N-P8[d^UIOM<(QJSS&W_./8aA7Ie23.CcIG9;
D[))GH-A/::ZXLdN5R\WT\B/8E.X:Dg6^UfZ@)&M_3d#6I)4a89fO:3Q?&U&J1Yc
2=-+e3cX\,K[A4RN36+fQT^I.g0C;eN3c/4;>1]LJcXAYa<]#g5\eS?_=6DJKG1c
B#FC:Gg?;2CcFcgEXEZ^WD;fXFB986QA1;^J9-K^Rf]OA_E.ZdeB=]<#W_/2E7>S
=6AH.&+7@=Md6XOA@XP\8YVQWW9[F&Y.FOQB9d,HSZ+2EXE#Z4Q(eEIdF5I]P<Y2
OUEACA83[3K9<3ag)_FC4eW8Gd.aZd81V&ge-A5dS?U#>d@-R@e/dP9/b5J8I11T
Q,c8Z(RR2&HeO6<2PS8W2.dQ+3M?GKZ596c-9?gN:-#5,L6JI8ONEVEI8N,QXCf)
+e@[)4Q+293TXFL?Q--#E:21AJHD:LRE@6;R()QdUIE4fIAOU\I@1J@F)[<@a,0J
F<JFY^O0(.C\PW()dGCS,=(5RULaDTE8O11[MPac.STWVOX@@H:)ZX<>\9)YZ7GQ
&FFQ5LAIV_cQC+e+4Ydb9gd4(RW&H9gd)-.Q_T?.68T9.LTeQK>D/<9N/aMaP^SW
6/XgXK,55;e@59#&<&6TG4f(XW+=:>D]P6WDKNK:5Wf1)\f)F3?]]0@/ZWEe<J>a
Z)DSVVB<.?F<7a)gdK^+0FRBCe6@U;gB-I-RcP<O)e&e)(Y/J9f^;\=Q<&>):PO+
EL\eD7-U7-9PFF]=HQ0=0><CbW4R+LMT5M@I9SH^E;J5e4@c.RL/b33,^[KRGU-P
5]_;_56N<VWXA9fg?PAB?=EPRS6LGDL;0_M4-0^Y<G>Z[RFBAY#J\f9^.OJC-(/0
FTgZ\/ZCFK]QAdg?+6b3bOW,cR;\M=S&@RTf=3J/KDO&SVHE4_T;cTPU:=:,b;.4
8;TX1g:1_Y^:SaNM<]VP<)IFT<6-f:[cANd@JX5&AS<Q/@HZI7;gD(6+AH.C8dO]
AMU21\S@/.[..M,B.:N2U;L^6^(ULS#K>#R8a_H,acV#461Y<BZ;Z?DX9Z]HBYEA
[59-D3I]YDF.?JfTZ?UNe]FNO^73^7PJV)U[=Y6/N19f,(=DID+?<aB]Pa>^J)SX
/>&1;bDN7-<K&_+N^gSZAFX,O1J<(\2#1Z1OA17E=0L+T:JT<==;T8<c&>g-O+0[
7=&:8IVK^]76&\aKE?8aaaIcf3>UHRYRKbKR@5)f.<b(2\D)f?6&?eCf)[6K\#@Y
=QJ61Nd?>g9:TV9@SE6I)g)Qg)?<(&a7_))LE^,BMMW;YDFM1U./X4HHW=9F^)\X
S?1LG:&G@F_B=g8R<HMK3^eV53fWGO;8FY^)X>J\,C.)?M5?MD1-6.+VXL:?0Ye8
RXbA9Z+&e(5G35(6,-adb[PUgCJKMd8B^]+fCW\+OWT70;@+_;]Se?MF</]C/&=6
@K(E4A0c3+?Z^Y=aA:cE;/+E\Q&AaR#CeWMd;STJM2gc6H19aZb3G6@P&?GH>5C>
O:BYc(FRT_7<eABIcZRZgKgSf^Y<HQ8_UHP9374DQVB[cIVUNDHZ.=DgaB8,fKML
M#NGUT1=NO6g,^>T#@71?Rf0Qb[37K.QO)W6<\;aLZ,91c[#d/83._W@a+aEHTW_
605VUHJ/TgKJKOY]FDbDZ5#3\8MJ7@?T/.QD>^;F?O/5&)LQ9?\@a_M_]_VL3@C)
.8YPgY<1+.:;Yc:S#8AB+FK,KFUcZFAX5Z9]5N6f.@H0HQVX9.B4dM@,gKP3VV:R
fdROeV21.(Febg(L,W<WXK@RNfK9Q8TVSJ+(;QKGLZdYXa_T1WA4S8#ZJ=&ZM->N
Re&;O>3PFRCC4:@Rg8/+8Zb-7KaEL&DNfQe7TU#bBQB:D#FVS]bb;LLa+]B?#Y^a
DN0DY:2gJ\9X&-.0O+G=4>[DJBRE+dIB779f))9AS)\g9=a(?JG]<WEF]Ng3Z_WD
/#SCe0a#L-EO2\YIgCJ-,J8G5QSH,\UR=,.;A^ce@&]J1gZ#A:bVJZJEC(=[YUHV
30bPcJZNf[Uc=CFQ_X,4:1M?<&Y0C?/VWDS:,<>)Q(4=XDfAO97<9+[<eDNK?2:,
[1ICc-K=eUe7;?K(KPWV8DHd9I-,EaBD3PD+8&:^DYA-8BdNB(7L_B#S9<WC@2JC
8HeMHM__<NIFWNYF3NN4#K0E#&;^gPI&[6D3?]2_LM,gC-[Rc>41;S?VWY6.Y(<<
WZ78P.P;&8]^33S0QG2RI<cI@27bYI7UIB2-.RgGF-g,;(Gc(2UR<L9<^,[-TTB8
M=(c6LZ5(A<9a2:gVL8=.+/Y)J3C1-_e.K9^PKY-]d9S1O>a./5\_T4XU@7WSe9c
3B=_3-SF3(cfVeEb-c4?R<YAdJ0E;00EK3V;H;#KAWJ)\6F(GVM0/997./1#gb7&
_CP)[:A)Pf5C;#W?CMR,4<6.g^1UUBEX8GRTFGb9\KLa)W)Y>,HDP#;gG,@b>1=Y
fZLYF=KNb?2-JG_D:5eF_C(R.1&cS>P[6:#GO1RI#O<OfN928.=D3YS=7@#BNb13
)8\.?Q(27HVP;?gU9UGd[/-IYD<Te,=bE/XBKaK>P,\SX-e4K0VX(EJS./Q)f7V#
ZLG<SKcBB8-b/.c-F+M(EBYE?Wac(.d30CfIAF@[79]2IM#9S.5Jdc:@O.9IWVMf
[.3T^1SAWL\&N2BcfS&\0V_g=@(Y4ZIW@>;Y&X_CC+-\J?RaED&\R+9<ee9?C)3<
--?b8AQC4S&]>POG;H-67bU9OH-6=N;]NGYI6Ff3KRAcOQZM24Q@81:T/L=N23(9
M](CK+EBXYLN,\Mf91_fFX6Q8+K>=U<@M@]SYaO8[IebUD]KQ/JM^^#N8d&Vg/>G
7-28OWOe+[)ZDE10_HW4(I9S[9W@ENU-AE2AU/2+)2B<U8_dCR:.Gc<f18<ABHH\
G-E)G\^Z>RY@>@MKc5WAD[-5S;]9Xf9M4\CaM^^d0)G]E&)?.==5c=RBI.=.SC^L
C_7P;LIJ9M,A,b_@T=g1#g_>619E=\3(6R8SP^5Ia\FgcKc)2N7,^O&1UB=947EG
TIgZIfg,e<4&d9Z(a[U4Ya2W6E-+F:_O30UaLS81A+#N(V8>0C1,/2A1R&I35E,,
-,O(cXe03BA3ASP&:C<G?;Y>c3<D)Y\MfLdNCL94+DFgBS=RGQP,.Y^M#-V\_:#Z
0^&SO&:Mf^eB\_TJR+WMY<[/;5c64c#&)^(Z7FB0<5#c^M()Q-=J<SY+IM8MK2UE
[7(;^0X?3(1LbWQ0RbI.bfZH.bXF_FL:b5.GAJ#a)7ZDfMG;<@NETC7RZR1C<:M6
g)T@IP[g/):L48<A_2V-BDYGc1LTZ=\b;A;TRbL\,FNfKS?4/O&f:02cM_PW+#L4
aSe39>BY@DJ.&g76Z3JFVH=N=F+W.YE?4(.B..H1;T3JaFALPI9;Z)g]53+NT2Zg
,^8:]-SUIPMeLP=(8RWVfU[7MT/Ef_3E])Lf[_G1Cc-.@NLNG4F&((CVKK<.C>DL
[SXQCDA^;<U^XW-EKNJEbW/2(eKMC7SSbFU2DgMLH9W@UVAaBM5GfGGPV50Ag6g?
2PePf\9RG5+C0/);bgaV>E?SbG+8()aW\_OAb_I,e4X(3YB65c,EB53DJKce04GY
RA7&M-bC5]e.g)3H+=-+;(ca\J[KJ-<[HB,B9/G>\M6bXLEBE0M<#26IVVNH<(f@
Ua[+b_1IE3^(#YW;R\^e(2EI8NL;UC/bg:c@K@ER>&N0^I_XI4gNDfbegV;3I#>Q
8NQa0H<EM8G.,TR[_=]_62dgTOSOg;UHMF=J/cR#VMBYG@C5G==bfcBK>OCc;ZUB
.]3WO;8<1]=NQO)?-AJ,LH98Y20[@G?9gM9>aC(=3a^-c@GVA^V##45B+L3<9<J@
IJ7@cYQ(Z2V&8I^KU>[f1ZZLf[UBH8HE2?WMg7@N[f&g7&]AZ_9W4_T[(@XHBT[d
ED[>L2=fRX7U[;MSS.QQ2fdEKTbfX;@4QdMW)7gCSX+8+1OU6[O,IZAgW^?5P.5/
L1_G08>?P/8)S=JL\2[8);DZ73&ADWYH<:TJB.?2_,6g&HY9,[bE6R@fC+8:gW:b
Z#.d+C#KI3Z4@1Q=D<.&<Pe_W>g,.Z?@O[L6RF/E[gd@CA^Jg/K:8dL6b,bU3V6F
O\YQL?^-,@,JD<(3R/M:L;SUTMSdF8=/(<PGNS&eRI.Mg#>O88e<;FSCX80H>D,2
7decbfJ1bLF0HENXH-SG\eVU;,2\PNXIgJ&@\BZ2936Y9GF@1OXP?W6I;gLBXX\[
KaOTP6F(5-CEQ9,PgLB8b4?2@c?4g[9:HI,F[G8\K6]8;gZ&U#POANRWR_IEC+3]
;8c#AA1)a^#c3T<.=NH(@(^&K4AH1V^d#I].=J[_I1g68<1O2E+-PNMUeG4d?GH\
fHF/.:YU/2^90Xf#5Sae.7d2V.eP_RM^9@AH?Cb3Ig8=DXKNNfZV&I4G]I::Q2b3
9Xf,,V08=3P5ORDaL9b:E=#XVf21/g.4M_-)[=1@eV-[:+cB\EebMXd1geTg+bT2
EB9.EN#KSV1eJ,-B8G3?I-5Z;1:f4)+@5&S/Z,a3&e<OcA:XG.91A-746:00HCeY
6b^,E)a/_;:2Y35&+Ff)0;M8.2?M0P25]?:P#^Re=\70cR5HfL.HOR0IZPS^-Ddb
V/GLNU1Ba\]^e3Y-\-O/?;0/=41X]JNB5dbb2YZ)6<Ye,>G=SZ.QbMDc;C=SJE5X
5EHC]077XP:F-:Ta8.7ASN&,86=L/GTeWR&+1f:52:,B\G9D^Rd(d,RYAA5adfL-
VKSRY9;Q2>CK&RFLOb^(g5EM+N,9Q+R_B1eOdBcOJO6US#DNc51@/\44&LWZc,F.
O_Z2R?&9K5;6<,b)Z6ZMb3=?A01O0VN>^UbKG^2I8dA4SdRWbb,SDU2QF>H4<?TY
3Sf[-IP_6ZJ@cId;,:#0c3EE&9V#SVYfA(5JJSL_UbO=ga\5SWP8+M-#YT5V4_>\
@RCYL0CRW-c=0,3:XMC1_1@V[J.52Q&C5;&W-K6W4&EYDTQ>YJ9gFEV.)WL19PL4
2BL(^b=GSX3:K/)dcG/C+0KX@gNSW2-+He/gNTfQ?UDXT60+2gf2cZBB\E3/8KbS
Hf#L6/AJIVM-Og#TDf05K0<,QB]U?4RP(fcE5&Og9K.__HVL,^N5RG)=XC[XM>=@
#9X.)JGT8>8OC0N=f@G0+6bT]7E7UBf2SHJK(^TU9T#H.47VIg7[9b;S+g]3QIOT
B&Hd.e/YMEE.3-HI,#\^<PR>KJ[F7D9#Z@^4U0U+g3:Ubf2NM:O-.P\;_-44RJE-
(W^QT;>&Y-&;>L.6<J]eA1GR,7e\1/J,F_XX)eY(CXG=4>P0SOAc-@UW_>(Z9b>W
ZPD&=]e_5/I<UYST/:,1BI?a5(&>)B.N3H;F7Og>-fMbe)2gb3=Q77dDK^,]39PN
YE]EB<=fB/UJMgJ(aW4:D(R_F,ULNf1bV8)8/?&M6>W6K:1]OKLU.-PA9dZ?&6RZ
9DfDfO3]H9b2@F,0O]Gf\X3c)agQ>CLX14YFK0FJV3T32cNO&:)CJ[-=<?]K0<eW
-NUBY++cc&R:6NQVfJD:TIDPCU=-2-XPJ2c[1[T@-)CUD[MeHIdT>d]3T+T81AYC
SXX08I4PE7@DH4Y>=0N6R^,?RHWH9#+fV+^YM=MP;?VZ]7[TC]736<bSg8&3OHTR
^9R3gG_:M?&?(U:f5XB4\V).ZB0I1>4D(FBY-A>cC#QFW<(Y>1c+Z>[BJd=cf2>^
PY([>M.;[C#JGU4@e\7A17V:L@gS>WK;Iae)YPT2EgP:[K)SJ0Og-6+=(.7;I)?0
e#d&35#6;/8+_V7g&PPXgE=X?e:<F<fPFdYD=O2Y]:-3K[EX34OR\K7C6HQ\=Z4g
\g._:F^0O9A<M/Z4:Hd[.-B^JWf8(95e^-[e@R>TF3;[\O5EI06@0a[RQ^5f^0A=
ZTb4I-6&Ta:6-9aZ767;02bX(3g^=P^WLR7;4AWY0<Cb]?1M/1?gOGRAg.ONETUZ
8&B\0FWRR>7E2gPOC^@Q+Sg.B_U+4G/1eF>[3AM4g3;))3\L\38SR\]:N_Iaa/U:
F5a2R<_QAYa,@f>SQEKWIT4FafXRII6,^]Y<)M#Da9IN:_K^0N0I(2dVB8WH/gSA
1f=B+L:JKF[BFBW@c8\-1_6MD]B?ZW0KY4O^-7M/[.G#(6^IK.F14U3ANKcQ-.Cf
c+30E/^B0AY]2eNU+DW(R>D&.;9W1BQ<=(1D@?HeY]VG;DQLRHVG]-.Ia?<RgHQa
D.\W(8VI:G=\X9V<R+Se2,aX0.,b?RN14RGZe^H=9V0E:;W<:K[TLdOd,L2&I;)Q
8#eIO+dG=)>2SY/N77L/K8MB(ga^;9P(X&J(]Oc>?fOVgZ+D(LNH2_W5KRHa/GU-
VFaNOCLQFReaH#]0LZ[Y&>0,8.ZP/bIdVJ79]&P;]F3H4SV#;]W6>V[bK[/J;#g?
.TQK@K-U7LbD&#E(ANc1&K:dMBDS9YKXa7;&,GPXZU,JXA?8&MS]OV3F#/g,AO9D
AdYYCa[N>QLMH5aTXFf2&TKbH3E-^,6Zdf>N32bIa.N.R9B6:[:^VM#]?Ba+d25O
cNaQb[0NXgQ2,e^=4Jg]=UcW,M0028D7#5Q##-4XLE@R,S),/.F98\ZbCS#+[;21
FPbDbJ1c?D4LYQ1@L[^B0-?0Q7a0_U]IGTaZ;]KaM792d(7F/gbGJ[E7HM-+ObRg
&X(4JY2=5\3X<BcXaP9YM@4XU:=08>cg15E?KS8ICX/0A)4K@g=30NcA3V+(90IE
7V+N+GEIQ^-KaNb^05,cbEF>Z@8,1?5+bQJN]Pd:UfT8I:EeM.fRQP;W7QXc/<MQ
+f/]=/U<LcONfgP1ge?EB.a\Z1..;7N^V:SJFPIJ^>HHM(G9PfI7&-]V<:2]U=ZN
(6-;GP7ZLKURc<7WOU@A:?cBX9J9G]HWM_-\Wa0DBX#+2^5K\O?.>5OTWaGdX)[#
g(cV52)b\Dc7BR]D]Y?C;YYeL>RJ>1M2:00E#a;>AA<9B>NKV2Y8D#[068=/6gEe
PgP/(?4LAN6/(D99NO-d\Z,A(\NT_)FC:/[4^_75VNLF4;L;?BfEBgDfQ45FXSYB
eS&=58?[+JXgLfJYZKS^&1Ue;EA9_X]W;\]2:4TT[g>F,/Z;IL@K0:W<dX#7#>,1
<aVJ(=<.f81^BHK7f2CW^QFfX43@#1@(cbQW)EW@:2f1F01ZX:fUF-U61;4Ae^BR
(1=&#)#E3WTe_bfG2+Z7/W=-DD:R1D3UQHdegM=IS>6SMZ/\/,CPF.gL3URd^V[X
eIX3bDT4:/^ID[D2<\HaI>F)ZL#:f<KB-&-L8-R4T^/ePd(5,2#793\MFM>@(2>?
&VPDFT+g:@(;#(=G15KaY6dXL3fOIgeD:LAH72XP??^2,MH.XJCfBDdKR7U0\RQM
=AS-dM-c>KR>2VQJd#>^/+<1S#@:-XXNGb=:&dC>M(QSUB,?TAHe#CPg,DB=]V@V
?[BMf/6EMS.ET3e1DW4U[ECA):>89Dd(1Zf>df[Q@NZ)DQd\Ga.A&;(BAG<8_>L,
Q.WI>MKCg@>V)^,abG_<NBd];@1>T8F-aS(H5-,G7V?XT7/3K?TGcf-PS7J_GBBK
,B@BH:+JLH[Hc9RX,]a3[772^IaV8XLRQ:\,Q5VAf4^W]9BDJE@D;<QIFD)c#KFG
8HFYd:Q+efYNEaL4#4G.TEF9:[CDD3:L^UWN/Y+#?7WTa]Z@\EQHSb<DJYT-P/#?
X<(f(1\BQ7#;f=M@H3I)PHY#U@8?b/V0aI?;f9UYaG(RUS.RKFY/5KD]4fU<8-(]
W#A@3[/?UB)K=-M?E=YL-<:bL1B:8;H+P/QWFb2W[1(f/7[7NCWf@FYRB()#G@NR
X51&eZF/LRc</^^&NVF2#U9X->QIEU4^V6(fN?OBJ6a).(=T5/(LJ8ETRE\K^RX9
3KAOCa>PGa+b)aa&6^C]IB@U3V=//C-E)].0]L4H.#-g_>1^SDH_BWU?J(AUO?-5
=&LDcL+F6<5O1eg_Zf&]<1<F]VLSIGK0>/74OPL&Z?D;Nc?2[[eHCHU&C10:DW+W
&591;[eERE(GSR1MWHJ=-]a]e8>[ZLf6QO<aE6/1A9@Dbc&WNL3#[IcF&DLR)5LD
2,[I?g7OHT)PG_c]OTfA((6DSH#M9Z8^A=&B0F&<.-ZG,[BdNVaR,_,42P4c03AH
CC)1&.DU<:7BaB+Y0N#4dbE.@XNN^Fa(G4V-&L\4QcV&GAJ>4^FZ,AgXO0@)d]ZP
RBZ-8_<aNI;ZV08FN[8\_)_?&:3))XSdVM+;Q(/?_[90bSJ>FWge]^(Lf#D@0=C<
.HaV\EGLgTN+[0;Tb9/cL.UHT2e7\,JX3d4MQZGWf6e^XNH@^aBP]O28Gacf#,@;
HQ&cL@S.<>G4RN5JFOa.Q\SfTPO:,[;Y[BA=.U5eV3X1OfJ2&=L:LE&+@GA0?U<e
7G4:#Y@_,:I-+:ff.f\P\@Kb1\5Z[_K:8EZLY=0?<4X+)1N4D@-=R):G(cE0U)BT
^:G\cWO-XSGVWbYNOeQ3QFSE:1G^:0TH]\eUCIBE5U0_/=E7d)[8#3MQ@2O32.@c
9F.Lg?FgKQ.GI[BeI&MPX/\:N]3Q?.^,DRd<>,+6G10X&NR^C6)E7IRN^eI2,-Of
W5Q/1X4RAB&OR>^SZNCQGS5KA:dEQCG1K./XL_9PO-eJ/a6EPV@/<U86<]0M&39I
NX/7:XM@NSBd.5(/-)ZC/Q?IO-K(ASF4G>DKO\>Xaa\1?I[GEHC47DUK>L;fWL3Y
WSG)Q,beCBE7b4]/H,K+CJ@V[/<[f8OEb5]fNgR((^2E..+fY6\Q:_aeeW)R30R9
\Jg0CS&6CCQAPRfJWJ\T)&_D1]3=9G4=<+fc-)GPbJ>>R,af[SK6B3EF55;<PF[6
(A=;0:/[=-M-WM)S_b^E^MgD37:?(TH<OJNfYYO_R@cRO=/@9ba4B4D5DcCJ0FBR
IWM^^()beO^A6aK0gLWZ+Ag8:Z?=TIf47TO6(a@4bAc];0dUV2gVW-@ZNeL@.VKN
<F1J@D=KgGQN8Xg,+X^d\(ZP92Y<E[T8a.gN@bM7-T),F(=TVNT:WK8:J[4A,)5D
4?,fHXLI=WC+^LaTO37g,OPGVEID9Vc.#f2<@UJYD02JH;YI^[:QU9^Z_SY+([69
2>aZ3B2e8\AYaPK1SfJZ;)#_?Ac^d,9JeFNHXLZR>29[N)?RE1MKT6d6IZXF3NFc
IX,cY3EeX[BgF.V3Y5Ub,M>[LJB4C?E)Q00_H<HNRTM]OH>?AM]P^e,g)f2.a9G-
+\aAPI#0_OB6Q?;5eIQV17Cde+FSJ+X2LJK]ac8OQN_NV7C8+4CFd^EgA6/ZOL5&
6_AgTQ.Q-@._B\7O-CZ@c=0EbL,A?XbL>LHA3C@.-W;C@Ta/C/U7>EAN5P<^,ZXW
D,O4ca36O14RO)O3<4_Mc/PIe,6SP-PT-E]7I+.0=.WQVU[ZHegdNZ?Aa#VA)7F9
WNBBBNUc,f7U,b0fOb1R.6<VaL+/2f(KRS@N3&3KW)OK+G9^X?:2P.?;2-9M1O2Y
^8P2(]SSdX;[\#O70K1-GD6fH9-M=cd2LV;G[=f9RLK(e407\f(L:3H\T,&5FGQb
<Cg2TD+[+1C94PWfK9_aO+@g-Ge#N>#aZ6\7?gV7-dKL0)T<W&f;9D..CD\ZOPIe
b-;8UAD@CfRD2/K9cH(Q)P9b=HJeNX+GNJMF);7G:;?)a:Jg:E\d&;.8#^QU7?W.
fKdQ/OQ7\I.JVbKb@\H(8:V68<GKX^RU@/MX?K4B,Z=NM8=/NN(,3&/K/]\Ca_:=
1C8^]]3GXGeSQZ_XbWUW>CCW5d_&2^U/V8Y/<I8_NS&Y(@&9C1MYJ@)g03P8gaR=
,<\7eLF?/_>1M5f#ZA8AT=3d._:V#BU.2QP2PbEd2\8DG.Sb-JJ.(5-ECGSK]4c@
fPE[[ZPS^BZQ\TM7fFB])W:806N>EYc53YgA(BFb?7F<.b8IcgOd;,(cU&ZHXddT
3MC3+F01eKV;^^A2>0NCZ0Md_^0H)/UcDd+K5.<<a0O&8=?RK@cG;#:ZfMQ\Q-^J
aIH986ON:9M?cRE85Lf]:,WJH5P/??5N.X4O/?be-0J4+V+_MHZ7[&NL>6aIff\V
4+Md3(5_Bf5c[;[OdS]1B_V36W(88ecHa:(0d9:\-1+T#J.94>Bad&Pb=[]UKbSG
H\NK6+@5+TFTFOBBdF=Z@2W?/S6@Ydag_0V.+#0b]KWd8#A^c?F4;Vb<Xe-1_b-)
(A+R+JgA&WB<E;@81=.)G5G3?E?/I:WfS0M8:WA:-.50];;6(YXR?M7-cV-EHLA<
]BMc/?VA[YgG;PV>NAL=3#7gR9<HW+ggV,-#d;4QdE+H^B3S&9(RA2@VT83BHALK
X?-K=0L]6(^]VRDYDa]B=5GYH[^>B2M4aJ7MNHY(Z59Od=11UUbfZ@cVT_LZ>;/c
.R)OJ9:48[E^=6_d6?_R>0>/(PC1HB7?RJ#IO-K3Z6TAK5e.3>c4FFCN:M=RF1Z1
aXL^XD.a3=<DW5E@?4e&1=+86BLbB38F5CI\?\IL-57L^eA?@&KH&7=F&#ZBFI;;
:18g^KB68I_W0C:<fMSb#E6acYR#IOMIZW5WP6A&E(?LG$
`endprotected

`endif

