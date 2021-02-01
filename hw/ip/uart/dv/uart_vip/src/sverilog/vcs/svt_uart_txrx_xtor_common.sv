
`ifndef GUARD_SVT_UART_TXRX_XTOR_COMMON_SV
`define GUARD_SVT_UART_TXRX_XTOR_COMMON_SV

//----------------------------------------------------------------------------

`include "svt_uart_defines.svi"

/** @cond PRIVATE */
/**
 * Defines the uart TXRX XTOR common code, 
 * All the logic required for interacting with XTOR is part of this class.
 * This class calls the C XTOR API and gets responses back from them. 
 */

//SVT_OLD_ZEBU supports older ZeBu model that SVT ENET supported.
//To avoid BC issues and to be on safer side, older implementation is kept intact under this define.
`ifdef ZEBUMODE
 `ifdef SVT_OLD_ZEBU
import "DPI-C" context function void c_post_xact(input byte unsigned array[]);
 `else
import "DPI-C" function chandle svt_uart_toXtor_dpi__get(string hw_inst, chandle platform, int verbosity);
import "DPI-C" context task svt_uart_toXtor_dpi_configure(chandle api,int datawidth,int parity,int stopbit,int baud_divisor);
import "DPI-C" context task svt_uart_toXtor_dpi_send(chandle api,int length,byte unsigned array[]);
import "DPI-C" context task svt_uart_toXtor_dpi_receive(chandle api);
 `endif
`endif

class svt_uart_txrx_xtor_common extends svt_uart_txrx_common;
  typedef virtual svt_uart_if uart_IF;
  int rx_packet_id;
  int verbosity;
  byte unsigned packet_zebu [];
  svt_uart_monitor monitor;
  svt_uart_transaction packet_received;

`ifdef ZEBU_MAC_PACKET
  //This include has all the logic needed to generate a ENET packet.
  //All includes are part of ENET BFM Verilog core,
  `include "svt_zebu_packetcreator.svi"
`endif // ZEBU_MAC_PACKET

`ifdef ZEBUMODE
 `ifdef SVT_OLD_ZEBU
  static bit svt_uart_xactor_creq=0;
  static bit svt_uart_xactor_available=0;
  uvm_packer packer;
  
  static function void sv_set_svt_uart_xactor_creq();
    svt_uart_xactor_available=0;
    svt_uart_xactor_creq=1;
  endfunction
  
  static function void sv_reset_svt_uart_xactor_creq();
    svt_uart_xactor_available=0;
    svt_uart_xactor_creq=0;
  endfunction
  
  static task sv_wait_svt_uart_xactor_available();
    wait(svt_uart_xactor_available==1);
    svt_uart_xactor_available=0;
  endtask
  
  function void send_svt_uart_xactor(svt_uart_transaction trans);
  `ifdef ZEBU_MAC_PACKET
    c_post_xact(packet_zebu);
  `else
    byte unsigned bytes[];
    if(packer==null) begin
      packer=new;
      packer.use_metadata=1;
    end
    trans.pack_bytes(bytes, packer);
    c_post_xact(bytes);
  `endif  
    svt_uart_xactor_available=1;
  endfunction

  task wait_svt_uart_xactor_creq_asserted();
    wait(svt_uart_xactor_creq==1);
  endtask
  
  task wait_svt_uart_xactor_creq_deasserted();
    wait(svt_uart_xactor_creq==0);
  endtask
 `endif
`endif // ZEBUMODE

  /** Reference to the software xtor C API */
  protected chandle m_xtor;
  static svt_uart_txrx_xtor_common m_map_by_chandle[chandle];

  // ****************************************************************************
  // Properties
  // ****************************************************************************
  /* ---------------------------------------------------------------------------- */
`ifdef SVT_UVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new svt_uart_txrx_xtor_common instance.
   *
   * @param uart_if Interface that is used to communicate with the uart model.
   * @param comp Object used for message and other access.
   */
  extern function new(uart_IF uart_if, uvm_component comp, svt_uart_configuration cfg);
`elsif SVT_OVM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new svt_uart_txrx_xtor_common instance.
   *
   * @param uart_if Interface that is used to communicate with the uart model.
   * @param comp Object used for message and other access.
   */
  extern function new(uart_IF uart_if, svt_xactor xactor, svt_uart_configuration cfg);
