//=======================================================================
// COPYRIGHT (C) 2007-2015 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_XACTOR_BFM_SV
`define GUARD_SVT_XACTOR_BFM_SV

`include "VmtDefines.inc"

// Kind used for byte_size, byte_pack, byte_unpack, and compare
`define DW_VIP_VMT_LOGICAL  9        

// is_valid return value which indicates "ok" or "valid"
`define DW_VIP_XACT_OK 0

// Backwards compatibility macros used to bridge a couple of VMT versions
`ifndef VMT_MSG_EVENT_ARG_TEXT_SIZE
`define VMT_MSG_EVENT_ARG_TEXT_SIZE `VMT_MSG_EVENT_TEXT_SIZE
`define SVT_XACTOR_BFM_MSG_ID_DISABLED
`endif
`ifndef VMT_MSG_EVENT_ARG_TEXT
`define VMT_MSG_EVENT_ARG_TEXT `VMT_MSG_EVENT_TEXT
`endif

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT BFM transactors.
 */
virtual class svt_xactor_bfm extends svt_xactor;

  /**
   * Transactor id used to associate this transactor with a VMT Verilog VIP
   * instance.
   */
  int xactor_id;

  /**
   * ON_OFF notification that is set to ON when the reconfigure() method is
   * completed.
   */
  int NOTIFY_RECONFIGURE_DONE;

  /**
   * ON_OFF notification that is set to ON when the get_xactor_cfg() method is
   * completed.
   */
  int NOTIFY_GET_XACTOR_CFG_DONE;

  /**
   * ON_OFF notification that is set to ON when the reset_xactor() method is
   * completed.
   */
  int NOTIFY_RESET_XACTOR_DONE;

  /**
   * ON_OFF noticiation that is set ot ON when the VMT model has been started.
   * It is reset during the stop_xactor() and reset_xactor() methods.
   */
  int NOTIFY_VMT_MODEL_STARTED;

  /** Controls whether VMT notify messages result in display messages. */
  bit enable_vmt_notify_display = 0;

  /** Controls whether VMT messages include the MSG_ID information. */
  bit enable_vmt_msg_id_display = 0;

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
/** @cond PRIVATE */
  int msg_to_notify_id_map[]; 
  int msg_to_notify_type_map[]; 

  // Vmt Suite Level messages
  //DEFINE_NOTIFY_MSG_TYPES_DW_VIP
  //DEFINE_NOTIFY_MSG_IDS_VMTBASE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMON
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMANDMANAGER
  //DEFINE_NOTIFY_MSG_IDS_VMTCOVERAGE
  //DEFINE_NOTIFY_MSG_IDS_VMTMEM
  //DEFINE_NOTIFY_MSG_IDS_VMTMESSAGESERVICE
  //DEFINE_NOTIFY_MSG_IDS_VMTCOMMONCOMMANDS
  //DEFINE_NOTIFY_MSG_IDS_VMTTRANSACTION


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  protected svt_data xacts [*];
  protected int cmd_handles [*];
  protected int xact_cnt = 0;

  protected int out_in_xact_map [*];

  protected int max_active_chan_mgr [];


// New for the BFM xactor
// ----------------------------------------------------------------------------
  /**
   * Handshake from the derived transactor that indicates that
   * change_static_cfg() is done.
   */
  protected event change_static_cfg_done;
  /**
   * Handshake from the derived transactor that indicates that
   * get_static_cfg() is done.
   */
  protected event get_static_cfg_done;

  /**
   * Counter needed because the methods used to set the configuration are all
   * void functions, but the VMT method set_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * set_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the set_config_param() methods are in a seperate thread, then there
   * is the possibility that the reconfigure() method could return before the
   * VMT model is fully configured.  Therefore, this counter is initialized
   * with a value of 2 when the reconfigure() method is called, and a thread
   * is started that monitors the value of the counter, and the
   * NOTIFY_RECONFIGURE_DONE notification is reset (set to OFF).  When all of
   * the calls to set_config_param() are completed in change_static_cfg() and
   * change_dynamic_cfg() in the derived transactor, then this counter is
   * decremented.  Once this counter reaches zero, then the
   * NOTIFY_RECONFIGURE_DONE notification is triggered (set to ON).
   */
  protected int config_set_threads;

  /**
   * Counter needed because the methods used to get the configuration are all
   * void functions, but the VMT method get_config_param() is a task.  Since
   * tasks can not be called from functions, then all of the calls to
   * get_config_param() must be placed within a fork/join_none structure.
   * 
   * Since the get_config_param() methods are in a seperate thread, then there
   * is the possibility that the get_xactor_config() method could return before
   * the configuration object is fully populated.  Therefore, this counter is
   * initialized with a value of 2 when the get_xactor_config() method is
   * called, and a thread is started that monitors the value of the counter,
   * and the NOTIFY_GET_XACTOR_CFG_DONE notification is reset (set to OFF).
   * When all of the calls to get_config_param() are completed in
   * get_static_cfg() and get_dynamic_cfg() in the derived transactor, then
   * this counter is decremented.  Once this counter reaches zero, then the
   * NOTIFY_GET_XACTOR_CFG_DONE notification is triggered (set to ON).
   */
  protected int config_get_threads;

/** @endcond */


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance, passing the appropriate argument
   * values to the svt_xactor parent class.
   *
   * @param suite_name Identifies the product suite to which the xactor object belongs.
   * 
   * @param class_name Sets the class name, which will be returned by the
   * <i>get_name()</i> function (provided by vmm_xactor).
   * 
   * @param cfg A configuration data object that specifies the initial configuration
   * in use by a derived transactor. At a minimum the <b>inst</b> and <b>stream_id</b>
   * properties of this argument are used in the call to <i>super.new()</i> (i.e. in
   * the call that this class makes to vmm_xactor::new()).
   */
  extern function new(string suite_name,
                      string class_name,
                      svt_configuration cfg,
                      int xactor_id = -1);

  /**
   * Sets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function void set_xactor_id(int id);

  /**
   * Gets the value of the transactor ID.  This is only needed when using IUS.
   */
  extern function int get_xactor_id();

// From dw_vip_transactor_rvm
// ----------------------------------------------------------------------------
  extern protected function bit[15:0] map_vmm_to_vmt_reset_types( int rst_type );

  extern virtual protected function int map_msg_type_to_vmm_type( int msg_type );
  extern virtual protected function int map_msg_type_to_vmm_severity( int msg_type );

  extern function void process_internal_messages();


// From dw_vip_gasket_rvm
// ----------------------------------------------------------------------------
  // Functions provided by the different model transactors to create model xacts of
  // proper type
  extern virtual task new_typed_xact_handle ( int chan_id, ref int handle );
  extern virtual task new_xact_specific_handle ( int chan_id, svt_data svt_xact, ref int handle );
  extern virtual protected function svt_data new_typed_out_xact ( int chan_id );

  // rvm methods
  extern virtual function void start_xactor();
  extern virtual function void stop_xactor();
`ifdef SVT_MULTI_SIM_ENUM_SCOPE_IN_EXTERN_METHOD_ARG
  extern virtual function void reset_xactor(vmm_xactor::reset_e rst_typ = SOFT_RST);
`else
  extern virtual function void reset_xactor(reset_e rst_typ = SOFT_RST);
`endif
  // common vip methods
  extern virtual protected task manage_chan ( int chan_id, int n_threads = 1, vmm_channel chan = null );
  extern virtual protected task catch_buffer_event ( int msg_id, int buf_arg_id, int chan_id );
  extern virtual protected task catch_output_transaction ( int msg_id, int arg_id, int chan_id );
  extern virtual protected task catch_out_in_transaction ( int msg_id, int out_arg_id, int in_arg_id, int chan_id );
  extern virtual protected task catch_initiation ( int msg_id, int arg_id );
  extern virtual protected task catch_completion ( int msg_id, int arg_id );

  extern virtual task catch_msg_id(int msg_id);
  extern virtual protected task catch_msg_trigger (int wp_handle, int arg_id, int arg_type, int arg_size, event watch_trigger, ref int obj_handle, ref int int_arg_data, ref string str_arg_data, ref bit [15:0] bv_arg_data, ref int status );

  // Note: getXact_t is changed from a function to a task.  Also renamed so as to not
  //       collide with getXact below.
  extern virtual task get_chan_xact ( int chan_id, ref svt_data xact );
  extern virtual task finish_xact ( int chan_id, svt_data svt_xact );
  extern virtual task garbage_collect_wp_xact ( int xact_as_handle );
  extern virtual task sneak_xact ( int chan_id, svt_data svt_xact );
  extern virtual task sync_cmd_stream ( ref int status );

  extern virtual protected task do_post_chan_get ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_pre_chan_put ( int chan_id, svt_data svt_xact, ref bit drop );
  extern virtual protected task do_buffer_cb ( int chan_id, int msg_id, int xact_as_handle, svt_data svt_xact, int obj_handle );
  extern virtual protected task map_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact, ref int status );
  extern virtual protected task map_to_transaction ( int chan_id, int xact_as_handle, svt_data svt_xact );

  extern protected task start_command ( int cmd_handle );
  extern protected task end_command ( int cmd_handle );

  //extern protected task clear_xacts ( );
  extern protected function void clear_xacts ( );
  extern protected task set_xact ( int cmd_handle, svt_data svt_xact );
  extern protected function svt_data get_xact ( int cmd_handle );
  extern protected function int get_cmd_handle ( svt_data svt_xact );

  extern virtual protected task set_max_active_chan_mgr ( int chan_id );