`else
  /**
   * CONSTUCTOR: Create a new svt_uart_txrx_xtor_common instance.
   *
   * @param uart_if Interface that is used to communicate with the uart model.
   * @param xactor Object used for message and other access.
   */
  extern function new(uart_IF uart_if, svt_xactor xactor, svt_uart_configuration cfg);
`endif

  // ****************************************************************************
  // Configuration Methods
  // ****************************************************************************
  /** These tasks are not needed for XTOR implementation, so have been kept empty. */
//  task drive_mdio_phy_add(bit[4:0] tr_mdio_phy_add); endtask
//  task drive_mdio_device_type(bit[4:0] tr_mdio_device_type); endtask
//  task drive_macsec_attributes(bit [63:0] tr_macsec_secure_channel_identifier); endtask
//  task process_internal_message(ref bit is_valid); is_valid = 0;  endtask
//  task set_verbosity(ref bit is_valid, input int verbosity); endtask
//  task drive_link_transaction_err(svt_uart_link_transaction_exception_list exception_list); endtask
//  task drive_link_transaction_cfg(svt_uart_link_transaction link_trans); endtask
//  task drive_xxvsbi_lsbi_align_marker_err(svt_uart_xxvsbi_lsbi_align_marker_transaction_exception_list align_marker_exception_list); endtask
//  task drive_xxvsbi_lsbi_rs_fec_encoded_err(svt_uart_xxvsbi_lsbi_rs_fec_encoder_transaction_exception_list encoded_exception_list); endtask
//  task drive_xxvsbi_lsbi_transcode_err(svt_uart_xxvsbi_lsbi_transcode_transaction_exception_list transcode_exception_list); endtask
//  task drive_400g_pcs_align_marker_err(svt_uart_400g_pcs_align_marker_transaction_exception_list align_marker_exception_list); endtask
//  task drive_400g_pcs_rs_fec_encoded_err(svt_uart_400g_pcs_rs_fec_encoder_transaction_exception_list encoded_exception_list); endtask
//  task drive_400g_pcs_transcode_err(svt_uart_400g_pcs_transcode_transaction_exception_list transcode_exception_list); endtask
//  task drive_align_marker_err(svt_uart_align_marker_transaction_exception_list align_marker_exception_list); endtask
//  task drive_baser_66b_err(svt_uart_baser_66b_transaction_exception_list baser_66b_exception_list); endtask
//  task drive_fec_err(svt_uart_fec_transaction_exception_list fec_exception_list); endtask
//  task drive_rs_fec_align_marker_err(svt_uart_rs_fec_align_marker_transaction_exception_list rs_fec_am_exception_list); endtask
//  task drive_rs_fec_transcode_err(svt_uart_rs_fec_transcode_transaction_exception_list rs_fec_transcode_exception_list); endtask
//  task drive_rs_fec_encoder_err(svt_uart_rs_fec_encoder_transaction_exception_list rs_fec_encoder_exception_list); endtask
//  task drive_basex_err(svt_uart_basex_transaction_exception_list basex_exception_list);   endtask
//  task get_interface_for_do_cfg();   endtask
//  task put_interface_for_do_cfg();   endtask
//  task drive_to_dut(input svt_uart_transaction trans); endtask
//  task drive_do_cfg(input svt_uart_transaction trans); endtask
//  task drive_ad_trans(input svt_uart_transaction xact);endtask
//  task drive_do_err(svt_uart_transaction_exception_list exception_list);endtask
//  task drive_do_err_stack(svt_uart_transaction_exception_list exception_list);endtask
//  task drive_do_cmd(input svt_uart_transaction  trans); 
//    super.drive_do_cmd (trans); 
//  endtask
//  task drive_do_pkt(input svt_uart_transaction trans);endtask
//  task drive_link_fault_sequence(input `SNPS_ETH_TRANS  trans);endtask
//  task wait_for_link_up();endtask
//  task reconfigure_via_task(ref svt_configuration cfg); endtask
//  task wait_for_reset(); endtask
//  //They are part of svt_uart_xgmii_bfm.v; Do not remove commented code
//  //task do_cmd();endtask
//  //task do_cfg();endtask
//  //task do_err();endtask
//  //task do_pkt();endtask
//
//  /** Can be used to configure signals in Common class. */
  extern task configure();

  /** 
   * Calls XTOR Service loop; This Service loop checks whether
   * and packet is available , if it is then it calls a 
   * functor part of C wrapper file.
   */
  extern task try_receive_frame();

  /** 
   * Whenever Driver receives a packet from sequence, it calls this task. 
   * This task prepares a packet and sends the same to C Wrapper via DPI.  
   */
  extern task send_xact(`SVT_TRANSACTION_TYPE xact, string xact_type_name);

  /**
   * Whenever service loop in C wrapper is called, service loop process RX Buffer and 
   * calls C functor. While processing, if there is a packet in RX Buffer it sets Pending bit(argument of functor) to 1.
   * Pending bit indicates there is a packet available in RX Buffer. On seeing pending bit set to 1,
   * C functor calls receive function passing packet content to SV side. 
   */
  extern function void receive(byte data);

  /** Sets Monitor instance. */
  extern function void set_monitor(svt_uart_monitor monitor);
endclass: svt_uart_txrx_xtor_common
`protected
3XB]7QA+bC/MB#07dK1B91R+T9M;OGeY]O7.LW1bJ/@EY,2.DZXG+)\7HB@@U\H)
-HI/[g7SIYc)KM;3-1[:^#P(E^_C4cJSVF51\<c172>_TAN9>PeC:TR>HA#NWN6?
/.+3e7)eFR>CEB7[Z_12eQG;E+HDNRM[=)CWffF][V.WR>9/fSSUC#baa^D]W__Z
_CTT4)E4O2T5ND>^MVH#4ff:,+;fg2#2E&[34@U#((PK+f\S/W<E:A7UY7IK(K,0
=#JKS3_[WFcFbVNH+<C7L+,V_X_2/ZN&Ha.N39Rc8Y7^cZMQ-;Y1SXB]NYFgHfP/
3FS]R:-^Y&b(6MY.LG;9L^O@Q3M@4M57dH6492^/3A3OUf;B&CO^<\KRaN=8Zf##
)&(RBX9H1B)#PN;@LMffSY6F<ZcX3b-;Z0OZf-Dda9&G4(5O5:7:B#1E4[JHE3S\
BP&8+\[FIe;J\==(6\a/7U,8PXaZegT,H(R#@4#c&.B)6=@:G3@V]_NMAHfUGA@V
T_3??+IWB<DB:;S8#NZ2]MF;A2Z@a74X>_XJ99D4>P90KQg>g1FEHKCJ8AOZ,G)e
D;88S3Q+27(\aKedbXY[G@(#Nf[?.#9[T1-eT9(B.71-E@V\)1,YONBMLe45[(+5
U09Y^_dbbHa#f71A@0OBQM8Y^&>C))eJ>2ccC.MUE^//6HSWZAHVdD(-,]XY_6KH
b8LW=K0?DAZ/ALd4/ULP/Pd_<6N9fb8QUbVbf.E<A(=0+G+fF]_BL[/9\e>e8H61
_-e/KR8]RcAUTY6+R:\R.Z(>9:I8I>W@M\_^XK_IdUX0@8_:>0Rd959dO4+9XGI6
9MBT5(+(M<=JfU@9C5Q.e7Y+1]E->>3[AP2SQb7G8PG6XZQ(W/-48SC,3(MV#<M7
<>GP1e.:B/;a]ca^B4-/3#=36:;6G@/V9KG8&_PQ\6L]XJ89P[Ce@&F->+75U+D_
3>RD628IfYMV[dY2]^gL2AJTUPQ)<T_<AH_JE&15FL>X=;?DEIUQ+O<83.]#3c8>
2<1=TQTg6VN:UYS@e]?bPW-^/Ec8I4\)U3f?)+((8bCWU>-gS,IE2U?PZ^d29\3]
NLP:,BR/VYO0Z[1F^gFFRS^DK9L?MBeB^(+HC^5E1V4LbGSO]C&(8.P<aSd?K+F)
3Ld4B4QcC?T?_N7f&I0gW50V0b)3D4A^OW7/OM4<5(5DQ+H7Y&B?J<P^4b2@,-eb
+ZR0=EaN0:+O2=7?83JYFX?_UbB2>ZX:Id8B>Z7R4@;XB@\E?:C7-IS(K(Dcc@ZJ
5Rf<R;d-?-YVEf4FA^Z]4_^F3O-+DE1[3?MDI6L9LKcPdeXKC8gJ.F>ZV[=,+>gI
5I^ReS<UG?7TY)2@.[7J_JMDdB_HCfdWX7^Q]cfBVCHCMdVMOZdKP+dg.=cbSB3(
?TKTAW-),OP+?R4.)<5)I(,(K-a:,J-Fe,<&Zg^1K,3a>?VZ;QD/RPAR\=?[#gG4
9F#))Z\F]G&9_AJVcNQ>A_e@@@79U.NQ;TLX1FDM/.P.@AA74))2#WXea.ZV&Z4=
17PQ:JH9J6[YID_\,fIKH=MOae0?RIVI8Y-;a&HNf-6G::SA>O3>XdM+V379;<OJ
cO[1eb[XC&\cVY:])L(U;0,c8_BICV/)/Y<a/.OHcU_KBI\@D033WS8]F\baX_G=
bEd64,d#2.4MT(C][aBWXTMPJg_UdO/(eDI+Q7?Sf-\JcJX0V=8:d[Ud/@EgBZD/
g4)Fb)PIWTb_94U?VB;b?FPI/3J?ff:.^2^H8E\-)X5PTD9I-,G&+PRX8I,=>0>a
@4&);524ZJ[E3M@_SJ/0f>EeEKd7HC(Id#)\&gV_^,GaFdWD\YS,ABD(#K<PQ(9Y
/,5QVHB5,Y#>+)f(U?f,/GG4EW<:_Q-\]cB?[<;,BM8)>UVE7R_16<3LN8:I7T.;
/GWGQ7?e:;HId270+&)2Nf<DACD&J#.IL1]D0_Ie?S.edXPD\,N=d99a^FFHTbL5
a170UP^Mf;J#6BfD0=I+>b)a@GG_4:;R-D?M<Q^:Y/1@09\fd]_VGV<@9M=:T<01
&#UHV<g2O@EAHY6C.-U?1eO&2b6RSWM=9&+bbYBIdb/;ObdJHH?C+7\[P^WC3]T9
Rb\W@U@QbTM3dB8,LF@cf>\;#UZ)6PC,W6\)(([T&(R>25U;/M;GD)HPaA2Vd+I;
,)Dd(A-BI:.>O[CcbfQ[ZYMcdB117fGc[fCT4&Zfc=(d23[GQa;1U&PGP<,2#4V^
\?TI&?E,5c8e)B7<gcK68c0G\;?8gGWH(\1J>86VgQKf&G]:P7T.SMX&.OIEA7&]
HBUA>FVOM=@;RV>)/>K;:WgCLJD2>HLV[]PZI@JNFGAI=8JEX;OCSYOc,;>IV(b+
gUWC?W)K#:SIMW<H1-O[N<[,7?F[^G)RK]I:#):<C4:Df=T>D@=L#-MI+>VNC[3_
)U>CeF\62O4JA_eT1(J);RF>5:R.<bU#EHD-IfaVW:VGFC8+Ye=P#1W:=V=31Lcb
aM2NdEQ2aQ7,D4DOaT/I=2ZV@@PNfTM+N)]+bd0SS0RT-AH9J+fEN)6Nc5<-;_ZQ
W7Yf/1C?QJ+P)7Q4Kg14Y5&=aV,=\-)=>a2Kb(Q;_[YQSeg]8UO/GOHLdge&R@]9
1RS#0CU1SG?+EG2A()dDV1@fcY]Cg/HBH?N?-H-195bQ3ENSD]F=APN&G\57KNPO
1gAe(J>JKcc&8UcQJQFT7QNU\_T:[O:ZgDCPc46TgWO/4?YZ2K7;VJ.XDa?BfeH5
2;\P]UJO?N[A)ODb@,Z9X(=7(K.-#Y#(TR<CFTEZf>U)/:5bf:FDF0-Q2AZHW&IV
RK<7/Z;dP;IS;@9K^_0OL+e=#W6U>&P/AW#9FO1>6EN#e.^7R(eE<aJMQB?P<A&(
[H:^7+4bC48P)?a]S<26.,3dbe+K2::X@U@a8OC8fcR>NY)1aBA:C=(0P=GYG1Q:
?+6CG+R_RgL=4VHCf,:fdM@I_H)BKLKd-40G3WX/e-d+9WY14ZBcU[VJUa<3=:+(
XM?=,/;AQCf].91[bMHbN.EXCG)G/;GGQ>e++2.O7N81Y-R+S2fgT;P/,K(CBD+6
SXQZV9]RfcdDSM6<P;=#MG1F2Fg<:?_8NW?]Z8>?3a;HK3;c7B@?3.J4KQ:[;]0R
+&XLde4KMHgCZ^KZL-(e^A\4Scf(WFUf<:K:f)@MD&[]3R7cM>3-_fIU284X6+a-
8,GJJV0V<TIV3b-9Z+QU26J)3KMU,QL/7_RAWM@KLVd]aI+1Y^9GB2+D<ZKKbN4M
?8dT40TI-<>S0T5UNZ9==USf5OFBCV_=MH8b;A3B-5#-Q+]_4O9+?E4-//.)XfY<
3Pa8D;^3-2I(XFCKO.</4,+YP,2F)Za5gaS)?V4e4]9dWEV[?VF-CLEY<V83WP]Z
f.B;TWGO>NbOLP<;O6/]WQ.Id6e\IR39OPUOMU00<[B(_EMc@RT_P3BUe\?C[V5W
>=GA(]NPR4JK8:_I-T9]PC\N=6NR5S>>0+E<45SH+fT=cM7]_@,96TN7/X^a6+9P
\?1)R]2I7Q7\F7If:](J.ObeR5[WP--bHNG+9PU.O+NA3TeTU)6LJ1V)615:b_P0
:\)=]BIR?1dV_7Q=AT(PXXM^F+FG=e)Xa4IL7B7>BMeJ,#@(EDKCSg18:?98VFLE
906/e6<FHMK?DX3bSW5eHBGf;_36DY>6gYNWC71-DMHF:fO4#9SZ]?93?Jf(0<JY
^_Ab)B=UCReZOLT=c=N4[&6OT+0_VXNF=OOBR9^12.)GfceXSKEYfXC[G75PeSQf
Rd<JgT3:4gK)TY=\M)cbdK&[412=50J=S;e&=E7I4(eB3:b7^)VA.8#8ETF[2(I)
)TeR,5(7YY,HePB\;NB+C_6\8-+WYeS1dCedW1f\Z7<04/:)@_YO2+dK8T@37WO2
V<FF)?-,+]VAJU([=@^_,KdB(HT0c9>F?cB8XQFe^2WfICNT8EcP:5\KJ(+D-af)
2Oe]:=5geL+O:[Q_U]7a>YKJWZZM=Z>.I_CcG69>_YCPK\(M=X(_XX-PYJT_Oa+f
dGRb4HV,J?aHQ2P\B<6Hb;0JCE&[UR/TM]XBA-C2X+BLf^-/Q+2,_NP,MI<<\V<I
Z(WeZd6_VQ_-KWa2M.a]B>I]=86G8)-DKf^PS=EdC&Y1OOegdGS0:UdPf]&MH^EU
c7+g)T;\^eC=T.W\Cd-SVSE[ER;PCN<CV;I:F8IDL)49(U3a5.]Q#K:S<K)\X#E=
<fB-2LfDT)L-=J#Tf8(_Wg]-)_K]]0g#H6BH>K)CL<C(#J7UUUMF#^:SL$
`endprotected


class svt_uart_xtor_common_factory extends svt_uart_txrx_common_factory;
  virtual function svt_uart_txrx_common do_create(virtual svt_uart_if arg1,
                                                         uvm_component arg2, 
                                                         svt_uart_configuration arg3); 
    svt_uart_txrx_xtor_common obj = new(arg1, arg2, arg3);
    return obj;
  endfunction

  local static function bit static_initialization();
    svt_uart_xtor_common_factory f = new;
    register("svt_uart_txrx_xtor_common", f);
    return 1;
  endfunction
  local static bit m_static_initializer = static_initialization();
endclass

// =============================================================================
`endif // GUARD_SVT_uart_TXRX_XTOR_COMMON_SV