// From svt_xactor
// ----------------------------------------------------------------------------
  /** Extended to update the NOTIFY_RECONFIGURE_DONE notification. */
  extern virtual function void reconfigure(svt_configuration cfg);
  extern virtual function void get_xactor_cfg(ref svt_configuration cfg);
  extern task get_xactor_bfm_cfg(ref svt_configuration cfg);

  // Declare all of the virtual methods which allow access to the base VMT commands
  `SVT_XACTOR_BFM_VMT_CMD_METHODS_DECL
endclass

`protected
N,^Xe(I,5AeebbW94J#dR_?9FY1HdJI=MMYHPSXfHV/aDG9,M_91/)R&&P3cgK&9
R;NH[dW4gC7-^>0;dESN-OAcf\RFUT6O4L#WT&Ja[:A9V@NI(MJL-_+a5<-R<aEg
NeQ<23bR9R8?\B8I4f>F[MDOG6:7e-eL3+Q=RGF)0G@FF6&CQKHSP_LO/(E6.MMG
9gDZCD5=.&<E:O0]^02#NQN@cFMQ=GTX=[H<)7EECM1VJeR8LMfAJ.W.7gES4IaH
EaPULSW9C1Y#<;.?9CZD:0ag[R1dJ<#)Nd5J<Sb2JVV<_)&NYAWKSYNH_&/>aL[M
9CgR(8.)]_dU)[#YO>PV5f.@5+;48>RMY+<AOBSH[-K=;6R;U\b.D?>KdeJ6N3.V
V=4B+[)+^<dN:@R-)eR6^7,LVM4MMZ+[T>RNIO9V23;U&EZ9cgK4GQeV/CI,3)U4
MP1DFU:L(49Qa/JAKW>RCS[e:D-+d5dC?a^^&H&U4DFg0N?NM]5[4R\]XD\GX_K/
8:NWcG5L@)HH<a4@LfU,IT)EVJ:+aKS=L.2_+UH<B;K,/#?P@N#F)-9^FP?aGOWA
?@)GX+83>(C2P?f[c]?7SG0&b?XVI069Q1TZe5K0GV3Z&6V=e/BGCg=g(\/adH^A
>^]_6gI:O(QHQ;;(bD4Q-C<0\XEDWIP-,EYCIL+@>ZZ)\O-+0ZO/]KBS,][<]XAc
,/9g.=2K>Sc_6?TW6-&IZd>\29)SAPg7&BR7LTafT7bP1Q2^Y8gQgN\7+c>-D2Y[
KZ-3E&&^[?N=W;[IfSeSG8;N+N4RE#d5Y6JK4A7-eY\CTdZ2N?_QeUZb0\]280?5
@[N4-AH:58P0X3@@ba=9V33c]8aA-e+c)=UL[#d>-DXDD/&VV7<3EMbC8>(KH<BV
D#S^C,V&YJ3gAdSZ3TK_2PggP63HQ,)+KNBZP8RM?d.HG)G66f18];I_b)[[^aSb
KL8#f:Ybd3=aEZS#BCa;Q0faXEeR<BN@^R^_Y]W_#V0R.;AUdAT@7>0fYd_EUcUH
<BSYSC]\;Q@@4I<)c,7;D<?6TVLJ&gbX(5:e)dP@9X7CR^BTJG1SIA<4G66Z1?+X
HbQdM3=E&fVL-/A]g=OUV?,ag4+^bbREXJ,P=I7(bJ\;c#QGe1(XY1>[=96?RZTJ
&2PMCPS5RPZ@bb^.DL4Y__a7db(T/aJg[@CLfO6F(0&DY94KTZDI105E5-1NV;RE
da/>C#b(^O[U8LJU2QE,\70#S?7g.M&1SgLU8Q?Q^(]OG;9T<#U<GUV]Q_b+#;=2
Y6#@LG;O)3G]2+b1Y&I-[CF2_B>SW[UaZNHId37=GbEC<7Y+QA:0TU<_&_CS05T3
LS9J,UP>Q6b=+F\PSMdYcCU_F?Rca-@10CKg\LH=8W<g.8@O/3.AWHeSBPRWe7/<
OYR8;??V3E3Y#f(+M+;f^WM8aG=A65U<^3\<>47[J-5aEaX=S6A-@UL:8[FM:G/g
6A8NgaF7^Re^P+<IX2,^_^?8AUO,2J-#>UVCP2f.@86ggOd)2UVGa2V=B3=,AP=(
<)D(DVTV2SO\HTEHSXH20NVUWe\TZ>MLWH<Z0[f4Q\<0[OTSHNX@X8_WUS-\dB=O
ZSaF6T4_^aLTHbA&(2/a1EfT1F:>O)0R[/Q6\>J5eHa<#TF1f,1V0aRF,<=NH=<0
7(cVK\21NF>S@M+6XRR\4Pb77fJ1[SU7H)=-4eXIfR0)MI/BeWD6YR>[Ce>L)d=7
995ULeT29a8_+U[&4:c?K^H5TcCWYcKBN;R3R4B@[eT#,RUMR;F/&3=S?H)UV]C]
,,J(EV0PaQ=7g\T&X-\SC2af(@XfJHf9R1Gb)LGIQSI&EU7DS.5fIG5U9.@QU)K(
PaC#6\6+^VM_EJB3c#X9A9+Ug_VTZ:d/\FXe2d,JHY@166/K@O;6;OGZAfXUcLQ1
5.PX2RP^VgB<g#1Z@R@<:72Le9N2(^FgRDO#SO94BV[NFF/U.#3I2#B4b9.GFX-b
V>[-KH_XgQ-.5FFNMB(eP#9KOU1,:He9C8B/5[9L[6<U)UW&-BRIfaE@AO[UY4[R
62HG#7AG^\YFHG?,U3SHb=&Jd/#?A,.ZH2gf<D-9Y?.<H6EWK.@(;fZ_,F&(e9f&
RZ9>P&+LD8a+gGW,QS3P+:G4U<>PFJR)E&C[.,0aeJ&eYJSRIIYaN7065f4ACOR[
W]4T7N3N0?)gS+bWQa5?Z)02f[D?+c))E6.JQ<<,&57@5O?Y\&gBb8WAaNLA;\ZK
LaDW7f\+#/B(:dd1_;a-J#.faI^?ga?SILg6?-2:b8HWNBE8@O15IVF,C0G4A(\@
KBba)AS3dN50ELVM[-;3X<NGNHDT\6375_,0A2bAf:_;aOE+2g+(_YDHB)A/(-?8
LYCGGH:HgdFE)S:GH=FEIOd<\(9;>HX;9;^F-3bV+U^a\^0,LQeLIQGED>_<b58J
WE52045:>a\FQ^\+b2FaO:N73N<a=_TH(E5^YLCg[4+FeN^CL:=192&EXSE35DVV
IC7[\97TZ#/Q3XN\a3K&WMM6cWc8=8[731/>BH6#.\/E<,>>/Z2))DBdDRZ&eH27
d>Z13GK+R6@S4XZJHEdd<J94YCI299<7+I:K/-^f6T@V\VcKTR6)PLA.UCWO#OU8
PR;bF:AG[X3ET20I?d3P@Af@c/.G8_]:6^M],><RR:U,_5LcL7QXac&Rae(b8]N7
\SO2\E\BP;XIN#@?aPgW(<OPG8QS<b_dH]XYRKaL(;G)IeMgWS#),+f.LF+(Y(+P
B8L0A>5X[ZNHM>9S53ec>6;fR?CU&X-3B+3Bg2X[D1]RU0G+<\-T>(5S>JNfYS2M
;8BN5P7)O)Z/-Z=5V-E,]()aA@,OKe3XYT(\ZW89;:L?:?2/PGg87DSV&7[=SN0S
X:#>9Z7<3#b2:Y(>S^OMAg68c5QZ-R/CdL50dV/&c,8[UUCfHX;^>3]?-?A9]B>(
.D9J=IV&T__RdL#0V]R3I7Ge=0C],2:3JgWbHR>a_,O&\8J^=;RS#GY_/f]CA33\
,77eIY(R4Zf^@:@JXd&E-bJ:,b/>6(M?]0ZEM6_8\B?@7&0Q[M+1+\.f8371FB]=
<#)5#NV@?AAe73X&]dX>CIg/DH(SgKW;\]3JQTd1f<8N@]C4[Y_UHc+dY4V;d^I0
;FGBbLAMMeS)[8<0ZN?P_6+J>D@I0W\E+AA9Z95X4X?KOHg+V,LKQQ1.JfaH_NZ<
@bK,g)/.&bY,D40@B2/U(\A]?_^R0HU(JZSYN=H4#@fTZB#&)E-0UKT<KVEd@L=f
9(5=RaMUU.7@6>2[SO<PgVKR.ScZNg,?BSKPVM)LJ=c+Q;dNbNRde-S>^7.D(X8&
4F&R/7S_0fGg&]]I11C>9c9f8R@_a:7Bd#/C2W^Y=&P?eJN,g#59M&81YS<C_YKe
9X]01f@L<:5N&J#?]efA&JS_6TYePd6Mg_HEVGSRbL2NSI^[55\9P<1\AK[[[0>7
Q?719(?8:P8YRV=PMEKE5E_?b(a\8^_Q<T^YQK8_gA+C4Y671[bf6JbY.U\K,C4B
dJ>MKa,][<=WE(CP5Z)/)M..gHHU-@Wf:W3PDb-HL/g.6-)AV;ZMG98IIfcYI_BX
21>,UTgYNM7D>8:X0X/59BS/#S/A[Aff^AHDW<E4<KW_:ICL_.606JB3S;JbdVWA
1]4V(S(0,,cICRFV)0RW?RgJC^>eQ&ZM]WQdc4G\f3(96f&05a#5IgM#EZ48ZbJ\
/UP>&_,AW_@5_3aJU>+,M0XQ?#8.&#D8\d<D<-3Kge.\Q?<N>Y,O&:&^5BHU#f63
L_.,bYJe^Y+4<JVD,#b>PHM0>a.(89UWP,W6-]ZH:=N\HP_JQgG1H#JE1W0FOVc,
F0<^8#R>X;HCER7G+8DK.JZZC2=_.(9+?dJ#@Y]74fC#cd6K\7K4AQV5/IZ97>LM
KdH8&TaJY[^AN\9GI6Q-V#g@0[OIg64?8KA0.[ZYFeYR-7&N-6^>=;a4:#6f>9.3
NCZ^XOeJ5<Z]>3BHY0^VI7.g:KaYXM0BSS^e;/B9@OETQX@4c=++QY8Yg\5;]KAC
#^bb@)UccN].a[K_.EdXcceGLWB]6SY4Dg69aJ))?=C3)S\F)Y+W<@dc;.?OAPHW
N0@6f&eFE3Fe=)LMJIcV.21A>)3EUBQX:)2Qd6FN>__JUdN[^fVcFL1aD?e)+<I6
QY=<SE5aWTe1BWPU=Z=5#5g_d6\3L0+N+A(XEd2QVbC@RJ>g(#1VM<WZYV7?WaOg
<I;<.)P4.e_^\BcN/QQ?f>ee6_>G\R9gWTcREM7Z.V:dBfE+A8IG/-_6EKe1U0E)
LM+aB,QPWRCX]MY\IcXTJLf?]QNC^I#B>g8_9;&KWMf36bgZ6D#T:6NSA;e-_[D_
)/c9ec_OaB8EV)]Pb>E6/BIKG?^<J[H-f&Q9=bZL[)<a-&Y)><M1g)A#&9@>PMM5
76?_+:<5GbKN5ABd-JcIK2U:bF8[DU:PVd8EeSS7L,P<>_T_a@8N:?KP46>0P/U&
^VB92M]ZAeVfA,(ZFbZY<#5I[Zc8]NO5\_0.3:E(+,-gH@-@L?\32Oc8)c,HA./d
F7-_KQ1A81HNc&N1D\b3(cFB(WP#R_aE5R)B\=dQZS)^[c>a55\O0\=T7)0FM7U(
?g9Y4.9JDE)B?LXf@Oa,77:f_Veg+ggJK[\JQgU?YDc0<>E@H_)JaKYP5:V<T-cC
X_CA_[?=&c_VWW0?MNM:2M&(6PF&A3gW&]KL>b=J4Z<07XM@CgOHE.dgeRCM:aG2
Y/V+C.OGJ[0O6>:ecY,Ic^FV(]HQUf?K0AM\aN7gB_&:VeeJO082+1DH\R_Ze2TD
dMOg^-I7BAJ]\B(5F[A=P2g;K830&E&GXLWDE#eHTI3UX/4\[>C&SO[U(YfM^f31
-;=AXBR\@I5OP&GB\A>]D6X_L&L6ZEUF04N=C?:,I;G;b2UX4a[71:Yf00D;Z0F9
a^P/;XC_LQECdIf:#<c3UU>:)_O]A8)GK/<\]K_,++e?Ig:D\#_4QRbd/J?@--08
J(=&5M^]B./GYZ]Af@,E+=;[5?K1,[(MPCW:P[J)Q9].(8F#:S;26?Lf#EF[9MFS
I2LN#)Q_&7-&I+SR/^MKTgQYZ4-O.R,X2W/2O-IV>E,9D52@3f^0SWWV?,I:L8g)
FV]=5d<8[=Eg_Ff(2S1(ZcHMg-,@^R3L[[Cd=Ae7G.NY&)OY4g\F9F;gU7H#R-VA
->SVf3Re1):Pf^>Oa:G)]]b-gc,Vc)?bM=<bLZL&SO7X)W#GHbU+Z<<&O20S0]8Y
@-<=>L[=TK,<DONV_,D48VMM=b&/>/YWUHSHE(;Y#&><YUVQZ+Ic/-DIAXecZc&Y
9[g=gAeW<E<0S1&YBSXeY6>T1<]PFA2;B),2D7>NaG_(5:MfcRF6IK@#A2UMB4R2
FUW,)@W3RZ]<ZNf=?V@-?@=EU(>d_;a=3N#^&f&>T4IDWZ5TS5P@?6Q0=Yg36W^)
PE6H1L+NM1^70:D2TZH=Xe(_JbL16&\CbV]b<F#Y13-W\CP<OCc].UPbNYD1LJ:8
bZ^:4GgC^,AIX9SB\RYRYfSF0SQP3ebNZ;/gR?G8aK5[]Id.<2=IB#U8^g9,)LG8
,d&3/CI:&M5>?T;_6f#6>GZ(2Y#f787Dd8\&V_3B&[P0#MMHCFBQX:<]ZG[H>2B\
<M=c6IR-)Z[2CI2KI5]_bG)8]X.8KBMX&MJ<^4JKG48-A5YI-6\DFI,He,)).0@7
c-<E8aSBYH@g(76D,-7?)EfZJQf&66@+UQAIH\De2VSGCMMK,91e)WFd>Xf.fY-#
dM,1OaPO0,2C#O#-EeEcZ@_JHGbR^341X&(/G=4V)G^_:]Yg7B+IMD;X]A[RX_,M
-9;@F;[2-P6-Z;fG7C(W_3Vb#.,ZddZK:&4SO;Od?.>(G_EPN;F1_=6N/?PQ<0a0
M8LBSJ?cT=1UIXTBeU.NVa2TS0X)g]=cF.0+68=09??=Sa4fgT@,LV&[aQ8.PXK(
G=(TY3=+^D3@EPB=_bG,D_HI=4?@-L)INf2)OB)+X3NK@dN-d]-4IDeQ]]X1a-D>
@0<I6,9Q-4^Mbe/HA_1G0CEcg5I[:Q@0<G,U7AR]>0=I-JY3XSWDUg^&I1JK5^f0
O)28]]g=\OSQg-A82(OZ6U61eNeeQ#:aAeSHTfgQMg\95-&6_)gR.b0VILRT#RIa
IFaK@.BE;RTU:71gZd30XIX(cLFg3dEXB;^cTMINbB3YI6^HXb3/2KN#O4bFP&=?
[EU.]+W1F<]V\2LEM(:.1dXU19HJ=D+0-UUaY@)F8aY5:YX8>Z[9?9OM\C?&_S#E
:;#Ebc=Z9YO#^JVFU[/d=BbT+cK9=@81KbFW+S<[0(-T,[JF9#TDPN@1?J-,ZC(L
-;Dc[52FGL?]QCaWF[3;X5TLY:+_=MUM]]SSS0\JfQQ.M\LgOPEAX^0T0JaG?W3=
[XAJf(J>R)DC]_=/\dQHBE-]Q]Q/ZJ]L7SQ2J[?K#[?KcRe1055Rd17Vg]-_<75A
=,Td3(P;\gQ9X1-b<b[f^P:X:8+79?U<=J_Lg)\[6WB9#YBN(@P^a+DXII#T]WOg
_UC^[DP4_fBD5(QRCV7AUW.4FD,#25FgCX6Y91_74^_Sa&DV_5O2.Z:_E6:V6LI[
O_AGQcA3:JG\W-.+=K?0O(5d&1_E^UDW,TI7R?[9d-e4AR1VBVTA4[aY)=C_#2G<
_LA2ffaY@S7VO&#T)f980T+8<J<a-N:UG,YZIK&Q@)gd+M<#(G5Z4;8X(I?IY:9S
Qa289e&G5&2&R0c^ZegJ9dCTY[1#(U>e+OQ;cFd)&c4?IM.-Xa_0TLI9>XW+J0;>
T8fTT:Pg:NDYS1[HHYECH/IH?dZFZbI[>ND^.LZH8Q]W_50FKN0]\)#7fP3a.dUX
.FZN7F4J]]C2.KR&@BA@O<,D])ROUTUOFWJ2<4XBd&H5S_M_X-N6T0[^5V^X>OPU
9\;c(1129,)4-GM?e@#4XgITcF@NQUUVLDZ/CeGWSMHS)YMNV<EC1e,fC)bKRL-C
4XU5GHX/;7@NAbK>DHO;+bN#?ILEcUDbcJ+^a@JI1=1S16Xc9/O4FWKOA-KOJTWg
,7NC]L5[b9D3(6/&@fa3/E(2MKFWFQB#E96F1?]S_T]Z[HK>IXG4S/cBUF,dS]LF
SfXGX.bT;@=+]ZV\Y^9_/&^?ASSD7KC+?--<3KOMGK&(\+<H:9A<3M#]^3LaWIK6
K)F@c1fL(<?;]Ic?N]TN?8T.N.][2NMNZ.CZQZ90=N@#VQdfGbDO&_5P<]]b&ODJ
GgM-4MC;7dOT4/eMUY9R9.2FTG,D9-\+/LJ->WLMYP&H/H_E(c655&\RZ7bAV)F&
:GGdZT\1>=,H^0]?AO,C.G@M3[Q/LbD<f;#>4,T+46VDCgSOGNP4;:C<UcBL3N?T
WWD\/UdCH2V(R1:#P8+Bb_L2(G>9WIRbFPV:MfB:X.H)E&b1BX[M>N<eWbfa&.\c
Q[#_)AATS=OH7IFY#c;cJE1/Uc)M(]X6b6_K4&[5b/PX;LcHFP5#fKR3F-X]7+RH
bQO?\1I@NRg82DV(4X^D:Q)&IQbbOM,[5e63FDX/NU.<1eZS.HM[S3:X]A&^TYV_
I3TY;,bG6db-=:>0a9T+DQSSd-Fb>cG8->/dJCXB^FaZP8(GfQ/68DR8U]51-;SJ
RDN2#(VIT\T-NU,O1@Q>Ne;bIB<aXTA@8W\Sa\8UQB<[C6#,#bB^(L,W4B5X(K)N
OgaUJD98dHX#9?-(a7E]+&/f<.&M,W8W59aXa6--4.?1OJU#&R;RH2UdGN]=U]RJ
ZE)V:GDK,)G]TX3eGL-<6=Q4]O@B;@]:OC#_NMfc.\TE]YF:V\<P+(9QO/83_TX[
b5P?gX/(IRW#9&=Hb_LJ.(fZ.-_-RdT1/^V;#R:ALPETaQD(GgTBZUJ49P2#WO7:
U9JeC1#WR2)&#)D\1,@f,\_J]dQ:9<+7,R(S8)[C\\8fFed^?CaI[3P#XSE\G@Wg
]5P2/8L067@G4P8eR#I)?R4<5AOWPgN/MS(E?-E?]4I@]65MX+?46K=[5eVe\47L
\40CZGSTHHCBb#/Q;/Xe5dFY@(B]cUD@NR7@Qg/J;&8D,F)_\AYR,I\6.Z?#+.+e
+bQ>ZY?(ENXAX7^-<JM;#LO#-FJ]f21EXO)_)f6M-6/&T#/4X7b]\D#,Z=.ZRGPJ
:T3WK10EFD,V6PVY;Fe^R0B9U&=aOL?G<XAH3B9XaGCKYA=HGW^NUXaD+c+/:HCg
#.;HX/\S7.J/L-_RN:a@Q+6KD@XJ9W9dU5WeQ_2e>126Y1_9Sdc//DTVF5.?GZ,V
Bf(gdM(]1VIACV=(#;DD(bMcSF2==<XD]UC4..T;HFD@YO:.U2afdM@&A&G:T6UU
a=>RTHMNK.T>4\H/0QQCS7H([YbHbH,Y?<FI)5CC3=I66W1A;gJBKM=CBbS63\RW
0&4+QGO2ES:@<I.PgEc05PZeQ70eX8C\+U34I.8N]5R^5@N=#D9g6FgJH>=-(#W,
23SMD[I.FAM[H)M@6g8aNAg=41A:/>U>X>J&J31[/?SE^.a2PS.>A5X-g#)4Vb>3
V,Lf&aRYS5DM7Dg^#aK#)DM2,R^/TE?X<dXD3S\fW.9\6K^+T],58IN/B0B:G\?^
&G>(NNP?^VM4+c]>QcDU>J94R@JPH)O7d0VG1?<I0QYL5)3(>W826MdG#OPV5;&g
UEbfU1d+53CXQe+_.5e+5]28B2Gg2R1ReYHLN1P/DJK(.0SA<f(G&U.BbJ(Y9Z;1
TLZ&-9>RZ6gNF2TPV(_0RUWN175-WL4^(]a(H@1,.)>^RTK-Eb<S6[<N\.K+L+H/
FG-8>(N0^J;,.L&Z<dP4=^K>\SH]>2c&?)5^/JJ;Y-7HJ]E>C:>_R6U>f\c)W5X<
E=B8c1D1P7cZKg/>DMOQSSAaGBUX,G3dH^X#f/dT0DI0EGHMNFc+Z>)=<F1=C^ME
<d/,POV^3XKM3?9cF@1IY>SF4a-VZL;V1Q:JM=X>(4@E@;4..5,(#d+Q8Bfb6.d#
1D-Y[N+ZEI9DU]?],)J>,KZ@C6M,5HZ:WdB.A)64Sb=Hc+4;6XSUe7QVL58gKK>W
W)9J\d;5N0bf:B&EBLA<Ba=bJERP0df#_AWP5//;>00M.V1O19dPVC&.EgGf6@UF
FQEEaANL7)OB>=\#?TK35b1ZM:fJ^[Lc3T3CDN[eAVOF-BdQ1>+0TaIdBRB:3FGc
b^TR>QOE\&Wa8B>[\0_>3Ae\\66FQB6P8.B>XQC_ULK:^QRI93N3[ORFd2;46TQc
bVca#f^Ad0d)^M^O3PCBCSWRA^H6N?HE[M&M?9NI&1,CK.&ZE2Hb1?3-N>V==M+e
-ZPFKYIRD,c@@9f\6IA(CZ0TJX2[@X1J0\WR862cN(K-U(e2Ha,_HF-UceG9&#R7
dQ.4M.RQC>b9+E<-N,V,aLAVK2J-R<K_gSZ+;ebHfgI1^(A8ZP9A5QFa\?e_;b.+
4#;FAK3I:WPCPSLZ.6#Q:a:0^GNKH=Y@AU6b7\=Q=],#3DFR3NA5@XZZ2<<2BD9P
#-f,&^21Ud<=O0#D^)]7TWd:-[d072:QBa;9f+fZcVBJH1>JUV2VVW3993R_299H
e^,f^6[OO/6=-RIg61/d7^AWeTUfV<,>L[R/XGJ,/3/#8bbDT>:<S32fRSF+E1@6
Wc[M(51_G_KPN/fGM[#FdbG2K9NY9Z[:9T&UECX^EI5B\4-RDZEI]b1g@4LUP(PG
(BL8^.C1MRPC-E-96Z0TML(E7.K]E_XG1Udb-AH.Y3;P3W2?RE[?MeCGV8=LWCZe
LMYg(S1Z0RFI/HZ/_Q2I@+E2Yb;<Ieb/,,6V_KW^>TXI)=gF/,8\c4S[ZfN0O_AW
P@JeKH3WdNBJD7<P]^S.OJM6.?3WN@;<YM7TFLBSW&YZ?gXK7/M&:-4\1[ZTCA+Z
5/aJF-I#O,<QAFC,319d)EIR_N#O?X+4ERVQU6JcJ+6:RE)])&\8)?A58&[DaM8_
g:gL)VJSOK0F=)876F,K>BCU\B6JHTHKE8+YJb\T,N?Vdb]7eBO9L\QJ[^V>6^]&
N5OfJ6@=(b<17+IX\F#;>7.D2L??J;b_QPB4KXb;D:eJTJUM42c?X-+[OD#NB+RT
\YJRf0[?_/+59g0.^,>deB_I2[:?OD6R:[GC.)><FGXc/f)PF7K-<@9?:ONVH0M(
PC>BeM<NeZfMJH?CIeKIQ<B?NI<D]WfRV1J+NCX[HfXf;I2\DS/OLV&49VUZ,1PG
VM;T,gWLV:=L2_>We?PfW#+S+T2I]_TXSbE+?TLRZ6WZ<HJ=@G,WP+2S]LZ7<DX=
9R1Oe9EdOD]L=V@23[O0QK[/F?[C8(&8?U??J1[c>YLGDNH?=GZ[2A3KBg]J3&45
28ZE_7=5_AM&De_2G70Y1ME]MIQKVFT7#7ZZFM?X?96+:S&TR9(fW_AfU<5HIO,N
=Da2f?Jg]T^-;b^2V&;8J59(>JC5KdDeNALO:A2Q_=&(/RKGG];[a>YIK/9>EOO3
=6IF0\+Mf\-_RVW>03VB,#eZ-XS#3\T@FH1PGR[?6\8R,dfGE;0^))A<J8IKQMUX
Og#]L.=7T?Qfa-X&aQ=HOe0<3<P^+9Ud^N?SZ3)d]Ja\:,T3U=CIRRWB+G\ED>UZ
)FEGUT,eLAdW;2VJ@0;S0AY@g51TH&U2Y_LMbOfX-b/#(gPU0OP&a@-PJ=9IEO<N
Y_\.=c+\CN,9:gGC77:./]B^GCLeT<,S-M6g(4:ED+0AdZCSU@[Ef/4PeeVHa]#b
.@6M,.;KCKEL]:9..F]a@ALT=&1P/7Sb\adK&\B+OC6Yc9=Z?&E9Ag/ag,KbKFEP
??AW(A2NK0T=Y<e@?_b&&+e&#6#Tbd5#;EEB/c+H_;HO6:+@I.K#U3ST61?5@2C6
(X,c]@_WJ.^JJ7Y^Zf0.79JbN90TV;=-Y-K7:TX>4DZ@&OfAU9N^B_^[K@GRf@RJ
LT+a./6/?:dD<8;M#3J]T68(X>4_M=,D>PL^;0+aB_^=O.eP_cP&)?eaMB,-H0-@
1c\C2)V.HDF4Ca-Le/S&ON@4@]b,@:1VMTB3;OJHP7+d>--Y.Tce(QGT4(H@(G/<
(_&)b;OI:4XdFD?Rf^J^WPEe\[>=XUfE,5#b#b?e[+Z6Re1;=^[R9YZdN2NW:]>e
?TH_C>ET]SPD;Z7d+?^/ZJR4^QYd0)T3U3g5[KK9WB?55V.F4B7b8.=9A&#<T/_J
&003Fe^;AgS]eA689,d^ZU.Y2;9E-<a=>8OTUOC?.Mc^VS5f?KGU_IRcZ--U@?1S
-;\g=HYFIJ<0ZAZ4g9@F&R:ISQ(BQ_#f.>G8K=R?bQ<D=.^Ec1C0+ddOH-&JV+8&
8OQgZBGFV;B8IFD>F,;;&K6J]]+54+H2^@a(.-O7?\^2aYE1722bGKaHLV^d_+#]
AM1M)](2C=]&3bgEQ?4Kc]NCVG0Y2:Z2N9:ARgWSI[#.=)&B+_:A-/)WF)C8#MW6
@D^Xe@XHV4N\O29@1L67d8^K-T?DLQgCI,@[@PM)<.T>LI:S;:XU+7Mg)X)2eF)C
Te7OgeBL38D)7]X?4X\KC;:GG@0dYWgEF.Y[JSJ&CHQ7QMUC#TNZEP5/&TUdV@AU
C[MH]1J2;RfDETf]Ef7A+0.6B_8d]#;fG=YB1X-c^.-fZ1)=I+N/f^TP+K^PN+6b
G&W<bOg[[W6aGQHG1B3+(JZN1U@-2)]Vg5+_K4:cN[-f\1g)PfSDKJG+?NEC9d?8
8^SIOWQST<6_N]Cd<H(=V^:>Lg8YIVB)g6+2?U&:7@>ND#Y=E^>f^Z[B3#G_6#KU
WWGBP[)OC@d(DHd6.^2,4LE5b/DcR,61VEeP3\ULc5OD]]IXLT\8E-#&:E?TZ,/5
G8B=[,MS.1bCTF4F@==\bUC<efgK2&aC6aa1IF(DSF#5E=]_S\g<f]AA]U@d6b<]
<+;_N4,gP;EU)V1?bV^=6ABeR3(A\YZ8O[-PY<]FJ]XdJY1K45E1[(bHO.Kdg?Mc
N1G;&4UQSX#JHRC\V:)Yf[7S8FegbP]M+&W:LGG/8+]G]3.=T5fB?OWDg+Qea&7\
GXSAH:6IG4BCaP^e3Db]0YbYb/febc_^<YcC3G;SEN@-0,_\Oa+ObR9X_0RR>ea>
:BI5_#0EL@B<^U)9U7#YQ?4/J):bB;Z@4df12+>2NKF;a?=916fNJIQO[G,7MbEZ
He[DXaB0d6&I2Se@:LC1VF4?TGcO._gMde+@@R,<D1A8f,#/QN#6L)/T/(X5f^UE
?g4:g[S_AeZ.;[&PMEOH/KSHb)gAZ>Gb@B)16&g)b<O<&=V_O2IeZ>RFADaN>=a+
d31J@\UDKgYEO[?T.Z\@S.M,e7U0cJ?(N/FUWTB1H5MJP^=HC<5N.>AJU5L@TaFS
G>?ISL[Y8f///)XLd\[R\d>aOZ^S7#_S4bZ-ffJVF/9QU/]fFe4OU^0F^7PPW?\6
)ZTMA2W_&I:a6eXb(D5,,/ePL_b_&S+E_4@=b@YWXO;3b3QE&18XN<X824@AL565
^Z^d?Y8aBC=ZWH)CF6R-+b?OaB>B^A4MQDXH5O/W6da<TA,.XU5.=X\KT4F73-?V
SY8;LO/V8ZbG5-OZ^V(-NcG/f9TL+1JLK,bf/b:\<B5XZ@=TI(ZG-FE7_D#e>R&1
^;V:,?&TDDK#\a,aF59CE7.R)SLfZ9M_UE(MDYBgI>GATGc.9U9@3QHY^WGQB[\=
SP5g^Y-9&X(/.b.6^)ED-BV8(EC,M?B&D,Og^dU^?QL[TaMNS2:=55RfM<D:LQX=
gc,N=PUL0^X=M,X1P[+CTgQJLF1A/H+J^[b(#.adCFTX?/9O9KW>c#^5a=;Pd8J\
M,<P3+DU_L/6)/-X-ed4WffE>>2B0=3gK=dM]Z\F,8f(<:OYV7XMU[\._85PS<\&
JRMDMe<9NJ(W+c1Z2P52,OgIHHfJRCJ-N:;8#1,.@P5=_,-.)O\B>(G_^TY@TAUC
1g:=X&FT^2+W1-IHU/?=&6A5=H-?VW^H8bKH#2&.2P[ZIYgU(b<7eHgL6>I,0bI,
[9P1<b(\.D#R,+V95:1)NP&PH:IdE<+^^80>@3)5B7:[,KIF4)X7-RF_gMY&\8V;
446LW.T9[=W(FV8=QNf?5@-T7#,Q^/&6&^>Xe/>U4+MXP^,=3=fDe?651b(SV<2W
/P-a>B8VYbS7M/H59C7aW5GgWg1SC5-@gA,f)5@94>;Z-e)9F(VZ59<)0Odf__ZO
<Y\.71:.A4ODbdVFb,AW:XVVce+W<)<g]Efb<LUZVFVf2EL^O+<5P]Y:OOG_f1#1
F2XeUS;aaAd0OU&bN;M+dcdXC:P-dE0U?+&]g/>e,459W_<O]YC\/J;Df6&eW1?0
_RFcf7^J^eYBYI:4?cA0Qe--)MY+_.UC(dIGdFPD?P=9g.U_U2gLQ_5IH+a2-Ag]
F1D0WGK4[GVb2A>.U]S?[8:QL\7ae]>M\[=BFK61]X9G-H]Y6-5ga_fY#^P7_8Y=
09036TST&,G#UWH=#ROW_YWOe8UUFL;eOAMZg+QF:EX0JMcHAWaR9:LTG=<d-A:(
J7D.9HB6bWYWP]/CW.BCY28d&H,O#VR,N:fYHFS[g0X=Db3IA]#a/gC.0Lg9^N-6
(H]3UDQ:@g,H.PU/I=4aTI]-3b6[-GE&8VB5#PZ.AJYJ;U&IORY55g/:NXR2ccCB
55NIGd3ZLV35J,9DV(6TM=gf5VUCS[:M&(J0MLWOgAFg0e68g+DC.DI;=gd2@C0D
&1#HfW(PPe42T9UY;Gge)#1-=?e@AF@Eb@f&+H,VIA]NV6UA[4O[OYBSf9E>_5=#
G.G=gVG,[e^HA]6N3f>/:cC(W+7Sa)e,.#K<I#WcZg2efM6D3<d?Me@+[cf^Y=DG
:&3IZSVK\V(@eJMWUV5Y4F_e1Z@Gc5.@=:V]Q,:.4ZFQfH(X-YKSgBe>a=gX1fXd
FgRXe[Q#2R^\R:>)CLV+/P+1:C]ec6#@9f,8@L90+FK09d3B2&.]@9QVYd0J#<VK
Q?+/L)O+&/)[:#;AT>T#PJJMc@Z6bUW3F@HJIPW2SQ<=)ZY9ce)e6&>dKCC==#=5
:LM1;[Le#O;@H3>)O[Y-7,AMS0.0[<@UJ)O=<M+;0XA2ZTUY7EPd,1/.@W)39,-]
M.E=4EfO9,d>_3D8H>R-+.E(^.^K2].e\]1<.X<&48;L:F>YSB;EK]N[\ZgP<J3I
?[,.ZDQ:@,SXJbb,Y>HRU0WQ[7/7G480Q\S68[g.[N)DATPdZcdcG-.EZ_ebR-O[
]^370;SM@@?G@>cYgbQ]AZNM(IY;,:R;&JaUT_]OGC&K,(E1@W9M#SBC2)?b5=Z<
4[2&FGLJ#;,;#(_1+)Q,d]=[fO-./R15\UI_0U>NY2^&6H1-=8=)ABLa)K0?KEUb
]JP=LJFD_UQeJWDW6/0JA.U095P_0TJBTVX1=D^4RJ(f3.>M#S,f]Oe4+\&MGGbc
I?\f122:)OD,+9K+,923g>>:)gORaJ&b0e[(Y?W9<5Y\,KMeQLfX@C/X=ZC(?Z-/
O]2JPeH0d8W;,NL>d[)4dUeT?UA\4JY_E?]E>cD8&)&+\dK.UBC_?V-[13#[ZY:2
=D=Q]REHW3OcHRbcV>9G\S8[1D0XBXZfSA.g:N#e0Vgf0Ia,.T#L0/DgP][4cFI+
CbOPSWHe/@M_\5(JCeH7;8,(eO:(fSfD?-GdS\FUd-G_E#>=\:C9P[4G6&1I,AbM
c/X6?[Y28DAf[F_V+NQQ9F[\D/V?b?^-VTFO7;B=,NM\_#R3NOg7,?VFb.3ZWRAD
1YSE0/LA3>-?]GM1\0&1AJb0&N<X+4NEF?<7DKbZ1H8eO,@d3?TM8O4J_c,V1KR#
O)aD5,N>e<.)P6C5ZI2_0;dCdW/gR)UWO@,CbLR8ASZc<?M>;D@EQL&@D+^e+KeO
+II]a+;[[U/CO_,WUW1:.KUBB&^PI25_)C.;]VZ_SIfWD7KM;OI^#d<5A2LJ>Xe@
<MSW7&2Z4(#(.AQ6=)P92IeD8O;<cY(SXb96G-Q-,HC(64eU83\3aYPG0\SbZ145
>c&8JdZ2LOTc?BTG/c=,YN,g#QN\Db+Mc>a5NB&f,c&\BJO0dfL:QS<:&FFacN7,
PMV?;ebd7>62I;/@UVIb4,M]><7Za-UVN_bF-:a=94@Za,XYIWS?0F^L)SPKe492
#KFH6Uc:@1B?Hb3be?-7\R#BfE(PLba?c_Z0,]S;]NG@_]WO7fU[3-1B=RM/gX?d
WBALD&KQ\7GU(BNL-,)BKJC0<F[JfKPQZT60]a_+ULQ=#[W<gTIWT5:Y2B]))V<Z
/e,UB/O#LcBM1VYV2;D0\;E4&<@c6.Q>.XF)95DZ^6N&,36_T3cNa8FCX=W->Ebg
@=dCaN4KJ>ZS)c.Z-Q48,1GfWB/(0&:@LD/EdIB&2WBW2-[#HD:DfbKPe03>-VJS
0ePK,dYD.X6#3.ZT+g(9#5.)0,2?&+=H1#?aG:)15&Kc/7]]3F64L,:9E/aSV.+b
;@bT/0^<\Y6c&40GD-fO>75=VBW4A:dQeg-fV8L@C>#Bd?;HFM:9YO/2d&RIS20f
R1Y_077A8.Tb(:[8]YQO,.L>c9Z\DLg\)^f:gaI4g15SL4ae0f4?Naf@WO?23R(T
XL7RYX/e^A3JB,FgC-33VLR>^6&H6NM#RDVK-3YPR=S0L:CTGW/.X?+b;R71RY>S
NF92.9<;cL)T>#]<=IT;NOI-R>Z-WEaUNTQDE@HA1B#g\KdS+[#P8;[Rb(VH?7CK
3e9GX&DV\^G)UEA5Z[eT8bOCXf[Y#G5ECXXQ\F4,fNV^aW:dN].,A&O\:F9-L&K8
B^;RT>WdOc)_L2U2K<RHFY;D3-7)G=<X79,P^^0bHLZaBQ2=LT.GTegKVX5B[a_W
.&<&g5JESdQ]gc>Q1\M<R^V0P53#D\20Z9J7c&Kgf-_QgBGPEaTE3E3Yfb6P2B+b
b(bP<R?,^B=2Af&ea<Y^;(PR[XREM5daVZc;O0EJ)4=J=5(:ZWP@4C-K;&ONFOM&
:;I_b.)V4ZeT7Ob)7Y(6)1:]&_ATLKdN,+3PPV12g_5:;S41F;9OSIF_eL0Oc6D^
&6P@(HCP=#S\<.4@6?a08[3,AGU:d]-ca7[&e[#aWZXF\Z8bHHN;,>9WMAH_c??S
\]QfD>15:8?P1^-Z,RRcB\H3Oc]bd5<XLU/]M(G>E[b]1F(cDJ))5M)LREG.TUHX
T)YP9\^OJ,H^K4/06V;;Z>IJU73aOP:?U;#.#ZaU[N)/BUQcJ:<;Zb;^T^[d&EQJ
gT0&49MZbG=G^OM,aQ-:D8\I/6+QP-ZK<bVZF)@=&FI^=944OQ60L/<#fY2C<^^]
T<-O-[+1fDa_<.4X;2c5\<0J.@?QT/#GX;?=^:BAJ;O[1>D?1;c/KgCU#/ZaCT2+
I;B(@7N(CWEKO:Q1C]HDOD8YQ^[FO=2Q0QF]+Z&bFN[X:dg0g<FAEbR\;Y25,;)5
7>A8]BJ_L,\d^I7^S.F^CfGd(,[D(T<DF_J;VL2d&gJ7UaF9KY^HSE^#HcO>A7S>
1OFFZMCXZO,<MAcYHH]+?,)KOA&@/1.,6T/VOd\VWT7NT7.@I#QQb>M(O)KAP_d<
bHFd-PP/&g22U#0>N]KOQN#1-02\#([/10e1DI,9][XMQ;9?(@@;Y^P:#f35faEP
PHg1Z?9QS3B-BZ[=JKG,06<8^+IEQ?.<U.61gfA:+g2:dI1);14UUG+a>.ROF45=
/>3ZfTFRGeK[D;V\RVZACGR1[@C:A@Ggb.a(YA5(5_:A<<K3E0;5/Ucc8I.XPR@d
?25-/ecFF<FQe+eJS1H/cAWWU_KUf@GUPd5@5fb0fKUK\X@QUG+d9Lb6=d]X(WER
IMI\[#UDcRNLCUWVJ:5dPR76SAJW#B?Ue6\-(<Q61g<G;?O,?H,H8:M+6GN8-FgS
59<0_T^0MK3YX=@1I&?(UD8)IaJ7.R2^D@5I3d,8F&R1GV0XRPMTQ2]RXg(aN9(/
+1.H;:R\XXAgT/@.,?W3EaU=?X#^?^eXBX,bI,cbX^:9VdPc+0Bf0\TC,d@#CJ/3
@)VX15RTLabFR?AAA]SWcTF_-&2\c+#+A1DE>K&Z<PI.K[#6[CZG2RY2Z#gXDMCP
Y<Ac>W0[EL=QAQ,]X?gaM[YCC9TM??gZ<,BJ5EePLcA0aZNK+NMM536P5?L7b8EZ
G#6=7H?MMB0-&aTdXEENbXRG6FCVQXHLFQ8^FQPN3LHE/agV^NY=gVFQH6\11QfM
;#J9K3V\_fGC#:e[C0HIDg#W+P0&dJ1.YbTNFSSLda08L&U-aOb-b@/P>FLNH8-3
X\5_LaF91.PbF,I)Ef1P8HJdDG(eLPZE8?&S/+5ffSa]d.cNFI2T[7b:XK+SKCL(
NaVDLf@X^GH5B@S+>MB6Gf5g-GTL^2=JNgR]?K^g3E9PAE7>RdgFaY)QN6?6R;+]
<7Y.DO+S5e-g>BXDA8:NEWV_62TO.\T>GOUdWgc:NcINN/gVfF/6E3G;/Q_OH3@7
9;52bXHT?:Y\:_M(V&?Z=KWe\0IVXU7Hb(66A)P:O)#g0&;#<L@G83:CW5PT+LXS
/S.DSdLMU17JYc(::7F;65CgQ,MJcK-\XRM)-UEYf\CgQ-YGJeMD#c?I33,Q-BV-
T=@](QR2c6XE]#c1,#S;0We2K@]ZOYY\3;9G5D&c??M])RRL=-.fM_>R2SaR=T&G
W>IgQ_dB8_:If+Y80<_+:E435P>M4+MgP4A+;Qa(:3<]WcM_UY-eZ#7/8K6QH\Xe
1We3SXaYHKTU&P96a/=>TOF6Ua[XKX)#Y(X8[D:1@7+A^UM.RG)AY)aOPGbdX=XQ
T,YFCX]DZ98?&.52dC[@AcFU[D7E#Y<D(Q=(T;J>/c.[(UOc<E;&L-.>,(D^CIK+
-GRg4[N4&3ZGZJ^7>T]-6))gEK,DNX,b4+:<bB2IK]JC7efGL(R0?>YWD[P,9,:5
)F#1\J/b7YMcJKcM7DGMO0HD,YgU#1[PBO0K]ZI=QIC4J-UB]=]QR6_Q6g7>\X6C
S/P[3DZ=)^ffT2HLH[^YbNTYaN,Z[W]V(U1+6L4^]aU<+);BT<54L0)c-eX=K_2<
R11)8_X<?bC_b3e:39^LL_>8(J54DGO4QQ@]d>T[F@=Mc>0[SCZBH6TOL1=@0PDS
T9O^e246,J;KJ3-\2=ZdN8)(+9PIPS(@:K0XAS9M=&9<fOEZA=]IOc=C.:XDM<@J
<f\9/99;>+?><CXGN>U^[Ge9&-6[B6Z7TfHa0W/Q/:G6eaa17d]DE0:9A@,JWH++
D)P(Y]73eSK/PF/J-0-g,^VE_._97ga75TL&fDHT^af5^;H7@EQ)fUN,CH0[42^)
DO-BTgXTJ.198M@B(QB/E+80+b#&Z+=/V7RK>E]1d&A,5#.2Rg?ff)Kc69PG8?Z1
cbK-)D<Ca^a2c)J)_eB\TNC<XRda8CbU=C;S7XCB9J)HH03LY==WD^ZbBTE1V4R?
BgHaFJ^GU=)R-:7G5J5:K(#b6W&bMQE&ZN4dfYW,B;:b35NOG3L0U:KUPAf^<]RM
32-(JSDN-8@Qa@<D.0SR164I]Ya\6#SJ#W+66I+M\.N&.G7VeK+?R)01.O67;KY-
<^gg0TT=V=NI10EFOHO,]=/YNBgfM#Z#P._&6f:#79+AK0J)QU6</=59ZE<2@>,M
?0a^5/B0_86T6^KT:BMHe>L1.XK]7eVP@F^DNAf<S1gLcMX.e/@d,b[@)P&SC]bQ
=?Ec/IeT>K<5CR=..NW3I[6b339TQ_5b4/B-I^BIL,RP7_C3J)W-e34H\Ma,[KQB
f(-e:UHIbF1ISRR8MQ?DT)Y7GC/^U<&7)AQ:60>>JC6?33VK&_BZ->)Z;Kg],QWB
.KcW4IRc#A<2?:cALC<2+[4>RBW38.;PCE=^\M#[U:DL;/bC=+_Td):=DSD2I=W[
c@TD0.&HV^A\bM)=1?,25<#F;N16]6O&_=bd&4b1\+Wd72[BY>RG&a@5/B1W#4^L
cW\M+T6S:\/(dX,ADY[:S(c=M=^TOAW9IA-M8-_6V2-P9Y[A35M,cP#aQfM+M-dI
[5,UJ=&\RPR<WW.-12]M=NLY(,de&M75,Z=P)Xc43F+WAMP1QfH)Z<347G[[MV;K
7e=B]T6H<C,8EC4Rg>+S,c(JO-S?0J^S.(0bX<KM0P::B-SAg@J.9>C9MPd=(+DB
C\cXF4UP@bB1.;IIVGEX=Ub^E_++^7N\L3,P]dOYg?;/\3NbD==TbQI5DHG1KX6e
[G[,DKNfXeN&M=+8.5P.NKW,K9R9fVc.-DN=0K-05g).NP,)9Ccf#9[8S<Qdg;L[
5G89O5#c:<^W<@Z[YIPDJN],LEWDgR=OTY)8P7Qd6>PeU8,:JOCE8=MCZQ?+-C8P
Jdg__#I+5&#]38Kg@SW>54^1U<#6aW3#-):IDcLEJ@G&7V@,ADW&H@RLH1ADD/_5
d?5\-+dNX<Z->>V/_7JL.BcfRCVD#6MeJ<,I)6/80Cd/BeE7N-c@NC62b8Q\cd^N
D(D9gVUY=[&3>aT<6SS+-1D7(ORBDZ.,3d:J^+g9KE0^adO93>7DI@;d6/P4bX\U
96V;g&f3O#<e-7)=g?03BC]^Zg;22,R?=<<\<(EeRLJL(b^,N86f3QK+6g:UBV55
eH(E5c&9fA/@^K:c)NMV;c7&bU,&@TY-LcP^-,F2RXV=\Z>H1Q:QA]:[45.6VKaM
TV-/Jddf^#9QPSRN6(?O9T>Ca2?/Ec\R3L+Q4T6G&f(KL\ea:HCQe[D)-H+D==?:
XN<9Kbc65C-L<4)=fCXfS9,HU/bZe<R>f/D.3?9TZ8C&)]4T2W)T7;GIL2HL-#,b
SY.^<XAT:5fSMUVJ;I[^G(<NTOUW6KCA,)W-_M..?UIAMJJH\d\KR1]gJF75ff)a
K9g_14R->,;MFRTZW..>=_]]eAH6MI.d2UCN]CG,b\V]9-c[43-DBCa.J;c.RQ#/
?KeVa#-6EQb#4.5M,a754FQSRJ(TaVY=9R-],6J/Oe().K,G+@5,+AO21EGFa=0P
\,+b@Y&&9:::_.<QYbKWWc^\f@CN4?C/Tc-PW@Q)eS2XK86VIPc=0Y+._>41e)+&
a58Sc5WcD7(=6_68P.4=cbRf>4SB-X\M,CIG&W/Fd8e91g]VJf[)9W;Y],=,^H6c
7+E1FW3c_9WNOUZ@,H3Q.Y3>0Xg]CG]UZ-HId^-Z0g+=c[G.^HZgCAHPeVEB^2fI
+Xa==dM)N8VefA+-eW=7SMX,d9A<>7dDA7fJVJ5#&Cc>@SQ>#)+9YDf+/003EE:L
2J@-#JU/(GIS-Z,A\\+N/N/T9-M9:9X^.@5WL:4K#B[b/20d#KC\6833=9RQ\]+O
OS\AHE)#ZLe:,d&O89R7dgQ&A&,:b:J5K\1E<_M^LbOFga/e7KD;[1.L6P1S20S5
e6I,MDOfB]egLd[E>COLE[1c=>bd<IYXO_EY95cA<S;X2W[?Dc9>3M:Z1IbI\YJ-
(][aZP.bQ7UFYMOG(VZO/?09KG[NW\Ma]AFZ,L.Ubed3OXL-V;?[gEf&4Bf-44bQ
.dg:4Rd0Jf8bb8e9e_c,30XQHPYHTLC^TK)R&aDXIZU=+682;8WC0+IP)[<H/6d4
e=Hg.U-K\5PGb/DNH/Q@A-IF_eFI//WZ1cS/Re?I.2NL_4g>[)Y\a\YMS1]O#@1P
BSd\<A3ff@/R30#;R0ScPd-FKWB)J_gT/Y5e#b)C.faNWOJ(We\3?.M6X)F5-Y1A
C>ATI)UFC=_Nc+Dg(+_GL0CRM&)YI=[)]&;0ZA/:3->(Y<42[J-P&3;7aWY;;;N?
6^M1Ae>PaX42gK>(^\Z1dAY7JGH<_S0EaAK0LPU+dUX33<FY.^)a70WX)ZCYY3#3
P[gTOC.-7,UCA:1C\C6I@,U9W0U<7eT<LWgK/VFeGRbHV>.cRggN2OB/UBCKdd_O
L4&R=^+-^^QSK1VM2^QI0BBDId;Je25-+-bYF+;4fFX&L&,eEI/FQRbDKf)@Sc^D
aMQZ4(:L;d399)PHb7CG/f7[9W:H&G_5?+AV\9DQ5H;ODgedW2KgV--^QF>>Ag=/
aI@<G4;a5GP6f5MWJ0T08R_7#W9MGEDdS;I]5?#Ud^B&Va/#W7OXQ66R_cQ?>T7G
,5-eGfT@K_bWb2[X<^O8NY)\GOU;W2D=Q&+VD0A]GRIUbD)04gQQ\/I+T5^d,-PN
>R)KRNHE7Da7;[2AD&&VJc7G/R@VY,9>4\@NEcU.^LV,_W]d)JP@LYP/DP/4WD=/
^1OgaV91e)1K\8[]^0X39EW\_=<P.G)D8S>5_.F\->3c/;\\VVOg00>9F?gC^5b<
^U,.-gNJXV(GQN#6QD#;ND.]F#L+V8.)RcVeD0?Ma-3ZR9<Ag8K_@V2QSC^:K:X>
S/C^(>bVICO_;<TgZGMT+\P>O>^S>Z^S7+B&a7a,)Y;T>I]XVZM6b_O+4,GZCdI6
)VF/+YX(6bbC3+09;GMXR9),R(+H_<RO38Le;a9>9X;TPI/4CE,4HGgQ[\)MP.R?
b+MU#0A/>Y.HNbP4YM85?dgIbJ74_3aDB5,J895V]#+E;L8F0G63GaH9-^Le/3+J
QNHJ[@I#P/54\0<?QaTJ9aRS96Mc?N>1\_9,K?,&_BYPWAFK3-0g9LBLbGX+<c[f
-&@&-)OT[Bg_eeM;)ZRYgGIbg5IVeagU]\Y-/gXEM)YFFV:c^#K\BZS#\-LVEQW>
12YPVDB6K&=&Z^PGf2[:g5921VV7E@;,YgYT=@)1G(>79bKCLZc4d80(EE;4+C#.
V>/(f@3M7>)_\:LIYRUT/0[B>/7cE>1)OSYR[35e2^:g\HHE?RD,Va,FLdU+-XN/
[CgDZ(W1XS@Ee9)9X]9IY2aAD922I\J=K/XAFA@-0F8b,W5=]W(XB:C)S?3::O>1
gOS))JBUC/37C^T@Z]9d53\f[<](57_91<<:+@Y\(@WBYd;[UM44F6DE_gR6&R4P
:H5S2&?,aX34-1=T7\EJ):X3)1Y?b,?d-OfGE]CQc+[;P^R;d0aIQ<[cJ\:A-,(#
A2_baE^fBGJ7JK5NE&TLcfY9dL[HP4FQ)O(QG>=]a<aVR].UE;BX[L-.&^6XN.Ha
N53G+JN4K(,))e.K@0<F]eRWZGM^_PD8eWAV0Pc<]9;45e=.#R6=993\e+9gKMBe
#J5C37RPFO?XO,aJK4N?TL^6?P3e4.1=<6aBFGMae5aC-;:7/:A@B_[4//\];GR;
USU\#6;A@,[PH[74YbV\KQN#7LfM(<DD5aQO)d98?P4B:Z3H6E:,1,gSB-5Y;F_T
gfXfg4?\@e;1Z[_:CO]>Z9,f8_dI8?)&Q/GDL]LcX#+)D^QecODa&-?4g]7c0cCX
IEILO)?cG[]0PWdcQT?e3-7e:_G-K?:f;B1Jf?)\Oa^&R&1S:5Z@Q9(?_<(36R<9
IB+_.=PF_W_-ZTg-43ZR6QR]dMKYT/HdU?KJHY-CU-\3TGR\[gEa3Q:UfP[X&X1+
?GL[[c0b3eP3PY)8>++TFQe080<+[MRQMcX;d.&?:0g7J/KFaWRa@5V?N7EK#Z<d
66(:U,Sd)C66VZ[AO1CC?)@E=(L+NYe6LRZJ-<W]7LReFQBMVL)TV.9SPI&EITX<
[6g<5-Vb?_X:IZC;9UBOH^EO/Q<D:0S+(24(K^9Mc-fYTL37>,Q&>9EY]>1bU/R^
P(:eAMMQK0(Y&&<9UEB4\a)60B1KIJP0-B:2[:9T\@YKd\^\e#?_KEc<#Ie1bID:
T5a^8&#Aa]&V<L,f<X1+0dE7e&:>0c\fUB=L)1D6@TbeJLP7C67V(]BY\1;G:J#W
B1FC0B5?4ZTIJ)e1?;g^-C1?N;b?^A(GTeZE/<(<993ER0:R=G-<^f?FT4=>Bf7J
[/W)b>K#6]d9ODd0d+M&2c8Z589,0630d6[0cP<OD0U-VTUe]-^H2\B@B7O6G-6<
gB:BNg?(H[f31C.OP?VB3aCA<-\TGa5:3FF5S><f)=f85RFSM[EG;?NZIA_8c8NG
PQ1IV_OKD[eE3gQg\E&-Qee(H+YN<DR69:@DV-[R[T)60F1PaJ(Z;fJP5LX68^DW
(F84O:Le@RIU[)QdD_-S(P&I)]+53=;;?F&11B3<6bV.GAf8>[I5;a6Ua/)&SSDR
W8KLI\WU(KCN78MA+SZP21LbL35X4-EOG.\BL(K;[)gE(L(]\CJ1d\1JZ\+KbI:3
[;9+S]SPNH8#[##(GYL^[>IP#^L5GHd,3;-)YY#-B:>JXK[,-W+<cIT.LXA0UT9R
ebK=TAf4/f4(H,Jd^0B;-D4.=6BLKa^>W-<=-J@^0\&#QeQ8XO.<a?.M#aE=I3b+
3)#9fR]U.(DRLB2LIG8_VW48QW6Kg6bDHIcUDKW.HI_Q:JX7<(eJOU)[WQN_@CL5
8C=55.T@aag@3A6/c?dfRH](>U:FDB)6JA]:;PSbGbDY8INYIA>]L@R[FOHY3&Ae
f5/DYUUg8_H)Og9RL29=2BS(>;GO>6eZW82I.dUW;TRNG:;e<V]Ca_V6dd8Q):-^
(TR?f4eTY4Megcef(G^;VfOPJPT<\X7]X?/U\0CORW;1PH[aT&:(U/AdJ<KWA1,]
J]R:K3OP7BKI]&_dD0bA/>Gd\)ALU1F@=PW0&((f@78de:<:@0EFSV^9g>RMRT>R
<aFC#[G-F/==,Y7d+c?J/\9X9<_I4J4a[#LN>T;/Ja:@-E5,Ag94/+F7BH@QO+DT
P07\Gf9,VE=G^DBeN[-Z:gV\J<[WTDS:WKdC;^;AV+UW(&-<fD?a6G0Z(?4O?&Uf
XFA+_gC5]8<d9-WaA=LA<ZJf+SE8Cb4AM?],5VI@68AN:e+<,PgR6@19gQR,L&0I
TX?GX6;D;GH:.EGBR5E;LFHHeIK#WMF<7NFcXF_eNB2CD_YQ2MC14c2ZG^Q/&^VO
LBWY/P>..1V?16ZLAODdWAWTU\G9:E2N+H91^EB_TQBgg=<3\7W-d:b7?^SR_;7J
.WE_JP)QRUVScM_\2:@\35::RPBZI-cZZLIg?1bMgY,ePMHKRYD3A^2FeKT(;HZ=
3HK+c&fJ]f6XW=1b\ERa@?,L0G4GN[);W.@[G;Q+a5S3IdX;I)Zc0VSN&YVe=1BG
fP+#>fFQ:N?;N\A>9b^:(M)3OGONbcTKY\89]U+gA2ZX2H4dD\Q(d7X]-,YV_[dS
HX_DS7E#\6J)2:>U+5]2B>/^I2DWI3A:SYV<V]#E.GK_9R9QCS\=VQdLgJ#gNO;/
-M\FK6Z,98.3afb9F0&10AeQ8J\c?AUdD1Ie\]LIeV-F99YHD/6ZTB+f35LdV.bJ
^(Y(8dE1Ic(AP&QVTR#I;cV,A63UZ<2C==WSZB]B:+-05EW(<W+6.FC7AQ?.cfY6
IP4BHV#C>eOcWU<3VET75d,T<<deW4/0<^ES>NdS7/Mc=gYS(_N14[,GG^[7ATOY
]RNEIQGdG3@T]6,WRO@S+-LNSEIccK^aRcDc,X[b3<PJ.0f^BMZ82+O316,Rc=d7
83<&3_V__3^OW+F/S8W&&NCI)f(9-;aL=.Me(d+bITM_AMSKF)[JA9@,\YWUHUDL
(KYV96&&Ca(Q(/8@1R8+)e#g1@SR^:;)VL_bb\c^O\PNK5cNFf9AW_a0bA@T[\VA
eO;8Y<feQR-I=<(+UQcbZ#0(:]G@QG:,^D83[(FG]QR9]@g\<LUKK6ZHM2U:17(0
M2dT)Z#3MGf]MNV[\XZecd_OdV[<[[/T<PQ\S0X)U=X+OQIg:<LA=M1U,\DR5Fd0
3S#0-=Q(&I8AIM8CQ#f+@XQKO4GT3TR53TM=[]c\VXMHY(C[X7Fc.,UX<>P/;aWO
a]@T\3K_(9<F&Qccc91#>/8B_BMT57gELd./F)3^8QHC&G,>S80H^,T/,QgR6f#;
W=XQc0b>g9fH]&]-cT2be2829[(;bY16If2g9AY#E=8;OOFS4E:ICbf=&aFQ6+^d
US#A1Jb^]-.(BeI:UJ_>>;I=U[L:Ce_1;33dIC+]0d@A?\WHE\cSD(P)0PR2d[60
:12BK\CW&:<?\4SSP1<0[?]2R=PfQ09&HFe4SPE,3dV@^LEfYA/<F3-,Lc,N<@Z.
@+ZQHR]7J=]C@?W=/Ed[C,A[e0)VgAbRGcJM\<XK<99F(a_JJg;[[S8>Z-N1B=G@
U>]d99Z?\V(XI/Gc\MTI]?)/2K)#8O<#@V/bbSJ=#Sc>3^2>@O6>Z=Z+IH1J#A+e
6b7KdTRSY5DG_gVPaY,XP47&2f]9+HG6^=U,0YT9<aeX_,TJ00(Y43c.>a(N:-[0
\f2YV,71H<GTDc(K@UE\?2:,6H#SLK6J^CdE06)f&31:ENSJEPZ?U2,BKAe4GN6U
1A9+ZR4EWHbC)M1U/4(\J.8D6[dA,IV:]::YU?VB733/gY4g(F3GC)PLM3Q[FH0]
FLgf.\H7H/<F@;:V(94_/OM@gY[2KV\A2W9<]<DcZT3E^H(IT=W/YVOM?43/-8g^
]TeAOZ+(Nf/GV7fgY\\IRW5AE\-f5T6HO/+CTUdV\[XD(POESNdAJ,?6B1;fV>S9
5@=IAR-#T]L1E;e4BGbGD>KDH8NW5a[AYPAQ\51&IP4D6681b@\)+T5[D2D(?Uc[
4cWcH7V<@a[+TI6:Y6a>EAMb108_C1+PJKUH+,VXU;HQDAg@]ZM2&CX9HTgN/(_2
F(<LGbFM.:U#]2O9#gYK&OfQBf/<FgTQAeLXGeL(.Y-K@T.XP(LH0\H)0MLUgR^E
[WJI=Lg;7(;BFW-2&R;.M&>_&@_4ZE#K33ePH;SG7+>=N0:C3^5c-]MUH^O6(SD3
=P>3J36204NNK&DDLS(L2K+dRXJXA=VD]_U>P[T3Tg=DB#;+)EOcOK._->I_7.#[
0]C-[Pf68(/M[F/7gZUb51JBH0::+BUL&US2e4Z+,YMfENZ^^aT^;07/1gEI/D5A
/BMA>(LEPRZD5c__2AVPV+dIL\J3S^^67TXaKM+0PIZ[-2>#=SIc6cF8M/2Zb&;G
633I&H5f8TDMB4VWYKdC31ZIXH^R&LMaPT#V:NE8OQ>,H1N:(BGKO&A93O#W;Cg0
=AF57HZ:XbX2)+#g9&5RCI@Z16ee-\Q0a-/#PZCF:6A\?UE39):JUd1-/49L>c0f
Ib/U)W1dN29C__GP1f.T]#I.]6PCJHOG@ZG21+N]c+]5_Ca[SPbSXH++I)g=CHB7
4X#<O2RX=8e(PU8bf9P0:?BNE&NU<b2WDdVfC.D96W8>R,eS5=J.f,M5EK9#-4)I
MK<3dU06QQ<QLL,1I]K8;1UP[Q^JLg/)&E72COC<FP<7-#aZN(O=2DKLQ@?\<ZYD
U,-._6?ecR5P)Va]Wg-_FDCaP.+P<NGK\W5Fa9W:J3YLebgX^TJ)c)X/]c\M\&Ke
&\AJ,EI1@7G(/#8S(WcETUUV4[]4UZ-Lc:B0e@^f;6:(?121G6HAPb:GJ97Je@,L
(#U.\b;?/F(\_fEgdS&RWcc/PSQHKE0;<Xd2R5__9.:0c-]-RMP#=PL^MQDS[c:&
PKGCRUT(Kafc[D/,VYI0T;FZ.1]X+5#XR)S=L\X(JbQ1SgI3;O+YHM(;,PRH,26d
B&.;XO1OO<_@Be3XQeDX/_#7K_YV^_#Z;fd,5edEY80;GH[d^EZG&f;0I1>af>@a
D3>XQUS>DLHVVRGV.7a(.PZ=H]U8FTMAGTCd88>Md3][e#29ASRL3cB:331^3#X0
?Q?9?I_a#Q-)L/CV1/PM<F.<?H_G8bdJR:3.HI9ZLaRFeZe?+@A]OD0,gYF=,Cfb
Z<M2LVY;)4b&S9(RUQQ2.Q425Q4,F_I)ScO=F-bGg)0<)0J#fZR;4[9+>1G3\J5b
[.(</XBFL[[f_OPPb8\3J9H0&30(PeeES1gI^Kfcg&aJH:(V-=b<d>cA>0Ue:aQU
Q>:.K@N-9[F>?W-Z6aaH6e1R.=RVcS.:DaX(E,76GRO&7d&KHd?6L?M@6dT&[#]a
@b@Z+,PY8P4G:L:)U,U@0-M?^4-Z]LgH=?P1I3d<?;.+gJd6,E5c_8a1FG[XTfcA
&g&288(1M#c18_FT6Gb3\IJ\LQ8KgUed#R#:R&0V/+\fJNQ/B;92=JM(@8MC]gDW
G/5Ma>I&BXA/LU],Z[+5gB4X9IU1W9+93+/MgN]-<]HFIQ-#(.a&B8&LB#g:M9AT
g=#\F1^^8AKD=<C?cP4/fcE?YG.Z>QX4B@KL9_>FaLG83R8NAU;DPM8NM-J@M\E[
RL6bQ_7&V8ad&9aRa?+f]?<)I^BZd\VHHWIDKUYEEg?8(d:Q8+RcR3V:XE1N7L&Y
1a#;/]0@I1QD?.@V#NV+U2E3)+N>Kbg1FdW)8Ud8+/&U2J5W8I<12]a^0I\YO)#<
4>TKGS63J#5[W\996Z14B79RWFR?^<+KI..CH?I;-=ST2Y;5fS\9.FGIY/#YL\S0
bGd55<?I,7fO;9CG+ZBKc31dO@U@a/@>NeVHHJ8_E;T-X1E_PC<Ff;(LN?URH^W3
P30YTK;EU]LM_U<AI73RI4)1BG2(B-2S&-<Bgd(DP3bRQ16JR]2X&Y817JTR;4U4
XeA7L-,HC6/ET>9<dA/bMXOQ7eQ8DQ;IL&3gL&D9OEM&K]U0=aQF,\R]EN:JCJT,
f:gab9SE>&fB6YU0CYV5-f(S1<VB\Z#R/B9[@7\1=/eD2ZQNd3_cNJ8A_JCdW?;6
3+Ee^7-ES7HgGXU]5?;W]:Y44HX28cVCI1dWS[f7\8OXPTO#4@3d?#4/#C=<V0@V
[>d30,Gc[S98EKfD8P:LK#IfD+^D+;N?@:)-BfMLHC<T;(BaA-YaF0,a4S&DYSf/
K>A=)Of8e1?4da>;9Re4V<E3-EO;7R1E?D]9,&efH9=aT+EfNADGc+N-G;17&c(W
M//Xd5>/eJ/\J]dP@),WCAZ>AR@,VL;Dc7&X]d@@/DP@7B2_GL+=WB&a4T=Kf[7F
E_9CJcM-@dZD5L1SPEW=7OO\d(=.+_B?2+GU;R))#5K,K42\_#[GFX3Jg0fA>4OT
;1L78L)-T(#J1^Z6VYK(P:d1<;Y9ANMf7@R4#7KdO>#=F^afB((CDRI1H4DIOE[U
^)dO.<U\)VKD\a\TcPK9K:[MVS0&_?-<X-6/Q;]gXD&M]J4VZ9gK]>2X&V1e&f]-
C4<_HCVQN;.XYKQS,@Wf.NE@Fef+(A\R,:L.YcQ;_>3#LF32<BXB4eL#J[=H2;^/
Za\,B5.-e9[ADKP-NA_8D(\T0f^f#aW^U]E@Q+I?JGX9W:)McHSCDT&)J;#V1)--
=ca:86T.VJ-J:-,EL&[bC]G=YH@OMfF=UH0Vc3E_::\4)=(f=^S3)1FNM&,=PR#0
;)95DIXVb6R:S[>\H5g,M.cGAKb3Z;BT0A0A5JUPfbON]K(cEGbc,E^OHV/B?[b&
VEabg4L/&LFY<>\PWcbC0\YLKf;F);\@/#6-;Z]Q?A3\Vd4fQ&GC>.-)fDONc;&g
0H+9>OP8=g&KTI-8ZP6D10Z1bLIT6.&dOX-6KHPff\QOf.XQTVTZKb3T0>,cB/HW
(I?WYQ>OY)U7O,[9MX,Nd70U^Jc=:Ge@XbT:NPGK[80:)\Q0^c,@6UC1?QZ0ZeF.
5N4aLd+VV[>2A_/_AY1f0,H15N]=3?c<94/>ZO[R,bSC@b>4HL@\[\1ZYYMNG-E/
:HKFfIR#c6J,MVVH?&&7,f9DY7^&Mc&W\@-\=Fd#_Df=PO[?=3M\V-^3452[YJed
E2BaW0Y)GBGY]51.KeIe+=ZS4dD@0W(ceV?YdaYI[@e=B&LD:B+4K5e7:X)TV]g1
P2UN^3DO\e/3YX);SB/\&XZfNg;D9:He0)A<XVN1LgCL3IbH.8c0X(ZER9\T6KOO
AbS2bRdTO[9Ze#^VD&WW8bYWX>?D4-F[K+g)6ZV\F7AH&7JBF?gcg1d(>0H/EHR?
]Z1UOHJG]e+D?M?8@OO_AE]6AZQd]dU@;Y^G-MJ0)?SSOV-2(CM,3I@7dV&dV4OP
B0A[^,0ZC7)?a-4dON1>,)-N_aTS:A-PQ3Y>ER2aF[J\YNVIZG?G(I7L(.]VK\,Y
ZKPPc<b,ge&g(]1F9Vgc(@S.Aa7Lf11L]Q8Ie+?F:b78aVf\3_=VH9[R+OZPH=\0
c.Y@If[+aa/LV4<>\GG6?3c5R\gC^U+e9CGWV:1gO2SK=5.2@<N2O;83#I?F0GR7
,eaM@N^FL4dWF=7>OK#8dfH^N0Y;2ON5U>E5GM-I(&-+X\8aV-Ve7/8Y5JK-FBF:
48>dcCNM1-W(#S6L&MeCcILF\CFg2M)VD(QS_&;NGe&<Y#cP)9(O&G+8UP]e^<8X
M@#,)A&9S))L#Wf>,gG@fV[DD962D&V?D,g(GHTagS>Vg^B,7Ja0;NBCG[K2=6D=
&<)CSQK;-bdX4Zc>>IQ6)0+RGJ8_O=HG7NK-UAFV/8@/RBK(+4\&4e/&7a2UR^1f
PD.2V:>/cM77ccF>/31]90JaU0g71JZeK9ATH-C;Q&N5<)SFeY8MC99)[d6;=\ST
,X=K0f>b_BLY\a^[M6d+@Wfc_[1bLRDVbR>bKfb2AA8>d8#E@7K7/LEC#X^G1dN(
HRJ7YGa((KPJd/fK]9)CEa9^Qa_YIc,aJ5YVC?fPP.>U..0[Ga^d]<FGHQeJ50g>
V1:JTC1X-]db.P1LbZ=BR=E^O=JU:.eI,-IW1C>X;H-.+,fSPPX2D41I3.E8XMMH
Y(CC6H9[7)ID-9O3,:DJEIB9@,?.>K8/<8X:F(0G6@:Vb)(cEMMAaZ0.4S[_;aV)
\Ced/-Y8aKTLe)I8+=LCd]b;,H#FT)Q@cbFM.IMOO/6+#H2-Qb,),1>EZ#N\a4:E
S^FHREUIId373S]7>IN-G6Keg5\:(d4S=QZ.VG;:bb=S+;J0D)IPNJ3Ef0_,OUOU
N-AMJe6.7ASe)eBcJ3\2<)Seg.G-bPIJ0FbP:B1HS\)GS;LKX](]>C3/_[3H\f@9
FH8;0Q/dJ@b9E:A<Q-:e?XbcZcTK#M7<5L5[UX)G9g,I14dZ0D-:7+@0TV)[JVON
&8Z-)gTVIcQd7D@Y5bQ=2b?^>R=X3^=.(S@eROPI/=bRISZaUMJ.4@9PQ4<eJdZb
7Q(Gg]]9Y>7FPBK&-dJQ:C.M?.a\UUfZ6aJCRf4T0X+(<#A2,(>dR5gg]G.Aa2:]
;@3F&F@P3Q<<WS:fGLV_TFZ41GIAPI,60,<B-OBJ?QgRDN&A>CF3HMBV1[>Ee1C5
YKJf8F<J,QX(7PeD,+5<MEYeKg.Q#IM,<Q@g#B+FKLSB8<:)H^V38e;dUP>3-HBP
eI1SF(M5GXJ[M84LDQ)OY[A_JR-ZZERUM1QJIKc:eZ^b^-IZ.TU/MG?XZTKL><9P
>K2(D1419aX9eS?^9)\[NabPNSE1@TBa7AU+^,0aDVTZ7cN:B\^O&G7E9-[/f@0#
WT_?Kb@_d;8PGPN4-6FEf,+M)T;cQNIc-cdB/+B(SUD7(-cf,0-L>BX9AB>0>ML4
bX/1^UdYGI&<G\bML6dU#2\U\].U)1R3VJ5Z#bQ-[Q__+NIVR7<)N;,;B:FP[@(;
[QU^SV\FC0GN)_WW5C+;2N(Z64UU@OM45=DC?#T\#NV0H+\H73DK)DcZ2ge&cG=5
:HHJdcKPAN=/d4+#,ZWeF3GAH1eHK(:g-.?W^)40&OS?4X:;8/PD_fIOL>Ldc/_:
GU)GSFG&@Z#5UP5<BHFbN)-J3OBdEDPX>aG[,H(6PAJB/&((N;OUV2&ALEX90Y(2
FTOP+6&6VZ2Q4;:#5Ca9KbCJK)?fXS871,.76:^\g(K:&-Vc:d2g^_11<(7O4WY@
KegSGDNd6W2A4MaMZeDF,39AdE>B1A<0e]FaLbG&0<ZE_SRH<+<JUK7\Y;<<J7f-
>=(_R^V\(XBK9WaXPS02V,3La)\@Z<e+M&(]O=BXWFYGN527fL+fEQ3)>;JYA5TD
F3dTe7_]G78\NZQ467CP^7V4gTPDF1SQb5e3LOf(2)+=N&G/L8FF>NL+67I5.A\L
f58d;CT@<QaF)<Je3=ac2SY6K0#K-FRGL0#&=a0;<QfH3b-N]<M-Ne./<_E=58?V
7d?F/56C2,+bKJK#/b3L:eD5(6,BKfT+HLM6L<I?(.EECfI?:\(R<JLe1F^1.4W)
SY1gVR>+bZSQQC@.:&6&2=gW/Y?7LH6gA7>;V\a<E@-Y#GZNQ1T_VA2cM726f/3>
gceQ7\YE=.=?A,:)J5E_7B&<Y53@:_CeVC]RDT_GcS]#2,Mg[KR+/TMfY@-Ng5+4
U06<<_#H->6N:01YcedD5P7gQ,E>0U<B[1O3N(:BQE+Q^5<MC^S:JNG>N;Dc6,Q6
>>^L5Z2\:N>Zbee6(.fa6L,MIYGHP&?PCac)YZKb.A@YTBJNW[,4I:(J@[-X9KD_
.3f^D;#(X:-+_&#TY<#eKN98QTcC41XUH//eS><\++T?E6Sba-Pb6ZG\++_S:.bJ
U6H&+7S>XI,dWWT?XD&G+.^>]RKY2GU\W(,O/+UHdE(?4NLY@Z,E#?7LHA1M>/.[
4efVT,R[WeAZXZgZSB^c5RHH8fcIN16gHCbY?I(WN0KQ4F#Z;]X,ZBZ-g(=&g=H;
;.[L@S?:KB>H[U?2Z_e65V@SJJU\J2C#V<^FXA#fS;^7WFS=<?IYTAS\b]7T#^+U
bI0-<7&WBJ>K.8,XMAbIP@KYLRR<C76U^U+/3UE)&g:?W22M-3gN,PGE94=Q[T)8
8?AANYT[4@LUV9XIH(5-/c.:W>J,X+a2D-@H,U7E0Pg+)]SP)XV,>N5ZWM#R=&J7
V82e>E6Pg#I\5e4AYI]^5.WO_;&J5@KVT^KBcbRF;e&PL]<,\Q4DZ^9ADQ9)013K
<.M:g_H.A2UedL8F8b<P<EgCKfXD-298R+2LBc-B+G;_ZS>gGdMK/>4^3>fK>8F_
Eb;(WRNSWD>BL9?G2.<Wb+aO#bS]a>gLcUP4?.AEg]31V]bUQ?GB)N.=#[^<(YDW
O_VSSRIbNEZXGd[JWPEZD])_bU,M/+38_g)QR3:3-Aa#Z\13KV2=8<[Rg+N&L(0O
T[;O2ZZYP0)99:@G1aae^KT,&#ALO3dM5IMOZE3&]aIYU[38,efO@cPG?ODX0g_A
?DRNY]6?JY\H9E/f#\99@0QN\6:N7TTUWe\;,AY<g2QcJ:(1^PFBc.^+b/3=M;22
:+O)1I[g5df_>\aG&CY7/E0(XTc]8f=^-bJ[cCE#XQ?LZBdSGFH_T.;E>\e5LQVS
:-,)A+2/fPCX3\.CLP4Q=MPSFP9d4b4ZdS7bV#>V2a6I86/7GF1Ee(OEEQ2Ca0>R
ZGVA\;DI6&8?PP[CZ[f/<).-<#\=EOEa94@.AFD<ELB&_-eIbA)SWeI7J^,AGARU
YdQea,:_E^::^]aJ9\<,DJER4DITLBDZIg?KTZ-H/e2feP#<TTI2Zc=]cF+/=YB(
8I.=eM?6S]9Ja9AH;:Vd\^]S_]CeKYC[8(3SROXWeEK0:=P\US=F4A.0&B6#>TS9
\&5]dHaAReBVBfLc3aGWE##1A8N7@fIO2\[X6]<\96&>G&Yd595\b2B=Qcd;2N.T
/\MX2D^RTPPFDL#YNLEg^^3B5H4J?D&/f0FWV77UbKH=5Xa=QG2e2)9ZED7:NY;7
LM;M4=+)Re,RZ45bDdG<T7)X7MM-WbRGCV[+OH2,,cWUY8^T@>gHPLWBaAgYR@W8
]O-=MMNN&9^aP4C=P&37=?VEEZg-T>0KFGYT2+CXLaNW:YS&SCKYFcdNVR#X<&3E
gR5&HcQc:,+G&Pc7cUXQ72UKVgMcgW=3bWA7I/Z]X<DXJSUfY1YBIWP3HXUHSU#B
J.+?dO6T\YeW0+de[GQEZ?-_U(]RH+3B#T@P&F]^IfG=L)&11RDLNQ^gYNc60-#(
LUPT/JP&:3;8?.Le@f-S=F/O46.&B.0]QNB9N=P(e+FJ^?-,TB:NQ,ZT5#W[)Ze?
@\29AbFYS:A>E1]G]NE3-b;Z>G^_Da\IOH08VS>3RX(-K:);Ig4A>a-TKJ[;_eM+
B3\X,H.bA4Za:#]7_;?ODHFMf2ZW7J+W2RLL#_RW9KA1/ZMec05@0>C#aTHb78D@
gCNg#K)=,K3]\[V@3&bG<;7DY>e35_F;KC[egQ.O+ABFEZ.GS8a-f[1Ta@5He&XT
<-?+GFO<MaQB?U<Pd)_f&Gb>_ICB6.B<9,HP5G.e-L:Z=?cD-D7DEEGL7J_.P7_9
d_eZSI9P;FG?@HG(V74NKFfRT=C.MPf8^XAB7,EfAE\NZ+>O5Z8C#5N76B,X29>S
Hd/[cIKO@\EM3F:SPGT2RJ9eNEPY;&L@96\X\(9=Tg#9dIT&Y],.d?[daUG=F3O\
JOVIHdb.N9],Dd3N>DGE#V)P,VE/AI=\Z6[FF\;?HPW@YS0(1FIcD]3O#@,3egb(
7RS/=+?Lf@a^&@(GQd-CTY;>SQN0:@2=Z\1;6B=K[K+HHEZW4UaAf7X#eSV#JdPD
ER1YBQFZD75gY;0H6.=&.A;X]1T1/YdM1O9#?5L/=ce?U<eYR_F)EeW9dOKGaSg[
YgGN=QA&(B:L?80DS.LUIg8&FO?CRDDa5B=7C9+L@62>dIU&;-\db>5O-.,[G2.]
U\Xg&.BfW(6V2>MLSFY.D8[=efN;f0)>OBQF11;[1=BIIRDB5W6Z#@V2S8W&FLgV
.+gJ-Y:D]b([Qd8T?dD(07@Y7.S8@&PGgbE@/S05F:9VS:<>\.)A:b=E_VZCg-ZB
(QWTLHX);&cUg\g4?[1?>QTFR-1>6SdfP3M(d>9Q^?.cbDO2f76U=/4,\M+LbEA&
1)6R4MLFXL#M\7LH-[-J>bRKUD=,9Z)N6IHU,19K<Z75K;X/Qb58@PDWcZ2Pg;F0
7g-^=D/07&WX84d(RcOZbd&I]TLGdFL.XT4eB#1R[XIZ5;4LG410FULBP\E6F>;9
7WT=&3N[AOKA-5/C?fDO15\)e1TOAcG/b2>F(HIb=XW_DZ>U5U8U&Z<\TKY+J76)
VL.OI?7Y=1PGOHX&HOAVgW_FXM&c0C0S?OHV&:eZOBacK)H]+8:9MC<^5AHbTFKe
[Fb]BEb(.OEd0)X4#RP=fJ,+PGDVJ;WGc.X@dH#R#WM7^B1O:WS:_fHc/d7[]<]S
V=<O0FM0LR5>N;M=ffNg,:E]3O(#8OUG7/8#aYOCYMP6@0(8-N6F/N7,1a+D2:4[
FIIG4&R:c6G4,cIcY#4FJ3^#cg6eIZ32I/YgeLYT&f52bXeH0NfF1,->6@G^RQ#T
6@fB:C+ELg_#UR6f945:@PV84U/Cd3^H\FWX99/^)6.J[Wge?OMREIO5:29I5Y9@
E:;4V;e#RF]#@Sb.4=4F^dT.L>U;0NHW4;KbMI&2b.F?U9[_S-][-5G2M5Y_bG..
^S0EV>W0(<.NG26@:2I&.a?XLSQOSSff#84(cRDBQ)W=^-].cHXU=MbfHLb24)B:
TL-Y3N:EdT,7IZ&&AKEPP9)e\I4dcT+g+[>8<\KDJUL_]>01efWX538-d<Sd:+b8
S7bYX433KX&LSTNKLE^5?9/>AGWW7/_5U_-]g.C]E\L#LEEGd>e\H2S8VgOBVZ3e
=gWb=[7HRb^eZJ6KXc.SB,,0^Q?TDZAAV+C5<&H8]@-=^_a&CMX_JVO/LO6WPb\D
83,fa1e?>?OW#L3dD+:c[R,7\GWK)W[WA0Ydg,e>)\ZTJNP1H6dR)^#:&^/>:2T2
AE6^XdNTO)0MU=P/Q>.gZX1c\e(,04_JGH_<.MOe;PA<=-,,<UK+18fD-K@@FU3X
E-CGR2QR42XTV+fYDc].86(M7Y(WQPA\\I/L5LM<0ES=.JXMHVcQV@f0bAD=O][N
61ONGK+CFA)V196C=b4.2bQD#-#\1Y6VI>-3-H71>XIc)/V+S101=A7>S@A&H9cV
bHdWXDM;(AbYM+D=<4cGL2)PE:K5R;\+f=?F5<;H<_#RB6\&UP5,c9M4Ra\DD7<b
DW[RQ)&1E.Tb0.aA4U+\/DKDR#UQ0)4=-E<6VT1JGGT;GDK[HXZR<EN06SN[S0PS
eYD2_(F2H#gP<BQ.ag=<<QS88dd^?<b.ZQb]5+MDZVc3D>fYKS9(PWD[3D8[5f&9
f\#^e9cM10E.^PS9:.NKGc_I/+UK>[c,Bce^8&TC^L@XE0b6PQ_K8AJ,?9^dXO7E
7Ted-^1AW?.b.[bR.(B_;6Z:AB[D0-[XgMOW>)QQU7#MGQc\P6b9aR\VZ(T?d_gG
eV-G3E1Sa\ba4(e0Ge/#:)MY<<PNWHcP+9fU5HV)1Pca=cN[=YeCG9B<RM#DEA(E
aB5B[Q41bMUT@R4#>G9,4RfBET-,]RH#XT<L3=)c(K&X84O_65BPEU9N+6Q2A9a_
JCN27Ne+8a8cR.Zed>189S@HEUfP>?=fLE-X:.+/aKF^/77Q>/\7[dA0]0+8&?E^
f[5cg]>D:EQEf<\Q6N;5a46bG_0ZI#d4-C:20_]]\H]S<PT9?@1=+SPJW;^]0[.>
eb7Lg/(&f7Yf;0f56WZDHT^f<2+^8g28&;#_<=0FVG=.WV+NOB6.1G+WAPQM\/2K
XN,_VbgX[:^6W&/8F\MW)F>E_#R7JVgK<K]L[KLNMA@fc;9\4J,f)b0Z@]DE<>J2
)1BHWC#:-K^\R:K](=U-U3gBSZ<<ZA_X;cSW_]AK=GLO1ZL&aV#1cC0BRJ(4g=Nc
;2T@,K[;F4gZ?0S+eRP-g2G==.+]^\^O;5G+=X2GR<B7gc>[4NWQD.Lc?O?NLYg6
(<UQ<,Y;K,9Z].g5dW\dV(HM?XJX[>BSSM4?W2D&/1>aW.faMd8)37^85<IFC);^
G:LJZa2TOO7EMQ8UF0GPMGge:3aUCZ1Ud,9GJFV@M=9]X=ddTEb/Y8g&L)4#>(ZG
b-XaZ.\e/.S,T8KQ+9gLB)\@+M33)>&(;Z1R]c&U)Q=^3@,B\#c(),42)//7\:0,
>^0ZC=W/7[,HR,43]?b+[>A\NR)Ve2S)?A)bF4e,3V4^=CD-ZL.6eL4U+GEDKSJU
eI8&B/Y@+++I66F&fX,C=fVP?5[>fXTDRb-1I+1AFO>=G_H]aVa5b?@UJdbUeIHf
).N.f;3Jf>HQ[-^IPQ>ePG]]E=?;c&Ge.E<<KQ^:+978]..A<NUXCMJH94:gEFIf
K_G8NgE92J[Q-$
`endprotected


`endif // GUARD_SVT_XACTOR_BFM_SV
