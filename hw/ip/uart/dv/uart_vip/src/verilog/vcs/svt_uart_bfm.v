`ifdef SVT_UART_VERILOG_TECHNOLOGY
`ifdef INCA
`else
(*RTIME_UDF_LIST_VmtModelManager=`SVT_SOURCE_QUOTE_DESIGNWARE_HOME(vip/common/latest/C/lib/${VERA_PLATFORM}/VipCommonNtb.dl)*)
`endif
`endif

//---------------------------------------------------------------------
//  Include .h files
//--------------------------------------------------------------------
`ifdef UV_PROTECT
 `ifndef SVT_UART_VERILOG_TECHNOLOGY
 `include `SVT_SOURCE_MAP_MODEL_MODULE(uart_svt,uart_txrx_svt,latest,svt_uart_bfm_wrapper) 
 `endif
 `include `NVS_UV_LIB_GEN_HP 
 `include `NVS_UV_LIB_BFM_HP 
 `include `NVS_UV_COMMON_DEFINE_HP 
 `include `NVS_UV_BFM_DEFINE_HP 
 `include `NVS_UV_LIC_DEFINE_HP 
`else
 `include `NVS_UV_LIB_GEN_H 
 `include `NVS_UV_LIB_BFM_H 
 `include `NVS_UV_COMMON_DEFINE_H 
 `include `NVS_UV_BFM_DEFINE_H 
 `include `NVS_UV_LIC_DEFINE_H 
`endif // !`ifdef UV_PROTECT

`ifdef UV_VERI_ON_MODEL
 `timescale 1ns/1ps
`endif
//--------------------------------------------------------------------
//  nvs_uv_bfm
//--------------------------------------------------------------------
//Declare Module
module `NVS_UV_BFM (
                    rst,        //Reset
                    clk,        //clock input
                    sin,        // serial input
                    cts,        // clear to send         
                    dsr,        // data set ready                
                    dtr,        // data terminal ready           
                    rts,        // request to send               
                    sout,        // serial output
                    baudout 
                    ); // end module nvs_uv_bfm

  //--------------------------------------------------------------------
  // Reset input pin
  //--------------------------------------------------------------------
  input rst;
  // --------------------------------------------------------------------
  // Clock input pin
  //--------------------------------------------------------------------
  input clk;
  //--------------------------------------------------------------------
  //Serial input pin
  //--------------------------------------------------------------------
  inout sin;
  //--------------------------------------------------------------------
  //Data set ready
  //--------------------------------------------------------------------
  inout dsr;
  //--------------------------------------------------------------------
  //Clear to send
  //--------------------------------------------------------------------
  inout cts;
  //--------------------------------------------------------------------
  //Data terminal ready
  //--------------------------------------------------------------------
  inout dtr;
  //--------------------------------------------------------------------
  //Request to send
  //--------------------------------------------------------------------
  inout rts;
  //--------------------------------------------------------------------
  //Serial output pin
  //--------------------------------------------------------------------
  inout sout;
  //--------------------------------------------------------------------
  //Baudout output pin
  //--------------------------------------------------------------------
  output baudout;
  
  //--------------------------------------------------------------------
  // reg(s) for Output Ports
  //--------------------------------------------------------------------
  //reg          dtr;
  //reg          rts;
  //reg          sout;
  reg    status;
  reg    out_sout ;
  reg    out_sin  ;
  reg    out_rts  ;
  reg    out_dtr  ;
  reg    out_cts  ;
  reg    out_dsr  ;
  reg    resync_occured;
  reg    data_packet_sampled;
  reg    cts_high_before_middle=0;
  reg    cts_high_after_middle=0;
  reg    rx_rts_cts_deassert_after_middle=0;
  event  event_baud_count;
  event  event_start_sampling_cts;
  event  event_cts_high_obsrvd_before_middle_stop_bit;
  event  event_cts_high_obsrvd_after_middle_stop_bit;
  event  event_cts_deassert_at_parity;
  event  event_cts_deassert_at_start;
  event  event_cts_deassert_after_middle;
  event  event_rx_data_start_rcvd;
  event  event_disable_rx_state_machine;
  event  event_disable_tx_state_machine;
  event  event_block_uv_handshake_receiver_1;
  event  event_block_uv_handshake_receiver_2;
  event  event_block_uv_handshake_receiver_3;
  event  event_block_uv_handshake_receiver_4;
  event  event_block_uv_handshake_receiver_5;
  event  event_block_uv_handshake_receiver_6;
  event  event_block_uv_handshake_receiver_7;
  event  event_block_xon_before_buffer_full;
  event  event_block_xoff_remaining_buffer_packets_completed;
  event  event_block_uv_start_detect_1;
  event  event_block_uv_start_detect_2;
  event  event_block_uv_start_detect_3;
  event  event_block_uv_start_detect_4;
  event  event_dtr_high_1;
  event  event_dsr_high_1;
  wire   port_rts  ;
  wire   port_dtr  ;
  wire   port_cts  ;
  wire   port_dsr  ;

  wire   rx_data;
  bit    actual_txn_on_bus=0; 
  bit    xoff_remaining_buffer_packets_completed=0;
  bit    xon_before_buffer_full=0;
  integer    count_rem=0;
//  integer    count_xon_after_xon=0;
  //--------------------------------------------------------------------
  // Include .vih files
  //--------------------------------------------------------------------
  

`ifdef UV_PROTECT
 `include `NVS_UV_COMMON_PARAM_VIHP 
 `include `NVS_UV_LIB_GEN_VIHP 
 `include `NVS_UV_LIB_BFM_VIHP 
 `include `NVS_UV_BFM_GLOBAL_VAR_VIHP
 `ifndef SVT_UART
   `include `NVS_UV_BFM_LIC_VIHP
 `else 
  `include `SVT_SOURCE_MAP_MODEL_MODULE(uart_svt,uart_txrx_svt,latest,svt_uart_bfm_fbrd) 
 `endif
`else  
 `include `NVS_UV_COMMON_PARAM_VIH 
 `include `NVS_UV_LIB_GEN_VIH 
 `include `NVS_UV_LIB_BFM_VIH 
 `include `NVS_UV_BFM_GLOBAL_VAR_VIH
 `ifndef SVT_UART
   `include `NVS_UV_BFM_LIC_VIH
 `else
   `include "svt_uart_bfm_fbrd.sv"
 `endif
`endif  
`include `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_bfm_license)
`protected
W3TD?2-T+LSY#U+3I#M-[KM.#RNd?/_?,487T^S_WD:e7&bX-X_&&)1[ed)@9)Le
0>QZZENdEP_+)IaQC)J&.1cUO(3YJ7364+FROJb_gRQ/OWALK:BJW.9JP=^QN6CE
XEY)c2.cX9A.V(SN5+H_1dAS6;fJ1gV\4I/:]E=8DKF^_eMEYQNIJRBI<7IX9fR>
=18,CX9UH:)&bU08BKOW#8IW<IPB8CB1U:egHXCIKV+0;;<=#/Gf#1[/Yg&=N7c,
K#S/>E#0^[3KBF_f\fgc9Bb(37C/EGP54X5&A4JRAP62NE491/Lf:9G-JFA4d0C=
6W]LC5<\#dZbKNF\H[D+CZ=U&^1&]YNdS#c8aN:[28C>&S8>b;c9DFEQ6a.Q.L^O
.H/^7g-GLL@KKW)V55G,T\c08-6a8Y4/A\?BE-7/S7OJTK)/,[=Z8.SHPPM>f),8
cYM825U.1(:]ae1CQIUVd_C-/V>eN64K1dEP@)QZ7ALACVcW)[EA_GG6RSEJ:_^,
B416U;80GE-@GY/2f76)N?:UW.)],]7F2@X?[NIg5KD3K&-,)g9=VW0O8H?SW8]=
==^907V(V=U\E5@b)=Y30&SQFKb^)FP;DUCI_\RI0(3MeU^6e?9([/K)1Df[OSc^
b0L,PW&J?:f6X/PVI>-4-?&(W8>EA1EB])NCS6Z<???JO\d=AE_b]UEU(^eVdg+@
/>J>Zd^?M0:7AG=_P)>:ZAY?5;4K#99K+DPgX=1#3Yc7SZM]W8IW,?\WcCf<[T9J
O&GebD[N(\6fJC.X@T\X)91-/LI2Y>dKYZ5[H,82VDb<Q(>F(e1eS]EKJ::#E/<6
IS7S77O/QYcJX7CaR&3AbbGWFd3gTg+/eZ0Z41^8&^Z]XG0B;X&UYfNJ<X>0Wa6:
7/,HNSQ;J0<MDdQGCMe2b35TY/9Ne3W05/GfbCK.eN,6>95HT\7CRLKW#,-)IX_c
U;?1[@=&a9QVS.T\>W3G19@4[M[].&a:)e8@4;M-1&^#>[e1]\7&0Ia\BFW>eA(B
e<>cP:\W8M5#eUP98=5c,HR#07;8S(J9:]^_-YP?X7?+SaU(ZXU__>fcDO#&GCME
SAS,ReWbPHRL>(3W#GJERW:&-a@(H^HUZC7[X35JG45=VT1OSgCYI\8)b?<@f@XU
4g:(P.IOZWXV5ME+5(5[OY&[5F/-Q9-MJ+D\aAAQ2WG9daY/Ba:096gB&)(bT3:/
;S[b<bc=R3GSYd>Wd-W<C5\5V+/TBGd^_1EgC(8.N7A#UW+a-YOaa/<N-ZN/,GSS
I7Y[VG04C8Sd9>CF,eNF_0R]#@<g\6[&:NKOS,319DBAXF]d53:;EVY8,3ROBBQ\
gD(B(T6CZeA<D-ZT<<([=IL7P-gDYEeC&d^VG=F+C\1L1YRHXRTL27g.F>=U0U##
/@af]02I89C6\<[UJ<+]#Y9DYUO4X@[=M]-dOdR\Ic__6TX=BWYF#3^S;c0Q8#FS
T0Q>)K<]BYeK8Q[V-KA\SV9NSCb<=e4GDf+S]9F,M>\GY2Z6XZI?JUYL2+Ke-LBa
2IBFA+8)2GU3=/V@be?4aXA8>HW]XWf@&5dOV3>KY^]@^UbO?fFT1##N?H.(fb@#
EP7d-YZf:QP;)CKVDDe1X&]/#Bd<O6T+E09K>FK:b_:,Y5\_GQbY3<W):^WRf(A[
@:YB@/JRA(Te+bFY.2g5L2,L7CBT)RYK99WK6a=N(OZ>(:6UK@V&eWMf&>H59a<(
1(;?;S(,4,;,5V)>:bUIA+VX93Ab_R;]<JX+#HYAFFEf9/ZS(V2e-bU2LeD\._dO
2VCM8I#L)Zf366>aOM1HE/:KbKd^7:)MFZ&7:)AYJOD17U1[Q?\dOD1LGZ9DZX:K
X5&9/PG_Q1DJ#-G)P6.S_0Q+Z;ggE<BO1:E8N[V2B3DS3-V368]^>-5fD;:-=H5f
9<DZg@[]?f9W2M9_S53#K#-cYcVP0P:,XgS^5X8YA6f^Y,D55O8RAb=H.]@dTEP-
E)2[(f?K36=f)4:P678Q-3@fc40SccK#7@B[1P6X;OWVZ6,;9EZW6fZd7fL^=Z_?
NcCdf_13UXaSSfBUF5#5A->HTfYAV7<G:VF/?V_;2c&XBAKCS:2(\eHU1VX5YUA9
gDWe.<[QWL]5U@OB=eG:Q80g=7g0/fYP&^>8P2MGEf;H,8=;=f:E(;(0#[R@]BE<
f<20])MC?/C@V-D6\/K];O#S-;cUKYV,T_ZJ5[)WR?V;YcQ^O.feHe@/7P1MVKBN
a@SPfa&fe?=:(VVS]OJGPXP_ZM3a-,CDGV?155LL+EE<)cP<V0<+C=GOb[_:c1YH
9WSE,+31<5+U[PY.gO>c=^[\/8E5Oc6#X\C=]&YJP(e)C-7\=3<WZdbAR>+IP.Yb
REI+NaP98^[S<Ee/[99bF\ETIbM[WPbMTb\JI0>2CKU7/\<Q6K;<41&3C+G1D,J1
WIRR?K#@@ZO2Ld-.R5N+WLR>fLde;-O4ZeP40C;K?H78+f76:Z9R]KZR.#<BU-Z5
00HC8>>UH;g:bHBU1-QNX?S>_99)6[fFMg->GTIN6gM17O7XU#[<:@6c1H]gDRZB
5-^]QEc4LK<9_bJLM4P1[BTBRVVaL4/]<e/=-A[+d>SaQ<=22,DL7>7YW/]cC-4>
XAW_Z_O:b(=\_2?]#g\;,M+<6,]Va1\0IR#NN#FXJX4)a]6cTT\@>B<.D+&51cOR
f7#V70/a<T0BTZQ2dZHOb)6>74AK39+X(3Z#:C^<NPN0ZSERf_V4+T^S[_XB98H[
IU&ZVE+?GCX#7/;-TEA_d)OeY&-GWA8O-9+@-N<3ZdLGY7Q;XDd#Beg]?]KBZ>-#
=-AbII1a73T)\\P;,T18<fF?d;:B-bF^AU8O1BO^\+COVa4TR;a&a0H-_,3VBf?(
B5T10/3:Y_]1X?5QN_9&/-ge1S7JOP+N\0]He.2A(D&NGQe_)dfM8FfgMY=d3gVX
@O8KKR#BFbbd3ONX#UG[e&]R2_\b>557QURWbC\,5f_d8EgI3EM]S7a+11SAaC^M
CHKA_\>FV(;TGd+I_^cJ>G.^)/f-+=A<2-[JBW-98D5@LO;-?dZ1QaN&P?2BF#NB
f^K\=8]OPE#KK&ScE<=1.\I^^9V7-/9S>?cJW60f)?&-aP8eXVHe2J,D)(KF-A5Y
E6G++I)-R8VL>bI-5)5HEbFO<\JJOVcKA@f\#]IQVW,+;f)>@Vb=(>OY\AKeJ))a
Hd4FU(60;FA&C^4D\C7AI3UWQ23=[:RT5CK/OKOZLca7S7JG5?Q&:XD4VgLg8gSB
2EH6O(0SQP+If+1LLIf(Oe,-cC--=729aJVe8)P7SK7[7Q1YbC\-E8aAF,E#L<U@
8&]SeKRX/S^4O&deSGXVaD<cZdbEFd08+IKMIBRM=B3c,X4K-)/N>.[:[E:?f<[Z
WR(5d\>05.-WP2._)gGOe>O+&F6f^U\#0N6fF;Id_0)J@7:R2N-3F9<;17W2\H+E
U_ATaKVZSU,.C?AR/=KQBLRSDg&>eN,XW)3&4P6_=HYb<.TD&=#S5A5T<;2eC\A-
UHIa@QNePI-0O(M_?,MAQG>&b0F1-_e=0-c83A[,<J><]?&[\+Kg[aO/]M+7ff2V
RRE==?1-(9E6+Z2V1@=F6)Z]0O@1P?ZH;?cOLXBKVZ<ceY8aa9)8MIFM-58g@?#P
V@-Q_K/fPc5bcgYefSLUE07-FW/EIfYS_T,]_-B>5Z,EZ67Pfd6S>-BB4cK0g:[b
MBB-=(ITAZe,=2:bW;dO9e([Te4G.=Ff+[),UBTR:]b2;.3e4V^:LdR;G[.ATd_]
6@E<-;TP6R#gL)[.QWM=YI[>V/JdcZS:/b5H.K@c6::^2e?GYDT&abLK(0NW(-RP
a5_JUBc+AR;.\d319P]->(<Q_.[d?gAF_H3JffTQOTFf\9WTbT]CU2PeQ;dO;2>P
[L/?B&Y)1g3Y@;8A#X30O2_PMU7N2FP=-)c>MJ9S<YM]J<59ISU1W3#TY]22PDd^
CB(b3SbCJ_;0^1U:K8(4MPY1?]a]8(BeKSbFKL0,B5&-_BgWA.2YY6+?PM;cB9\Q
IS,QQ5I[[5O#TM4d48A_X_W5#3YP//);CO/#,+BBOUa+&>Uf65K7M\U?E)-:9Q.(
4=056#]GHX]V+XaGS82WI,66=(:S=-(X]4NH_a,BI5JY3PQ+cL:c(GKVBNgBc(==
W3K@)TSA?WW\T0[4#<EOf;^5FRK542TbBIeGZ;?E8.GM64H4[31<d2d.I2)O724\
?X&3b.1S;B66OZGHWY-0ABHH\TT<5^L/&QHH@gg-9Ua)L))P7D2KO&Zb:[cbOSND
T/FAK8b-QS,W3.XN&T<P9;PRMaDTId&U.TP6Z]B+0_V,.[f&6R?fP]^#RQ<K:)H)
=GNOONPS>6ZI@RICf]95TE+d+Y.de.?fI8[D=ARQ_YJfD#<(VE/V<,_]/:Be^7BV
)??QIH<)-Gf<8GbeWeU7<7I.X;&VD&7-(ZeQB<DM=_PMa90B9GFeD@?O1d29G5/5
V2+QW614QD7;Q[_Mb^c7G7PfEUc07bG)WY;Og=S>W5E(LP._LE2YX)11+XFgDM/2
GL.e(P33MJN?J+G,c<;f7>N?BIGPgWT6CK<,-R8(Jd6.,PBE4/_H56]@b]6f:^B<
(^Hg[?bB]GD,U?;ga9Z>gC]QcY=Q8bIUMJG@/fCTPLBXWLT;a)T.eaV)&0(b0RQ2
>2D0@UKGRC>R=HF:>)(cSX_;UfUS+KBgZ=24S>MX5J,SOIY_V?_-EU1e55_;eP7,
T8P_&/UR=^(CI(0#ffL/H.+UO0]NaZMDFA+H]>)P<B[+:Z0I3MZdS#dgT1:1K]+3
WJ-29OCT>NgZEDT_eL-77^9H&N-37BVWEXNN90WcWb.Y_<-@6b#&Z>I;M\4/=E:f
7(-_QAP9L<246GY:3g,Q7AEA,eE<TH?bU4+4d=8XC@O9cO^EKFdDY>#PeP[Y)<LW
LC^M)ORc,HP2)2WZ&=066:N+?QT<S9Bg798-L;9Ab6_NTTQda.c79/eB^L\0,(XF
F0E[fJ748TeWdOSAC+KbO^d+^96TfWAC]X?fHSbUQT7BC9W-O>G;J1+NF#eN245E
)(K,C52aW@D2TYX2b@),G+/,@53G5:;(g\b>JP,f;+\:>P.?B2I3N)7J>[dA4<]C
g2X/RSPaPZ<>J1)e/gQe\JH:aa=]:/bU8DZ=f0<:ACASDRgQ(ULG0b9&GCA8LaXB
c;-]fR?N]7b71+1Obg:MW5TaRK;gR6Pe,?4&U(;A?f/FBFVeZC;g<_?9MD6R+3M1
bA67:N/:ccDMGI?=WA;/\.Q\f932C>O()(8+N2=BEF(d/:.fe>K5gf1M5g/Mee4a
K,<]<48[-3E)>V(=RO5<#2gXQ4H:BdT)E5CZ6VKbYEII=#SH3#8?C^K+e:?\CQcS
8:3b),M0NCY?&G-GX\#0c486cIOO,0d7+HVJ^D^3C_aYH2EP)fP0?C^)5#PcdA=^
>,42+J=QE@F(XdPMEN/#)^>BXSA&;C4,RWC]08L9=E6-TJOGND.d?Z+97T;@#a_5
?(R/L]e\VEU)(,T)MITZVWCd90VSJQVe3^OWA,6+f_-TOE\dZ,UB,(TJ].J,M.ce
d\OSC);?S>X6CO#f.J,8J\O4A7?M3(b:(f7#&3f^,S;]56_;-b<W+?]=-T]?Q@a@
<W7)H,C2SH>>M/?T[N410E@B[+.5,/_I>JGee/^A7XB;_.S?f]-OY59^_VcbYfY&
C>f3Qed1OZ/AXOg4&DeS]aT&7&bU:F&&S(X;FDIO0C6XLXE0B^^0ZYW8]]O/d<J,
5>9cJ#R;I^)0XR_6L8gEM-5LOT\NZGWMF[V^d;XC:RQH.F-3)28Fc>/Z:;0FS/[;
S.8^-e+\=D3890K0=&PK,#X2JX=W\gF2bZZX[+38D\QfPQ?Q3\4S+UHJ_L&ZGN8f
(<T7?A<62E26)W:-,1Z\cP430)/&F7MPLSa3EV2,7acaV7HP3&4@X_gTNcE^<YYF
Rfe#Z>>1\M,8J3FW<ET/8=4+a-5ME9@ReF4dUU(fV0<RU&H&]51P=[c(U9C>J=:\
;;E(&e=:F&5,LNe</AR9[52G7_g+;\.EQ>54.;:.c:P^5I[H\+A(&JQ+=D9EF=>^
2):Kd=D[-A[WH<?b8>,&CNQUL4bLSc[?E<G-U]BV655,6>L+&c]Z8D0SDc=^aH_[
:P\-V>YaB_TXB+&01;PPa[)\QVMb4&6)X;3,C1#^HH.PA2F8HV1.TTf/12M>^EQA
f;2TX)6-=d.Kc^5;E(Z/f&LBV80LOA+FI./U+F_@bYWMOC@NJNTa1MGM2I0KKMcD
VNFWER\f5Nc?.V/:;0F#:@16>Z96R#)[.ZMdWRC#1\S._95fPgaL.:@LQ:PTeY+R
0D(->-g9I0XTG6c.;fTfFZ-[UP>_8=LKNIH(N?cF;._]KMW?4Wf2GFGH,+.R]OVb
F[^13^+[J/NXg5M/c4@9P3fg5_OD_NRY69/VCV._9c7[+UIGgZ0XUP[S?U_R<[>3
a23MW1TKe3#@)2:8Y-f@QAg_J[6dT417<bU);J0/G2I(MZ>HCL.6Y8+a<e]1cd+N
Z<VLH4>7LWg)Z[RT)PENWc5J&HOa5<],5-PCfPQf@9I4GI72[4f.H&e#G\@P-C;U
/^3><5(D@X983d(:(8J>[(eX8\D>OC^S^,KEV&CEQFgCMB91XgaOX1J4?4\3[d__
-M]_6PVUYQ.7@7SHGZ0dWQ,\&EX@:^fAb?)I#I4CA^?a5:04V(5Y_.Y\4cQ5SO6:
g@P^\aBJ6ISC8/9O1?()S>7Z78H_JP(,?eT1@=KB&bM9./Mb,]c[e_RBM/=g]0>2
4QZ[I17=(g#7YbF,aFESQQ5,I=Xdg#FC5AIbbC&BR0Tb_.[+M/I2bYf,.RT9<OaB
I3a18?Y<PF921A@>]5W<W/PI#3E9Q;;bVY)#a+e@OYd0.&Y,]X6dLG84>]<N2IVV
AS14BI?L[-(fd6,+:G4H>985HXE6;+1WQNd3E]0=Q9GePZWc2EdMW50e3;YX?9(3
QCGAe5Kd9bXO:0Sf5+:-WJJb1/0f)FGUcLZ2C)M:H404-XP3WGMJ+J8PUAI^W]O^
ZQf>E[[8)0S#;YS,33K@7TbDOQ>G_bbfD^N.JXYIMc@e6@^J&T-a\bgHG;.#>G_X
(?2Q=@0GQbB2WWK1UFZ[1GTWCd40U,HE4VdI2.;YZ3-XaXL?K/eRDQ_RIZL1S=,_
?TFLKe0GWEF+M<E?Q6UcV;31Je\V95F+PX/[+=PCJ4>ecGeD2<A/<>.>:TRBfWVQ
SN_[,8&M]-G=H:29FRHA?LRg#6B_>VNPWD@TV-#6/(ag(;R<(+7dJ)@7eTg9C>M_
La4=EM[O4(S45_+^:HeVQ7LMUWIW8\@00GA=?D+G;CgK9cBO2[RXBP\FgKZIM]BT
-BcWE(@3bAN2NeXY:=0C/G?3b<#6O[KQU[9N[:eF,]T@UT;C5,&>QG#52V+g;]0\
(VEWA4>c18,]FNO7[c,7JFQUUW^?_d<3b1ID8dAR4B6YgPEfC)\>cI?7=5=_P,76
F.7MdKMG6AdeJe9=P8#26#58KUbG[QMWEO1]9^\J#H+F\G,XeZC.IV]_O[BKaC6L
ecXCI-^W>G_56T1GS[]D+fKgBHY(P=;#>.2Hg)&gPJ8K.W5Oa(;@HG(7Qe3U37)_
a8e8>9HH=f2+FbGBC7JX6^>:9Z<9LeRa_HPR&M#dKX>H)be^6T?[H3>baAO1AHWN
-bGWMNK)>;H<MgT6e]/-ZZb7f(<:<1])2R+P/Bf#cP49#CXdSKQ4+^[gPAB^#QR\
F2VFR6<-WP\]YCS=fbHCaga;F@GG02NRHX8OEeHF[\D\3J1.D<D\=9S8@e?.P[_f
(#YS9-G?YS6@=V9\NFAWX@:UU91.K,511:=cF#]bAAICIA)AaUgU0/04L8SS8MT&
2,a^;J8/f(2QYD989e._X>QB<.g/+9,cQ0^YTQ#82_>#eHeS-MH8GMSW+13#g9dC
JGNT.eJNH\SP^AJ+MIGRSF^4\bP\[;;>.@f#eW^[e-3TF:AS\fYbKZ]5,4NHQR,/
(8[YM+1+SDe0\ICN7#:#4<VN;VGM;D<-6^(Mb(bY1<]^;+c7P^TRO/<d._(@O7>B
)<N>H-Q-B/CIZL6F@DddO9c5E+c+&WZT0DTf:;SCMK.5HX&b<(g[XPK66KJT-5Ve
J/(09PFGT#,0Sef0eH(5b.E26DUOg]<AZ,d<<)ad2Se6SPX4QfLc9XgcF98_aT8E
DP_ZF)3a=2cFQ70d^2TWYVe_:@b2O[ac4?B9fV,-7(;\JfKSdaQDKg6C[C(f:TFY
/M;GCLVda(\2T;DG.V]+E@CgTOU,?)CVJ:6968B7_VYK<X?+Wa[Xf<:UO387:+_3
Y[GgG:)_((A1X(=+f16V6IDd.^LCW6C8LE4WSTDI)JR_fTWF+FZdLF.T@1JLY?6X
a;>:QQc?/^g2&Pd9VOREWUA^OQ?W@11K2_VSdM.IC5T08NCX<P&82_Z8_C&dVfAN
I[TH(=\#,Wa75XZ#(ET]F/3:SRPXCd0>H2;6-CQ=&<3I>VF0Og?feY,,(:KNU];Q
@<T0G0e^Cb41c,5Ef><,&#HUSR?+UTba#\:;C<_DC/c2MIS1CDgd,ABSf[BbR,a&
/<]D;B#.>ZT(NJ>WW.[+gN03aL,<V](aIaf8T?+=<cGgW@fL+DZ9JMSKG]IO@DVK
I,Y2Q.FSKL5E1ZDPGM1LHKUa?0,Z=2SHKIJ,/a.WY,OG11X)B:dg]S[9&DHVGV-_
\aYG:5O=ff-N/L7)?&]BJ41;RX9fY208Ge-<V7X@9E^FLP=0NC6>GNDc317I\A&9
LRA.]e4AD2+>82:7C38T=](#[,cdS>Q3fI;JE2:;\[80?-<P5V1J\Vd^\#f>32TL
e0JYV6]T@KN;=,E=3;RXM8@:bY(2XH0#R4_^eeP)JTMb\_fM>Y&0\V>O0d_^#d?R
dS,,XEb0aF(+D_&.R6]+ZFP8aT&:7R&C\59LLS7T[fI[(df44O&7YPcSedKPH7bM
)_#ZR,V/8g3N7aUfaR>V<XaF9U,C)c3,+3(C-Jd3Jd2&]I#UYPQ(\TS(SQO:J.T#
?/<7K/fgO^Ef?<0SB4(UF5V<:>A)S_B:32<K-H@Z#d=LfC[0=TV&161QY=<DRGLb
-]L:.SbG-OPLba@L;7&B9-)[1^N6=K<NA,+,&2f[fG-N4H3>V879=7P>/C-Y)RRQ
aa-0ZH9Efa-.=Q3:2dPEY)5#3[J0BIB+8JBU2f9c;-XZ7<<\X3C(XJc?bWE(LR9N
USbSZ\[c,Nd(<W8SY)ZN,)+5YZ4EF,[@(+/+PK[@(1BKZ1<#Q+WG_?WdbD3Nbgd0
aTQJ-B>._<P4fX(F/P&>FR&<3L#(T3&GAU;@,3M-V5;B&8-VFQ2LeOXA@d3NVbQf
,NCS7&U(<L(PKfKOJ<0cfW4OMT.I7Q@-1MJ+fU6>F^_.JSg#a[(U>1Lcf1WFPBN7
RWRA:)d?EXDbZ[KW6N57=O81;f.XX8S2>gWE=@M+7Q]18ACCW5FR+g:G3VC,0H[9
9Fa)X&Z@+438M0T<H2J]L<6/?LVW9G>J/=T+H9H1gbX6XGFC7SGX)eS6JD7C.W70
JRZS+H9&U\:eA9M9[/V;_)B#>fT18K4J3<HdWEd::CC]fg6F7U0/Q8XJ;DFPM@)#
M_E/7-LB^+=9=.EOQbVP9FN#&ECK=PEEOMB,6bM0I6DF+K3,QQ<56f4gE(K9X/:7
^E3-;G?ObbcfII?.9G#[c_9MGZe4Eb9:54N23QI)5V9]YU@;,J#g2<\[5Z5FR)N4
:a-<5O2IMRTCG6NBb\-b/T9Oa3e<d0<Y\]WHS[71fb58ZR+(;\9?/]DD.(/N6O3-
[>gG>-C#)?(/\[0PRX3GOG?EJ)8NJR0X>OQ<+Y0DYaY-HLVPa&7dD6;=C.>KWWdb
3bD1EH-?:&MM^2C64/(V-95]QB)]PaFgJ.,HH8;G#IdcQ0Kb.g3MQ7TK.2Y8FT87
PY#8dW0>XefNb][2eAK2?N3M1W&1_)L2)@ZKGA#-ZP8<K2/VX]0RMMHLC6Y#bQ)N
6,3F30;;W13.>JD>\KREcX0GHC-Q)392:VC64:1fLFZ1.R;XG_D&DL]]P;Bc\06@
\L_/D>.Ree45J#R_9ED(LMgC0B9SZHgLT6L9(BKQ4TAOd+=-IX]KDZ>&f2gDMR[d
0H#,K/YOFWf\B#7.UXM>>C/8d8=@6]Zb4+B-WRaTM/BB^e7b4G?L]]]3)K0A5H8V
QP#6^e]d57FBW#[,Z:;LEX7@U6M/.XV&,/0HO>SaC4eTJCdX9#:Bbc73[X-^KIR#
2ES0NQQ^+^d.f#N&IZV5c.@Q]O.IBC>1#H59B4ca=&B_86G&HS:6R3O4+=0\,9@f
/?7.KJ3a09K:aA^WM>Z?9^];EXbN6FfSe);X(GPa9#_[)>52ScKWK=:-?/]T)9..
J#:g&[TNZCEFE.JaV1T]X4bdg4>KLR.VTC\?,1J99M;L748If2)OWTG8>gNG#1,N
BI3\UDG._ZdIK+g><BbebOTB?=L:7Wg7.0/PH;EYBF>+acY3cbIXP0JZ4LcU1.He
;5LcWB]:V<>(eU=dgS&cQaL7(OGT;-4XCA7^NGRT0C#UPAKXIC8C14HBV9DJNA[E
DgePE;U]KRdCQ^/<bVROI_g0=G_[a>?NNfWe;bA#Z.E;K&;B)98FXAL0Y9FZ]>+,
Q\:?+f2QIU04<(WO^E<-2/b:O_=WDNF.NZg9F>)KY;5N[a885VOa1bI-LX\&SdD@
?UgA>b,S(VHO0Na,3IMKO4E6+P[WaV>@@Ad)Z\;1RS)5\#YK<O.E/=NSe3fCK>bQ
L8.gO7bGaATPDfQIc37Q[g;YQfTW1a8e0L:_OPaeB/E4>REA4I7J?ZH;HF+A3UH?
[YO#:dG:bS,WDO:V-QIP@AVYF.\G[<RQ-,NDEC_-_K)D2IL5S;d)4Waf>QKDdE1N
DXP/D=BUTS2JR-,IF5)cXa:_eZ3A4_3@<Y6I(R^EU0SaRT6e5T)W^&bFUI-=Q\JF
X)]E-+^Q(a\(dX(.[SG)KaCb@AU0;9NTH&2BKbZ731/UF8Xb<e0IQE7I75LIBN+C
fXX3YC9;I&M;=3SEF8S8<)0Mb)[2J,UE39EUaQBdae19^\X#63JL?QT(0#aMZbNA
]8((GQb\)=+eR7)3>4DUO\H]NLYUE):LKg#5dY&VFVNZZ?8Sef;K_3aO)/#KfTG3
4<U;.HfFZI1-Sg;?/aZa<RET=1I=OJ_+6JNHPBBTJ3X=)/_88c08#AbHFR?HT&2Q
?Ta9?SD.U[R<+1b73F856Ag:BH>_eF]bXXH87YFT0aNU2:QD4FY:gXgNHU;2Qe>/
&gKMFgG7bT73g78L>dG=SS-d\SgA?78O8VdT2PQE=[<8#&P3@/Kb.L(\-;BAG4EL
=AR=#3c,S\^.-;-?TW0(e77d0b1&e:VOV4=Dg]<WDW\+&?;3_?H+g)>_gW3)E[?F
<D+[F3@(Ge:Z\S.Xgd1-D9SS29.:3)D&N<K+&-\59LC]PJ#EA_B2>b>#a@1gZF0(
a52:A5QfYP[#L/Mg9SQZ\3,aQfL>C&]IR^\UTHJa[:3LK^^YQ7VZZMEa))eVR6ES
\:OOc@[;3C&g7CKJ]Q+d4gH:Z32=FXUH[YJCJ2bYZ1HQ>(A9G>8<QA?0=>?01N<c
_LZ,NHD>ZgJ<W:TFGAH.Ng._fRb(63#C--FaZMB#JW9=g?MbP(L,.>Y_bS?KI6d?
aeGAb;[S>/0&6?8^g0:#JV6_Y7,K)D[^RK.QZ7fS]de?O35c+#d:VeYC?/IS7/He
>6fF<ONcL&02K_[K=F]bd&+Ua<(bTR_82FJISdB?cF]+/P,5-7.6O([JOYC[:KRb
K&;SBBg67ON[gd=[4Q^E5T-KcTWR90VZJN@71ZCI@=<A-/8CYB2&&5ZE+\#2WOa_
X7+b.NXHTA\V9D>_<=LaJ\D&fFSUSg@:8Ifg,g1:,>?C>Y7>(>CMf_>I,=f-fT5@
[[c/G_gSg_R1a7(EHQF#.&1MH^+9LAUGUHWM)BECQ]5C9@.QDWWB;b[F56#WPK@f
]]4b_9(DHOX0c(6;V6?64N^4cGS&_Ae.#.)Kabf]e#dD0=2(HJdRWM\K8H[HJJ(b
dT.YZCaZMKf[TRXLV#9NSa.AP-:@S7,VRC8[gY#H@-H[8TeBFETcNQF3Db]4OY4@
cG;f=a=-R@gQ5aDNd36EY)gadH1WB=PLa:OV0VbS4#MW0OJdM8\1FBHSSfJ\SWd2
<.(I,D2CTH6DJ1D:_\7LI0+YbW=_b.;b>c7<4dFZ6:G3eT<e^<BD:[J>FS<(Z)f7
6J5DD0M+XT<-&W=5L8ECY)Z9#NV<7F2I8/K>JW8#N.IA-2GcG-RSYV:efKII6bWP
C0e:<+LEbAG3)f\[IJa[N5=&KGF&:##U/O[cb,].B(b-M8/;c0F;ff,#c+AOY&RW
FE[1L=-1,?,A/^7(^-aPP/&0&>F&X2;Z?I1/MfAFU>+Q,7gRHeAK>Ie\=>>^(],-
T9Hf;TV]HYMEKZ9PD&0I0)SV@5KHJLX(3),T_&;_5Y]F.&R5VUIF]6Zb=J;3P-C2
>=b.NYD>:P^ZZdYUM]PX:UKaVB#=QC-OA0P?\c#;TfHZ9]#@T3bL0:+b75#HD9T>
6de?X(HCfSPL7g25/+&gYeFASX6fZ#FU,;#Y6R.IKcH,VU;XPQdX;Vfd(aD[ZP&W
B3RA.A\bI_&cS:)CYD,/,++N9YK;M[6gcbbf^D)J0>FODL&a/3^:D;/S;:[)K1)K
C2X-PM2a?9-a)_S+;WdPG&\YD0e)KF\7GWfObGRW/;Y=VaH@B.cH[:@21CDWEA:M
8f6Z:T<DIJGg#X7RB1MQMY^<0b;Ve(DUW5PM05BR7P;M<Mb_K83W02()U\T2W2O0
8105#?22O;H+aIGW5D;Cb.^8SZ\+DZ_fLJFU_Rfd25OJ)<Z1d0HD;Q4=)_;fLG4K
\[dbG25\We6H?/W7<eOCN#<U^Y(B(M4Va,B:b>O5OeL+3.eG]U2fWSSG48W)J6J6
?;DMNeLZ\?>-?9KT:S[3Nc#P9.G;DIbM7MPR^<aOGCc74OCH4&6&8VC&eCQ=^<]D
SW(TL7;GV=C)RJL)7HA_#4>G)0JSV7;)9.:7^BM-9Y]VB6(5?(87PcT3GB+1eLF<
AMKGac>VG(RY3WZ<SCRO&P1[KLAG?4C]V>#8?I\D/5:8I#Xd\BP03_fgN&.;C@,[
?:?,([L)30QTJaT3C]bX<g=@8/g2c+8<)@JON6JH0^R+V:Z5eNDf2bL(D=,g)J][
;(d>DZIVZGV/J0&g_\O-YQ;Y?UNT9Y1Qg^2b;9QYaZ.<-_LUS5cMJcM<^]T,=,OQ
SNQd2;/1g08dK)]Leb&N5C?YM0ZA?3,Q&L)CE>g(G.SfDc7&AIa]F2+/Y@-&=/:1
fH7\<UC@J]cAcY)+YWAV3@<d_;eNa?RX40;:dU8M71BKV)a[:1.R9:)FZU+O+LQN
fE;H_^T20@M)#KK#G;0HdXf,A8A4R#^9R/Pc6U9+ED<fc/OZ&FFJ4CMR5I8]PfM4
G4LI&B8Y3)7c)9<2@UEBP,d+^:(=;(/Q]J;g-M</C@W(NZNXY,IUF8ZC&+B,FNL(
dGd7>;:L:&OQD=__XGZC)eIN\gTZE2(F]8ON+:L9Zc>6QaH28]G9+S\MU_g\Vd4)
/F@ZN8,?gV8@gOG2@OZ=I?4YSX?7KdG\G,AB:3SGEFL,Va\f9bd_RW4U.O2]YdDX
V=\[N788&K3K0\e-3A]40GJgBVD)YJOaJf@1.1,CW=7<?DB,#cL2a-SbP0YV]1aP
BgW;CDR&#\HCLW624:KLMZ#=I7D8^&)P_&;/abG5<c;Z&7Ha5H2(9aG-g6)MHF=4
7(8TfQ5?Z<7>74?OD0JI/&RC^cc6TZg9KO)ABB8O@<GNX;#ZH_@2N=O8KH)bccEN
b?2C3/1aJ5/E)FWGOT3@0c^/3FJ0KQ/W&Y1)Q:a/T&K3Mc^Y0904:Me9+?OM?bLN
:)B5V(LP:12dJY:PB&g\Mf=/D1YH5L7Q=-9^J0&EJBH(6MI&UP70/0_-S><Qb8Nc
JE&YcD)c]^W,G_1Og@?JQQ^+IXTN_aPI@NO34R<6c=>N5\EIbA5\Z]K;Q5dC&XL#
YSO;[4WOfQ@F@/CUf<:SI)U#Z&F&RG]CM6V>1_(,BeK])J3XU2+U1KVP?AA]EJER
;LU9#0V#_aAWg8[(+XeX9VC_E2NONPXcMS&b=O,H<5XfFXGY&P:\JXE4H3]&=\=(
RD;fIP&2U5)6-6QeQ:(@=E/Ldge=GVL+FP)aEF2S.]U:UDU\HBXJM&IQT@<5XIC0
,IGW/VY0fO:1QX=4V,3NbKH66(3E?MfA9f,.K><NZ_1\07-ac[DcTO<:O5O.A-B.
L(4#aP(9(>0DK8a^13;)ccAf-?8J=[bW?\I.;FR01CS7PIFO.6Jd/#Y&/^UbLdV@
8(70#FbX7BRM\3./<746JVaCF<YF@K.O>KKKHHVCSF?bX[HJ5]8?fU:0)+HG/[bD
_a<H]6J?b>5DR[;3dbAJdP2d)c2QU718e2]D,T:=?86AeP<8DA>A)7T]PeOdN(eY
e_,2S51N3a(D,K@a\U^>6CO8FKASf7d^a>TEOcMe06HPV(6H5RP+=@CG<U)bD#,U
,gcEK1:,EGAA0ZF5g>IEC#7A=@2Z2=/FQ15Kdc<UJRM+;KBG.W8PDT;LA.LGZfWL
K3ZK6IV6[+F#MS9P8M=;\_J&ab)/SCV4(H_ReQPbYDgPfN23c:/B)^S>7He61I,(
1GST2DEG2E)OWfdMVS.T4a^Qda3ZJ=R&HcA)]gE>6EI.D#SYc0@WD??fTZT][4/f
+0g^eF.D)Z-\=_Y,UQf+V&OO;,7BO\6Y6258]JK2=Pb;D\>eOa)\9ZAPb]D-]8fe
Qa[.a(+]14c/^?ML3S1aXC_U]/P&FPbg#VD3EJYb\W>[U\bf(X4b-^8VJ.T74#F&
8ggU3AU]9?F94L\WE>[a/c7\,^=#QHB46H3_R92)K@d<J8C:,)@=>S1d(\d2?/@#
PE1N>_W2S3)KEF&T4MJHf@Y#/fXLB[^QX21\L#cZ@?b=:c&Gc.TLK:=R4V]-YPKK
-H9PGB0.N<Z7e.8#+[c..QW;QT@:I9b@FZ?5XHB3C^E5OX[&I70\FLQE07APHZ.5
\C9?=_(FA/,O.9&/A(Q(U-;=g:IXF)S/bT=_W56134,>(-3>6c)SVN?SO4M7[;7X
9Y+I]>>MIRKX;>TEYBX46#/Q<T1>LaFA1M=->Y#K[SPF?9=KH]@,T_[a0\N&I27>
,+&A78I>E+DTSe9,@<+8FO&QQa^(fVf^(e3b6R9I.DE;BHI\H9G8SK<DJSM&,2K\
>P9H\/\V/F/FD)H]W.0OHef>a=1f?[4P);->c9M^4[[W4@_[H=(]90PfR^1858dM
FZ-MR@S(U^,PF\)aC\:T@>a7cU5eF3HG&CDe+c];,c>.#aU?b:bUPJBGB<;?HA3>
AW-,G_fI;g3D4^^1/;AOL@.VeG,,4eXJW5Y5PM:V9/EHN8N(O&4/WQ)<YB(8R^[^
A^;E=&:M9ZN6DfR;0IO&@LDY:/HPf?6]HM6a=@/-6178H5O;Ga\-[.K8_aPfOePX
.\EOb>Z6=4F5^a6F629)+45G#I)5dVF7cSAS]fCWH&<P_^W7/1>.Ef+W8aM.AB:6
TUMYCTBb9E;1\e).Y,>g-@2QTRV-)5XDK\46P]eb((X8EE;JJ-be;-0c@VeY25A/
AI+<I6O_E?5DVX3,@bQRMQf4>T5.g(6g_3IERLd+Mb[K(LBe?bRdce5&B4EW(G7_
OET#Za+D+,-\)]g/Wfe5>LFV=AP^cE;-9J\[\#>4/]g;?XAH\bK/GG4?M\)09fKC
]G#daO>cB-GRXUgD/c:W+C6S=cXY;RWS+O&EG;M0Jb?ecAO@;F>^D0.6d?G.=XWc
B7U1OUUCM7cXeVI<0ZS0fX_VaLO/^HZbcH^&cSJ(#_Vg;cV<V7fUT67bRZOH((&d
+HC1[QL@75dV/C4UMERDG[7J_4)Z8N6ZJKT[YJG^W]=I7G<MQe+cYMcEe)GJ[RbP
bEN>ZeRHZ\gg,Tb:V9>K5.gO00_6PR@X&JEURa0BWD6IE$
`endprotected

  task do_cmd;
    input                           packet_count;
    integer                         packet_count;
    integer                         i;
    begin: block_do_cmd
`protected
7RReYMSG=:#RKQ><@HYV6)@dEDA?U33H6g/H3>0,3:?fZ2?X-(4U&)>AU4]2Vb^I
V23gcM?>9aX-\.C>BS3X.3=6Ug><0I+KJX&^+fZM19ZNZ57OCQR5#7_ZE/&0?1[W
P[,Cdb84Rb(#@\UdT[8711M2KaOI9I6[Dd6^66H?K[;D2/;?TgY;>7W&2YP)(+NK
O1>gaPgPL@XWJ2#&f0:.J@D#4XFX)<g&Fe(AXAe5<@HF8(<[aeM4I4QA0EDF2U_A
P7I.E-D7Ib6?4HSUA>IBV,Q#V]([-1@]NXADTWV6dO5,QB1]NH(S4cMgPcc&<KJg
>O>eC+04M]LbfI:>5^GGa:7cJ@0#2<5gE.0I4,bV9S_O)D.Y><@APDU471T]EI:d
\(3CEdJM,IMNE8RQVfQ)2_WB,&fCJJB0@@?W0V^.>0I;RfR3[V^PBb/94a2d^:]:
VgY0A]&F\S+5Le/L_f+8Y.BO7>fZUc,L0F9?Ye/DM3-?(E2N6+DZA^5ONdeKQK)T
c7dV7P[.O.+NB8V/aOL#_C_C.&BCOgd^80[PK64c78b:7?.5XTN1ge;XZ)ScE[(3
fF<HH?4DEVeS;4aG)868YK<Z8QeY8<=6<691bP8M;DADETGCSU3R>?,W@8S2[\?-
MO@W,I(gUL3D8Y@??L;Mb)F0@W]GWE)_7,R2<GN99E2=WDCH.<Yf\f6N[\B2[FM@
;HTR#Y?XfIFVF3a=7J\9P]0+8F&,>80C#YV>QB434I((?Vg.\-[T-V(H2D2&NUSg
gA>K/d-AOfTeB954W3TbM:TUB9;=AUAE.U?+)dUeA5IR4^O+We?FaS^N<OB]b^@2
FZ_4JNDQ&cMTgNB?IPYO5B_Ta?SCP<^FPL@;U1<0ISO4;_9OQ&K/X+./fAe/)4=Y
P<8D.0f2#2[/Q\1H)YPf6KCS[FXK5-^=6@_L0bX3DK054N\WV;;afe_K;/Z9AQ]\
AI?J2M?^=@Mg+QR<?G]e(Dd/C5#ZL\=#MA+=X/LMYA2MN[7[Z(H4.Z6Cb,K2ggFD
6gB1a=F^U#T;6U5QGKaQgC[Z2]55CX+;KJgZFB2)E((14-PZLe+[-.R_37cMQBFU
e3;Y^2Z^.C#f&QR8;VId[FP@g?;476EL2>a1aE&dc)0T.9(#/a@f7V1K(:[(&AQ@
Pb>.[>W=/gaL>V3CHRN>C\LBCG)?4Y?EM3.Cf^6-LIDBA.B?+UI.5GVST.3&b8S-
B(&2KODB@^Z(#]DRe)@c=Z]9-1D2ZNY1-ESIO4#Me3d]],4aW[WQ2)OOV0]0g#;L
PT?(IM0EIM:1T2LaV:IHQWGB^O[#D#)X98TE\VUWN\?Rg=g-+XaYc=b02_Y]XZR+
-Y=2:+^IN-3QZKE&D8ML:W)TD<Td5<?IfgcPZBA]OUV7142&Q4Eb,8BS4&I7RJL(
QGT(V08ZU0[VG=3A@Og<ZS^bALS9)ce1Z&LG:>/C2dc_W0_+9]gAIE6JXfLPT[)N
Iaf#DO1F\@L:-fb#)N06H?ITGRU35a50<#eNFUfX1^G.VAOVc8Y3YW6JK$
`endprotected

    end
  endtask // do_cmd
  //--------------------------------------------------------------------
  // Task : do_cfg
  //--------------------------------------------------------------------
  task do_cfg;
    //A constant that determines which of the model's operating
    //conditions are affected by executing this command. Next sheet
    //shows the legal values.
    input [31:0] param;
    //An integer that specifies the new value of the operating
    //condition specified by the value parameter. Next sheet shows the
    // legal values.
    input [31:0] pvalue;
    reg          err;
    integer      i;
    
    begin: block_do_cfg
`protected
7]4I>4:?V[15X4X=,8&LGI]]-.,JW1c_)J/UET)K36PZ>W\9T5/?-)bB:U1C48P9
P-B;<f<;+;JU@TP:Z>NIb).O-dB;=UDaPIZ80,@_?gMI?2fSD>ETQ0RD4;BP^^D7
6Uf(C/FT(3U8F[J..)Q3J0J]TfF7/3W(]A?>X4dYCFMKCW:Zg22CV7;+F6B?P<?C
OS^\^]_]1cORY-;SA0PRFc=30^-5<?]63@V4DWZ[USTF<+BUE31gde&&<Fb#\g+f
LM:dR35U>XC7fcG>UB35=(W)b2gA,97+d4b76fET6;7EL\\g>W)dg[]L&f3]>]P^
Ef/BW#G@fAVW_++(Z3SIT__4]1)H@cD=HBe[E7Y[C5,=P<UGg7D/b2D:e=T-9_38
H2P1E4E6K])7&9&YL,bCfUJfY9IHb>;a-159:HQK2JP=[/5D-8V.()G]\\DbE,(,
\+:M[B+@EHbFUF+dR(daR;aHeUWR;\SDa6?^(a#4B>K.+85=9;]H&Q=MAcB,8J0U
R[_2IFZWIC_^D\S=GF7GbO1L:2-7D0QY_5X5M5QZ-5E:Y??2@9T5\-LT#]J&FNC9
G>GQcdA@71>a0DL>RBIH);T^HZYE?f2<DQ7[0MV1)?P#+._XfS7a,P#DEcOBNE2;
+5L]\2<f1\ea@a4aUUDK=A>]+,VBA8J(VXG.=6X:Z.5E)/=V8_&@S@U6Q?<-M/;#
->(0A./GGC)=9,\=&GD3L^I_TbCKJd<C-4]SPM]7-;Ta?E95U7PJ#Qd<2gG>J26F
&SZJAXa:^#3F>1.2SW=W[#-(@Z+D7A7ABPbX-3_b9TR=6d@+DOFV+S4fTY)9TUa8
;=>NA;f_9,;C^YR#D&.C[@c^3G:990L])LL;e88EeA9#gI^@L\#=(c=U&U_LL@)B
=Bd5+g[AM.U-=[)@8NYKET#Xd]G@E\9?LVZ9\J7N_G@cFMYLQLPN=K-0fZ-d.;2R
RE5RGK)df0Jg;X&F,C:WP.W<X.I5,?aR[TXTgM=I0?eGWda+#Mb2f<C.FPV9FZd\
ZTYfVE3[EB7L)d/9R0AWSK>b964I4)B6S[0,S_UK8//WZA<INHV9WW_ETR2WI/d_
F^2VRZ5N5,SdKHN\HABgeL85)+ID\V=,LPa1QLWT(BPE4TX_7#8e1R<9#0_Z1gHT
DHbU10K@F^.HUaf:1;3_KOMR?J?8>Re3c^9@#0(;K6Gc0TQc=@K/,eXMMVcO(>f/
M-W#R,+86S?C<5Z0^>)QMLH8NJ93]gb93C<E#DYT5GGb1[E>ba;;cDM^gATA@6CA
N0dBGZBe<G,AgE942Lg_dGE]_(Q5,J#4J]>N??:IbT+7?IQZ.cZb0G2U;T[@Z/+c
YJ5;_&Hd>Q/RWOZHQ3V&dVGH_-;7[8\\g1c&b#5LPJEbP=Te;2IZ)Kg-C)+DS#Pc
UNWZ=&UU(cZQ:FTee)e(IfP/U9b;OIB,__=][GgT>ZT_Ob(bLDDC\A,Q@?@Ne&K0
+(eA42IJH^ff0?eY6BG>.8D1,X=@\d:@)5c?ZI)+[\38^9)#\;aG@IT.^(M-:a3J
ZfR5#;g/bS<L-@g<Q:7]c=OA7@O5#][#)#D0PVJT)^Wb;=b)XKc>1M;OJ)NW^@OE
SE3UA?_0\[B[BZfBb;S949::fSGMWf6C\.RT4]E@9G:.5S&EQ^PD-5YZY,[H@G7K
Cc-A5;:)EM#gP[V#)PAI8EL#5V(JTD27c<@?4Lc&ETLMgO2#D/RR<gG9AX5UdB#X
U;G_fG)PE32DO75T+_U+:_J5f=8\1?1<-#5O=6MO0@6UH+BU]8+N^BK_/S0&]02]
O;U&aE)_=bEBdPEfHDG3AD,III+V(:FRXD:69\4)\O4dNURLQICA6:J84_YdD/JK
UH>_SUa7S7N8RPIUf;V4CABXK3@#<4;SWC0G5&-SX;RO-/1;E>X?,EG_H9;_N1Bf
gAO957>0T@X(;6EAYTRUX::7_LE#3M4DWOF_g?F=PLNfWb5_K9AEf4gB#YNS)1Z1
H-R0[LDYYW[78aKZg4.\9,)MJa<gaWE8T)V]=&TDVbB4FX+++f/]-C]SK5#adYI_
0b&X<T,L/e_[)<PO3;@WPb2V[P#SP?JZ0b^-)(93\)7P,_d.IJ=R:@V):CRKDOTL
2#:M2a0LSK@;_MC8B_H?WV0+g3f284.W=U.f9\KF#C;O>0/Pee70PeYP:caf5A,]
a(fIF]3O\,<HN^R_-I<,gIfCG4/F&N6N774[JW>Q>CgF-W[4QWB?DcZ6WNZ4\FGI
+0c2IdPI=NaS+UC0/5G<RO&9Z@8P8g2[6FTPa>J,-,L/U.Z>ST:aC>4#c.6S.I(^
ZV=WACcFOCCH]V:H6[TB.X7H_>7YRd1JCV\VbTgE[C+UDg9QL>>#ICBU:^+B<98)
I&IOVO>^K,IC/\g#-]\eL?VSZHPCG++XHCNEGE?(G_#G2H8W\F9ZWKWBB&Z2VYW6
VIA^8TR\cE<;SYd]O13G/0Og0[(W]W\=[MS:NP:O/VJG9O^MB-]V\,3]XC6Pe9NS
bL\QgEMR:,N89MDP(ZH,VdS;U3FFgU2ECU)49Bf<+GN]b^:M\(D^Gb3HC/7LMD\0
(Q+J4RdCHJ;M^R89ABg6<(Nb4[HIC^JA@fAA1.5Td:22&gb2\/[TMC^e3-Z+e^6H
NV92Lb\X5C]TDQHLW\/@gPN@.eYbVAB1\/b<8UGX[O@8^LCSe[Zc5HRU5fHYQ=1P
#3D.?=AX6KA&4_+?[:;aC5<IG2EfFd_X5Ld)^BEBb9TV15R=Z=&:ZZ5\>[EQfSI2
C(>7+#/dLU;=1\>8f?Ob0NJRbG:]#>=26QP4E6G?d-/G&[C/2a5_6#EHb<dG1L2D
5?4JR6=;P_(C)D);OEIN^>?6<V;K.-Maa5(QBaFZb]+5<TN.6RM6HN,IQ\I?0#YZ
TDQZHMHNd\K.?LWTE90QaF339G)#SH)L9<d?OBBVOL+EZ?c,N]3OUO7)a<A-US;#
F#3)[<@&44[;YPV5^cW#K28IM^0V\JO^[_,]\bS8C;TH])REE&FU;O/E+DFF209d
_Eb>,3BQF5?F17@d0g9<NDa7W)3,5;<?fg@>9BRU0/<#SRd]EVJMJ=Z+AZYJcIO7
G[Mc\84)bE.O.ZRRe#PG5L=?f5CL6L:P5F6YOF^a_TW4Fg[cI?G7XI\NZd5Q#SW#
T+8./&_^d^5#L6URbHb/XWcK:7Y1-/,7^=5@K(&LXQT.CZ\4.5TO(bB-O\0S.2BL
(]+R)?R0F/&fQUV98Z^3b#&&bb^Lf-C[YE_(S5gCfG3@3IbeCT@IgXPfP=+<6>b1
G7&38[I,GbES[92JYf6HSAf.,IRePe49SQ#\F[C-NNMCQ21#9Y^Tc5M@5OY:[:XT
\OWO]0L)6cR6ADME3R30[XUW5\HG>_^[O=_\-9,9L,QCaaW[YG^fP<P/e9F,:Id=
fQW&@A9,&D-Y-,(+HRgP9[aI/CY;4fLJ4_Q=CXQQBEB^_Z(+f#6_27eC&=>OPWf4
)8O[/[3VF,1Lf_TD8EL02#=D+Z1Z=B55(dEOZ:FTM<;Rf>]3OdOUJH@&F0(O,A.D
\/&W&WYCMEESRIM](cSY=(Y,?1bA.(@DSP#B&Z3M7)QHU]7cAYe&23X^A?V\(=[C
T-2/B)P+.)AU>\0BbI#WX.bc:a+92I]-;?#d->&A8MUY]e+WS7-O)4]22Q@_2WLZ
P/-9+:[U.f>f+[]9IL8O5YMO>/V8V.6E+<IAA;[C0dY:LJ(W4UbgO.F(AI4[1BUY
>1L#U9,2:4UA11f1UP,fDS;.c-Z9LLB>Ca^gd(QO#D/E)ZOK79]R]^R)H,>5/HYV
b7-HJC-R,EI_WI5<1CWL-YO)0?G5^I<Gc-VffBL#9bL:\FE_P=#.7[a:T@HT;PRM
#(WG,eES_YA;078gINRfBJ_SaY8AfXB_Ye]1L(>F):0[QK9X7#c5SFPCCL21Q-B:
K807fK@1f52Ub)+<P).)2(/]UYE73GG#--2MAOBJ)F<[V:c3gR(]M@c^e2CJ]&:3
)IU>Hc&PDaaUO6SEWaPaC&J(0JRG3<R,eT4?UaD/WgWF2#QQ-:(M9af;f/g2&>9,
AH6ae\P7b@@5IU6RCLF(39f5eDH<FKU=Y-ZF@;X_gB4/9NYf,BU]0=#>8R\L0:Q>
5F&]LF,-S>,8X7aAUgc?8H7HBA[b5:GC,B9D8,HB0?HZ54W7Qb<_YV?fKQ&1TGUS
d54-3-YS,A+[+NP>OP7,68A1LN5facES#0ME+N704[>1[@c.)PSQMU^N-;TN?C2F
_Y2XNZ1fYRY&JC,1)J1K6OJ9?<RaaaZ36QWV<;7O:)WV\6\71AgVQ;0bC7Iebb&H
B5<_Xb]/TY.9:P<K>cg4RF(8@Db?DfcaR=QK8D)Y:YAbAHF^Z#]2\:JU=./OGa>f
-4NL4S<aW1LGS(^L25=4;ODdXYAIR:LXYd38=fNdL[OdgDNfg#<dKWf\-F>E1eCL
=HDgV,#MdE>O9_1+]c^V.SL^Q+W#8dc-P[B(f@K9LX/EbY87Y<Y^Z-/TJP8P@GY#
DU/BIG:6_A;BgVf\Yb=&(YDWU\KKOM&25A_]3N3QH15)^0FRg)ddAdZXa&@,Nc_^
22V2(I(AdXW^TWF(6I/)8)]W&DWSgG\(HU>b,gQI>_5a^E/54GeC[/Q@e^(8<)=e
g7]6T,Z/#aE-DV+IJ0/ITJee#8ACaE-;B[(WJb99,LP:XcG;86D=LMM)UYBE(YJD
H>L&,,=Sf8^KLMV)J?G,.e+bF;#G/eY)#A\^G@/(U(bZI2d??E&MM5R+NH;.5f1F
/3&\:^CVH_7R(2G.]><03L20:.?R-PC&;]85>M=C=U+OZZP.[:FLcHePYAL)2\>\
)37X;dHA/Cf#(Kb-MTLH^690-OP,G+^1HRQEN)/c>JQ?SSBE;\X-2_.DX[?<fJ/]
Y>.Og__ZWb#^ZN?QWKJ62f/P+0cXF/aGXB1BBRZE7:LY&9YL-C,HD][8e@J9^0UU
]1<95FB@UbU>VE_-I=[&5bK)?GBU@ad&W_,2HB^f7,cG:8Yb7ecQaWJ8CUDZH7ga
O:+UD)QLQNAT/d;dYbHN-aYeD:,Tf5.US#JC^Y:B0ZEHDc+Md@@HBS9QXG6X0,P-
g(+C>D2,B:CSHS;&X)\N^M3DaF0,I2e\.HM#\d2UCK?WO^c15VZa=K33a+3IXKC:
,CM7GA]OTP3FFP.B4e\eHID97[OIUK[+@c38IH]?51Bg:AQR>ARb23&9I3a]U&^0
7P+[+AX-]#1=<3NB-La8RISS@SNeaJ(NSL,W(ZEO<I204T:=K9bV:+W5;X:7_=#J
_GPT//=BKB&=/1032X2,8ZW;)c=MM(7G,G=X]_PfJT;B]<\\HXK8QKC7[FV>_PV(
C5dbMe,3S0/F15.QP;_cDSGUUC?Z2]UPCVAHNT8-LEH\aK-1+=f7@+Ag.b+_GCH0
E-(cE]2Z2c]7HCA2UX+e?_Vd]Yf:E[_)@/f=G@4@Y?Zd5I?@J/a1\WN@1/agHU@b
&-La;[TKO)2(M[a8PA:Gf&Zb:9;T-Ld0g4_A\1(#U-.5S^8N&R\WN]Ke&+[bS]K=
>?I6M75d)A11DLIdfa8,BV=F(L-Qb(VLY:P58^WTeJf:-ZL@G-2+-&GI,N+-Rf/e
a,JCfgBK\5E[Z6S_:3[25>?^Ncgb<E^@>cB^E=bSDY2_NJUTPB?&Z2,KT#MD3C>O
ONQ>@^#]<DZ#VF4D7[W_UB8E7]S#;QOMW#8aXB6V,Y]H8O+XHB(LJ:_/SR=YCfAD
CU))T(-aISbL:BMgR?.070K/caOHDW[2;9T8/TT0QT:[]c@A_&SgG,(58M[eDf&2
8-eWWLZI4abIb>AcU(P[15=U9R29gC&fXHO97>BS^<gRHTW7GK4TP3E2cVK#;-YZ
0VHQ?E>+AA_?Y#_>9=:]gf2+3<9P-ZP+SU,;cR6Q#UU^g=K^4<Z.XHRGA9&ZNBI&
^GMS2f3)+gB3_Z.Lce\]OAMW9D0e83Z>7N78(3#U:(fQE)-\Z6TUd>Ib@e?;VO)A
YRLga#2b(7I#ddX]&Hd9:\GMLNE(aJN[MK[dB_;.HHDKP[V@DEF@?A538;CO4d\4
W]-=JBIH5I+BE42]B26>KS;C_IGX]YC1P(=OZc1)_eIab#H]XgE?J3>(_/MH:fD>
)C)f)?Z)&A=:a8GdBg2(eW@PaNSFQ6QLY[)Z<Q@?UHD2H&TdMZgQ1YWE8[OBH(KV
NWL;>^0_;e[e/_2Pg8ZM[UA\>-XTDQQL/-,1+B0[Z3]/7C6Q8J/AA4VZd:RJ#bIg
1<cfS<1__?4+(I>C[8&[-FbBA,&DL7EbW1:(f3\/:+HFFCE\b0+ZB&H</Xc4d)N0
;:9PW/eACY57J74,f3<?aZYN?OHW(TB4I/=aC8[TL,&U>P2F6WHI/P^3A&g-D4Oa
JP3KNeb&<39APX1GNO1I3[,BY\BM?g;N9(IPO]OX/<Q2Df_&bB>@M&\OgOEIM7[g
#>G=0?\VA\-Lg3#DeBFH+W3<AOOE4]A9[MPA5FXU/H5&E<Wg6^d(IU,VUN=MGTE/
HD3aWgXa>2c=&-KGQ>d=aN#?#f\a4._EL)RPO6OBK,6&P>I-D&4,g3JVA3E7#6&9
eC1>F-C3VPfGJGRPbUN1a5I4@__P9-ZH>-Z/0eIO_e)OcDR5]fVYWO7)S+&Y]1>e
,cTO3Rb<Ib.VLBf4Q9[7Y[L7)a(e+@#HB^_OTbY^Y]X_A=XY-X99AP3P2^51?R33
Q5LHNGFG/8I6fOA9_T/L?cL]8DK/7TUNU62QZaKNV(@:?^V5_Z(GX&JTL78ZO,Ab
Ze6_,VUU9&g)9F[8cB1S]=)=bE(gQYL+1TYGS&C]B[Q@;gPU<>-:DSVdQ><8^.9K
ZRYVDJ0Y8^#@)TNGf#-g0fA;e]K?f)WbN6UUA^IBJ[U:^ZU[:13UbT.+Pa1\[3<I
g-cLf_EN?F]7FI^Z\QCHEWSfg)cJVY>1[gM_feM#P#W+Ff67U\aJ#1_QD9]7)/3<
#D/AY.V/Z._OgDFN3#X-#?<>V>aN/2WEC8Z+@I3;5gEOCI2YfV^6VX6(8b=_8Md8
\F@I+e5BF;>)>84G:GQM<\8Jc6YUbB9Sa-7BC;e-Z7XY0#FO84B(:7T.@RgY09V4
YLb+78Ya68G9R-G;JbIGM>d0/J7V/dW\<:@FK0.8/HLB[9/^bb-fV9#?#@:)OAP9
@&9]e205=8^S/)ZeS22fQ=Q=@#-J(2P4&Gaaf5;BN9O^AUQO3b#F/2[PA33SgUP6
/bG]N2Z+Wd0=0#a<5(X?19DT)f.,;2C=3c7B)Vd>dddINN2bR4UI)(Idf=K47]#Y
00<PfF)R8P2eS]A4<GO4_UTG)B^a?\dE04>=REEQ+X15SV;-]3]>U^(39I,?a(]7
4@>EAUPdG-K&YU(:^^KW]E>AKZ:9+904ZOTKPT]GU<fg+#bD+-Y(LI7Q^<9XfR<F
04B0Lc&#Z^>eVRP7MMT0,YF.PYf>OB>d&H86O+Z(]Y^28\7.Rf-:L_beJOegCWIH
#9H_-[:0Ce];?]0Z<3(Le#@;J<IMX:3:McMK.cafcJ<3-&_RDeW\+)J#RNe6F#@H
2e-XT?X5CF\S5gZU,?WbK+C#P\S];V<^Q).gR,4-P;gZTg75T&N18TW8[0d6ABTO
c7KeYZ#1J]NTLfNB:B)^GEYB8WNee5S(YX;>^X@D(X;9H_E\9+(Jg1@L;0\ZAb(7
c+9:?LYR@Gb1+]fQd+.]AS3<6JI3E(WBPf>ZUCd8/NICSLg#WQD(eUX@)DVS.bJL
MD,b(9C<3++e]IM>a[8Y1>7VMU>X:Ia1H&6XRXb<B,I##aSEI)SM43:LfY-c#aV+
]K]EWPaONMTO5>;;+DHO3#^W57#7G18Q&MbBH:QB8+Q&(SC0)Q[HgM9SK/O0Sa28
WR&VF^D&15W[9LeI#D@Uc:3IPF[8_MAK@V?JY>-A/]fJTOL8R#HN]??D)Xb]H=)H
,5WZA7]]e:40:I&=GK8d\+P<L:^[#MRWJZD@096Qd6BP#_FZB8LOf29X\;.(A;6W
Mc[S,>[7F5+5^b&SA=?c:H#O5S>PbX9KLOAd-ff_PIW]300EeE>@3K/]YeKT\@+J
?4B8dP;cV=Z<8D@4eMBe<.B.&/W;@O.X]YgfIJ[eNFE2[5-fNFOXBRL+Xf,>-=QZ
Y=S]HcdTWURHG2>8FT2D4B10A6)@gJCW9C0C)F6A@bV4BQgI:_HVL1Z;+,<Z[34;
)PAL=OIe^?@UIRfZEI+RPL_;KC@1)5W3W]A>ODCS8=N\V)KR2#Q=7eY_K@//]G.P
;0M8_:1)],,6N4&;/IW[U4=F/2eO>I2P9OVKQFMScO9NIOD@@<)=6ONZWBf][[R&
aH98_8[#S3^7T,.BB(,&J#7e8bfgPRTM+G[=,^G;P(_O53Z3;g;Y+&E\81_#QE[[
7)RR6775U>-Z\<A_g?;/?^J-N)W\I+]JBS.E;//Bf3\163R>]U)WFQ1S<64=I(M\
/<6^]d,MBda,9f)-<bC0-)FF,)P(G@M=O+7V^YMH[:=)C:HRaM^+af=.<8a2:=NK
Fe?F&DOVFf^[PZK,D]S(NV_d=T_c/B0IcQf^[SH,e]Vde,,7Ig9;(<C>?aaH<IB3
TZVAM?2VKYU,?0Dc[7N:A>@4UC&0-.a4J@)64LJf:X:Q8K01gU(^6B2S6,QP8:94
&_FET?9D-29(A&-C.L@G6XVWVQ4Gd^8M+Y450XUZNVP;<2@XL..WB5T8Xcf0<_MZ
<dHc4aZ.94/ad@R_7f;M/#6PH,_La[MJBG4@<U^4V+S?F2+MC.F]aC>0aH27^\TO
1I7><+L_MQ7VQTH5GGcP(FW;IL,O:1a_;X-9.?_6/eeXF?(3M0JE^&YdUDI(+)IM
?]^E@M\gbBJ\@-YE8GMV8ZX[MSGQ<Y(30SaTZ:a=;?X[4SC#4(2#[D.LL,-7]c_S
HT6AB74aYc27W/JN<OCcV?Sc(]0c&Z:ZcdF>g[(X@F@D-PTG#WJ2WL2(\IBF:SKJ
54;ND;/+:b-7>aJ,@MCD/T/1\_X_U\Z+TD,>B:SGC+CJUKYC1R>R@DPX)=HWUSgM
aHc8Y#d7&[g9(N8N@@DN6-+YB]BEE/NS6NcK795P5WHa;P7]XQZH:J[?;Y[,]&Pb
Zb65_T+K0L0X7W40g-G<U#)JE1VV+X&2VdASb0&+Y[SAPL;PcT=PG0a)/IOeSOcg
UE#K9U<C@&bEZC9eML8HB04WQ46_IPV->\TG/[?03=]+72GD@38&c_>,5>N]8L+d
^>bV=M:@]-)/D:eeKPOKN4dEY>EN:#Z_B+7>3]9b]>5a9JU&0H)Q/@-4L58OKM7X
-9/3]:5I(-IOcM-AK?&ecFc:b_+IS6;SRXJGUJa)^KHe,KR>XX0gJME(V2P3baGe
O^a&J.6#2+71P:?1/4;[He()O6MJ(cD2PO>dU1P/RO:7?F\)-e_)>-a+LU4Ua)Q6
+3bC6R[PXL.A)C17Q;I++eR]8CQ:1>V>Y:7W:2,PQ#5CWE,,@g+J6D7&Nf7_YHF-
e;gCgPI_Z]XQ5ZJ?dVfG#:gM8+CTQd=UPB@]cT#\RTCK.5^BMOQ35cIaIfYR\C.e
G)E6f79Tc<6CD8:S9gbdS9PK-a+OC)(VG;Q0;AKH3>C/=SMbJ@f[P,-/JICH]+UA
fe9IBC[2UK)GGY_=9L#SQ.O[DdA)b5gEc^Ka/aJ[:N1dGK#SG=gUbcHCS4K.EH-I
G5SKQed0OagJ,XPKBdY,1a49>DgMZ7?>a72a9LBF7dg8U8c<2?T&+8;_()=&?3)Z
8YP<>=S=TWVfg#ae-6g<3)AL)@?>G1I^D+dBT+e:C_P,ZV2Q.cLg1@E#3A&<QXD+
8>X+EBO=#GU>2LG\a?F)^&95dc0AO<ZS\8bSNF?d:f3Q,B_MRV(&HA3J<ON8=<JT
ODcM]+[)I5NX<c^PJQ,a3=>CN;8bYKV^RBFGG/F@I#f<^](F-I3L9_)eGCT=1.Ob
O6[C^.>.R+81\:7P;LEe&D/76G@)0/PU4(X-I&Q;&:/a27aQgR#1R2R#@V_aAIRG
(\@CGR23(5Y/_gSOg?B,TaU]e(,:J+R-/;d866e?[[E]7bF#&R1C;?8ON_;cN>0G
E2/]B]-T#WIJ\FNgR0cY8N48C3\H3TZce_Y/;Hca#)/aL,TSa77UKc)5]@6N^&YV
B4IEJ:EgZ-gQW=ZJUWW])N./U-KVGWa,70=\=gc<-b:SZ(\W>A7g2)f@>5a&4^&[
fN^\R37?a6?,C#Q-?f#.SYLV#TNBI.NXN@]/EJd7:YKKM]eP<ZUH-2^_agAb,8&E
ZBHP-]=O<V(G7OWZgGB;ZL#&c;L(1G073NWQ+d4#(+DXZcMaGc2;_&aYCgXSZ@[-
[N5+B_AZBg[\CRNV8]8?,NJQ2D7T<&/be8+S:KN627\]-9#V=&,U0W>&U[)\FMV\
b_X8]\?@VL:ALJf\NP-HaXg.&,?OIN.P8/G@_0SLQCU<[7K.d9^^PKKTV2cLHB;Y
7Rd0;DaU1BF._QS_V>DYfT,0VYE4fAA4\AD?2aL)QUcR=VY>]J7VDT1K?:Y^C3DL
aODS/=1a5Wc.]GP[?eM7/L(32:LTAdR1eSKTK@8HNT?3JFJ0\-aX:C^=TK5/37K4
&GV\a[#=eMX?;=X60O7OM]Ab/2O;C=](QSEPb(85W(W0EE;553(]M+QO.(CbG,+T
G..-KP?S@/1_fS17KUQW1J]15JH#Pe_L1=ANT6FBYTHC7-Ib6+?A6(S,V]1g,aS6
#;],(SEIPY\OTgAGgA137(XMDg/G)_G8NWSeD+XN)(cRT/b[5Bgcb.^KJI)Ld,OD
E]I:2(g3\E&^H&&QaO</X=>8UL]-NPO4&2M/;g:Y@9--3ZT>L2?EO()@C(b63fAa
W^^ZU+e;82E<dG:>6B@EQ8<\0B<_gKA92Z2^4\B38cO+Z;3FIKg-J\VA(B/JV(YX
bQWJ6#>6^,29B9(V:]NH#0Z.B>Zd>1cR7LJ>K1SGe&AKB:ZJEAZIBcQR_U=OfDVW
-f8COF/6^1+0SVNgLT1<@.)<8S3044SKeg1L1J9g6C#O&)#;_W<T\4DNdP1?>CGP
d9N9?Af2H]VgX-[7Y@9@O(ZB26IC)UEWRLg8G0RDPGc;?5<G0_9IQL/:YDWd,^3Y
:BaC:9KR9QMT?I8CC\;)C\dV]e\@>UQIY\/bgFWa9),Gc-I?QBMRJE>5:?=8T>IT
[a.+A>PcMNEAS&O.::-@_6J7=6HN[Z=\V26IIF#cd#M:TDFF^N;fR(^7W?JPZ/.7
]XK@81d85-&>=@McE_O09)/WFI4b[PZM_\3d_<I[^C6/9YR@]M_PGLDDaV)cNAE8
(Rf[^T?;<I@@_-NFX@LVVQ/[B2XcYNBI+DE8.HC[=LdZEbZea=6/EBfC87./bR^_
4(DDEHVIE8C\+7Tc\Zc5\PGSSJ0CQ5R1SE\6=0=SR>7&G&G_4fVUDG?,g/f[99_H
46-)L57M(BWJV>9=fcdb<OEDYAAKVD/SA6T:b5L+UQ+US;G-3Qf8W=BIae>SPcX6
]19f1K.,C<5d>RVS,HXC^))eP:IF]TL@4aC?32e3IQ/TR@fIa5F_8UYYOgd&^aI9
L5Xd=\ScSf#SDa.CF:I?ZR,2AD?fDN;3?<@.O[HW_#AF[1@864^/I3a&X6)TF7NU
43SbY(S3>-DTXO8:E3gXKB;];g4,ATO=XIE=4ab]3TC&#f@^PJ50I-^S<Y8X=\<(
c1B?CZd26ddBG,6SE+_L;U.KNHLW&Ea+WNK\IMW;c[e(FH:#0DB<Fd&b(E_=g>51
C[Y1IQ+I]U0Uf.V9<a5OGP<T[)JdFM^B3;0W:R#)DEWgcHA3@=B.GS#/B>&5f:49
R&C4=[#:_Cd,50UC@\KR;X:.HE,B,XV?3C73)+P_@D)AMA4\YUM>9.&V+[85b_g:
;:4?D.VJ=W.b&\98__:?Y7BFQ52&,BWI[-:AH3D<Ra<,CM_+>YCfUb5fc#OB@6K]
480.+H5(c-\D\5ONH?9]5Gf3Y:<)b5<2+B&/NEJ)F]<;PMDQ?,X>R9B;,JG.gM7L
;^=8F#C8\J#2NHW/U9cKBbS;MVRPCL/fJQ3AVc\?Ze<PEZL8:5Q_S-H0_24YT?KC
^)V;GeMT^.Y&32.>#-g6Wd>;8W+)/41\)>&Nf?SXX&H,a.D6,Q,G?0SLICVdGKF>
+3T5a+C^/d]eTIB^fO\9\\[g)3Kd4,7P7WJ.ffC-4[8TP^+_C=232U\PfaO_^IQ;
>&-ARV9d1YCgaLHc#4QYM]ILR-.5=U5+PM+#0+c1g1AAR^R_C\Gc:4N)cE/OB^3a
\QG@Q.=?C2#3/EVJ0c-1B2LdSCSE3Ya#Z1RZ\FZFWEK\Z8)UfA\<^+K6L\]QCLZ_
WFYTW9O][4J/..^JN7.T^884O@U17Y6^6fAYBQ/a>=NGEAWF?EV#Q\HA@\aN&\GN
g)MPT,ETSDMT#7;LR]_BI\TQ+-K/,af0e9=.(&DcJV\VC.7^:-eHK6\4>TDL3>#2
RA;bb[;5#.AeXD5HDU@fb6RV^8E-FJ\2L+XWZ5<SVga-UC9Y##5[BM)Ja58,(75_
cW3>@M6<M<PF:0_[ZA=/@KW3)d.,Gc,29X:89&0?<fYFB\H[MZ,\eO/f3N=D[XST
d?bQ54ELOG\42W32#2Z0.QIAZR6([F#Vb:SHO3VcTK-I.CHX_d(&\TEK:34XBZO0
SXN_-:N[0)3S4a=9K=^[SNRG[Ub\]c--(R;a<?_fGV\(]\B?PD[D#D&;9;-/_&CE
-fV5?^aaJXT_-O>O@@DJKQNT&VXM@LJ,#M?b6W\3SLD)B=FP;O&_8=..D&:_TU\4
N4UW,f5e:dMY2a[N<eJ?XOVP:I3H-K0)(dA>E:RYIE/:^Hc@;\F0CEb^+W/Y&>[1
#+Y(@4SIaXC#1;;L5<C]+f,c,P5g\[]0C<K<JK7;HD1U4F?EN/SH?&fY,)GER@7K
M??VW:Y=-8Ta-4?dNeI;?&eaCL^]UD#L.^cXeU>5#&/XQS,=bLc=-]QK)V.WX>_b
&SZggMK(?VXK02@X5K:E.F5EFU2,Fd20dA]4HNM8G2[W.3D<UcE[WNHJJEY<R[NR
Z3Ce/R6B:=B&@&#O[d5ACIVX_H\<EbHfQPO+Wd2.Z<K+W[/+g06BW-NK@CLdee7Q
QGJY-NcM=/-C-@;a2V-_.:eYOK_fQ88N)6@Z#EeM)09#+X/(1@Ee\8QN;-\7aeQ0
12JE\\26V)0XL(eNfZ+14@-2bdVgc.C\5J),-[P([D0]fR\@OJEg;5[Y1bXAK.48
J@EMP+<[;e)P-cfXJ@a-2DDReLJOB[C6HZ8JKeRMeN<55fXV12#R>R\NYCJc6cGQ
&[\6>.5#e4La-\T4[d2>ZXOU=AW-I]ecLa(Hc3BS\;gI_IIP4YZ>TX]5N5>8?TN2
d)K6OFF:=EVX&9Y[E(f:^Y680NS6X36(9WGBJ<5GJ#E/10G:@?>H5+E8LccYZ0G@
BL,_6TD-gX=bY)PF#^NeK:68F,0(W@Z.H=1b^Q97.FX=MdeLX#<c)KB_&8fG@<JY
59Y=U,L9f\J?bL?Z[-7)RUeR->]<cH;S\_7)/5gRAZV9MHLFc9.-B9?cS0&2NNEc
WaAag_(7G??0UHL&TG34,.=;FAe:FM3,YTgG4LR?dUB@8ZC+CZf^fI6Q:F^Y&/I=
Y7ZFW\#G#+,13(A-Q:+Qbd#T@OYQBHT\-<+S;(RV5NVEF++J0P28JT#1P.&#-39;
#-US.X(S@I)a,[VMWc&LAPG;H;8YX<f:B-TKFFAIY@ZE4N\]2I\L&f-R&,RO[#NX
FELOH52.7AEUWKS9J7HQ>[,/2U&-.61cBHZedCbNS0dPfQ,:38<XC\VF9^NIMg1A
BW3J_&g6YdO^F1,_;^]\D,Q@d5E;+f5=.#c@[XWE2Q:MeL8d)35UQ[#K85Y#WH\D
LI_b[G<0^AV+d8W8Y;:^6_832FBGAE.5\Cc3]D@SV?9YaRZVGcR=BYO?05PfDA;K
XK17-3GT/0VEEN(I\ePPY<&f--FY7HZ[fdT@&Ze75/<<BRDa+#_.MG+.Q<XQOK=0
b3,[aR(BQa32<Q:4;JYW+8c@GZeF?RG7;O;@Z8XG6X<RM+be+=T#Z:cT]#Z6JS82
5XOaABW2Ec)\<^c42:JMaaPd;(_(@@FLT3SH\^a<P/_.VH0T1;H72+d>L:B1/>_W
@=.X.NS\.aS\7ZQ2M,8A0#?KO8&0&7QZF;=02G)\D-#K+9L;5X<=HSd_U5=6=e#a
61_/c/UF3N)bEZ8<DV1EF?LHN,@+\DN.D4Xa.&0SH]8a>>.EcZ#)L1Y)<6P:QOLR
OaTb/d,PEL1I87OO99]WJX6@KG7C/YNfd1cN01&(S^6,Sf4A/5@XS3LV;YAJY8.=
JMBIE]TMGA,ZD=S4KZ;A?CK2IC>GAK,@WcN>?C]3XY@#T<f25c?Z3_G<cD?^CJ64
H/0P\7M1G0Y,[+6X\<KBIJ8<50LF993QNU,S##a3QB9[E<MEC8\c./V?=)]H@8\&
^&[RP?aE1:O_9e\R.302)P]:88DD,ReN#J.K^#_^5\RZ4TSTU(=MLc1/\-OFfXC#
Xb;bIf^V=X-L/OL+gb?3?I^CQ15O^,ZeReFH\TXfP8TD,^IM1WfdC-/Yg9ABa+M1
8FJF8#EdP]AG1ES<NL_+c_/JGI9a00BUaIJ73LB=6T6\H@?IbB//g0_;L=WGGc?c
,#LYDKD=b#U<5X=@#H^=L:O9&QU7I3&].)H+&edE^S1;BDH:C()dgOV<XPS\;O;S
IKG0cO7?5.BY6_LYI4;Y,BZbd1@0FVVM@@[L0+>C7<PKP=(K42AL)#e<a4gXX/F>
gKV_B+5RSdTM^H5>W\L7^\Hg;:_M>7^<B,5-D;Q<A84U+aJ=X:?H7.FZ>K\I#b70
;G8_SS52N9G]/U9df?YA]]Q3;W-66;YGf/?^[6Z(E?K8Y7=T,N40d@T\:89B(cO5
M7THSgSHYH-^]]L\2bB](@84Q(V3EJ2.4?RD(@XZWf+MU#58a>UIJT7)4B\6,\PN
Y+4E>f\OUU_fOg.S)C=#/C.e,(\(.VP&NEKW]SM@_gJA-YG^EJ\40\4a.BBFa5EI
Ibg8X)<Ucb8JW>6EXFFIWI&L]8#1>6GbT,0#L_<JHfaC1Y?Q=#ePC<2fX(B6GOOc
^.@NYP=CS6Yac7BI>ICa?F8DE9[)(4F9:O#1B?3DU;]9LN?CV-7;0SQ.I4T=4M5R
TQZ@G/0#^OHbeff&28E(3[Z+707X._&M\gK[S7L031\P2PF,_-MOA2-Ya=8ZREg5
:DBL1D_>/7EW?DZG,4TU61aF<X36,4+d,4_N7VWJMaHM[2fM5K^K+8B1_-ECUY&X
OX+-[Id2:JaK4.=K;^S[IGYbW^[DR&Cbd,8[FE#V2W9/FO4bHF;F.J8)TY(\@JK9
@ggf++C-]]D(<>Z;KFY[8ZG1+&Bf<gC.CO8>#G)g<+g,92OZ&1K4bVg6=f0BRO[+
>;:(K\@C+NfI4[;F\+/L)D@R^<UW060#eP[-8>E[Dg8Rf+MG/UBXXZMUVSBD\;(K
K)P=,P3+36#RfQ98&U:bA881[G)VH.,0N_1<3^D[1bTLgK/aT[0M:_.1b:>&cAYZ
7N\YG>+8-6eL8:KJ?d->.A?EAWPM8C\fXXW=5K7]I\33A7U[C?VeO-O1+CI9AZ)Q
NaV,P#<,LI6K5CMO-).RX\DbU\c:92:cRZ,g3=QPL<OIU_A-Y1E^g-\WZF)_.1F=
WO;ZZ&;9QKfN\NIIDa4a5d[8_[RH[9X8:ANGcWQL3U3Oad>,/GTN5=FeZfP<CXYW
e&)A=c=,Ob.c75/,LVYF49,[>?FVK1(2TJ>-H<VDS.JX+8&Sb)>1UJ2Q.18ed;[d
Q?CdKGBN9PM1SgN?V_Q^a[-,e7G4(6L]AFL^E..M13NZ+.Y5V4##;Jb^PV#<S-.;
eL=J3^Q;7Q#C3(dSdSQ^1cd==CPdBGJ7DMe/D3VV[HXS=(EMQdf3_8V<eG9LTR21
\gJ:DOMFN\&E@+>RDE+W=.T,Z]c_f=a(7]bHTTZaZWK+3<_9JA?C4O5eOEb2]K/?
OENdXH^B\YACPg#Tf,/;((a&S)?O\fQ9Pa\\R>EDV.H]T;=LHb:W@[,aJGfcWIaV
WBG:Rf:T7L]0Pa7B6V4KR#J(ADYOB-4O,M6GL._aCB9Z63A9I+N#@S:G<=F@;331
J^@#Z/N\@@,D7ed08U>I:TG1AH8/)Y5dE[@EK3YN[ELP&I\>V0,0=Q679fPC?J.?
),38LD5JAR;?4R4,J?1Y;\ZRK-?VZ\VYBHeZ7#SN0(P#&4R_/aWdU61<(8^I=QEC
6-M1MbeVbE\(Re>-8RG4>K&0^>T3?NfP-^EA]#<W2+C/@+#,8NbNZ5-LH7L/a3KD
_ef16)3#-MaE_V[^gGE<:cVSA(,1Xf(2DC4H;>LA9WcW<GHWg3P?Fb?7C1IKF_.X
)60E):J3YE#/g<g;TH@4+0MP]\E9N03c/65W;&fMC-XUOUL^HQ0aJJ(?6e__QV1Q
]cJ&)f=KI=]fR;1]UFC:2aJ^9/ORTRNY&IcGV?<3CSUC:L.\3dELb_EAT6XAEeIS
@=M.ggg\SR[<=,<V6MBC]:X43AXA2&?>g1_+NWB+P&&MX8=IH&1a6S6N3Pe4+.9P
fCX>b][S[UMHdIHU5(EQ7S7F6fBb/KAHOd\DDSea<2MKa@_1IA1[.J.]Y(/5&Z6N
,TOa^NU6Q.U]J9.45O:\3<2c3\TAY.N6aKV&V;U2A71/&9-B?M<Z2].J8f/LPB.-
LA)9GfX5VV[PA#cJ0D#8d?dZeZB,GOT]OTeJP_>@>E(AL2g\5H&\HO6=GdS&F=?e
=8CY^#T\::NZ#We2d<9fcfKJNSb[/9U\?K(_#6<T[WDT1^gKV?IU+:]3YB3-,@WQ
:QUa3,W<(5fN;6/8V;\[;a<T3T5Q<MXJZ<CZ)=#9S4Q9.H,?,DT\K1_dX@^2f(11
\9e7WSBUe.#P9VaVS-g7CI(#c8FeV(5.#WN;W-aW,6]g9)A_#gMHG.-#^-.RV6.=
.__U@WN:D\;Y;UG@R[3I[UT53>?.U8U@F]4c@Hg&)OY\YJ/[>QQe_dRa[48Cd.Pf
-?1_[)XAA,PF(T+-<6[&?#)b/BF[LK:X@^5Y,PS[UZ[K2DUMK><:Lad@XO2_X2IK
a:=I+J)R6FXP,Y>S7Q/a]C^9IP3L,XN[.=VWe;4f_7+4N9]]>>DH]_[+C40\5IB0
gP2/WI?PZaGc.PSb1DePHgSA0:KfX,>FCUcT(P81bTG=T0L5&5@U@ONW,1?J+.4E
0B).dV;RN-LU47>PY9/4bK-d_=g\WQ:,Q;de3[(P6bGU#bKT24;L?=JKQa=05M]f
<>-bTaMGNMW@H[C8+eS:N6.;LT+.0V=YWL<AKaZAVTJJN_HRAfOZ-fc#?X:I0(:F
Og#bYd_85V9_B/_.(/+B9ZM[1=D-XUH6)FJ(E,]Z_T97a_++BWMQHG#eKN7G8FLM
N@4MU24H=@7d6K[9MXcJ+TSdc4d=ST1\^2+85UV4a[:PI+fSUW?=7<EGbR6BA,P;
.I>0S;S9NEIX49=)2,d29IeXEXTd#AK7O7QN6<NOFG3AQ8g?7CND2O4e<E&3]8aP
4aBKdN#J=/J7@/M=.QBTJ@[DS_+BeMMO,K<[Vg3)d:1LB-J(E<=,+7L5>KV2^^Z+
5-KeV>V=ZNSP@BMM,b2&>5?@DB0>,@Id@,F((S[29^fBd(9BC]))DWM](X[<=<JU
<HLWQ<<HM@_.3H\GL[A\ec29R7J5@b+22OSY4,bHfG>=SHL_d;N^DM-KR\-F)3b+
XD-Q9;d1)1EMG,=XL?=N#70GKa(FTT=D+H^6d4;ZY8-b6XLRX:dC,MH=1Tb2;L.@
[\5&RdF1eMdIE#:;Qd88S)BYb>4cWPLBSC\aF@-:NP7PM8NcEQLIaL-?U1@K72AN
RW?0cWaMRf7R2I)c-[YA3_AeggIA,.bGL=ZLE\S?=V7#DH.I>>HQC1S_B,2dLYgf
Z^U6PR1UBC?.&@)<V-CKIB\V_>OZW@Db=VEQ#:85W=[YBTN.:eC-@6A4D9QZ6A5)
9=^26I1/BC44?/,fX(#EHR(XFG4GDHBSW>UBCFDUfR&<6G45Da^JM\f^5g0&U3TO
#S\<^[?-YEeF9aL_989,+_7O3@.X.<He8Wd]P2=WW.FSIV<9-a.G]5HB58)ZX>:8
2<1G\289P^2J<D>Ma@.-?TBFFS.fSX88,8#M=ZRAW1d#QG\LQeZUM[)A8R@H_6(C
B3P@Q4;T#ZfcKB^7MMW830bW)3bF_[RPA;9K.VTWK2D4cGL??RD[E1R_H[7ZR]83
)X5RR_;2-QG<#S;8B@_,L,0AafY@ETR)0e?1RJT1JP(gNI3(\._G,3M.=7B;\>?+
>\?Ma7F\50ScXMLS/H_;42b2)PcU-XTgQ+GPL@B[eU]J)_F);XMPFb@C&JA[5<<+
J?;F\9=GJ[58IHJ2.9e(3K?B020/9\+2<B#T8G^WWLJ_Hd4^RSLN0bTe6;_A4b<[
80]UJ4P[21O+]1/J:^S=,d+FP/W>85W7Ae;X\D0E#3/d39VWeTgK1_KcX3HGcc76
^I@4b9PNLOG+OCfF,fVZ2[9ST^76<XU8beUZE^PPST3HTg/Hd7WP&M]Pe#UUE5EE
@S9MZQA3EOW=F&#d-Tg@X3([WQN&OWKROT9-)=VaQJ,WBJ]1AJ@K<?Ca.X[SW?dO
UP:-O>-AIZIeAH.(GGZJ[PYe\@^;c\CS]S5V4&):>g9<NH]gNNH2(g(T/G[W?T1[
7Z(@f+L\MPfb+S1E&-GNDD<G8IO0^#XA0#\a8,:?;YC_H@g^JdFfKND0cb;OYGC0
C@XO=]#@BA&\CY1c>[U<):3F^U<VSC>3;VC(EI7Xd+MPH&9NG30U^eO(:X4R#SIT
4LVPVP#[A&JO]c?(HR?.7X>6,c??GP[fHJBc#:C3Q0fGeT^9-aDMDcebRB,H1M4T
Ad1MS@?:SZ<^?NZDdCBcI2N@]9BJTL<<KR,HL>:P>1L&U94@N2H4HJIJf]g<GUM0
,/@W[Pc5\SJVOgE+85A4e[B;GZ6TAg1CN]#BS<;fK/P>a@ETJQ8CB?U[H(c,DcfN
8XCH9+QH;cSTC1AeOI9BI8EJe9^:g0W]Z:1Y-@Wg-9A=BcG,4J@_?-Q;?5)3b<4O
@64e>Ke;]eYC1H?M)[YW]I<.GZJ1+FN[E3S<@C69&UNTUAPH2286YB.@I.)CB1)/
1XC)0&F^;5Na.L:/0TLS\G<18Jf0#OZLBM?BM.2XX3.;P_gYQX#0[,LY=d]J6ffD
73@bHJ>^:YP@5afWe\N0HX,2,Rb#6X:TG<1UQ1.abRLI\C(:<0-#VH\bJaWL#.<Q
_.^c[XO)f@:H9Z#(.,g5^7/YQA0NT.SU2VN(TG_/0)M657aKY8Cb:]VbHH1A(LJH
>AcHIdYC]Sf^-SIIB2<Q.+7:=>^dDO7B;8YA7ZT.#@+8NO-79[9d3Lf.UP>cde]G
CCa:II#:&0.8A#W7.aXHDE(XC:<H30AfU09;::g#C[+E/G]OR)0_IZRecZN-AM.c
7-\4,8_#8#&Z3cSR[:L=&b5YN=g5aB\^I]S1QU2_A#[K)faa./)#8D).V5.6UaSa
b_SDf,2G.S#V08<CBG(Z#K+gADN21TRce#R9/Y^#:@K:F&6)8K6.[N4?bQ57#=bQ
K:Q:KXZ2Q&CXR)bXa^47AS&&bD9(X/WIC&7_^<H?TFF+-H4#J0SI#R?L40;X6S&Y
ddWE?aG0E:TEDeN?OA\(]I><94aBTT=)5ARX03/:^K=54_X;QLGb+V)H77IeUcAL
I\LN=P;fS2DKMc\KT/BB4Z2:?fO8O48HX>H\T8(GU&YQNc=>SQGMAC\4<<8J0L+=
8=Wd;&.7c8D)b[.7a(;B5aHFd4MQ9JF#_HKF?eRRV40-^gPBU4A&^/<(DDR^L)G,
_2-f.(V^,>ATP_&OUU/#T+c?OZ)UAeaebZ3^&I5d-RQ-II2NQ>9N>@K5HFa3gK..
L83ZMSdc\6e,,)]Dc01]3M:SP^CbJe^ZXFaZ^A.e-bKZ]A+448/H.;T@DAFHGR[&
_&a^+0MR,JQg\BS6Wc/Yf.=ISHJ(7/N#f.ZMN07aC,.??>QY\8C.Q:=>V7ED_C>3
^SX3^L1:LZOS7fU8@ZI&YX45-S)3KL=0O\OD1=O_WW+f3gY@AC2SHS9ebf,CSf-K
LP]-_[Mb@:Y-_EYWbDP]4CRLGJ5K>L<[^4?M=?);/We1.X.\9/I^0B9^_I:+S;N2
N8IFgI505LLZ=8QZ0N,,X[21Z>KA<]J(533=<OU+8g#_dbbQad&9?CH8AVT/JCS5
0eKO8UK9g@7ZYZ,13N-AXTZOPI3HX9LJ@fdfMEa(0T<QZA(\&PFFDgec<CED893,
Y24N3PefFLM5IaBHeA1Q.P(7]A?4#)D-S4NfVUP(WdT@EFV.015>761Wg5PSDf>H
^&^WC_MVB9O=ZB91&Zg43<1]ac4.L8X6gRHD]I]=QaY#/M8a^4/:@M,6R(9N6G,X
&;0H3(8\R33T]Gc-N?Zc;2.<#+d4,#[=P3C)L4AOS5ge<^fMDC96RJ&,g/^S#VZ)
=2>E#S92eHE_H6)_#VYRbbX0(/Nd>,GC_XW>Db^MbPKf[]TM^cQ.86L:[f4_K\fc
+S2;c(N&FO^DIG2]QO797S5DTK5=5Y&U?:&G@)K9]G(@<GgHF>)-bLGX]fRIB/B2
]CO)Rd1,^NDB,8ZX91af5D;EL9VX764DV-97KOUU);\2=CL_HV<a?AfD6f3KUN_,
+(^AWLR34G&W,H?@UC\J#FB4,&YcgAdXNXJ(#TTBObZCQb>C>c[>PSAb&H)^fU;Q
1KZL9TJO\6a\_H]W19^e[&;CY2P2a<SM_B:&1#)feK(Tc^Pd;e)UegQGPB=N+]#d
a?M_9]c2J#(PPXA47<9f6JUIC<YdHXK5ZH=,9/>/682Z[2Y@)b/&-=Pd4GXb?[)f
LJ#JG6gF[0]9XFe)62;0g;<fC]5(?7.W(dIKTBOB,BUO2W2Y35+3J#^./6(D,8]L
A74J[=g-a9-3TQMf?Ue#d(BPO6S18-g;L0^U77RH&Ig_XPK^VHZ=ENS83D+/LJET
YbEaRSQ57e2X+J=Z;dICPE,U]EBY6.cCUSf)_XS,:3G,Q>>f_d[bO_@f-::P7/3c
W9E9(0P<XB3C#A/R+;QbdTT?A.>g,Qd09XAU4QO\WH][[+WZGY[,E]TVPP[H7QcB
U[c>R(V0U9OL2@68M;>=cf.&EYH5b86>Q)HR0b3;5718^E=?9Q[ORMD-C2Mf8_XM
c:5C.@Na#ZSLVg=4784ED2.Y&>4BS+dZ1b9BcC\?dD=I3=D&5@IfIYQED8]<0b_I
2RR/8@VTbB^/\AH0NW&=@F[B-60:41LXKOIIAB?f?EgGDRW:#b,HK-Ef.6ZYPC_2
Lfa>R[7L:Xa:DC2e]C+\P3ABO0GR[CC>89g6Z\6FR,IRVJ_:+L&DfY8?>gN+_24E
W8<18T84XaJQS1Z1T0=a,T=(:>K3BQSKT]QV&GOFW?H_@?.:63AQ@>W?B\<HF_B[
=H&1CV/;e[4a:b/fT3]>ZZK(-#UB#]c1+8OW_<>fWFJ7E,YMC_5f96,A)1+b)Pa[
ebSI-A/bN_@BdPb9NS@@f(BcZEc,Ga8PcMV7A?1C<ZeZA^;IT]I-4@FT/9XM06[U
KJGK.T;d?,2(+X-YeJ]U.]#I1Kb&\b8/Q11Ca(adR)GX2S]=<+6=\0-T-^XOf2e8
[#-GYN1ae=B2=6If4&(c@9<[YU.U^54):158^;J(?QJ8?AV^.Z);;=f#ERKQKL3?
0OVA]+,b.0gGZ4L;-a\MXZ=@7]e:&EBdB7;a5MT109O#c,MgL?:^f9[O&(79&R(Y
S=YF5W,7G0,a2>C]9J9)74L-_+BGB]BBD7(g/:HY++M+M,8II+=;X]P(._@8;37L
V\X27.>PS8,Y=(&=/R<HMP_2(CJG<EA\ANcg42.4UV0/B&X(Qe=&[N6T/b<W_3:Q
_A0B8eLaP=R.DGdVV(^/^5NNe2):O8540gK@b477Nf73X:VdW4@6Vgg),@3D3-30
A&K@V.Fb3WQQa/MZSfg0IIgg9=b)KIfWO\2,YaOMH4ZL)4_)\4RdS;&=f.[OC5X[
7CW\DaY[C#KS7.0^VVK=@-/3O^YfRH)JNRL:8EA-9/aVU(LF0M1.SQ+e.<.?M0U]
F4D,e1e/e,X1W-PD[/()J:Ya)fc0:SZJ1MaT:K?^g&2QaC0baBITP53RbfU5_>+\
d+[+F6[Ff1[31/8eb,Z0-cJ;4.X]ebS=9_7[.FA-^B]PN:75FaPB3d<>K#MZ@.L6
CJ1WL]J4WgdS=G)9IWCA;b#[3^EYWccCCNA+1UMQY_2_8SLOG1^f_EGg?V3+>:HC
C]CNF+\+MaUZ=0&-C60;>C@</dX/fD?>+fE>XFH\5O+Je0cP0LD9L?bJ&?3>NMRG
&MV5/R[5?Fa@NTGCU0\)M&YP73VTdQ+eEXKOA&A4agK&?C@2VK==^@SF<e?A4\,,
7&fZN&HeA&G64RF=GOgdET(-f5^LgbW5Ib.4;=_E#QI[P>ZXK+.gSC\@a]Be9?6-
YecH3L[J2CTDNQ<_aCGe2g3]13g=D+Y@&eI^?Y,(g5cFVd,Id\-KIRJ\Z-&@PYP@
cNIc\-<SD<X8FP\=G5<B/Ad.9EXT8aH>OAbYcX)dYL5T?&gbP/cfH-U<K.6_\NJE
,3B6e1-\[aU.IWQC7d7AT0Cb8UP],3S2702PO5:5:5)E8M2?eV+SHC7f?deP\;IL
;+Sa(:+c8E>84/GTad:EUE8#LX(Y4438MO?^JJa5dd:XW5X1KZQKKUWMV@]5O6d@
NIaaE3KRF?KPeDTc,5,-QMY5TWHPFd&3X:\)eGUd\#J7+^Nf2NQgaX5;=OLO^:Lg
FfYAXb2Z24;dUC(S#H04<a\LCVNa0H7MB5XV,@L;^&ASF,d4+GEa_\[()=3GI5>=
#PL?L80T@U>:D-bFe.g/^J?]]&Z(6H<M>>fB2L^I5AM[48MI\?69)(.DKW-:5V_C
Z7RKS@5D:N?b\T:1P4:?I0BCY6.)e\E;4,g>0;>L#/9)G1B)fV(K>:V4PV@U[B@:
,N6FDS8b^fXOaX2DO<3+Ka]cZ0+[G6Oa]a^FP?SfC1b6gV./XZd]&ZK\^C\+PPJ;
<^OU^<[]&fQ=0(G;C;=41\H/P/T=Eb>06&@db-O79A3.JAK,51;&#WMV;beM+dK]
@#&7S(FYgPWb7d@.-@N]+4=I2d4PJJ#=1QA)ddT3g.gMA0X/1+fJ[0=@,ACU:Bc#
b9H3R,X<@?GNH[?4M7@C>cI?7?_)^IRZJR>\89fRB@(#8(19YK_GS?g#dB(OMBIg
BS_D#H;3W8@JW1#SW#@<[8eSWQN;eJCI)E#Se2<,fbY\_F75g#B^EH43b:#CKK1;
KRZ9L34?.G8c4F0O/[6)<6fF&OZH?,X2<JO8R993<3JZO0P?a@8;a;W#\O<;0&DS
ce?fd1P5H3U=GDA0\H<.cd,J=<VB8-MFM>fd@Z=e9SDZWI8@?5AY-e)\_\dLO5OR
^g>0&C8M440L6fXEMQ3]G07?c0N1OXT@F)5bP^^HW:,]Ne3a_^f,L#/X.CZD24d;
8O4.LIR:FG/9GOQffA(&071eK@gLNJ+&=\R8g[HZJB)IQJ2D)O^QR4.C>)TKe-^<
g43W729&?G>&KFY]8LRcIX)&1)SB9,7d,PZ9M4^VH5?D,B/\AOX>?66/393WQZ^U
P^OXSeZ98X<#M\/[ePa>T_XAL=(d]1^\\/2,?6DG_;0J#F)9a/C269QH=LcOU+_A
X>7Y_P^BI9N6JA9e4f81V_g7(-eY))MC=#_dLUI76.#<X(/+gVb/Q54:_1,J^8gc
fI<YbW3RI4MIge_2045.cQV&0eX_UH#D^#WGb)Nbae@IYg+#(cF6N+\]JSQb9@+@
(7\SG)0VeE+fDNKG96(;J\:H=Rd5MW5Y-bT[)(KWC7d?-#H]B<AGNO\]P$
`endprotected

    end
  endtask // do_cfg
  
  //--------------------------------------------------------------------
  // Task : do_cfg_rd
  //--------------------------------------------------------------------
  task do_cfg_rd;
    // A constant that determines which of the model's operating
    // conditions are affected by executing this command. Next sheet
    // shows the legal values.
    input [31:0] param;
    // An integer that specifies the new value of the operating
    // condition specified by the value parameter. Next sheet shows the
    // legal values.
    output [31:0] pvalue;
    begin: block_do_cfg_rd
`protected
:@/0--/<[X:=#3->KU:3AIA6GYLdQCe_c\Qg+7aOHG=\;aFIYeB;/)6RMRcdd]C=
ZB5+@_gcEYUPcQU-QXR2.G>?_27R0X41^H(--W93Y6_[EC1V^AfB]+Va-MQ4==GP
)^c4ZN4O=d]6]?9S2FA5.:,J,L@O0/=K;b^Reg<XfXJBOf.RVZ]3GH9#R=@S>DeX
?(X;Q:/5]9WP34c?T&:X#GSCg\E<(W9B_W;.]\\Gf8/fP?=6\\GAf<fR+0<7,)U=
PeZ8MH&<UcUS,<T:5(RD=\MSFJNEfMNOO,0Hfa5BFd[]^fCAFb[(1[gb()G3#4(M
3IW5Y)eVL?SK;<99T/2b[U+_:,S&I&]W/1I/0I]M4g.J5CC6HX3aP/DRegb1,WcD
_Y7C?2)4<;(LX8LC)JXT2]gQO7SAP4aZ<(@6bY9P75HX8V\VC@7F3aQHHZ&fCdN0
@5XV+X?/:TfO,&b;AU5da__S9ZD?6A>Q1T#&(A_#Y=VYJEF=HXBg?>-]>-2K+S._
B&bT6)_[d?ER:aP;N6ZS;A\fCC#Zcd8R968G/G\8gVU=J6I&JKX?GKR=[e>aC<J=
L86bI2+M_41=)ACbD;_R\4ZCKLf&KG/-9fR<CB&M,GDf<R3R5,TR0ORU=1f18beQ
/Ygd^GLK_I6Zb8X/A:T:AWB5FRX_d70+b8[]TS;8QN-FFPZf9[W^4=+.5AG=4,SC
G+DV?X7KB_T)F\O)b=[(093PDaa6@7Y6Z@UV+\VAAT+QFbHL^cVUC-81:f88/VK=
OI-+M=8URJ6bMA:]=.DeA5BGc?f87UFV_XGS2.H7H-RIZ>dY6:e^/:#/KRG..Q57
+1,eY;(\)256Ya;ZMAV]/E6E:3A3P2cRU.NACJB8fMV-14aEH#cK7B^Wb+9AZX,+
2^DN?D64A>06@d]5WeM7QRF+&FaEBb]S6C\O>),J@-7\@1EJ^#S\G#6;0])5#:g^
?.&5[b+)R>7GYJ+:SMMTK@Cg^Yf>NbFM3-2I0<eFK22FLS0f?=dBW--YUB)P6<BB
AQ&fS-/DF038@D4;UaQ-#LL(5&<dHI4c7JH2YBT)d6;[G>K\9J,R/).6dL6Lce?Z
He7?cKY9HTd6-)#)T+=/d_7N;]V--Jff7Z=<?K\OT4HHLgQV8#U9=Cf)Y+)0D3.A
CG1b.995(@R2&IITOVKc\B_W^G/f[RR0aN1Ie#K2)):&5?/3?TC;c^f[8F=SA3cE
Z9T8?>FV_9ZVWf@F:c3SaYF6;7)J(S);d;U=6[DAPS:eFDEYOd7>,1H:JAGJ6E8C
K>^\Ha?#:LO73E7(U,_fXC4aI8YCF8-[<3X&[WVg48RT&WXN4;FK<@e[SG+fTUR/
0JIH^9VW5Y_:#<(AXfPX]@7-OSf@Yg.L40(]>9d<Y4B7G+PK:\.eOa@V-HB:)9UZ
+WGH]34HN(<Agf@N8G3BG#]OSCg&[^J::)5-ZV>OYR?NU4fP-.[-[3Y]P?YXd<U7
8)N]BJ;DR>)XVFK?3/>EPe&AQ13-Xf\)cJYeZ;PE9@C(0:YKG@@-g7dBfH>3PG,F
XRcWQG&<?I_d@3VG5UC,ZO(ge8_]a\>&[^X[H3_MX61=>R^+C-@G@5BaM.T;6DB:
<#/N]L:U.;:aFARVX)B^?1+\=]EN3R51@PcQ_K;)[?SKO)_LFO;B,_E^S2,&\X^D
_WA\OM#1)U4J/H+EJYUZAYFbfXZAf,.dDK(Q/NJR&RNQOgf[[J?CcRXbG-Z:/c5Z
6Ff?ZAA26DA4DIUV?8ISXKL#Qd(aaKTWYegGKCOEa=3PLRVNZ_bcaD#fRO,M-&NG
#9(^c.e.DM7GY@^K>XKbM-V)(BfeE#:Ib/]HSdgBd5:GN<+5dX))NW_cG,Fe/fEW
X=J=g_aRKb6<4N<U_c[_+H.DOES;A:,V9XCOE9T)U.^Z;R0e7LOR@0Yb#O<]5UOc
QJU+7-Td]a/?:Q^N36gH>EX(>&EgLAI>KQN>c8aP/J:W1(WTCca1KXO;H@\N\.(M
+a4a3bT[?INgg)a[1Cd[?39Z3YJV6+(HX<03=2UKbd/A2#[?FVGDe/,[;[8La_eW
M3WACCZ9K6VC_@-PZ[WV7<LY)#I1G?YB/W)=J92J)CgYOeQYDYc7Wbc25dP>FW:7
72=c-3:b7@5.fF3H]S215=ZcB0=+[>?S2Q?L>?R=?FGeSX#;A0QE^/\W[QdVW17,
2eAKZYJY,L+Fa0)MID+LgMUB5,Kb7H003)MYBLZWH@H<RA\05?E3L45Ce@I:cG\^
W#MfID>@UZg/L\W/]4:8\38(6WO-#HCSU]e\V-C?(3GO(Q>Y,<8aTE;+<PW9ebKf
X9.aU9HIW6CH,IU39F[FXBeV;6N&PK]dZ/])7ND,I9]S5RPG,+]dWE(HJa-M;fA6
f</EA;)&8>(-3\(fBF@9_JgM)Kdd>B]F_B^V,fARHGZ?OK_Q/:+]GJ&eMUeT(9Yg
AaW2<YMAb#aS6MVGH70L3^>_>3D],0#\\2JF;g9cRXR&VGDID#.AUcL[JB[KSd#)
ND1.#\RT\<^-/dNQ_D_:?-H=V(PYXJ(K5F)Q?I>I+6:.E^UA2ADOb+>:=b8>S_2<
9J9OZ#KY8/^ONQ1M:\FR8Y0/d7P-]2aBGC=b@Z<B6-76ZKJ/XC)(B^EeOQ<L))?L
T/=U.)cN:Y2:aDP/QZ9RRVDN]JZPO=QH7P?X[_,,,2AO1K,D?9>=WM>>DOCA+^_f
8^?4PaPP7-U+5S\SUF7)c=fB4@K\:XO+X.IbF3?N/[#PX[J5MLI_I8_#;397\0E0
KOL\d[2(G2JA,3U&e7P3adc:eLSISS4^Xc_4F/XI]g<<HXJcd\-LaX\Q+;,O5JG=
gK;PU86gEGB;JA;bH-VQ81]KD;Z#8Rb7UL9R.c\C]cF6gYH[W]g5<;3.#8D)ReK(
CUgdR(E:I1Q/cP@T@/3B.eJR-IbM?@DBB04O>WK(.7MVbWG6;5cC4TGNX_CR&&A-
I^d?M&YF1XAMe>Bd=(;F]W@2f7T&+R>F9?67XT-RON)fdV9D8g#GR7?2c6>_-0NG
@dD@9,RIR<W^A<)V3K;+aYaV<=I0FKbZ@EgB8b^YAG@a)<V,=g/1<7c++>4Nf^HW
=b4ZNNWKRPQ^ZMZ6_B5Ja4aV1$
`endprotected

    end
  endtask // do_cfg_rd

  //--------------------------------------------------------------------
  // Task : do_err
  // This  task is used to  inject errors. It  sets the err_vector_flag
  // for that passed error to inject.
  //--------------------------------------------------------------------
  task do_err;
    // A constant that determines which error is to be injected. Table
    // 19 shows the legal values.
    input [31:0] err_name;
    // Specifies the value to be used for creating the error. Table 19
    // shows the legal values.
    input [31:0] Pvalue;
    begin: block_do_err
`protected
R#MUa,Fb?D,G.]Q@1E/=EZaa3gacWM5078_&V4TFTI\M/>_aI8F86)B:<0_BVDP:
-(4,Q]Y^@]fK:TTCGP>XIgK260[)#cFKR3/_F2aO795A2Q1:H8\_O9-ace.gD2D/
LEQY9+>>KIT3#,JR)<^T_&Y@&geS084PH@Wf>(R354CaR>RcKYOC+H6.:O?83401
TR_=OUH4=CQD?-I3D++b^1@+[g>\,W>YR(b6MGS[J@g-4,,;[D5VKT\O>[be(;b1
.)PR9e\)[Of;^]]bMAQOd_7TWIWASKLDgd4aa+EQOICeS;dZaASVb2+34070fWGI
R5fWdQ53XOAef<F=J#^g36dE=-G96M6gQ-Y+J-:@/d,Y=982ge,+e?MD7M#bb4^^
+]QU,]4Q6Ob_DAS>S]XIOf&O1\XSPGBLDYKfFJXaC<\Zb_(c>4GHg?#PM)G0IE4T
/a=(UB^E@d75gH]K2DKg[N/R<K8]./Tg4#8Ve+e?75fMX+WQ,6KL5ENV3d^PI1A=
a?#;O<c0;3Q[GX^1N3S;^.)[#(JQ=)G#/ZFWRLJ2B92>20Gb[^#OE?5>f>c-T)#1
UNZaY/T#N-;5fNJ4DHZ@8QRG7KOF66<07CeL[AINNT#FbC(H<Y:Lb&O^7NdN/e4]
.=\P_[)\bGg@Xg<KQ7N?g_Y8>PU]10VFgUI[=6#BIJ5A5OG529eN]XM9P8\E-cOF
FXY?IF&(=)RB8-1WZOSK?Y<[e@KDLPEObBG)IU-Yf2E]Bf,b-V0?>e4S@MC+2,V4
eDH6Z9]>(YB+>=;^ObJ(E[ALFRWL:OdOHb1NBU_d,3#CBK;&d0+Q<.-dO27([g,0
4a(:g?Y,4>S-PHKb[>ARIZOX89EbRTVdc\>N//eQ]8)g[9+YgC4F:EDDUBF1O7&O
>Nc78YHM/T1QEVPfN1TSJc.60C403;J19(ML&J).3C@SA:7.LO-_<9gIR3[(UQE)
,E\\9L->B,)(XURIg<&CN@).C(_SH2T7JHEN3XXHUeD]&&=@YVa[C_3a0_^XEE8A
^OS#Q-TB4H<dI21:.Y><P8V=3e[;J@-V=b4bIYeP=;[R/A0E57&6cSO/4.P-G)a?
@E(M73Q2Od+MB,;12^c:Q7FD-;)<\cBgH(A?R0Pg>Q.5H-C=dF+9e)F8(UQc6[YY
SX_W<bJc-6[SECd]I:0IKSLG=/P?PT6-LB2EIfV-//51YeY_c/9JOaV,?)aTc]2\
NA1E52280.8EcCdUOQ=_JS1[>1+[XYM7F#f]bCDOQJ?ZHVCU.WUC<ODHJ9KPN_0]
0,=Q:(]<-.PBB]ff@NbbJ51[6$
`endprotected

    end
  endtask // do_err

  //----------------------------------------------------------------------
  // Task update_input_arr
  // This  task updates  the input_arr of  the pool corresponding  to the
  //  next  transaction  that has  to  be  stored  in the  nvs_uv_pool.  The
  // input_arr will be stored in the pool by add_pool function call later.
  //----------------------------------------------------------------------
  task update_input_arr;
    input                      packet_count;            
    integer                    i,j,k;
    integer                    packet_count;
    reg [`UV_DWORD_WIDTH-1:0]  dword;
    integer                    loc_for_data_in_pool;
    reg [35:0]                 mem_dword;
    
    begin
`protected
C(6J]MKU^X67OBPcP_0TRIIBgXY(0BIBNTP8Y--a#?cUF]JNMJ(P&)BXf&9#EVYA
eSD&MJ:0G_3BM_@,+I2&C?C6JE.IA)N#Me647fV1F(RCdeKeC=E35d7:faZTYIS_
R6L3LP2PMJHQc,8^1\Z6NO[#&R;d;Y/g?YI?P]8,@BG)\XbPIN,C_d-Acc_G@9N_
7,c5XG7\DT,Vc^T60QHE(L34+6I=b+g1LH1D)XL4BVK0VaH_Nd(7/@&G03d+-H4e
=D=&81@BLME7G35MS><[R[1S6?3G=AffHOKOf60Q3gaeeTR>7_X-:)gW,#E7QE3e
;HB;4APD1IFP(6OW3)>@\>FTeJ#cKeT_746<g@ZXD541&OTeK#7<=LI&[=EMD9Aa
+#1IHf0W7^^T_5ZEPR]DKJ]_-0dNO^&QE&ef:15ZI^I5OY5UJI:LBUf_J\X=PYQP
B945,W(4+DaO3PTB>7egMbK9A=WgL+V\JQ,QaKXA6T-a;Dc4U[R<>+KX&PJE1#QP
ab_\JP5JMC(VIHdL0dS?39#(3\>Y2g2J2U#\+KD^Td?X5>PgD(_eG<c^-+\T-MP;
\E@VTYK>^ceaOL#PC-.V2;MC>Z.L+B;8VcaK9]M.=[J23MJ0.[DB33P1<P^2F7X/
L.&+X-g3IB(_&D;AZe&GT\H<E_\TO&G^@(gN1OA?1CfBI(.C&fVT-+O&P2I<?6fg
(Cc;A:]/Ba:&9R+]:+4bHWLeY5gHMGF0/F_;VYE31D^7X21E&?]5GMeaIcEX\NeV
[[B(1205E+aJXd@4<(NRKLPb:=(85YOU/[OgW?0<a?bR,;@8L<bGB,,b&D9Sf<\/
a\#.bUZNH_G:@K?&;A2aMI43+9OB\P;@,.[S\/e\I5:FZGV[VYb)I:KbWA]4(QV+
#7JdIM5WPSbJZAW;0P4c,?A/@KeJbcRM>9-?b2&JbNL#4g.&BIUL1+7IXSO(87c8
:IRWXE]F.:Tf,d^I>A2OM;95_?S(/LD,G_NeaCI\e&T+FbHBgcV=O5,B/C_6.,XB
&;7_Yd<+a>T?9(\O0;[^,2O+7G.+?C<YFZceeC:>->6_E<Ya3FDf&?a2NPJEWL_U
;L(T3KNVLU?6e/,NH3/3+6QagXW,A4,UbSH9(g0;dZ_4)\3:5->IPF-]d&KP)Y/_
K5dJ=1SKdC3SU8L)2UG8N^&289A#8O1F7a#WcK(9(&4YSgM#9DTRB?@G0,26XGb+
DJV\OKG&)TK1M3eS-XDB[JJY<B9a_&aZU(F7J-Z?cSIfKPRLF(KCAQM+URPOPSW(
S7N:R;](&5NSKQJeaeHBD]^d+fB-e&F,P9f]fYQR<b,R6f+(\+LKQ(9KO>I1EcTd
\W]eQR4)#=KG4;?Kb0_J0LSe_fEH,WO]XKJeKE@UJZQMIad(&.5YN9HU)TURJbF&
+Zd5D(>eZTa1]GdaO-EO3U^Add9:^N7_<E+#:4aF9]&.8RV>0PYR4&HL7D@?]AYd
Bef63G9D[>FJdK951LVYB<4PB]6:_?WF@47U:M],><<F1&8d2/?@QbKbJOfNP]5g
>&]HVPL#Bg3VWI;]RYK?\<4O;,-LN2I+/UOJ<fW/#02+U3DPJSYC?a.#:[be9Bb4
-(gZCUUG+ET;6g>IYdO57A+(G8?2Oc?AcgBA]Q^ED\O>0JNENRY1eB+Z6daIgWGI
^7S0Z24#GPgI6P4D5>TbQRbaAC+Y+38/;VVAZeK\=.NCCP1a[CL-6gKIA(]@d1MR
^YcJQL]X8F(.FTL:fbgYfdX;JI@I3a+UH_<3TOKOBO])LB)TCTV9GfH8DUGU34&(
0W>J-TO2WTe_8]E^6H;G&\WSBJe7)1gS)ff(Y6H<NVQ:e^\F37.EXDLQ51[PVN-]
@cg\872VNFdc7<Ve]&8\86K#>&:?^.e);^e&;,1;UQEO<R.?eK7Sg6(WS]egTTD4
4fbfb14YBf1[,C0]]I&9JEG.VO.K#LDXU;AHF=D2I@13YE0[a5_N6D7[3;(.IZZI
,O8f:S<R:NLE@YP)\FM<=]VC<9QOaA)R+BW/<D?T5dE#>AFaPbX>3:H3L;I5#I-4
LXINAOH54:V?Yg2E^;12S.-=VHS^\M</.N:\3R\K/_D>5W)Zf0=],./7XA\X&9@M
?fFHc=J@VY+Fg@X/LeS9#HE()29:\:MG4>JL0O8&FGAV4S8V/6KG+>/Kbdd;-5<Q
,:;URO1U@[)H(MAbF95OM_ZP?9f95[=6GO&@:AZaZGe=9V?a4Ed4Lf<F.EH^bLG)
11Rb6eLOB755BKWOG(7bXMW,WD4BCH5-06FTf:gM17=F+4.9TQ5H#R^+Pf??A1.A
cVJb<S@MMF7\-]B\=?3J<bRN?9C5<9U;HURX.EM,d<R)?/)?W(7A@I^+K$
`endprotected

    end
  endtask // update_input_arr

  //----------------------------------------------------------------------
  // Task delete_transaction
  // This  task delete  the first  transaction from the  pool,
  //----------------------------------------------------------------------
  task delete_transaction;
    begin
`protected
BS[G,V;7=8S;_XS?_Q&X.2KAX^DA4gKZBWN+)O<]^g?cHK0((@[(1)[JXFDKZ7N.
8J>W_fDB;A)=Xc.cFgRKK_C3DdAP&38U<YWZIEN6UaE2CDc8Q#;\L.Q(L<2>OC2#
R2e^QSLc_0=MZSbe>J:f,dSQ9(bM\dZ=8K0H.JgL@XGQcP22[U2Q0AIfUO3c_\8+
,8@aF#+]95-W1E5Q<8U(K7\9Wb[A4NWB/1-gW]^4<^;(V-3Lc7e#WALYGXT#N(c7
ME3+?=2LE[5@P^E/7FE3Web9E5[;C_>0Td^&J\FT/[Q_GND?f.R(g?7D=1/?9dV[
-8Mc-<&,;@GAAg.XO8?a:=QUIQcRX;?:)68.86fF)@&LT,4)3P7.>/g^7#=9I>UD
JHB<L70#9O];9_+b1d7,()R;.MdHQg&X=.<?F24Ye?P,bCD;CWa[0TWXLNED4N.I
0_We8PUQ3g2&:_J_>;K#6DDc=>U8,H@]A3.PJ0>31.A,H$
`endprotected

    end
  endtask // delete_transaction

  //----------------------------------------------------------------------
  // Task : get_next_transaction. 
  //  This  task copies  the  next  transaction  from pool  by  calling
  // copy_next_trans_from_pool task
  //----------------------------------------------------------------------
  task get_next_transaction;
    begin
`protected
996KU2V_R6gSN\VgUQUBZf_d]6Tg\,[ZMM:6[0IZX58eS4a=EB)g,)UD#G=2I#;(
9Q_48;4,g<eU#C9P+Q&6[QeCF((BL55^e)beX4aYSOJgG-G&NH1[(;Hb4KU9(+Qc
+1-_67SASO31\)RBEgJH?-U,&J5W8g-SY5<Hfe4DIW_Z1WCf8f5X#ITEOF[&gg?Y
9,M4_R8>(Y^4bg2=C^/@<M?\GYf:1_EBc7VK+3X8W4;KZ?/G\Lf<100POR9MFZNB
_[/e:(H-<=)#B#S,E07?Q^OB_=dC;5]T>d[[eKbd8&(a&H_RB4GgL/7S&JM?QT:P
=U<+ZQ&X.+&WEI)Sg)O7?W([GXO+J2-5g,IP&+[^EP#ORDFVDGN^c1a-1@27e&f2
KM8NO:JfG]4(L;PdER[2W,TRX/G+H6=a:$
`endprotected

    end
  endtask // get_next_transaction  

  //----------------------------------------------------------------------
  // Task : copy_next_trans_from_pool
  // This function copies the  next transaction from the pool and updates
  // the  configuration parameters  that will decides  the course  of the
  // state-machine as the transaction progress.
  //----------------------------------------------------------------------
  task copy_next_trans_from_pool;
    integer                    data_length;
    integer                    i,j,k;
    reg [`UV_DWORD_WIDTH-1:0]  dword;
    reg [35:0]                 mem_dword;
    reg [31:0]                 temp;
    
    
    begin : block_copy_next_trans_from_pool
`protected
fAfeX+ETGXRWZZ:8DLG@DY6G_>+>W,J+MH)@5Q#S<QQSLW^]J+FR7)_1NXDPG/4^
CKb0DXZ.g)X3(B8JL#6QR#XL]bX6[J?.1Gg?D31:0YCP\RR<]4^T.;-&>SD#&M=V
aL;\.8&H)N&JNAfT[L(3U833MGMDU@-QIObfKA#NC+\,RRQJ_dWLI;I2g,Z7#^SE
0<HH]1f[#25DHKff@4TfgR+(;fD\Rf#<[?^[J?/SD5?R;EL(_KJ-0g_=5MZPIae5
Y9=SM/5;)PT/6>S499UP\NASd5e(f.93_1QEGV0S6Ke&FfCE0KfJZZ-U5LaD/]B1
^=-1.K84QVKK5<API_CdWTR<2gRADd&cH82YLeXXLgSQ?0F>,/FIC845#L]9>UB;
>d(F=AXaD6ZUQ,)8VdH@Yc<GT8.H?RQWU73aRLfGI(SBKLg&eL1C/acMXO^0I(8]
XN;5ZI?V\NN[^]?(K_\;B-YO\HC\UW)2DVXAB.-Y[ZYW_KU8]M6[S-0+A=b/2A>b
[Z@f]2&B5PSW,d#76/\<<GP.;NZK5Y?Y:gaWF&V)LS9b>cZ)0A\M(8I=>8;6\A04
4gZW[CT#>c+dbM/Z[G[+IgLe+W@NV>,L7?Fa1>B_gZ.ZCQ1691Y2_JgOge(?[c3f
Q[<INQ2S]@aP&N9S@5^JL[JCBOa+[S1Ib/68_WZ8=^,\Hbe&QBO:1XedZIb-e^C7
Z[Bb0fL;=P4cfgQVIZQDY&&YXRObM&>77-g^S@C5K,:JBOC00DRI4g]MUW\X#YRI
6#ZBM\Za#-OZ:NfZ-_;&-EK;.<_WT0@7b0QOW1(.KV3[OJQ_V/5]R?12dT831d@^
0;g=bRdLX#V0TZ>Q\3c)0_ME/NF<BbMH38Y1#aBY\\Y8b(UA^&N8W8^HUg/NPZd_
)1.Cd=73+>H0R@;caAV?]<3N.9W(LGL:fR=c-FXMfY)Ib>)f7.P\EYKT]0J^_d8?
UQB\7056Xb:<V30cO)CQ#;&0-8\#:>fgcJ>,#^I7_IaRM@1c?-&J_-#:=I51KI_Y
]^#6X0;LP@S)OLXIY)ad5(0-_1<765CXZNcb#b77e@;Xd25:F;f=V3J+R4Gb##6(
,8JMN]XbH&:a9FD(YI4JP-N?)B]\FDNJ#b48H]G7)99aUH9RcD79II3OD3G7UL/#
JfYEbF5YAa6G7a\1RPTFK1EdE_/L0&ZBBST3DY@&]gEZP]-[BCF=0S4IATRRWC7@
V-LV\&+VXT+]ZH<bLKW;.eFCTT]dTHHS8?O<8?HFe+ITQ1@(U_Hd2:fP),E=eTN)
(9g=U_BU^+BJJ(Ra<&bgB,[71(C9a_gdca48@WRaPMaQFB5Qe7,aJ4)?Vg76?\T(
MT_[eG9,]1Z,@9I.#)UVH909Of5#S0IK4R)=,_gHOa^Z?9caf4@3;YLSFUVES,A?
A_@BK,cBcP=[S,J<2Y]\?We:L8[&cXB]OC:KYa9>/HS&A2XRBdfWV_/9[0RECcVT
1C26aKJ6O6g0O6f?A&_\]dZ^ZD.U3gCe?1]ZTRY>\P].aC-]JAM#HTTVBLZe\,Z.
4b?,#7>^ZNITY434gK2;7&I)Sb>)0M&f4#=LI97WcS4C@POOEAE/Oa)^<gEB&X:+
abMK,Ma7(Z;U+E64bQU_WGDGF_/_W7(6XV24+^K9<K5^ZN]F(].-2c3EQ1K3)D?(
JQO9/LA;HVEf5V2^-(5JMWQSDBI@[)=;FAdaZVOF8bZaEc.g>QLfd@=T-::+:f@8
F5B;\(Q?I)FA(PB4^2EL6+^LdZ#+;P=Bdf\MEe,]M/f;Efgc&2J>@c2#E?UEb7\O
0,-581A1J\^7(<Ea2Uc<H5S0-eRd;YNI8L?E?35N/:DM08=(&_BD)=.Ib249dE1\
+)-30Je>W[UUg+HVFN-?:O<dEP8P.BacbB<063B]W#CU)b79>X[Ye]I@(cfKY)2>
R-cD4?^,W;UOA?cKR4D#+Y<K(d)R]IT](ffN;>bg1?QZReP9cLBEG>54SVOR[<F#
FB=c&J^]9CN^8K9DRb1[N>26\_?(.c3P5GF<,2^5H1Qd\(#D:c9?AK+\bD\UE<dF
U>gZPP@Kc\\&c#0-f6;A.)8:TR\E89Eb1VT1]S,DS>Wg+MKBU?5_,B25Y1W53N:F
NM1e9fZa6#-E/D.WQ1EG7V1P&b1c3625I3W1L<+:CI2,8M&54N+9+:DdN9-NMQQ4
]c)1V6WA;K<2g#;(9E8QRXfKXG;1]bHbW9O_X&H3L0?H>1-\NYfA=6S>\63#F&/Q
O-4YUXPA8YUKG.7VQ+2(:4,O<VZD5:<HYD;dN&Y>-[4A+0aNI#.dcA=0PTVOJ9,[
aU#C><QK#AXKg(]T;Ya&0^c=__?.0^/-+CP^GF54AeZ5^[Ud+)_AX-C5eW#b^4aX
[9V]C71/\4OL#OEC.RSSg>aIDU^]Qf(g8d?I)YEQ@N+K&/HR3FAV0U27+((J?8L+
aY#]#0T^XGUV9faE.a#7MPVQKWMd/3M[]U0GFgWJ1G1&0FV[XgDN=HUZ[H1[SO,f
O^N;^0g317f(f>fd,ZPJOM<AJK+J&U/NM.c<+1SV(e2&Z243fQ?_J2aGB]VA>a[+
_6a7bOe?=FaNJ9=LX<5da>D3KA2E;>2bg(IYJA>T:3LW2QE&TS#BEc@)I)Z0]4af
^ZTL,+Be7c3.B_./G9WR[L^?b=.7141KaC&J>LB.9[9HG8WB)N0L;V)]L08cETY\
GR()18O3XTf(<a,dM<AZ1#:-JLgPNcFa_X[&XDNDU?B+JdaEdHEH[,A5).e2]dNe
)F-?e.3_D.]O[H,^_X)=9\d8^,\cCFPXT7QGE_7^7F?D[JKOb^dVVHPVFG3@7Z^V
S:J,Rg8a@e>f3EIRcSR_CVPQeP?=H1bTZab?D4T,L8-60^(ZMREe=7fILMB\Ea7B
X&2Q22PS?LJOWf,<GeJ@P,#T#f&F-D:UL1@QG@a>V(4V8XTeURS/A5)#Va6->,[e
-,Sgb7&]-6SCV6\d<)OIYe#Z+Z:UQKF5I08O>I^;,XfMMS5#g/g@A7Y64g8B&6QR
^)d0Ca.WX535L\WI)0=MM@KWcfa3/[S&LW&d1e<X-O^^MX+;JFX?c=fP6(g\1H_g
#3IS..5-(U<QIJTdQ4JJ0+]X7]5?8ID>#3/+Yag@.S+ORC02C361T<&EJ.JU41ID
PXQ>:)>;26@1:9.2eLN:)1]YH<B,AP4)RGRAI#LKdH8-EZ]GYIA[c&Y)\@d^WY3U
<bPKR1Y=YB+L5WaH0MaVaP&UA?#)cO3/J(L0.a<RCf6K8Y8<>-2((2#A;BeGD2HR
6R]aL@:+_fKW0AfV7C0;]LJ6a@I_):;QX-FOFVKUS;?.CG),&Cc6]59X?:c)PBPB
\P]6)5EA@JGf#eRWI3ZRVJ_1-2D]^24E_K;BH=baKN\5/(UCF_fO&31K[G,Ea66c
_6d9d)0\8GWP4([d<+:6JL\L>?<>aFC>6781C@.498O^[=8W)e1QB,\^3-\JP>C\
ZFT,9EIdJ<f=QYS>b+0BdeFY6:9f5Sc])D=Z[T_#^-d)M^EFZ4GBTJ:3D+bKNF6b
0cCO#,aN;WG#)98>J4T<)eQI-XdI<_G^^DF7He4#@58X,75f9/e8L,7Rb=>+3<)/
6S1b.6-<N05T_ONEUg_@F#aR+dJDdM.VCC#S)FNe@4UJb[E).BDcGRMf=S1,WD.7
P/?GI(&)_N7_Yg<-0g?e-.Qa0(HYT6(8-+I8W1:M2TbG\/F6QMbD--NH.:,HU@<3
F#(UON;>cGIAS(.bcSZ]e>)cF@+BUSbV6Y@bNX1VdeaE<KPYB=d^]M8V1ZdSXBD>
ZcJ/LS4=/SOA,$
`endprotected

    end
  endtask // copy_next_trans_from_pool

  

`protected
ea2=_4K<G&6CE>W<E(?)T2RIb#DNRYdE=bTaKJ[-NAKX;GF&U6_I))P-4BNE>BX/
Z5-4CNS.,:.6EPBXg_;ZP7?223JM&VZ)MN<[b@8^V.).-N4R>M?Y<MDLH-H[66G(
_:??OE;SC]d6?E8?8D)Yb^gNEbR&7K_5;4CO4WD^=;#_(3,S3I41fZ,71_IEa&EU
c1bQaQ6GOBSU)\c.P7[UM>RdSYHOfV-@0>RdR]_]aIf2OG)F?Ibc[&=#RZ6254&.
/R_H259^;SMRAT2P(&O_A<:XPFA427V#FS5UbBCLdbB&(9bc3J,3_/gZd0G&Z\8H
XEAWD7cOI/3](Ig^\dULUX-CbYHC/P4aR<?>O<3:SVET3V\.&UcXZD,8U:<G7/Qd
P8Ja#DT&R^ZKV&71KFF9e9J\#aM+GH\<J@+Z;e4UKZ.bULYSU/<\J74[&2?]80J0
I^#E;/:7WO&==3MA^]>S(:5;+:3<ga45UcE7JTHWH,[-gS.[.=f>c3T8P=&.RU3X
Jc+aQ8&4IH2Z&S-)Q](\H_5;2$
`endprotected

  //--------------------------------------------------------------------
  //Task : uv_state_machine
  //--------------------------------------------------------------------
  task uv_state_machine_tx;
    begin : change_state
      
`protected
(Mf9J+Pd?>T23^^eFb6=AJGQZW3ae-8HU1Q/VM+_US(FgYKaM-5F6)8&EZ181/SW
PeXd5)AI;8]\WAD6U):-@(<]Q[9#X)WU9c4P.,^61:HN<#<0><3UF:EG,\C=.A46
bf[_Zd8AEL6LY<.[&]O9=bc4WCFDXNJOBQWIaf>(VBFf\Q0A^RBK3=(-;H3T3#6.
H8P^,+bBRWVXFO0d_EJ\P@gH2&=SUDS>/^7NSg\XC[Qc<T08JA6e@Y<[O3cc)YG+
;d:OQTF1^TdCM\H/GKd>F\W?R>EA+Z-HROdZeBDAYd.(O90YeC)<g.<FTQ>eWa97
2-JQ_AL5RIeD\]Xf/_aQ@Z.?(ZPAS^c[MX5^K?U@^SBO@^_7E:?46S<0CA</8P:R
?dDROf,?YBNE=QL/2VW>Z]K:If/LfIK^>C[?5W?<cGLb[f:@XeG]1N_PH9c1287C
_TH?M\OV>Uf2AL77[,U[YC[1DC/NG@3L3YN8-DLQ+Oc9N\a:#g.T](KdC1?YFWH6
Q361aUad35dL&UdJ),^]+^NOAGc7e+)-/_>J^MZ6&[cL:B<M^O^Y.HeLXMccAMe;
E-X+KZ5F38QJ)/_KgEO-:Gf_MTVX36--^W0/:M79^XZ-5K)Id0_A.8eLK$
`endprotected

    end
  endtask // uv_state_machine

  //--------------------------------------------------------------------
  //Task : uv_idle_state_tx
  //--------------------------------------------------------------------
  task uv_idle_state_tx;
    integer print_count;
    
    begin
`protected
;#bK).4Of(aZa64^H._[PM,9bEVS3RKbKT=,AdCW\R2Y/<HUQ0D]1)0Cb<6:20Z>
RMZ9TX6VbW(FP9XK]5POVVX0Q95_I&GRLY-A1@A>>WAeIb+Hg>N5#BKO&Q6[,B@4
dW/RE<BO-DcA^)5VNEW2S4ZRHF#_+ZV8K2d;]#VFNa[3XWTMJ]NX,VAeG[:&d-E[
Vg;L)8ZQI7,2B-e96XB\LV6?.d7c:eKLOC..G\M7B_1\YGf.AD&9O[-LCQ+STE5-
I\+N^@?KM9>:?83Lfc66>BATPGDRW//EI#<Y#K4=SWW=2?8eX-LEKcBJ08T(L5GR
+[4)[0QCg+H9PAGS(G)>U^<1N44^S3<Zf1E2CCIM.4O;;C0E,1W0)WX;;_Fd9S];
_A38@L]Ad-8fTSYE.J,TdXTQWD9,(]aG.0@JV-R9fI@PL-@..7UDET-.(&7H\ZYW
VC]\f^-Q3FG&GPTM>?=b@b8[)]c9G.F>[S7(RF\?9f4gKd-G]U.(XM_T]YF<](=U
,467Pg[)]Z.71&\-eT+G^=/INgFT55Fc4ZVQ1&-c(VfR]_PTW.2\[;^^FI&e]M<C
LX-ZF&/2W(32T6@dAOCa]L]b/Hf-9)+KTNa<R_ON#4H,:UXBUE=X,-Wc=II91G);
;:HW@Ld-A@R3,(3_a],D#B,e_f?PS^dU2eHS^3AGB\fG5LK]M#N6T_9faJ2[\3)I
-c,B9gE-1:e-2XTY,\O?C_AJV[#B>-1S+X[C28<#(=G&ZVa393[,AM7V6><a,c)C
U)(\,QW0)7;Rc.=^;3I2MFIcW-&QKXcS?G7RF&BESbINW@U<2X-gc6]^GH>McXTf
+=?;8]A9ZNN9>V(2((X?X300(9&FERDW)aS>cCJ,R@8dB^bEeI9G)N8HaC[6-+>M
9bHa=G1YT:A:E5HIALgFJ<W]WaIb2D;/=&CRc]@Af&a(P(d+-JB@I]:.S.HAB9OG
0P@=.W&=AB]G-_0JO]L#5SQc[/28BX(BLAQA\IHb8PGb>B&RQbbU\.H5]8J2:DYL
N)b4QHL88Q5BOROM>@SO?DQXM^\5E3\XJe.4N#U8NK=3^&?MUF^=),8UH:40OF:X
+8E2\PI1^Z_7=7(7<5Q0@5EK>J_>:QeA;6&H>C\.8CMRM4;7ERZF,XH]O@XU,^//
R;&C6#]a3[ENF_,PbZG?aUZ1PeKSJ)WfT=DafRJC-N_H4e)YZO5Pg=BaW?;3&d<G
R\U6O=B[Kd9L+#PaMR1fGVKTKBEf:(Y\dN)8dE2P#I_4E&=:]dMU:JVQ@\:,3CA+
C()(_9a<IAKC<e/\K>]QfdX>#f_Q-.&e_7=T@TT3XcD2KV=2)\G#IY#PRE9+gc=Y
IK>Q@gdM/(c/P<.cW^4+^JT\]6AS8O1#b9,J)SNG@342H$
`endprotected

    end 
  endtask // uv_idle_state
  
  //--------------------------------------------------------------------
  //Task : uv_handshake_transmitter
  //--------------------------------------------------------------------
  task uv_handshake_transmitter;
    integer temp_curnt_delay_in_rts_assertion;
    
    begin : block_uv_handshake_transmitter
`protected
eQN\^)\Y7?-c^fI>^U3G9^V8<EC20Ta:P/5HKA<9QW4(>B53502;+)NGbS:RS3/@
C@-=/P4dd4@66,(=-LNe#eF/:Md;[?B?+->L)a;2RNC\KS&8Y?JW=cS77FSYDgO0
+7bU5<82:1>Rf2V@#F.A<P3C)ZReM4-G/cT(gY3J:H<e0G>BgR<10bD_eP[EJ#NB
TQMI<e>S-P9aJ?S@&?XG2W;6=JW]dFK0f3U(1ZTW83g?68:MSf,R7,5IG>;Z]Ma6
P1O\G=&UMM(Y@0E^<26g00))D1P+@N<#^32@-/Ma/]T.O6gQX<?>=/=]MXN2Va(7
2IALBXS8Y4W2>/[=CK2NBNeC_YBOL<g[IC1)#AScV]&\8#^4a0b#KA.10YT+/K],
3_.7Qg\dVOa[N-V<#_I9IV[;:ESJH-g/)30b]_[_8,Y2Mg&G,C^7^DT+390S_IT&
??4bf#UGCecHaa(JIZ#S;N]EP54+F-A2Y[A&TVJ9:J2cY4_:-)TegI;#<^>0A2.?
Wg+<dMUCV&7^&WC7+\X^PL-/KcR&aMc>a&I68@QNJe2MKBGPB1@)Q6;<9@GZ@^#<
=P/?<Vd</6#>QTcS&_<)X@PG\##P4I=6/+,aIeNT@Q=SYY-[)XeM#>TM?=Kg/+D(
L4/;&6OQK:E1:)HSRN^GgH\G5&9,;4b38]=]8aR5@X2/J@6M.1:BN/-Z:^B3><CU
,\:ZC#ZOX,@0YM#B1V(&AAMc(>Td+OD3,>X:9fbWUN._+a2;Z=H4BOJ(NAKT98e=
^\_,A=_G:M)F&[b9WN+cc\/&MRcbQI]d56^5218+JFU1#7?95bMZAX2)QN77C;62
-<[[V=d(46Cd7VX>[9[=&:5;bF1GQ3/\@;:/.^7..O;^9P7>\TB@EV7XGc(I1Q++
<cBO;F6\UIcPZRNHa0/SYbAFRE@:R<);-IfE,6&eAfcad_FGH+MH5ZZ5J++V+@-M
6P=b)K]\AHZ+d/)QX7/K^2^-T&YCbWKWF&#Ve#:+FI1&<99/3-U1cXa+KUAI=;e<
X2b)c;M\BR&;Fd)3/K<OYXBF+ODDB9G#3ITg7aa57@K^J>^Q+A@RfbE[MKPWbRTV
O)bO4DI9N-?-bWLV.-2,O/[NI[32V-94?+V38(b,8A<]HSLSU<S78KS3QN&D#:5/
Hd:XfWR[PZ8<0LB][7PeI-]Q9B8]_SeACYGM1&LL)]&93S]d5_9B@H/WM<2IX&O?
#[4JH6@TAHMT(0VZZ,C4dOfZafd^A,&JXP6U#F]EJ[K6T74\a3c0OAXFcD2X9>>K
P81]@),:>Y)P)GVcY0e6Gea@B8@J?</35e(D@4WRNTP>Z:HfXC?X0\]:e9GOC&1g
A&Q<W?U^=<3>ALR0fe0X-U:C<TU(HccE61]GYEc&T(C32)6,)26g>RN0_bQX</E&
81J)Nb7dU@AN(I4D8[[U3)=f3L0HLL9W++M+VOA.;UCFIfLCON#?X3CYZCgBEfaK
DaU<#L8KZe&CCff)b65S^2J2BD@UXVc3T\df(Aad98=F[T1PTAVd&(R]6HB_bfa@
QLY+1Y1^(&J,gOEC5+O-Q>d&GKF8,YdbCT+FB[PaZ=_c7JPNVg3W)0)_(QeH\/]^
.&C8](P^,ZeMB[X61FUL]1TYNd3<1UWbY3Q(XC@=5Y(21PE8Z,Z/.YCSLDKJOD<V
cZaJT]S9VRD:=E1fbOdTQ2D,03dgYJEDA4KO\Y-IT;T&:D3&f)LgM2TU/1F^7X2-
&;_H&>FW&dRb+e[QB<JA<-LJf/_dg4e)b8#P7+YBX#SH1\fACdSXLGT58cX#25)8
46a5K])V5Z]>/-;M_X@?CYIE@F7^Y^GT#U38>+Z40VYP_C6d:(EZ?[SI6TD=L/39
^W\4>+&50P@c^8gD0E0#-QP/NIRS_<2U<7@4P,>],a,_&4QLE4]\9d4583&Ag5Q;
R^WbL2E-V>=?Wg-dGcO58O,7aZ2<S7)RPNDNcb-6<9aEU(?7_b:-DMM1,FS1=,/-
I[)Rg,VCS;;\(U^McF\YJXMa0.=I7QZ<KY?]c/L/<Oa;B;==EX_8:&,[^bH0T588
9\7I:#]5_Na1O93)S,O)V+Rg,:N;HZ2L)+;(NAEb9L7QT#<9-2-a4XWJ<5I&==U:
K&PNU((bBW](WD4K6XeI&=<Ue8M0](AMPW1X]<D<5JHLGeF@G.0fQ]W<238>R>HR
f>[RQgE(MV8>&D>5GA/QDTWH71ZURGeY?]A:7QAR;=V^XAELgT<6WJLa+d6RJ++N
J@/MS?:H.1fdI-/N;fQT0YC+ZFUd(,DCMGJ@FAXON[E_bET;&<@4>,DKU<[&(Ua6
#FN@G[Q7[eJKfCE2C]A9[I[5Z7]IPVSCd@.0IXJKMCdZ:O#AS3=:CU7;\AHTMQ0D
>J+=WJTGYQP96@Z?7D5;-BZXCUO<9gLc.Z=88RV+[20IRba>FXMFUBegY(B4?>g3
fUVJ)XAA.4<]ONQD?<U#VCQa;MEYGWd,6M>Dg=PF5Z6JJ)Bf;g.g4&KT?)0NL@EK
b2;Q-b),,f:6INKASVH0.?6GN<B46R5MD)VXQ5S_^#M;K48?.C7RE.UCG4.XdbIf
(1@HTTf6V&9&?1B+eV@L;6/V29]82E[Sga;^G6d_d&=RX_WC60D^>V&Af4CY..bK
Nbf-0\22]Vf0gJ[<#VfGFdLTBW66L)Q59N)J6Ff,EL71@7S[bA,UP::&]X=WG2)e
K,1#W@8H?6&TJcW><D3L:,QTfE+5cd)[0DaJ9J5[+eQ+bG(&EW/.6T],#95@8Q/W
3FR3F,#Jc?.,11H1LCQ#ZT),X;ZP?CE+R>\TM=+F@EA0Y<fTSOBa,X5?IAPE20BS
V0S2<;(J+WU[-O/U6>7<1Af+Z6EP/-RN+EP8G?YO,00];E);Aa@ZV7g6_.X3^QC\
VRD209-[Fa:KWCO\+c\DNF<#ec0bDg=QR(P+2SY5fO;5<E[QM7<S)VK<B(BJcPL7
@1S;e_@@HcU#IId0/DQ:S[G>(/3>+;4=NGd,T<2UE]X0/GH6UBgA+^;]PeW3RRd^
/MVF[0:EFTfb;e\EYQPIDAX;I(_QFKQQ#V<:9=DM@K=P3PJEQ4B.7Q1=P6Z(]7cK
404H^]68/f6+XU8FD,5JWb02afBZZ/bH)&FQ6R7.:fVX(?]5N0+\C:\+>\(2ERNJ
F8BcPA^Y0.U8N087\>e6JQ]8W<UZ6W=A#RBAW8<>#17bC2Lad:f?FISM>;]YA<;]
E1fdDTJ)Y7:/\-\d59fX7R?<^K:-\g^G]TV,fgPb/3G]+);C3Q0-T;PQ9Kf<)eJ@
PgGeBXa+HFc/2=HV&P?QW#>B=/X_#;Z4J4/LRF1T&0KC9-[(2L4O#[]?I#<0c12e
^=d_M8Q:&R8R^[XC9+BM1>)_O3U0cET8#/CaMR8K-FeK@><.5LD.4Je>83c0T1Oe
TFRYQP[J^>6B\#[]?3K:?S47E>6YPVJebKNDd>V)=f0ZAV_2>#4]INfGcY+LF,YV
>S:\+bO]J1I^?W:>L/Y+/0_G[eK<:eW=)P&V)If^RZ18F,>bNbF7K+]N@gU8G7Pc
2PUX>XQT.;QccaBeLJUc?&_G1$
`endprotected

    end
  endtask // uv_handshake_transmitter

  //--------------------------------------------------------------------
  // Task : uv_transmit
  // The task call construct packet and then send_data 
  //--------------------------------------------------------------------
  task uv_transmit;
    integer j;
    integer packet_length;
    event   temp;
    integer temp_curnt_inter_cycle_delay;
    //Flag to indicate that ON/OFF packet transmitted for In Band Mode
    reg     on_off_packet_transmitted;
    reg     block_1_done;
    reg     block_2_done;
    reg     block_3_done;
    
    begin
`protected
,^-W21_597##&>X4^NG^f/:IcIT/9H&TUgUeFR#,])e-M#K33K:C6)+fXKREUAXV
;c[TGSc7efE)2ca17>BYdE4/N\1JZ+NbT1cH<LD3VR+-AaAHb&4X)dX7KBNA80Eg
]M3TO:0PX.=?8T_L[)T5H7BW@;J\@2EbVT/<?Dae[80=;L<MV[JbN8NXO,&]0=NF
ET75NB2^32.BA<YT]K/=e^(&DF]BNCJNB</Z2aIF:f(MdeKAJAg?.O:?g:#MPDUN
W-Q837FbQV8fLHGa+9S#24LOgUJe;MV>PK=4DKCBccNCPNE7W;OM<DTW:78>2J1F
ZR5[1Y9c(\<bYKI^U@3ZFP:>3YL@/@VQ,4S10[g.+a/Tg6#R+LL>c;V6aQ,aIWZd
Y9X4;Z)C=4PcdYA>O03&dJBBR8#92Gce6CMa\O4/^cEF;DVe/Bd7DE?=QLS9YWTb
,BLSG;PQ\#V3X)&,L&E/=1[ZbgW)-\?P/6@#N<2<7U_CP/M<g1B,]@@)[9=IX#6E
[GQ6D>,R\)>QA=02Lf>E[U2AE^SGgf58Q4]ge_8bb9>OYEbN6:-@6HREf7,-Pf:d
b50]a9@S9eHUEf+LLV8>Y0>KR.dH_aZ>+WQN+SOGDfZ/A>K.20J&6+A8QB(d_4W4
/+aLdS]M\@=C8?FbZ]ET,F;[bg#fC)&_33U#PL5&6_12(<eO>5D)(0>MNbgMEf0Z
<^\+KAIZ<I:3=JT.[:VI/SeE0.dP;-/Icc;G8d8V/8[6a]&a69S7)/AU(DH&W/9Z
JbDOa<98=U>2>+T.@gX,O696K(([950]R)J1f&4KJ2IFa,2HH&,1:^7JMQEA?P@(
=9(U40#ff7KDeR=#C8(9b70B8dDTHE=-5WO_5UggJb&,V5E]e^F29[RPP<5][:06
DZ,(YD]>eF#V^H849890YafLH)_9fdZZc?QJ9^ed<C-+G8#>T0eY1HWC)4:Sa^-C
+/aX9DWSYET,Vf@^d)Da(G.<6A]SJ[?ag]Kc(M=Fb&XEN>2NQ#:gW_P.gH.0ZUFW
C>CPae:8C7Mb+QTe1Q<--:>YSdHP^5a&W@Q9Waa=/[S]0LU@J\T7>E3/C-f+14\c
O0Rc-;WIVcMZc6cR0]VgC14R-U^f6EPbK7@[ESS8=V?fNL@\(]W/FPV<@d)gd8f\
,:Y,W8(T]/4TDM]fWTc,-R(aOSN?+E]X.[cP:0B1&B4)#6:[WS8DC@KFfaY3KHf<
d?&O1N>6G0@4>=(9]JZN]gd#CN23SH(\9L;Y7/&1GC.TaE@[VX10YW,:G167ef1:
=1I9Q](6CCdgKNDBNeXBU:f\&[E(5QEEL#Ub@,W\F(fR,(R^W0EM;f_c(f[=I/S.
a@cRR)^MVOXaN02Z&L[T^UL&:-R1@J<a41fC5\FICY?O11Xd9DAB\Q+J1a@.A6b?
R:SLO(T6TFFE5W(ab(S[<W[K[6JJ27([-9GW\)-YWWaH3eP,KfF0OJPBZg0[Mf)+
L7d2g#5Q#ECU#aPD3BPR3.b?6P(O5KW:>I?b68:P^KJ4H[BUICeHO^_=E>YXVF+O
bc_2KL&ZT(E;2UcX6<WfAeD2gOF>;0EbEHSO&2BF5]fIPd8JN^Y@VgE8G&U,+HTC
K&_SG9[c-.CH8RD88b:JJC44b8_PbNA5(UWP7932>gc.g4QJ.UTd6Y&]D<FZVM;=
V]&F3Z):;[FX9J(N7;1_GTJ>cO-H::.H2QbgS6JBHW\QT.2^E,WK>X/[4YBRQA\/
.aK\SI5ec<?+M4+FV-[/59,&=BTI)TMV#[JJ3QQ5<fW@^DbH_DbN\K7ZDfC_feH,
[AUb_2IG14Y;E.J8C<NGIMZ->HP+_Ug_V&&Ne[S0Z-Yc_?Vc:YaGGa4^8W)@YCRS
<)f7Sc7[=&F<QeKQ;]7@X_@7/R>DN61CFBReT3@2U7L;a_+2ZN,X\.XAX7)&CK[R
.VbJL(+J[KAP7]_eX)\S=gfO?ZU.@#,T<+S@B/?eTTFUMYWgd)=0[^F-3b<bGD>X
=[H.g],R4J31I4#&B:R<+_=g^W&9:]1T64aO+96:b\70/<RJ;:;g/4bfTC_E/9O+
dG9^O7EA]U.B:^/Y05WCIdA?GK.93N?e:+;dPd?e-.#V8M4):Z989aGS31eX5RJ8
3+OW#KX/L+gZ_TYKZAOK+0S;NB]651416D)ca=H/-K(K.[\bEN&,L_8b&F0H&26[
T5@#HI:35T=bY)XaFS0g3(0K6H.M?W6U8U&EBXIEZIZGDI7Y&BCG-#2;LZd;\Fa<
N<J6LI?gE5:-8;7Wc+2aOS[/H[N6<J_PWe?Q@UaB:A&75XRZODe^/Id]d=V@I+4d
5)2F\N@ZML.DH00D:LBBOJ=5EeCKc9/7;L5SVYecC/JZ:beSR^0\5Q9GDUWP?1K/
E=)/^6JH25Fa.2>010.Q2g1U1_eb5_@5)/fPRHCY[AMQBeZ=UQJ[,IU]BT#3/GEY
2bM(;S^J94+MC9NXCGGI#@M+8g,&BN1(C5A[&YG((]bQPFYFCZgg4+B9UV./,c3V
\e?e1PKHZ@@MIf3#L2E4BXc^@d9LVc?JAgVXAI5HB42DRU@;\UgF6c[?a]#]E]LH
=+f^JDS<#/f=O&A[Y@43XQaQC?BdH.f\)W.gXB.JON_7gN]H/FUG:<CW^A8D?:O2
+Y\MGDG/0bA5,ZQ#)6CBOU00S<4..UUg\+AU-dCcHc/#.1L(D)RJ9K4aSc54HA)R
&<38Ka1R0T[;0V]Y[e?cB5J[EbS]=N\G,F-RUa_/YI)/F_VU;Cd3X9N?]6L2JJ_9
TK&5-#-9KA2d)4:C.a5b)X1Gb9N7#68592^/344RZdM/=8b]T)G5TfegV/[;OT?Q
N]&cN+OKN[,N8:-1;NB/Ua@f/>LUFcO08dMUG3GTT\L&-5],O3]<LMGSA5KF5G4B
@G8dZ]bC5>C+W5GEM[2-eYY(>?E771UW>&9Tf3B97>5:9HJeQYP(g)OeVF,9XN@>
@BKO(O:=6Db1+S^1_1R5/ZBdbT+JI-8TVCICbGU9]#DT-7Wcb\aWc>[-T9H-\F9e
,OPT(C+FV4Y1bUDJ)(@bBg+?6DH:>>dI,ef4\IabLX]Q1[GM6#b+(1ZZL\b8D[MD
8E]9?dQFN\EdE;RK+J:5LG)9JegE1^J_W)S.cZQ_:XF#3b_5QRE9@;NJ9F4MYF35
4I_HVJeVMg)XH686+Q+XPS8^@C\@UWJ@IE&4#F._@W@GV^+?<N>Bb&@FYb)2X_24
)?]UeS<8:[XSQIQJ:?(/N;0e2eF-\T?aG+B4US>^6T_^f//M3]5TAB9;?QCFdJ<7
;>-,DE9<W.8+20Q)fO/bfeC6M,8W5I.4G#Z,FN&Y=T,XNDZ60a37I:4/GZ</RS4R
BHV=(:987fbF(f+PYXV=P(:8f9A=T8VP6HVHD0d5YOZ-?VO[4EO:2P(DgIVE^EF,
1TNPU3S^()b/9EXga3d3F<+9aK[Q]7SB7P,KCJ^P_,SfVY1^5X\eP+8]R;ccUANe
0.a[U4VZMR<H9>O5>W-W7[Q#T?Q\.=-?46e_J;4+ZYXZ7/;KR8B#[IdKW[.Y862g
-]=8\gTT)2GYE+L;(-gMb)<e]>O#H:#bSU2Ng=b@d9OT=G10=5bB@cVC41#.?G3R
]0OWCLbGgQ[dMgJY14UWWD,?=NW?^a.21V1a)ZL.ZK:1;BT/7.\2[LZM?__Zd9@U
19JVI<ENAD9:=FSbY2Ga:\CW]#1fZe\-15.3F;TS8)&#Pa1BM-S9S].;->JHU7fB
HZQ-I,W7E9C>fG<]:HMQKaHXY]V(C>aY9\]=G2]VU=2Af-Z09BJ5K^_(TYPY.Gf9
_,-1&He@;U#UINO[aXOF@d04I]MLV,1MXda?c0109T,AF(#cT0K3[+P-d:V7NCHf
ELFFW?U#ND6_e&X)YHA_MF-cTfAGK(++F8R)>L<D0KI^/;BNBRTDc@_KVIT]W^G&
H:Hb<bYUcF(Y?Xd.+X-b]^9-MMG+6(8?[93YI?#8(0[aO#8c^Oag>B#OVTH8VQ/+
8Z&<?d1KO<F_gVEV\\GC+(#<U8,5.IKg975==QdKcf\JD8S\#SG>GY]O?>P;8:(T
DaZ>BaT__Ma+KYE@BCMFaTS_FLf7T;O4O@2d#C(U+66_#W[^2S:&OSOTYDRU^WeU
1fQ6YdV<aT6/g1Q=?IESABC7ec8aCC9gMEJa3O^^IKIda?8.3dVG\?K/<4gD,(O9
LL2(NA5_VQ<XBCJ/CQV5YN);Z>=@X+NXV5_Jd7GT/]#;LNSBRYO7]UV+<_S)[L-.
A9Y+aIE(I;R:&c-XJ_S&N@:39P;W.O5&79KT<7#e9/\IXW^G5,WBXPL1K:,#b@Zb
bLKC30+<;R8_=7&ZG(/3VXL75JN=L2O.&4>V/H(ac/YPgHX^9HP@&5<(L7VAbYO5
GP\6V^N(ZO7.L#ga?PY6?fQKfH6BYd=@=cP[X?V)Qf5X3-cb>P;8X;4A7,e:a>:X
RK]Ag73(H6a(aA3B^5&?g\,DF>JaHaVdK\c^0+M?PH:dLEeaQA70[J.<:,#+gZH;
PYOVBP9)@#0UCT[fQ<#-Yf1=8LFCgH?cbEgPILV,N9Q,<8>+<7I,RS>G2(7X<5gW
B>IMg(TbNXETf1PaE+]W2T?GHcU_#2Ze@,eeRXM/SL@_@AbZAfBg(53;EW#2#4<<
H&?TTD6FQ4+/38HaSE[8f?U7EP@XD:-K6C17P3G=P@Mc.40,eV#.^Z<LY6;5U#5P
RfT9a,-gX1P=f>LU?>]2B;#EFM.YQ>\\.K&??OAKcM4B6W]5/[B@Z:e0X0J2YK00
-d=<Z[gf)34eE0;cJBe5QWg]9Ta:2+>eP23+Yc(@-a_cA\6+9>._H^Jbc4(dJL;-
/f2U=LXfBLTC5d9QV.1D2X=WPI6bd:I,e]&0CJd\]3f@=R(H]DGAB5CA^YW\/#P2
:2J8U5]/8_;606_f7ZYO250Y3AS@XDX3,RQRC/[9SMT\ESR4R6JM3G..)\7UBAT>
VCeFDLFY-_,FVF\g.++WU3PDLa;TD7P^I+5L=Yf3PL]9C<^E/7Qd0d3V54#WCKG1
:F.M_ST<Oa29#?VP8\)SE>:@58D@?G[bTLd;AKY?ba6cZI+C4eXRdaYQC+Aa1X7K
MQ6Y7(OY)&_D.KC8\Y:1B@O1^dJ[7,+:dJ3(NJ</6Wca-\aaC8Y0IZVUKT&OL>AX
NN);?6.Z:S?c(NE866fM6+d\KQ2]<8CN7H\CC]U#?52.<QJ?-56&=DYe+4128d[(
YQ_bC^DUZTHL@#.EdDdS&[T]-]6<<1R.gPWe2-]A/d9AU>):\C4efgI-J2_FQY)S
-X9]faTEfF.DF2^(&^>+&a;0OV,-\(X5?BX1IMEP+J7LS?A\AMCcF3@<?)JdJ8&3
?JGH-4GC#5.)ZK(TN9K5(;Z=?G5X#4L:ZMA,L,D6,>a<_R.1^g>1(YO1CScJ>\8P
F@]Y\d]+A7^A7cGe.I782?@e@YAfG#3L=e3.>E_MPeXVVH2:aRF-Z.YA=2_9,=VR
9NK?1ad=/78UDPcY<_]&bQFR6R\F&D^@28XV4@HN3,LdB0SQTHV],f@Z64A1T0R?
UY@=PP<\S:0S)6QXY9@=,]\&TB&)EZf)T9@SIITdWUec7-2HL6=)4,KMJ-V=JV2A
[)fQD(;1UDRRKUN).(2c0d>S]PV#D?f4^Z:R(LI.)92U-[5b8Qb4C7U\;L,^f;/.
1fWB)4GUH8;@Hg+g50YZEg06>.?4@a\O6?YZNLeHS/^EREHEB4[M,9LOA8<+eE[<
7,C:[NROW#0_)-U<f\9GG1G3HI/[:)<(FWKVeXfG/:BDCcC[/0OEcXGUe](),1_E
IE>1).g1I9:Z26T>_7IeL+?D)&WX5#^MC3WHbA.+E4S58-O7YBcfC2<;26:DS:f1
dU&?M7597[DVg)]FX,6;a6eADMTBYefe-Z+:B?46aSJ6B=C>C1Y2_X_GNK57X\M7
]a8.U&ZJ@0Z:d#_5_;P&W5QL^??5WD]<K4S8:YZZ48/b+F04(VgT80&3(Jf(Ig]K
GCIXY;9MV(0CVNODe=,&=?-H53XUN&X)[B-g5?H5[c+,eeMHAAYa(]Y3/U/:bPW]
3D#@M^[E]8PL(3D2?:NQad6#g_c./,B>9>ANDQTP#=Ta[9,,-KP+]<dW/[a5IN?4
@3.,0L7bBS[]SJ_aVO4?FB3T-R-9df+WKcP.^^RS=OTG6-W;G^G2.59?_L50d)b-
dTffGQdJTL\0GP<BWCNDeE\F@NU)gS[b_)7H[IDe5Z?88&KX=@FBRE[TA,>9[IU/
R7(cW>AHE6/V#8ZcFcUHg_LSQP@G#>7[]X8YCKN0g404;<gSZT8[1TA9+.OP@,DFV$
`endprotected

    end
  endtask // uv_transmit
  
`protected
4TKP+L2B(Ec1\PB&9UD<8=84>4Wa]A/d(@RML[&>4J#NTM)GB;aE7)6G9HdcJ\82
]Z>HPb]:LfMMI]IaSCfIL@?Z7ebR__<d#.BT]+[\>&DLf,;1&>bZ87PH8(T(ba4J
\#V<N@VQcfXd;,8P^NgP2A_JCdYOXg8&6>4]BL)IFZ&URG-ceI6e^OY#eI=dMFH/
U3T32#C+,(?H?]cR[:4@bJ]0fR^?gSN>3@/U&[?a0JBY+:C.SSO;F2K;6IIeL:/1
cc\I;3a.J1Ya)[0IJ(3DM0_:IaW9)OD&@Da:\@&[QLU.RZ=5c;0B7RXHd0@b<2MY
XJ3;8B+XSFVSf@Fce3dF-E4d5](7L]b@-:R_YIDX0_c@M-YY0(F+EN;eZf#^P8=9
PQN_ZD?K6gIE?R(6:,QKO21YN9A0VI7SD_TeF@\&@HEAUXXS5/UXP_7;<dSCc\.+
ec>]#;A:U64CEM4T#eQ6e)6e4JQ#]<c37XPKKLPKIEXY[Ib&f5Vfa0EFG@5]SC.?
8B@E=S_7G#+G:&9[U5RMEY6e1$
`endprotected

  //--------------------------------------------------------------------
  //Task : uv_state_machine
  //--------------------------------------------------------------------
  task uv_state_machine_rx;
    begin : change_state
`protected
9CBOV(acO77PR?(R0TINN:EH&Q[/IW;>,6[9P0NIT:.N,AL;36,4-)MdbB9DYgLa
;LYK.Tecd5XP6F9dWNe-T5/WU>V>NG^O1S]Oe007[HgY?AeMg2WYYFga2FH680Y0
VB0BcV7^_Dc2BW/=]:G)N5V6-@@FAG09MObY7gAH4fF6e.)9D;A+P#a6CO?2JM]K
M4f#6XKYHSN:g)M9(WPTf3E<O-f?HGDFQ2CBK24^;_9WC?5).[A)/2&UdIVZLYBK
F9AGOTaLgX9efZHIAWCd.A-fW(RcdT:+AQbe&b+K)P56@PS#E1KLW);ZZ4WeBa0A
L=\/E7DS=UKI)7)XE]K(#gXS1NMCE[6PLb[Kc@H<O6^C=GT.STFR9?G]-a<]JfS)
&](\AeYJ=2;NaQW1gYEPS:8[7>2:=fMCK.1I1YQN&W6):+WJ:b;-(13LV+T6dEe.
Qf36A+<bNbOgR1-]/2\)-K1Oa];G+ZS.XR)b^UAB/;V9ER8B[S[][TY.LA^dM;R@
O.f?FIS7Wd7dY>L:\WJRR-K6DQ>7JV\c6g[T^Xa2J<+0_>Yf<2&.bPZJU_LR181>
?Og&OWBD/^OA:Of\ZV>/VNZF:64AC>-2eF56]/=5;7-a-6(C[W-4MIQXL+Q9]f6?
fWB1gR318TG(b7>Vd@Z.g3##fXS,aMFK=$
`endprotected

    end
  endtask // uv_state_machine

  //--------------------------------------------------------------------
  //Task : uv_idle_state_rx
  //--------------------------------------------------------------------
  task uv_idle_state_rx;
    begin
`protected
8YF@=CM#@GRYS38>PSIc&OS>e?ZMC;J1g6cB]Rce?KbP3VIUPI03-)-B=:Xb&5>L
4/PS0>]5\gU1d@)-ca0Q^G2LB1>d=+]?dM(SSU,P?@R+M]YEPf.?MV(b1Ug9J<cR
VD_HWQ+]<R=Z_VV8E#D2>\&Y3:NN2&4,P=g:E]g(GY+S.CQ)[KL0_=1IV:bdZ_8e
9H1B+G4)TTK_B@]@I7(c\1(dOMHR=BEJSP[<&PZ/4A&VfH)Z4S&AVSYKWXL7AX->
QR74D?I(ZL,^5>N?d^VE_9-/CIS=0O)=BU_NaHF/[DKRc67/PMFW1X6>1<Jg023g
2,IMRBKP>_&#,?0.?RB7,Ua#Z3VI+(5TNYLc<.f^AK/>b>Z,DZ+#e<U+_</Mg08V
VXaAeW5M\,UP1fENT,/:H)dAZQG5#bg\0-W;HZ5BDCZcM1+YB7LDY.#RSe[)OK9<
g5ff#[>XOYIS]33O27g0WA2Z\FH7P,3PC&-PRE4F4PbEG.K9\Wg\ebU8Y[67dM4.
24<H50W?.7W3>Nb_-&.)X9T@_#d8KO(M]P-4N-MaX&KR=f8-;SB-U1\E7>OD;e[\
3a)<L=CM8I1I(AbfeYWS/:BDV<D?N/7Ea+U5-IaW@#C,.H[6Q4ACbH)_efJ#E+6]
7bc[[)<gHP)?)aEH\O-N@32RJ_,+JR<R\HF9)&f9(.HENN=ED[C(2Z[FR]LeN?Fd
88f@\#T7@26E2OYL4+H;4S:/BGLN6@&LBE9E1J4/BC7,N_>/DQ12]/FOU\PXB827
e3SfJfXCVWWT;^Q0+Rae#=Eg:Z1FF8XK>?XWcK?@JU37e5#0b81U>H(=E_.caee[
U>7a.,<WR?]0egS?1#bLE4d,R88_->fY9YO[>a9f.3UIf1g7g2EJ>6H6M/M5_e1C
BI\3IJE-S1JP@U(2P7.3COLQ.]4-aRFD84E,g&LdW2E_+[=>>\XY<#feD1/b^?OB
LJY;0]AK<0TNBQ]aOXaEcC^7bWD-YO+&d^&UF6L9QX\EMZgSB74KK8I^KHg/^/H\
W3,.9A@EKG^CLJ?=?E(&^V^^-,I?/?5>T.ebZ,?45GM5DJ,23]4@Y;bR/<<Nd.:+
e;CB.E:]PdRa&@3Q5agDPHUC^8UF<\-EEVFb-72N>3QWCbDF&J/7;db.@QS5;aU+
3=Z1?_gY\,7N0K:]Wdb@QWaQB@HT\W7[8&/BP/75:H3:Y5;#X4KdO=5+eL7KX<==
R,T,-E97PHH_CM5Rbe]FVI&EWB9KSB(T.)Q&?QNBKJ1I&PJGL7-Ma,]U1d7CE+LL
S@g1(IT7NeQQK(a=Id7S]M0?b+P4O:b+FXXERgd=X[;)PK8R^UV+),Sa.KB5^DDa
\J].YZ(C=2IKF7>5=)U5c@VaT@N;#f:.f@1>b2Ac9gb[+#MUPR&[L9b-Y<#8C5cQ
7M4EA;1--&]df@Ve.:WYR&]bS#W6;F;0e>_;MZG1J+8),Raf#Z;A\(-,a:8=?NR,
Z?-Me_J5U8+0[&f+>>0ga54^.REc^c]><_M50NV?Z3U>+(V.#M&(7#IK_//Gc#@+
=7CDf-J53WacO2\@]E&6cB8dPY])6[>DcD5)=dD.PLIa0,Q3(E:/K#Q-YV#S:4@\
E#++;)\L6Gc=a>Ib7XVJcfd3A7@4+XGW8]<0#BFT;e2V#f^bY/UHYGW7I+>VS:M3
\9O7K)3/,C9<5SYP0Q>4K2dFd72RUP,+6/#cGJH#5NU]@5JBZ.5LgR>+4Ob)=_1A
A@.PcG4J#ff;+F_=CA]-[IbD.HPg9BXE<AS[ZG9@=/HDY>Q?7&6(UbPPdcA?S_(Y
L7]GF>R^FgU=K)GPZWVGPA9QE9-f,gGgPPd5Cg.:2;P;)YD]2,bU=.ND43cZD?)B
6H-Fb(cPB?LH_\[:SC@cZgG=[8EDDT#?(0eU^a)DI0#,Zdfc\>+L5&\MM<F]#]0,
#:d8)/+P?XRS1H)6,]WS>/aQ1.g&gLfHBE&[4M0N(UT.#S#J=1Q_@Q6TTFZX-FM)
\W\NBD_QBbE(eH2>_@A2T[eK9AHE)PfK[::J?=(NV6E9@CQ_bG.a3Z5g-4a1#,+/
#BR/,=VC4\4<6D=bH+\=TQeK3$
`endprotected

    end 
  endtask // uv_idle_state
  
  //--------------------------------------------------------------------
  //Task : uv_handshake_receiver
  //--------------------------------------------------------------------
  task uv_handshake_receiver;
    integer temp_cts_assert_time_delay,temp_delay_to_flush_buffer;
    
    begin : block_uv_handshake_receiver
`protected
=(;M]6@],RU\LS_V-QB/^XO.)[[(XdV,c=(Z8750D[+8#9c_,>(L0)W]TI?7]P0^
H[c<;7><.//XDeB2YD4()@C.AE[GTf6:YCK\OJ>FdI;=;M.e@^[DaOP=,SCU?QLT
S(835N5@,f2VUN(eW;fYTZfWL(O1&]SR?f,Lf:,[Q7NKBI7-,7VfaZO9Da+=\4V#
)3L2MJTGZ8R2(9E<LE6690Edc/LH=T(81SR0W.<2E8]RLR\3J.dJ(Y@WNG3&[cbH
SLSPP0XE,c],/_O#S8[I5De4d#U7;:#D@0OdM5^X?4(W5/4VNQ5/6DP;BGSf-N<2
f+PNDD@,A0G:I(<KLELNG;M,-V_0OXbO\]:[=7RS+SW7D97QAYW2:L&<G71=UNg+
F2V^(.Z6<d#Z/abY74\APSX_&EM.MPcFITW;DJC[CI^Fb@,@?IU2)g<5WUT17W,2
ZW)>g>b<_+&6bFRW@A#ZJ.T.X>OJPac3EOI2>)>,-0^<@M\A^g+0)a.6BRQ#g]QL
O/WX.Pa8-J(M5AKDU)7)(]>JLXHF+a8<ZPfd5PH<?&P)YMcP_ZBL#5F4]9_7N/3V
V@U/c]DAT=]gJTXYa@-,-1eNDC6,W5(C)^Q:HO1_N\g=JDPA>U4.,;eYA=++K-9d
gL+FG60MD0X0d1Ja;\7dSB#J5CG0QC;022b/dZ2XG4+cB+NS/(\T)IN8XF?f48^3
-FK+TZJ:Zf;c@gY9N,KM_-<gYU+<dVN=IP=H<,J23I[.5.=MERNDW\Z.d87+S\@5
9]88M<0MbBVA<g2.:DQ.H:U6G36]](&4XOR(:[YGbNBLf\dDFg5ZBELN=_AVTf])
Q-IP0JC\AOG,7K+B6><VSZCQ_<=-JG@ZO[ZB9-WI=X<9E(XEB5C(D<RZH.bEJQ[1
)Igd/=>NZaB_PQ.3aW_\.@14fNgJU;R_ZU3YWaL6OB]PGZ3H3V5\.KY&JJI@0?04
0HMS)-F;<faH<3L\Q<VC17#;=MT8+2\3,YYZ0cFFLM3RVe5VR3_9\[fZb10Bb?R1
9#eDMDNeEgHR/<WBD^>aR5^P^ec1TCARW=YAK)<fM?W.#UD7BPV#+GU.GA4E0)8B
8e29,94-+8O&RQV58,N=2g8?A)KbP.dO^-:Oe#44Y)4gGBgPB3AWXRZgO:[a??R3
ePe]/g+L+?&\?BR(4[(JRZRAc\36B\M.]#Y-I>\&YdIfK9&>T;@=UA#I9.&0c1gS
5/+5K?]LdcM/7L0HGLH4Z5NHROfb3-dgJfg.M=c/)(=OU.:LK.0O#gA6^d.IZV+B
PY=T#MSOCGK04L7>2HCAJO2^T;B&NYacP)5KMUTV]RPd18e-@<-D]#cGGHc(T1g3
a21>/9e7WT=.cO3OF/8XeIV<?DW23S?XM(B-6\E1CP;dc[QaN,M4C#D;0VIT)?2,
FT69L&S^4S#@I5REM_#5g.4OeIH?&L/3?g1#B:a2]B/fWcIC^bX^\a./dC/0+D;F
H\&50A-J(<_I&G3Z,C#c1.dR(EA0QTbN[ED\@Vb+2;P7Z4]ZE=N]NBU.e.5UKbg^
QX12=/-cN>D^(cPNECFQITeRTG3JF07fIUOE=/Rf)[N#?5(-[L/ZN])@87cY]R#T
+H1W7GM>4ES.,K?=.bHQ2.fW][LNU-Mf9McLf2>W\XKD\7Q;Dc_3bf#S5FC0R24I
9MX/=eX->5:[?=5?[6.eEI-Q5NY+f.][7^TETHYW[+E66OaTgH;<I:G-:d/(66g]
LX@gZP9[/(=I.=+^I@VMT=-W8DY^^e743gb4T<OKLJS?g;V:O^d)I46T]cbZXUM4
0_J(M7M\7EAA+5CLC,@VH+^-;d8M/0f.<I<Yc^NS.BM:1ITO:+:cTS6,.V<J&X<:
=^A-/MXEbZ1I2OSaRf1cT4e]eB#U[]#>aBOe#KQ>8\9_JESU9:e]\HL2dW3-I8g7
9;#0<OPX]CO+=]NOI,RQ=W.=_B?S8P_XW=ggYE5ZM]b6a,a/K<-#?BCIS:&2;-F[
&E-4XRP0G\94?+2V>L_4QE#2.6\>;?5c2Z<(5PL-[-^BCJE(HBc(0JOa=_4E2(P@
-XbN9^9Y-_T;>EE=T.?UNQD5(a;bB?a&QA,1Dg#__F8KcGOSCLBcFLU1[JK<\HAD
NT2]PLOT0BMA_\R2?0W1ECbI?:F6ZXFW&^(GS0+_#;AUDP/\g&Q+Y;14V?gEN1Ab
fH;gZ9bb34N>3fGP9>+g]DGgV<+SKAJNRSVDH?,O[LH)P1fEU)S_U40c#=ZT4IH+
:Eb=QeW2\:CXFfTfbEVHCJKg7K/G2b-2>[@2:;O0:M]5B9XH[NdO_>.KCM_^5<@3
GA4O:7OZ[<@3L87eDLF<4bZ,YX-cUfB>;<Db:5T]d)TcK<CB19.Kc<+GQGZC8E0J
cS1QYW\\7TS0DPGS9_\V@:MFD[&D=/G]DZ&>H4,\6bgP+&H<da26ZHK3S;>bPH2D
,RUO?>6]R?X,80.775+OgYXI[P;e3DAe=3N+X/4gLJLPddTA9F]GcY(8:PW(YL]/
&ggZV5<F#1<0HW@7X1D+;\>^2(Y:&gN1:3\3U3&&Q]<X<P&bSeWPR02c2d:XMYCO
1fHLY&M/G8f]?8dA(SQ@Jc[U[469g8WWe]82VAY:M+WRV/OABWbA>:c\WC?[c7<E
1NZ4:Eg/e.KP?\[A;L&;AMI3&aY2=\K(X=aDCZD.1MA/UeA@:2:)OJG;Ie.4?1Ca
(_44,A3O@dAYJCHUBBY@A8QOd&0O[Df]c>UHU@OVK0]TOJU10>SCNV/39S.gCd>X
J_#6IEA(3N89Na5&8(&_[[cX28TX3NPUL2RReE#N;[&IXA^8cZUI;+K;?2N1_[.@
5<.EfD74[a1Y6#\-\ccG.GdcFY]@\J#6VfN+0_g\IL]fW98?W5A+_SLX^K2U;G;,
),Y6G>R6)_a73:<KQ;V[L>)<Xb+g<]7dI?\@TSc7g)/56/c:&MPJP-@JDH>Vb2Z1
ZPW(+f>;O-3@C37Bd+PW\+::=;J-)-\6dCE3/BgNDJC+gLb3R>W)Z,^PCP^FHa.M
]:S&W4\O5;A49BA?]ZV80IAZ_C>=;=WG?9dG,fL5.9b_&gKEg5gJ0_)\I\M[BSY\
J#&N+eDEXcBb7Z/7B8PdN9=^9Y0A]Q=)7#e<<1-8<+dG)K+RQ&PdG.IE(faSe,Z;
M(+U9^eBdCO@bc@L4B58S?9#dX.+K1JdHWgEI/UD<H45G[/N=(3=X,#9,=Y.7;SC
2]RMg+L4D871^eEca@^TVdUIb1GR6?&b^.:6A@#f21QN)?aV.,Z&M@995QMM/c,7
GCX5./gY36T2<f+WSX3Q0QSW_LLg#IeP9\:Y;Dc413OUc-F(bZ0K20Pb,)_I:P2K
0ZG2@KM^/7-\:ffG:dgbW?F\M6X3)0U[RUP;Y]AG.IB[93]+Y?SF\g#OOMOVM^/2
\d>G-8ZC)WN:W3a^XgPE2dW@LZMKH:+<GCNW@\8SK0?1T/-F9>,/I(e-f9I(.MM\
@3KZQTNODW.0E&CP=I>:F@N_T7>TN:>W8fMW=d)J>E.(F=5;8/&e&P)bZ]_2VBM?
7a#c]If1Q343B(&Pa=?CMQCNWN_Wf&O813c<e&<IA6RYM:^S-[U;.VJ2_6B:CKE4
Q7TOQEU7MZD^@1+d4HY(-CU4T2aWN3FM/19_NN&C[38=M)Gb^(MB7#V;@_40d1.A
K/15GTg^_RG\>RcgCUNNPY6I)T9NA5@(H<b.8-#fC]C@3/5P@-\:+adW\dQ6I3[D
G<?44CXbYCI/ATC:Ye,[#T5G]X^f9bW3Nd4X,aQ:+V+2A4&<:BFNZI85eTW+/B\Q
Ib\A6)<c?6F\a9O&+0#)/:_:,(,fdcIZ;]Z^eMaTY.@g?fYP>6/3;,G=#BEOVVYY
B7Z)aO]MH@>A_U4GfKUKd]V#6;f79fbW94Y_-AT:g/<#O)D73?WL:=g>X:X:CD<L
POU4bTX1[XIXG_5O]b(e(]L3FXf&_[IfZ::J^2@ME]A29M&NIc4O5H\.)WOTW\4L
G\d\5P:,gLE?b[(,)C[cI/O43<F0/-bc9Y[+0JCUDC]I[YNJegO,F8V3X:=^F<]M
b41Xe@&fFI8,cP;baAOf9?e)55fN9,C/[F=H3Y[D@]2GJ034ee(aG@Nca\[\WXKe
ML&I(2?X,QeTC&+C=.)CCO&dX_5f(/5;LL?TA:B(Pa4MTGAT@&G6[?P_::^^M,AD
BH#CYY+AbR,RS3<.:YG&[aZ;V<,X,.:SFgCSB?FJ0)?aRE<=&)HVKQ(MK9PH[f9E
667F\OdZUZd].Y^/7;GWC>F6[LdZc9=49XPXEB+@M&SH1P^O<=M\ba;33fR0B;)1
gd//S7#P,Y6Ed,UN8&J(PQT/N<_CL?@b^]FbbB/U<YZA3f4)c2PYF7(SF-&Rd8[+
(=2O#:]15Eg6>UUM;8]:J?XDE.8#W1?<D1A9[.eZdMfOP2&HCJT0YJ26_P&98#Tc
A(0g)EI3<B>4e;[_F8dKCX/JYKWWg/,=-S;K>R-:XZYT=gS3:A1CYEZ[.2=c2F;&
@YW-L[.YZ:D^OcfcDXIRJ178AEcFB2>g<FcDO(bCeEK]:MbXXKSCFK;KM0V3f:eC
JK6^M=_#--G;)C@[<BHf,>AJ)I0.6X2JdfO..f+-#PIQPB/bX]P8MW?#BfO@0;aX
)20f.T?.);G9B1Re^Y,.P[SU_4<<(Cf1O5TAa#212[/^9<AZ3\(Ub3&V/VWaN..Q
0ZZQPJU^:WS<[1.d175[L@8K0HU\ab7Q#^A@1(.E#Q:90.A6d-E>(e.)1a72<)7@
c2>B?AMQLUR6B:^Cg8F01:48)OX2NF9-]5Y9-WRAgI-.JPW^5b&(JVDN?0^/c,)c
>PE((::-2JR/^Aaga/DJMF^51:-^HC:(FJGXB9VEO(J7-O;E<3TL;-;fA?PWeJg#
\f-XD7RXN[;(;c3=P:^@B/;fGN3T\V[>-@gLJ[g0;9bKKH6RH<Te&&aN1[:AfER5
^::@_#NJ38A=&YX[HC_)G6EUG/K->]+a.=W3CDJG7_HGbRGSC-F0)7SI0]Zg=dJ=
UcgO,I/D+[&XC]=T50=@3dB&+12ZVB^AZHRN#7EP+AD9B=XH?^YO_e>U-KO+f25+
@JdBd(5VIEHec^AFL6CgY3dFK91cbcf\J;TWKb\P8dY)SRe4YaZPc;>UWB70,eD_
M;GO87B];CSCIB)dAgHJ?3&V33I]<B-A8V8)X).gQbT_&+K,V(T+f-/4f5cIRWYT
2#+I;N8K4((;E1?GH,DTH&D5e3EW0FXPaYa:P4.DUQM-A+]Z?YaIIc74>WMC&^b)
M>T5I<J7XXKbBa\I;/]&>P8bDQ;HbBITF_3XfFe6E\3LVZ7C&.?RA\2=SG@K)N?7
E1@8,+]&<)bDV)V>P+RDBaG3VdLC<QOIA&&_CC9eB0#3@8b<GU\^1d_#)3R#J,MN
\3-YMIZ4?b>PV)=N7Q9[\8V^D=;0<<_LZF2Y&>9=^Cb,U,0F4#@4B@Z]X[/c<5?2
YI(d/]bc_^[Q7>Xc73.+I8Rc-2dU1&+#-4DWO_.L@TS&DZG->)_O+B)6IN,fPAC?
T;[54Q\=.XS:94;B:=LZ)7C.K>[,_Q)3EUSg@f9gaY0g&,^b?MRYRV^f4SFbXE9V
TB[e,c8FF,YM;&f(+ZEfgG.bVe3253W,4a<Ia5L_d[e9(7abTA#S5+X>5JU7<ff)
dNC.&.K;#YGJ+=>.IM@2/f#.fX^g0@+,J6<L.JPGaK=aHY4QGV-CYL[F?#PDSQL0
JJ>XCC5]2]PFZJB5)_LY^(,K.#9&V=dHLY_#03H[bT+5>)dK)9c./22P&QbY4]4f
7a.PGEY?0&g0c3@XC>F2BdU8]L(HH53@W)_O\3S+c8@[e0^+GQNR_>Hc1T&fTBHF
2W[?@G@&30/D]6ZVf7-S[6)X;CAB6MCSBafOQDXg/[EUA5Z#Z93dL2?0#;5V-IXI
.KH/\5<06D_K8V7_WOKHVRBT7eUL2QD7?BXN\IdV(Na=8<c\8#P3UQ.5c9^<.W->
BI(H1N00^Hc4=2RQS.IXRL[JQdTP,72DF[^<14.=bAPd660=6WBI@T8;XUdgf2N]
B3@TFR<Ma0>:FV.9#;-gH#6AN;FSEc/PYBFbAG2Z2dRX4(;#eZN_S^GOSG1G5=^_
DIeZ_0J?@3_dZN70R22=6aD:U)\;_K-0TE(eg2U8?_L+R4^:=,aSWIEg&V36EV3&
>Ig-Y_#=bRZ/GKN#::KZRC+XQX4S+Z)<4>aYC)T^[K,7Q8e_E7U\L?Kg=:4P5g5,
FXc>2CSN_DS8(/++A::BG)F;45bL6;-d\0]3ccH:QDYI+cLM),LS#Y:CF/IN,L#_
QTAX?ZG1aRb(,S=b1X2c2PKa\M&bWO3,GP2cg:+NE<_=LfD82Y;Bf:>LdKNAB#JH
./+Z<3YR73:_Y+8C?3cGK^e9HW,>-]90[gMZT.(OG5aWY5KTYfeUO4(M;<^7R?Q^
R&BFe2_E^QQ31HbD<?6NXG+GUB6X>c]4<f9F]C,FAUGJd4?88WJ=RBKU>^/ZQ2NO
gTTb&fA1Id=BgfH]>9\ebOD(CL&Rd,AZI^>F<OLJOe8aLKS8#5H+P:>+X6_Ac\1)
56WNd+_7?O8B;.Mb2)A-S+MbY\JTT-NP@_)[A:?48SD,<<XQVY:K4O]Y#L6\G/D=
#\N/;&W@F?IID^I1R[1HVb3?O;J#O.L@+10I6+B6d#Xa0O_7^J<_D]]YK$
`endprotected

    end
  endtask // uv_handshake_receiver

  //--------------------------------------------------------------------
  // Task : uv_start_detect
  //
  //--------------------------------------------------------------------
  task uv_start_detect;
    begin 
`protected
/>(G_aPLIYc>1JBJRQ48)E>-_6>2U41a_)R8d79AE-WC<?8bH@W^+)dUecLaR3(7
D)8CYZ:ASE10)MD@&2#E6EMaeYF(#NZHK0,[&)e[#=^BYUE;B)(V(^>cCgLS1W]:
)fcZT+;#-(<=IW&T)c)f?J>\O7HJM&TRVR),ULdYH5#aYFS/gA-CFZ-/M^Pfdb-f
S3])QH,\?@P]I]3#+bLOZ:0F\#7RHU8O1T^bS6YU4@&+FRP@JaZV.B<P^Bg-,D^O
SS<YTc[[d?13&1#+:8EdI@[T<:?+-?<&>9=ADFR[LIYYKF__9[8gCAJRcB4GM^O.
[LBW.VYJ-(+_R@>KZ9JKOR22,O7XE[O??\NA(BfY#Aa&RRgPgJ9>VA1ULVQZV]df
,4;UKCG:f#Z6>Ed3EMB_bY&EA4.Y-OS+;?>R&\KO>UG[baOabg]N68.1-=C&J=F\
8S><Y,gY?8^H->Q0:#4NC8H9)785BC#E4G]=HS?eDI7?QbBVT4]H:S#Vb0AGd5G+
D2>0<[=IbO]&9+7PCPTPDf1J?;=Z5f)V@B(]QBRGcEDRQF303ZO#&ebEBX,0N6a7
&M>:eCI/cSC/bX1e&Q6Df(4>dI8AEJ@Dg4U5#6.WKV8:^H@_(Qd/C2T,O09,b+cO
>(KH[RQI0L+26OBdW=)59[fM.,_@<F9cJV;F?f<<7?W3#,<C[8[dOZb?XK>XDX_,
3S2,dP\Q8R<8O#T\I):.6ET)>Y&@#=[b7Rb;1]SHXOaG;Y\bLgOGX;1D9bZ9Lfd/
M(X\,0-9SgL^NTFGDL>GZ3M93M681V)&J]+>=5)5Q[I32H5:>W=RObH#,UX_=//1
UDB^P=0H4H48C7:;@6Xd+:&R=QQS894URV7aGISf-K-N\&Ag+Y)dX^72;X.d(=FZ
1LQ/@dD8RK.FC]KE2-.71B./-d6H[QRNST0WUY,UTB+DN(0+WeJ>P?:F1QY.&6cb
;Z_-SJf;fL\daNUH1/88bW;3)g1E.JG1G>8S@59NVV5OT)ITaM,G(5QNC:MYDXQP
/-X-aZ#cXVb:0A3P2/R2d^?:T;VgZU8-f]]ZQNfJR-#EZRHIA6=^)#b+WaCLaQag
62_Y=ZT8>PG.602XaQaVZ<#2@gU6(6S/1FKB>)@QT/b<]0I>22EML9WT0-1/O(Q-
M3^g@A(MQTEK5UI.XUg=_[)-)SARZgLP)bf/7:)/a(S[e\(:+J25D5c77Ccb)d4)
JI5WVT2RUZd53gUTT1:AQ2DfSaF4O]f>4A_>S;&.\J&W-&78XF+&];/dRPg/Af_2
CG9E=b5N]Ic<-:>dbO0]ZEFV##/EgU:5B[X]@T#H=\=1=<=R.,C<I=Oab#)0GRK+
05+]GH;/N^&K)V<FTNc/,2CJ=YBSNLQ7_S5dBTaf11GNUeR:8XW6aH</DfB^PL@+
gWL6Q@XB@ME&G2F_Y;]Oe^D/-X[0:;g2dUG/N9]\e-9<0&MZE-+&Q/g(FQ7\abRU
AN<M2?MR9SCXE/X+gL(1#C,9fZI\/C1gO=.TJJ?LQ?.8@6;:2g;>@855g<(b9\_S
)\3_We(P)V4(4=9)(_gUc^Q\QI>UB/2dPBOf(M.B6e1:VMPM[4^fOe3D@YUMLOIa
_CV5Ne:RaA.2)>[FT_P1b.<I,34]BJC/ROb(:(PH\)H;CB8Ce_?0>1]-N=IP7P[V
DO+gS90CO9:,TEO9O9EH[f8M>K_8^+Y0cQ/3G)T2AR[B&dVgWE_IfUc=PT=?_07@
BMR/)#VfbQe+L>)BZZa-OGBMYF@.b#;?9]J#;0Ja,b<5507IcPQ+e8b\=Y?Raf35
O9:gDH]/;8NJcP73^>RPa/3S:b]/,\^a(10W.)=\RFPWJNPX&RUJ4XYXFaaMJ[_D
M35B7U]c^/V/.G3ed&Q;XGAHR;D5MVf&V<7@/QL1N^CB-3>9]K4#]BWH.<&=L8W+
&=<(.#S]WATHD&4_,7)L@99+-_3AI<_B<+BVaE0PVA,6^<RVKb(\+bBe(.N^).f;
/V8Xbd^]2SMg>-L>I8P>P-]adb=#=Uf5#2X_0b)f_.[M?#CYHW#G+63Fa<<7aD+K
E?L3JR2\Mc4bOG:g9=39gERX^4Y?G.7;VY58+;1;e8+WH:5C0-FLDBe_Ue-LfTBQ
_GDLdO4VBO8Kg:_SW=X[)BU?<+N73NM6:;1g3M>VF0S1[S[71Md\8&(@#W/U[J\8
dMb0Y83#:_-cCVa,IMCcb\?a#f:b9PM6X&VYGF)7TRX51CFd]EE-1P>K_L23c+[G
;E]L\/5fR<eHG0JR?HKZaZWCRP-BBD0B4bc.C.T84C8FAW&LWfL51dG;>E^1=6W)
dPB>J#(]0RU1PDbDTLd5VGIf95QD]Z3?7eQ\(-g@_6R4,A_AS&80:G^>:>7_d+CF
UO8&PUP8F8ELC(G[YSaI6/A(YWgeE#d9,g86\;O;R<c>8+fQ,.TXJbG)-dI[L\[T
Rg>N?g/NLPKC[QFA>I572KbKAf,.1O,38+W=dHDa_?=>M:JUB[>_F9-A/P89?/WL
bdP6[0g5;V+fe,g([)6(W(f#2C6MfBSKOY49VeWEG-L.[<d&R6D+=>_TYaYV=Ie6
::>)CdZSPT7,/_OF2RT[@9:61feA8=B/NGCZV&@E:T-O7W&82H7Q[DfeVBQ>#Cbg
@\O8L+d(e6FZ#M)EX-CL(2DU0:f6=A#+IK#5RHH-7E9&J?>bCE-OUKbK[dcT9<;O
4+egYS3?)D5NO+:g,S6<^23Y[R>WdLS?C0H0ZQ/LS^>2cU)J^]L12PJ-5\Edb?Q5
B^QIBO)M)5#)\fOSA[.]E&>K>NNM;H]6LZ7^-&ZA\NW9O9@AOdd(;[&?08?FD0)8
^&5eK#1fA0\KDL?R[X[/PH[5.WMMgg=9T=J1F>HCW91@)II0)^LSS5e-fMK71O:;
RY[b>M6c3,3,AC.4U5AE-0.?+&QZ,WPa,3S;eXRT#SJQ:G?OFb6^9=_O-(-KZO@E
4;I4,OS&9WY\WcUH]eB<L8ASe_MD(7bgXLO6-[Y0@UP_HNHDVM]5B]87g/,\f-7]
=e+KV6A(=6E26T)WDJ1N7O;#6YEd,;+MPf#<04c>b+W?B#97I[ZB9@6M(/DIe-Q<
S8de4f)03d;>QPB/4,L02RJZ1eB/Y#]Mf@H0dRV+ZT-f9E8f@?[,2N]KU)[-#32e
R-8H[TYH=BH)GDO)5a#c.9^SMd>YC4)dE.Jce&EHT)]1883#,+[_11a1&AZPYHG\
4R6UHaRfA,+HYJ_bJ6Yd51Z&Y-=87(0QcMc?X3G+2eALU&;D;M9]/<f/WKI5R^(9
#QeLGeXcSf=>5Jc:;(Z(H7.M9:bKN604WPaK3E:a4N#V@T_<7>DN#dfe;-@@6]/&
O[KEAVHRXAQ)_HL<P1I@VZ^@7Y.];>U\58H(_29=5+,QS\J0Oe1V6A:\J?XCX)OM
g0+OF?-f49g23MV1a&;&(^>IEZeTUNb4#SZ(_U7=/Y8DfPgZ&3-FWM[F(?IJ_.8B
YZW7ZEPQ&N08d0<??<<G)aE:65]7:5O-I[<M5A:[3/<DH$
`endprotected

    end
  endtask // uv_start_detect

  //--------------------------------------------------------------------
  //Task : uv_receive
  //--------------------------------------------------------------------
  task uv_receive;
    integer   packet_length;
    begin
`protected
#7_SHfS3Rb+>]KRPBcWN06D:L=GTEQ_Pe=[4E7e4CE\;)=G3&Y6d/)Fa<SAP/:N,
60.=e2;B\bMBO\>NDgLQNMgL4G@GVU&c0?T8SNC8KC4e]c3(M#D+TU6=H<WK1_/+
70RD);53G=P9bJ4747>dDX@WY^#fa7&Z>/gg?+C8@[c[gg?F.GU-X4#_T4#SaX#\
I2_.^>[O-J1R(YH9E^X-aDbd9W^[g)OVE3TaLJQ3+M/27.60ENYMUR#:@?dPW8IY
Ef+\0+L7dDT08&=:cN7aRTBU]5?9[T48BC3b[B7BP?#,:PdG.]\:C/3_1C&;?-T)
S;3.?f6OM3Rfe:Y^@_.gYYM2H]UE&0@?JVZ:G.=H0Xb(7QK;VeIY3:bXfeZJc+gF
QR?OVc96)>#1fB#OM?[&Y)J4&Z>D3(Xgd58550:JAcLTI[V)3TA\#BeS^+.B^K&(
g=eP+9?=[&@BJ22RS#09P0<;5_XAe47<cM2,WaXSS<[VFge1F_1EUa3B53BEQH@/
(M>-IaG;XCZ.JgXGgUK73HU8)KRP;A9S_P&@3>Zc\;CGRRG/;:E7H85]H@XL77D/
PO;=)Z:F(<e@5afBc-@E?faIb5dJPA@RJCf>X4H+(+J4):J3g2G?>#E#QYJ81#ZZ
eW&/,Hg1>I5BfeQ_5a@I<N_(E1;DeFd--5JY/4&N95-Gc?.Ma(g.a_4N(GCPQ6G6
/,\QCW1_e7()Mf8YAWbC_OP)8EKU,dFE;<D3&_H(51aV\GKC>:[LO4-R?>f\O/OO
_WbcO.2Qad+6S\P@aKC](,JEe41F[)QEF;.?A=Y.4_;B]#=@Ie9UTKaec4BRYUTN
fETF[-P52A[1<a8[=JGf1e46>0Y&5ecW,/.JQPeSL]P+a_,L??5\M0Ab))_<)FaV
bAJ3c,;)@@1>@D7R/e+5dO/3J516;P\W(416O,g8D]\d4KSEADJ-A9+A4HT=:_&W
6.DFEa1;.NT12OS4eXQIg>2/0,V<4Pc#[3c81B_+-CK;2<?O-K.FQgZ3/dM^P/+P
8^A2@,V\2&T5(fABE<N@RAV.K6^91EG>R.V,@75<f^>d,-N=fWET>G58Ae1@)7RT
_V3NVCBgI?OD1<fZ#@FDPSAcdJ.7[2CAf&d[3GY->JD&A6NM6P::/NFggO#KUQIG
c#,<Seg=4K8WD4&5([4L5A&a[\6bW;#&Z]/[>SfTf0+BTg&#YcJ5^D+EAVD@71IN
3I/2-Yc05^38X(:/GML9LKW>:I6R9O69R[7\3KcJe/P>DL@:BE3H<888V5-8[9AN
fK#5?M\GRXWIBI0dg?0KW/6[GRX##()2@/?R^0AD(0S.OY)NWTY5e>874+dQ>aQJ
O7BaEG/_>MDZ15cC]^Y)gRgS)ceF<-eW7EVE1.NAZT9O5:?[]MJ]?)YPBYIU:LDY
N+b@]O8YT=PUPf9RC^V/;7+IQKZD,;BI6SQR-e<5U+#.N?^.;bE&>XH\-BVccQ2_
Ka,CLAHNbY<4T,2eb_1HY@)(>4I@Ug(G<(L0R2K8fRV)gI8O&:CSZBJ,e6ACHaeV
21<V>:A\+<DQ\^^Q,N,K25?5FCQNXc(H6IUN>R+2LZ0CP(I?d^Oa\9RH3F=VS/Y\
E^_OX-1A5+8B<YP5K7MBQ=eFDPGP0M9M?M9R>0)-HG?>;E>gU>[W&SBA=W)A\GPO
S2F+0d&[(S97J.NR-(f&DgK5=J6/8+6:<Y6XSY4?^Q)0-9JW@(a8P<1CaAOfRM>4
LZ)Ob2J#QR_+NG[LA#V/a036[E(1F929QUPIBaOBNc0QaT4>;XEdXR&DO-(3A^gg
bcA,f/MN@>Q0NL,R5@C0PI0U]9.a)?I&X=P-HV+^SZZ0F[U\A6HIYQ6f#9eEb)78
<-Ea=AV?LZI4V<M#ab^b/11?5^)#^;R5:5<?^(agbK5-,bNNX)g5H_2PDTVZ)3>c
3Ye2(cUU@N+XK5C]GG4^055eR5UJ^Db\c.+,GXge0]f@,JJJ_FX@?XEfL\59)2ML
cK@\?QQ[\YQYdZbTD4&E0/M^\WLU1Fg;A3fNOHaQ3C1b.)FPH0g.S_O,Q\65#eHI
C.KFML2+4S]2/H6_1R8a6.gJ@La4>C61O\FRIQL:S/D2]Y^Q:G#dE53WF[]c[><S
^3Z8#TVSBZ/&d6g_cD8,ca);,>[00WVJ+bYUYbWJMYg.@?8,A?bZQ#@F#.RW^Da2
J(RP>8)WVKaX+S_=E++f1(Y)cR]11JE]4AE=?JF:V25X>ZXdKH]SBP4I@/J(8@TSU$
`endprotected

    end
  endtask // uv_receive

  

`protected
d027#)K2LHW6P&03e6LAcPN(8E<c8T?AAM&Y+5<?X8E0f7WdKRX01)f_)M4Ddd\&
DOIN#PTOL5H6,$
`endprotected

  
  //===================================================================
  //--------------------------------------------------------------------
  // Task : construct_packet
  //
  //--------------------------------------------------------------------
  task construct_packet;
    input data;
    input stop_bits;
    reg [UV_PARITY_BITS -1:0] parity;
    reg [8:0]                 data;
    integer                   stop_bits;
    integer                   i,j;
    reg                       temp_parity;
    reg                       one_detected;
    integer                   temp_stop_bits;
    
    begin
`protected
\e>O=QUYL3>UI)U(g@e^URXc^Ge_a6?]b,c(3H#\MH6B&5Ja)H&+5)d5_3<2^)eb
\:4;##]MGYa/MUFH[Ee1Mb0:b?GR+##cMd+H&W/bCW2eH+\)JKVScf+)Z&T\fEDX
RQ,ZZ<M#1SE+\\6bc+@8Z.G)8Y^eP_9dQ.@CZ+;S_46e4.B-#HAW/]L(8\\#T)Ld
95[UL>A#,HE]STReB<Q/fDe1AOd4TdR>AE?HJ;K48RLFGDV<NK>(@8b^,(.<C^:4
)1#CX3H1R_F:860e+EJbBGMSJF+6D]eW1O<<2ZL)X;<]A]]PL4X)U2Q#P,90BK))
_aOdS,A#(Fg3N650>fg1O0Q#)#?VK?/Q61a<d51K)CT;J;ebUcJbPa=>X.43cVJ3
_>U\&;PU.CTff#R=I:_]b]VQ]1e3=e3Tf@>\,bccYK),bTB./4@RKY\5GSU;=F3?
,D_2NaENJGK;_7/+fZK9U0_.91b/93P(EC#Fab>=)=E1;:eDHYS_XOEMRQKIA-GE
>F5_c[56DHTdc4Gb/7NH4[=9g4Q-KGJHT=9F7F(c(D1YU8dc4U0=9<3f3BLAaJ_^
Pd;cI]Ma]0J,W,W/[HUS)#\PUYg;0S)@.g&X]@TMNRQ+,8F6>gbIS:DPeVL#S5_#
7,a5-gJ//=V.54LS#:gE2d,P8#.Z/^\644Mb-[,0+d&(<bGHbI5LOJ_^TW/TJC@_
6@&1H@A5ED.#4D]+_.#G+,9,?G),H2/DOgQUI>7P,Wa.H8QZD_6&B4UD8bQJ@IFL
XaaBOeeL^P;)TD>:EYZ1Rb1\/D<#:-f,=-:,CcO(&)+f5bQB^&1F3_J180BDZ;b@
7J+e<KM9P.;3I6K+Z@W5A\/NVA?G=>]54HZ>ec?.I&^-[05LLI8P+LU1(8A\-7F1
+1^]1PKV,b(CMIXJZFJ6_B?+:a.>S)]dQ=NC6-#bNI5QUVZK3J,aMZ^_fD2d)fM;
(J,:OgZ(^)\CVgB:4-2g&2gbUfaK41GVc>3<&7<[D;=#-Z0(H(OF[2b&FE\C563<
^d>-Xf)[8V9)Y5S6Jd[;8NT#\d:Z<6/O/Z_@8K6Q4=D?XDI0e-1+Vb<>W86Tf@1Y
U-/W7-_egTOU_^2SKc\eM/PZ-4INN1e[H=-/9ALNQ)BI9.=>;<C5fdEaWE6,AC8]
Qg2,_F[9)@H.=)A:T22C#Lf;]LJRI&,L?JR,cBO.-J\2IG0O8aa[SeL30DH>#<6T
\8P1O:bG0T8NaCcY8gE2SW.2&D#S_e5S\CQ0cQ33K^.W:+8@\?1H(<N6+]Ne20Qd
gZb/XU=TAATP<)cbUR5H-YRG)ebFKP/=QWYZc193PA9E.@>bK7d@(Q:GLCWTc1_1
C#.2#[U&CLHWQ2K?D@f),+X8#1.)Ae5g:@:WdHB)W#867:]#?]C2?K<G1>VZb-9?
aM\QGWDD/4@+X+Oe9c(@+#ZIO6_7JR6OD>R_]7de8Ec68&bYTf@+]a\N=)KQQFOV
=Me;5;]?8[<PZgWbTAeXQ-Df()a]V@M#[J6Cc#5UE.-UTIZ0NEQ726_E;0(=<OY8
PMWEbO1+e<ON.2M#Gd+37=Lg#NQ+f<WT[K.B_eJW^\3R;#R8bG19+1e4HR=T@&0[
_^^0fCR@L;Hb,deB47]6K(7,W>Id[d@QPMYbN#88BHK:g<gcNaU5B_G52-^0)/Tg
GX[bfdF;6]JLHG749TPOQd8^YU7A7CX9Ib?c]]R@,?ReP(9CaQ)b@6BgUR[Y0@AR
TH@?C(E_+7bTEKPB<B;H[8Hd72g\>eJJ_^T22eY],E@Z50>I(G+M@L+6WBL[><bK
W4+.@9Y/B?(:OX/dU3#3&V@,gH1H,93I8g/J8RV/<[I(]9(4X)BF\3;F8e/,a:MC
(EI<gU:U,0(6OfTS-<]\W4[QWO<[.QYMS&T6IVB[:-eKHQ@GM7:BBW?S89DGVD]U
DBJ7#TJgU\4WgL6H6)HESbYLTWA[CaP5TUR:/B27WOcf_:.D0[GV,BUGHK&9PNA>
:KGI@AZ6+_bdJbMXG42IS7B8NQ7[DTMI=2=<4TS#faQB+c^+eSZ\3V]XLZ/49R87
\[XN;<4?.]=fM)OQF2),9RM4d:-<QM1a:@)M/>N7#KgTfRE,-+CSbC7H((7HI.Y_
QST(6BWL_=1)T9AGfTHW0G(aV4&9)JJ/L1/D&3OdW4U4L.f.:I[II9#BdcS=V1X,
+<[DgeM)U7bX:fL8\cE<DQ-U&gEe[LUXH.5dUeLOgGD3=a,Aa6N0#4f@UOb_P=G^
(/,]6H#:<8Z>TCHU4C=6cBQ:^d[+O/:egC=BKPa@0D5ce&Z,6dT:LHQV,F3Ce)KJ
8>L,NT53OVU[H&PT6.d[U:,4/+^&6,U@C\e-6.,ceA9C.=BM&49O9T5^KB7-6^(a
[P#Z-H,;,IJ;;^8_1@?N=3FP&S23Z7BJ&--T-W>VZTcG9/fK>_/J>f7SN(^,+1+V
5&4Id#=aK4DML?VEAWLU]3:OS.:MO))2/04J&Y&=W<d=:9N1Q;7_fX46;Fdf[L=X
PcPf<I)6Xd)Y(efN-cCN[LVICcGL[/BY_T9EabeBH0]agNO6RA962e9a634G[0]D
-+#aMfIGJ@acgO8I^7CJBIUT:&S?PUXaJX.YdNV_^;Pa[bgK:L)^O]?BP3K1<^N>
WZe?Tf58dE.2&(^F6@6@/(YZ@<.RRc.KOEKTKdKF3STObU<T]C\6;EM&:cF);_VU
]((P^fIGESS=D;dUG<:1]=NPR6E[b-=)N[_[f+VeU=We]g9e^@fM?MUJ^<C.].cW
Q/_J>75?/#)g.3WW7&S]d9GAf4SUfQR=EE0\-0<SZC79ENeTZP-?c^]LQ.U)NKQ6
2+0-,6V,_1\[(CH?E956)VWf8(2+?28I_JRN-eeD3TP3-DOeM#J#P.WPBHNBOOA?
>7c,@gg3T;,,:Uf[77E9KL1L/7]dDO.8>Z29KdCJ?BJDYW@G2_Y>?,&-[W4^_YIH
9QSD3[99_LW3@,abL7I^]U@Me(bVVBK4E(1,@]=7OSbMW[_F9e1<9a-XT@DRRLW<
]M5##D]35_A-cL@+2W/W+BSRbcFI6.35]XbJbgS8e:]&?NT2]Ob<N/@a3c.>?ZM5
3T5AC4B1?1aIT>@0A2?8I/0HGX-:@<?)&Y,YSK9,S]\43dg2L^:dF\LGE4W59+O8
.XSf0.CPL88OR8F[JS/JIH5(HVGZ/g?ZFOL5=@&BFIB(64GX0UC)AMMQY&H?a#WN
K&-:1?Z:-@f0.-e?_:c21Y1LHcU1LbB?\I4LgM_B+_15RMgR.^aR90BEV>).Y_\E
Z=g>+)D;c^MXA6cYMPC/8\U#KUg#9[408#aa7.R.@IH6-PKIY/8RB+SFg3N_7DR-
X<U(cY_C&aUg(RL5aY=S(TJ972&:@4KL0^<Q>.DP-.RE+]2I36[W_#,W^LE+S/L>
L?ae9&_<^EZSgX+aLeLZ-KM&M_I#/@P>/+8gLXBPV/<@?8[#Y?/W2[(9]HXV@#><
6^EgdSGHB1^JVYU^_:g/&8HT8Q.Wd#D&Y[],3H7.b7OE64f:JM;9+9E)6,>^G997
W7QE0D-VM.dWX.(;,K/#>__.(9F5Lg_Xd6[aP,<LS2=ODQBYc.JI#\Ug&^0A?8g1
;TCO1^Z#eP.?eNM1Y])7gP9?VLeF[CVJO:f+c@Y=6<WRRa>bMH@F86@PR)ag1:Of
1-R02^b.2&V)Nd2&RL4:5LU.S.e,)KZb1?e,OFXb9(?M>._F/a@+;^>9cM:4BZc/
6F1.#6N)H_c&bfYPHa)d^9;YX9,.@9-bB;FUBA]_gH,OGeF7:YBN.CLRQ0Pd.@<K
OQTc-](3<H+WA]4A^V#cO<HAR6cE&LV&9$
`endprotected

    end 
  endtask // construct_packet

  //--------------------------------------------------------------------
  // Task : send_data
  //--------------------------------------------------------------------
  task send_data;
    input     packet;
    input     length;
    reg [12 :0] packet;
    integer     length;
    integer     send_bit,i;
    integer     temp_stop_bits,repeat_index,bit_count;
    begin : block_send_data
`protected
PacJ26\ULCA1YO7)ZCW\6HKITH&DF)5@15@Sg>APH9QU;5M@4/f>/)@UbD[DU9:g
X;d,^?IFY5VLSJU<@gHK+,;J2^),3^_@&dFW,R+XBgVUA1XcVcM#N(M=PLF8[#VB
+U476+JWL<08cT1<C/MKYb(4M+:2L2CSS456RK@F)QD\6XUf(W,4fAJd./PbUDGG
(cT+@V_La=ZR@CS:^)&/_Je7e+FDTIN+:@6]\P=;.f\b9#H-+EUcf;Ia=E#/+)Xe
4\L6ON&->61Mg[50gZ>1PU##0/W#30S#_280)BWEFI8FV.H26D]IEFF^;He4b^_#
\PKC27]J/E8RAH\,7N#BEJ6^YCgE9#HO<TL+T2Q5;Y)M/+N/2_K](@eLKJ^JeA84
-_L#:ET+/V,7JG_I&0F^fDHEE3Z;CSLN^IJ=OFJ,B#U(7&RG7g<QMIA@@<<&#JTQ
d;8KQeBP/7Q9Vb@@d::^&fBNK(Q\O/+;8TT:,?G4FD1;23VB=&+gK/G\^(fYXT?W
XUJYWE1b3W[6V&3(;4K?B,UNO3]O^AHe[,3+N[SCH/\Y,M3?]EQE)8[KX&O&d0T\
],WbF?N2:-07.:.2S-Y5C\A+d:L=RK-3I)_\aF]?@KRZZJT_.gec@\[VJ]<3B@KI
#,X9E+BY,H/(]JW9\e,ALc82gI[R9dY:T=0c:GO\1_4QVGf5#9f.LFBKUe&@&J_/
S&Mg=#24>>[]#LH\B>EMS6[0VG;ASfg#cHe?c3Sd&G+a@BTS/BGU)fYcdEB>fTB-
8EO.6P_X2N?D<HN+_LC9c\Za:AMI0MYE9Y+-AP\OA;aZ((=EY6,9P;,T/f&E7d_F
&<3P7a_[]+,7,g>[#OB-X@V7VHcTg6@QBcB4RbbHZg0;@EW^09g?R[SD?BcP/?Ld
UcDVRM&6bBZ_I^RYJ@Sb@Q^7BcBeDg@A7ID2]M0MgV]@-+]K@+-[,\#OK+=&>Z](
J@+bP3Oc#BV98B]bFW<[3YB:g&\[)M2BUO(;@\>MH76]DLH:#5W:GMdc\)MCfAL&
PXTVN^H:D=W[MI./R.-[0JT@#TATWE<>g:8e=C@G9c#bDA^6+;K;>M\?c(:?=W4a
-AN?<86)71@4+?BR\><?c2eN@0TPNMWfT1#\)>aT_Tc<<8d9+G00QYAO\Ma-^T]=
\A;3[e48TY\ON7W.<X(]0&=&8eR+0BV-e(^QT3VC_]d6Ic+\TCP(4feU;47V^PLW
a:&.2c]Q7.EOFLd\)bEQIeI.-<Z^[+DIBg)5-@aX7P[5,ZKUd,e@bI^gKNF7DLVa
<.QUN,XJ(b41Ie>Mg;I4M)cM-QXZKRV):U+>NaU:F\M7dH^E(a2e;/Sbg=UVAKQW
/;UNB3&=2?5QQ,cK-VDOS4/SaW[2+K9^Kb)^#UIH(FN(R7Rb+P@.K>?V?OJ(<gTW
A-3g0TX&05>-0C7[d3Hb>R^F>+=8&^,0YAQNL>NQOBGI3<T#,C&S9A>5C@eE_^<1
3_KS@9/N6_Fc_gJCBGe@TI3gO3AUMUCWT1/)&;#[:fV4d#aK;==Q.;?Z;aP=A.#B
a5d]Aea3G?;VR>ZcN]7d68,>ZIY4Q^.H+[:7.b4&89_f8E8WG0F^M0/Y8I\B.<AJ
:X\_];a25c68;GI/-FG1MLVH@RC1C1Z95)7.@+[J?3VMIPQZGN9b)d:U81E43e:f
2W(:,Y<_&g_1O:K-T0YO<A9Xb,+#;(HY9gJb,1HfQNA;8+84/VBMM0056cM26cTK
\NZR&+W,(WF1@?7T_dR/833_25VY:=cfV35&fe\I^86SUSPVLO:H7W4a;_DJ-OYH
BCf8LK85?XM6.4]?&[QP^e_NN,>OHOH7/K52<X0UeVY8TNI/&?cT.F=7M2TeA9I7
)a#g(UTJOP^/=:U05?ac66Z;4ME]C2M0UEGBE<N;A5e;#7W^c;,.0;3g6[VKO#8Q
8@7Z&OOVO<e3Z,8A=#_6-Q)]WPg+L_4We@DQNM0.c2_],>MI\Q[gf+0#<58HCGB+
U?XP7[1&2BO1&)@(aR:Ze@b8@ULQK<C<aSQR^db]H+EF^f7>2[CD1N;Ua19(_[[F
dYJ77Xg_CMXe42+Q9GGW;T5^>=(APad<\0V&C?TO6-H#Q1GU5[LPgM[bQWFL7eFD
\5G1_f?V]3I\W.P?Dc\NDOEXSWJIdZV>#LdSCN?G\g9RMfQ1=+&C:FDcGS(aMU@E
A93-BYe7#H7K?U?A9AKOAc]I<OOdD45,V5ULY:?]=e[aF,^1Wa8T=ZK8NP5=dD4&
3+2a\IU-f#N@T#CP?;,K6P3>/LCL(?7JWJ20O#]Q\^)#DAb@?TNR7b19).6b[c+?
3&M__TKDK&,2Fcf8-X[EJW0AQQ3b-DU7T0?E(M,C:\>HAO_P(2&LNdQR&J&#TSaD
(=3=X(1WA&8[FQK84O\O4>-O>=O#TLcGE_a^#[D>/e/^3K\L&^7V9&R,<,.gW&LV
3=aEf>@;>QOK1R9U9dXX[]S)VO#3f7g89O-g<9(<83^IcQGa#S^Dg,66Ac:EJ\W3
0d6-8?+GZYWCV3J:EI11]-WSCV8Y2cFQ7O@,_2OOAXN<1g+DXNOb9Df,5fQ0]>>6
EUXWDcB61^.&NAgBB5JJ5^4)BbZfBPXDaVQ-:)_Z2DP9D;;WE2.T6)c+(I,HfGDU
X\^b<Efg44BG_7(MUgOY@9J[>.d9K,&#?@IY59e1[9P=YH(8P=\Z21,K0]^PG0bA
\K_<XdHR(]DR;40\c&Y4B/(D.1VZUa0VR3IHeW+7Y-F(gN4P3G&/:HX/P\_HR353
c[])3<CaM^QU9SD@0cdB\JY):?3FBHKXZTVKN/T<8:GbA)D769Q:<?4EaOO5Sb&O
[K2-<a:7&+]W/0,HN0g5ZPeN(]b[L^HL3dXd<\:))(PS?M]S+BIg<^1XD1YC::4M
:7RZ;:Y^,P[051SeZXUYD\7S#-2U2B?YT29/XGg]3K/2VPM#-YK51Q;E\E+<8)Q=
fRb&EVY3cEGc6I\I(#66O[aE6(/2;Q7M\1MO4J-WYA#H95CcVG[OG@?_:>W45&aI
2[D)e>ROH^e3FK+OfN.\a2:1#;V#DY4E\U<:MVBfJK&LRNV_Re5&K5HL48RJZKgQ
LND\J?7P6KcVdC\f4cD70EfI;:I[#]N6+?Q<.E6&G,a(78b;U>Q>dMJL/MK>RES>
(55)10K-Q1^Z8,>FF\C3^DD:XBC=A:Jf5daV#NK[?ARGf]X708QZ6e\3O_L7c9\L
AL?(G3>J.WI46c-+5JK?70,aKA.&R7M<2YD4;W0UE>6DbRJM@5A<40,;?T95(/+C
K?VEN2S35>^(FD/a6^DLU;6-&gHD7H#3WU]K.9=HA<7KZ4Y\dU].MK)BN(^e\R,T
C=9aJ&&5g&M]Ab81&g^=d/[O5NK/<DX,RcWA;+#,::WIALV_[?UR35(O3O-5ULFI
?[OgXV>Ae8bc:</1RE+c6&<1A3dL5(N+W<Te55c@BIBNPT3P]@6MI,V@0&3:HP#3
:Fg(Sb9.GZQD6BHg#@WQK6d^XNJBKUFg^]T>&/cg^B<,ZN=[e8915S+YHPY4+D-7
C_c[@1Bd3+82>X/9.]]S\X1FD4K?a8g(\W^X)@S]A39fYU,b+A-ec9M3-PVP,PZN
YcV\B>DK5L9U./P?DE:72,S;3^(SX3X-NUT]8aCC9-\&a1-3T[+27E7X)-M9L#J:
P<&]:F/OXaf8U7;MRQb\=gE,4YUX(d6/1^gPc8[Q/g00O=(FG+^:#WT&RTAFVc(M
Q0gV_\9E#-^EHL6;@CPHWf4.0>]DYHe[e2Ce9gR4?54F&E[?OW9HWKKZLc#fe6J>
A(:L<BK>8=J@eUdef_gA>eYUe5GEKdRDG,<\(4?e70Cf-^P,eGF1L/^L,=DWeJ.D
Q\T16DYLA&M+7I#8=N\dQc4Y0M#V3R(3AMCG_K#LTG]U0dB::bEM[_=^[S=@;A^C
[S(8JKVK3B.>dH^4I3aeC+L-^f7:==]TU[L8W&,0WGKVf[S5cM6PPUc&EVb6G+>Y
[3NAaO-R,@GTI?+Q:HTWCbXSf<_O)-7^)ZWe9WTA5aP@_g/4fJ?e^2:]N2e=7\63
f70JWUU5:G(0fTE6VH6Rd8NK<TQLIPE.:Ac@\cDd:0#b4?1.IaXK7Ud?Lf,0gD#:
+ND9\^==H=/:<0_&J=M<E:58IH\\/&[9[RS);K)6eK4@bF(Jg:KZW53XT<J8=>;L
\>f7I?/B>BL(^J,&&?T++/Q1I6FX53WgL:,7Y+RVG(6^f_TPHU;5RJd.=T_f^)I]
)ZDK&VI\c@7R5UG#[Yd<IN?34Re#IY##g32(7gJ(]+bBYfA(eY-XFaQ;/5PH?f&7
U2?<_aP;@258@)^LBG;Ia0TT71gdEWVa:((T?+/W@=8ACYN[MLY(59CM9>[A_F9f
B@WDHdg7b\2[XW;2U1V9[RQ@(9M#J]D+90FK@MR]:ICW7-(OKNfY4A&JO1cI;f9_
bUe;KCYGVCOY@:)_8FPF[aQCM+MD[2PgLVK.DKM;E1VcI)D3:\T3&:]a,?dQJ1cB
^7GB72H&]ZUAV.IBdQXO.+D\3,>4&WRX&^1.4+IT/S@8IDAaPD74#6ANfA3]eSTD
[6S<LPU1+EUB6VTaf\G5#ZR.&1/7GR)QOSDXWSTc\\6Lc@Y@)&2T:<RaONA,b;Ka
.Z?8Y7#?;M5/@V:I]Dg3_4O7>>RDVVfGb\U&dF9e;(d.14VK=K5Q/[[1MX:ga,U8
#J(RW37?@+EFM->0HQB>7f>JYS(Re83@b@0@(AE8CZZ?SQ:g9G>97-.Nb;[cN05V
#9#^Q9<7H?NaL>K=W7S.>bP@1QNg:<,PUFU9Q1<^)T<bJOF;4KFfE2QPWG[c;=VB
+6039#gc]Z9)#H@^R:Hae,f7<e)?fL?QZFXR(ZN#)<(#_e_dWZe<6&DN]f)&bIJ0
T-b_H)f&GFf])#eFW23C?g]G@6D2QM0A5L+D5VO^=_0+=F3N<#_&D]VRQI+JN:dM
RIed_U/Xf<CT-]7F41Ec+[2VFd?/H&f1fT/0@(]ZW#YN+-cKQVaSRXP?B[)a3VcZ
5A2E8Mb@WdX4Dd3,+b[G<5P/15FU4\]0:O1W_AbLGPFJ,]b7HAc#3RG&--UU;-\6
cGL9/eg.SWP8Q:D5#S5L0S-T[;)EedMZBD]b;R.ESWIK0Q7C?_;bdWTJ@S1L2F6V
=cPM@XbfP.Q53IB_8<^F#)_.TR<7)W6AX8g863[Ba9K1TU@Q[+KPRHRX5D2WJI;]
NN??Cc8#aNJa?XQ2=6TBC-cN=6?M)e7PO(2&QM8O;Q\S]CX^[,<CGb#V[Sf&>EOV
Uf:MN[P?,RG,T&-M6;ZL59@(c6cJgg]7&#dHaW__a)]?3^M)V;1ZX#]3#^J)O9-P
[BF^>MF<LL9bIDAMNG5eCG=>K/HYBZgDF&^A],Q>Q(F6;0)Q36(3:d)LZ/0S1XJc
^BZ#@07NaF#E+gcNF2,NR6(DX\;B+9\#f;b[-Qg0HK@GdDddVJ=Y_DB,#@MIGe]#
F5);57WKCO-)7+=,Weg3YG<7,0[+5;U(7cQQ+LO<\>+JB0V(R/,B1A?RUV=#NA,T
5H3-MJb]S@)5EW\aL251=W4:QIXeOGe0d,>XHf-33NMcgIaG4SVC9M.#cL5T&\)2
IBGUYZ^^=0^WPbE\0Y9Ce\#EFH1B1+9e@<b>W:G.3MA=^+U[6G7-3&DB7EKEDR3\
dF@^=DILI-Q#4RHV:,UOK[gOf(Y>[,Y_7:aN1a<1QOcdPNEEVcPS(K@NBIE+QI-]
N+R1FI&5FC9((eV5?7@>XQdM-7c4[6_gM9JDRgT3J.cI/<C:&#5V?P_]fNVaf@?b
+U)RaZ(WHJFR:DF5Og8G,?1L)JI881Q>c,C@C/cDIRVE-5P4LX<;G43#OT;Q.ZRa
X8#_3f3&VeAf^]5QPcTf0ZTE;Ta:PgXC@T\ANYFYU_-D5UA;T=Ng[[RTf^f]e;5Z
0;bb5=ABVTYc/BKXa/7360U&OA8XMD(\+dDNe>^LM5)C\0VD-#e>^M+Z&(\RV0;:
LF8S<[\1H7QWbP=fa&GZ_TM3=gTJGEY5^0b077L3cD3cg1VY7BW1=HYV0Z8,g#fI
>VHPaUKV_C[I#]P:BZ=_1+cc.)U3\_=H<db=HTJ(H(OH94G-EY(F3XRG\d:C9@<J
+B>LK<:J\AJ&Se(V(G_^c&4\6Red1M.]BOc,S&)]<C6Sd(:9-M<;DJVHWIc&NZ@&
0eOU94Y,P_Q5JXARe;XXfgQ^@AG5>PX-I&KY6XXUA6&YY\7H.f0:RYU=?JE(Ma4A
S(eAN4(S5dRY8VJ6e51PfLgV.JZOO9Fb0#K9c)CHQ,)YF$
`endprotected

    end
  endtask // send_data
  //--------------------------------------------------------------------
  // Task : get_packet
  //--------------------------------------------------------------------
  task get_packet;
    input     length;
    integer   length;
    integer   get_bit,i;
    integer   temp_stop_bits;
    begin : block_get_packet
`protected
#QF9+Qe_(/?N98>f(#O<FeTDXT)5[2EK6#a>a;2Q@:/J3>2<gQF/+)dIf+[/E?W\
&59F,P88P:NTW0MAHCeL5Z5:^@^bA7JUCXE_EXS+g_fXN?;<:2&<SW<6YB;c,DD^
_MOafSZ99L@W->DL)2bMRd&(Z102a#2S3ZLHb\[2VRQDP:G)a/]cAIf5U,C1C_;Q
IcO@FEOb2T\2C?=OaOU?#Q7^M<=f9;FLN^D?QF)N7J,:f_FCUdDLKgOTV_OJO(HQ
Yd;GW>F:AVbSbTIY1.@KGQ.aUa37.PLd\HW.7MIQSAW<7,21O5VZ>TbIC=GQ^.#E
WYOZ(8)a2FEeF_3=,2:Nfa26bbQZ5KcFW3?g-Z(bC9]1?Q,=8]ZIR3de?8B?/fI#
Z=U5Z:[ST#G4<SWO4T^MHBH\9FITO):1BD#_5HGT<Z\P>>L7.caP>3FI[.M(Ua[0
B_JE_14:cG/Kf;:#d/THL59[M_eO/2VC[XW6g_C[2B8gD2GK1+Q@89;H(3X;^]ed
TH3VTXAQD,Ug6R)C.F]cU\D\aT^e?L5B3XX\N+TN=U[)@PEN-?d3UX24cB(:7.?f
J.-\?A[&K>.&T[2D;^U/JcJA_Z4C,Fd@-4A?+g:>J\86_I2M]90QPZZULL#.aOK/
46E,TD<ad;fC]DHKd>D1HE=I7_aaKF#,73[V@SNO^V>,Wf8Y@3.9I<=LMI@S^a8L
J2A^Mc^_02<((.185YM>I>T]Yec+8B+2Bf0O<JZS?72/B>:SW_5:TfNPNfEXM,L0
>0.0fYW1K>36^+[K9R[<SBQb22DM/=daV@1]\&_0T2fT-@_CG[K;U2I.g1E70A=;
7<Ud0:AM>e\\7XRXS6/1.8<ZIK:,JU@__DSG<3\/KagC6/#9U2ELSK<Z+(Gg<cDJ
OPLf;,,G-3ZXZJ,@Vg;1/]IO-S>F9ZU.a2gKb@[YV3&^dR9Q(9>gX15g(]<OcB4Q
>_e2S++d,:=RZ]T2Y-IH@;ffA;J=9\13VBV+-W[JM:O\PWf]53UcX\,KJ6Q:T#,d
S_1-39B;_ZILSP1Y[2P:U>;PZV/_C6WS?#_O+--6;@LgF0d=UEGO]3@LQ7,(7KGc
Vc^W;#[ZO.1UXQN]7b57[Q/H<6BgLUMQg_HW0-(R8B[BP-^gO:A@0a<a<C1G5EdN
3X?\bg/HNH<80<K#+FH<Tb4f[b\1d.fSH[e#Z0O[@TSQTDIBgC+dB@)MQE]4LTM#
-bGe>?CE]aCe?e2J1AMZ-Y&Z/V@D0X/Y(KK8a:UOPD3PWNe44EK97Rc28Q[d]fDU
UC:?T;.T-UR2>Q,.N8Q&]U.R&_KT#QB4R8@fRE0=>P1Y)0eWG[P#4J1RPV/VD0@0
\36J#VL5B-V]EIP9@Q?AHSf0GZ79VXF4NL-8:cF?]6Vb4cC/QfJ^b+0^:)C#[2^2
<T(#6aPDZ.ORO^c?8S?-g6d\U^Aa\&V48JL/SeNB+9)Y=g&UF2D:V7_]eJG)-Qg=
_D\B;YB6A,9S?4D@Q>L:H(H74dA::L^NH7G6D[SNYPZeI#1PI0?+O=IP.NN1SeN2
L5\/MR<bIC1AS;?WD/FY(&?WJD/ZH^TI0DYPH9bTLb#Q>^S7,L3PRRG@R9LM-7.0
(9ZP79+.[_ZDbH@GM1P=]eM/NDN&+XCY3)3+B#5;QeSV:Q1MLVgFb1Ac#A;gP,E-
?3b0>bJNB<FLY\eB9JWa3_T\A:KKK?\+B8/)>8gX?E_LYSJL<9&46^Vc#.E-+)F:
@Ig5]+KOI6=ZMYS[fH16TM,A^ON2gbY\C+JPaBL1Ue#?7WaB\7f>OZEdLZ@cJ5WW
W085S(IRX(,N4?MMR[A,:#^-59AX;:d,_be;G=+)V5_,8HfT;90F4[7DXF3OLO[&
2].)gS/G>aAYQ7>LReQ3YcLX4O2E/C_KL#:>]ZIJ5\),&bG61X=UE1:aQTfSc&JN
b_E6cfPNEMg+,6WY^.L)[.Ld?4:4_1O-/4@NYR&C(CS/,L@FS(;BY8AB<>@C^)F_
@ISK.A8EHFG71_PYM0YG1f()-XLX&0#5S,gZ?+Oa+YW(P(.6554FNSD.8Ef07O+2
R6J4_B(=gcZ0#\+)V0eF.-1[9C0:)D<bMN5+B&:+)+B\W=#EDEL0[6N)TUW0N_95
#;2D^L6cbPCfgSH7,H#-W:(_E[N(AC9Y9ZCJ9--X:+TbNFH>YQ<acV@^7P\9+WV?
=SLTQQN@^7bOUX(B8]]P#VNXd<T,.8>[EQ/4]9LS_8/]JB/^OZL:+6Ag]WJWKS89
9H\O2Mf:IAD^N32#3(P]b?K8L#1A/YX[PTVKPC=\>(/+S+TefSbI/Ie_09.^9JfK
S<+I2:2A?#/_WPL@X7dI]YILM;E72Bb]T:OG<Y-V2N=.V)gV:.\8VQPPQ#fJWVNZ
H<+5+<7cLUNc8TUZ]EL#5>M[R_]3WHOe04RDd+]b47Q<ATI4?UY[V2^P?K<f-U<Y
PAG^a:[>cR3KbMO2^A8_<RDPO)cgg660^8CKDAg\P]5-I39,O:H0V>@,7TS7gCJV
R8Fc1#]3-/bJ(=^P.1a2JQX;(6\_@PK2eJK15bT2?2.MBF6K5V8A,bYLSKN.T.ZF
bB(&6c0a]OIM&L(DFKGbWMcKE)#(:W,JEZWZDfVKWg(aZ-X4,fRd-\VR]/-NfIC[
5d5R1MR8WQ?]6E&TGa:L-bfMKLG)?P1T[11cVG@=-P.g\:5SFG/.f?OMG2QXDI60
\=a50NK1(Qb<=Le,=Q<b;3)/U0S1f+\])H1UG>LgEU1QD>YLbM,_#dLH5\<V-:/6
MUR#d4\4PDG;CYaH:BXa_H7K@ZQ4AH[QP9224GODe?W;CWM8L(V]?:0KR-=P?P37
1>48eTY-gT-Ne;:3+]F_\]fb+PDP43a]+<8g;?3Ff8T;W,-IN,K(ZXY\+ZAM,VE8
)=]=BeYU.VZ;-a\L#OOIEP2LZR_dXBIVPP2O0QZ[_d=Q?T^[5NF_@,ZR5)V@^-5?
;-@B(NT@?fg623EJL5Va.DVPA0GKXgb]aMB0=gW\PWP=/.U](3S]UD33D32KL=25
01>]PK^,/7FN;+@W8HNLaBg^IAIG4)XbW@1-B3+\EbC=N2NT0]8:b>:H8a-(/FM1
,VO.]N5)ET(/?Oee/):@#-R8g/ZJG7[+dZC4ag_I^;3<\BV@_g51VM&8Z]SF>(H;
C=H)MHWY<D\6J;<[?7,/e-?:d)#QGTWKS3d[DB:WSG?/[<8@OS(E)-:cVfdA+SD/
E42N:7HN9E-YKc,X-adOLC7APc0TFQZ1IG+AG54@&X9dYS.FH5?@9gD8Se^dg/[-
9\D:5ON.g;HbJY/eW_T]#\aP;EME9OSU9.Z\42/d/,UX=E;CTV(a=T[gX7]@Oe-?
[1KHD+b(E&Pc4b_b5bZW;2SB\==]#_=Q7(Y&ZE92@2K2U,:.NW,)\cd_1d#&?UH.
N68MVC]YO#[J54RUg=TKDB\IC0f1gJ]],T@MFdBc&&CdEc>>MD5&@1I5LN_KUQ=0
K1eD6[N^KJ_BGC@ZEAG=gSOLYZ_#Z;14M>5UG;J0T]<WK#=15MefTKW<X>-)g1X]
\]WO\8Q@+\]1]aA9(4>L0Cb]X,D87[M]d)-cc09MBZ9ee(DS3aIXGfW3Ac\=+fgc
<cBMKKCG3OXYU6g&)7L_B0)?d&_MSb&6&G8>a.J[9a4<Ed&eNHed/].YC3G6>6d@
OQaMV[,>a+BVPZLO(GdfQ\=Z\AGUWK#F</-7&Z2WK\7:8ST-_&OQQ.]g(F_;g-G_
:VVPf-JMAZe,S<g=/RE#)Af2,<GC0ZMF0V22e@4bL[OP?DI8LA=<,O=-e)2?AaF>
V>A[>R?aCaZf:H>J^\88,bPL/,e&G^+ebdU)d9e#I1=E#,_YA1V,A0C5S&Y(8g\=
.I8,WHLe(bcY7M>0O0TN_>O1eCfL#a_+)5BGM/85,9:_8=9DN0-]ST2Tbg333OXY
e3;(7V[^>WY,@#Pc,ZdLU36-UWZB43J&:10)U3W/RJX894L;;>5PQ,X>^YJ&(e9-
AfWE^6_c<-2CCQHeNI4FPC7QN27O=bVV=^V/N>Y6:P(.TF&gAc?SWSAgKPf-LP^&
P:SZRB\6R.QX:]A=?K\0Z,EU<:e/:+Q6[VYW^G([,(#R7:)>5T5X4EU/,3E(OgbW
K-EQISd>L9^F\H23Jc@;)>_Y]WQD]EM@A)U+X@&^D.[b<[Hd<5#3P#N:NTXQ+9C4
21>;N8Q2\/G4W&J[#G^@M]A>7IX6/-9NZ/GFT84GF7eaN#6@Q&eA8.G5]SWXVK6^
F=E9+OW[7UJM+7^@5\bQ;GOaCUL9<38]0236R;UY3&J7dC.&89V+.&J1D>Q^;:5W
X46HHEL]J8=(]V/-&Z/02/#-dNMV[URD-GY36(@,(D3D,cXECD\S))>RY1U##cM6
0K7V^=#R.UEOX:;ca;V\e1@\EaA=<;;03>fWJR9]8[3C]6<S+G>FS4576=_(#O-P
g_JbEf945.W5+8CK7X8AKR)O;L&FZ4[E8AJP#2/f&;E#.ED5+eX5#2W3O6[;:RN+
>VX(d+UB&_H+K.HA-M49K0I(-M\;b-WE)^/c&8Q68X/QSTAbQIE?fcJ6,aI@.bZE
RFES2.][=/#+fY3S4,>5)GgG\QJ^/-,.[JKCE_JZA17#M8CQN<ET,@6ZcX/MN\,>
NQQaXLO[\W,(+,OcGH7GUR7XGQX[9cD<#+&.@@YYTEbZg6:U&7R&18H?V.XAY[67
E]7F\e5V8UP5V6:7<0dB6g=>.+-\/N7IS;R368<ED/@6cI^c_0-a(SBW1cTE:0+Z
\L=8#.&A1[[1,Y:bL/6/?J)+&-([9KU-AN#T>4N]c;(<;>dG,aH,TX5EP._G),I@
.?G6bUaN8/H/f&fOXQ>[6AbFIP[W-Cg(7ZN3JcPM]GDC6/B^2190c].2d#gU<8>7
Z0?S9I86Q4gY#A1@)U_>GC[YfS)6Y<Q=K-F;dTdP6SVBQ3.K2a\.#_BYbYW/0H1,
SfEg5?RPTeVbHVC0GOO@9LM-)4.:ddB7IW(,,<DRFARYTI->V5HA^W.(0[EAe<.B
1cRO?.fKW\L9F9P5>GIP]E\VJ\OH>f4L)cO/6?C^Z@:YE$
`endprotected

    end
  endtask // get_packet

  //--------------------------------------------------------------------
  // Task : get_data
  //--------------------------------------------------------------------
  task get_data;
    input     received_packet;
    reg [12:0] received_packet;
    reg        parity;
    reg        rcv_parity;
    reg        temp_break_cond;
    integer    j; 
    integer    count;
    reg        dummy,error_detected;
    integer    temp_stop_bits;
    
    begin
`protected
J^dRWRU@&6/2:_X<;G&7Ib<?a.[+W:_fc[bY9c9IeWDS)SgN9D]1/)@VS;_WDJX,
_V5=.&&aBY3KBQ>>G>M<2;K].Zd8CW=ZMNC&JO>[#P&7bg=BWV_;-P+P?c49C(3b
EP6,e9c96^RC^>bLA^#T\:Tb0KT>R/b05)2,=7R?Bf(:aX7.:VGU\B=)P+-.,5I#
-0;f>f5AS^MBZ(1U&L>@T7NU8=Y#R@^?N]YT-.5e]I/9=6RWC=D=2;gLdW\:E^^Z
A8+g8gc=BH(ZMaO>&UHB]cD4ZX2a(:A>GbC;g+[G+D9_<A;[ARP,BQ72F0E&R@NX
F/4cQgR^=@4QN+FRO_Pc46_F/KR\7<Q<3K7].3g]/NfE3MS@H_D)CLKD1eW3,Y<D
D@Gd7Q3LA4>/1.=6OXGL@(?DJH[;8QXLJ#)+EL?<S^U(b4Yb@OTB@,e]ZW=4HM&]
2Z^I5^ICO6T^T58GVPCTJO.X9O_QRWZX7O435=9[a1P5:RHN:)ZU#Q;+c8+V7JXR
TWD)I;RC=#A4E#@2Q5c?6H<+ET&/gUFW=NA1?Q&:[?g.==babb8ME.@>]V)ecBTV
Y/>IYZ3E^13EEOB]QY&]1B_e[Ic\#b7)f9dRcAFLME7^-DCP21-)]fXQ&HYb>Ebd
:@c^)7EDOIF2NTIRWfY2Z_cPO;4A,OT(+)>G1WWGRRYT)&I+dY:].0LV3,OO5HDN
-dfJML9.DR<=J,c);_9K^L2P,06F=<OEE3=9<f1D)I\4.bR/,G^=_-P1,gGgYIWf
8gV(^^37T8L/P+6YI=Web@DEY2I93N4M#0MXJGc9GY-193AD_&83[&_\_a43bM<D
A/L_4:9+G<)G#S/F/5[GAGT<TV9FZSUOadMf=)T>gcJ,g:(QO,PNJ2703+06gLVR
,#V>g;11e[XP[_A9gJPPOJQJ2C0@(T0H1Ue.d0E4.N?FA=J7D^8^]-QWE6\3<55V
2)E#;Jg:3d:f5U:2F]B^9+R8g:CD-S7YV>HCKN;dKXDQO;M1G<W=P5Ac60f6fRA]
-eSCVX))Geg_3d&_aQcU\bNGAA9Z]ZU0dW1P9I8WQ[QB7?NS;5>A#cSBc\P)9O<=
#OcA+Mb[\BF^]5KXL@Za6>55ZHH)=HH[(PD).KgHF/ER/4:(/MP/AK5eeYRa70g5
^\G4W[AC?<geH=9US2OOM_Cg^C2W;VMP4>=_LfYc7W=1.B5ePLXKe:+H^.>VY(1/
U?6b=&:7be_[:dCD9Ac5O=bOPS5N_\4f>L.&a\YdC5;aXIL2?e.f5Q,^N>S@SK=C
DIda\Ggf1cJ8e<3DT-AGT[O,W(F:A?YH^LVW?I@T&77efI6)=@QD5gK?SR#&;X4\
-NfPM;1(?;.bOH.&W?.>@<C6fTLJ&f7U91G0Vd02N5Sg4]O\]dQ-CbAA+UOYLCPM
_I3>HU(@D[&54<Q;ACUD@-fA4?5J#ML#dKb=S@6QEE=\(?5/(+2G)M7)+:\dQN6U
4^U]LD#/=__fY]\3[cT46.:a[4g?ZMJ,M05I2GTF^SgIbcS/-ecRBOg21T[@WTNe
B22X\0IdWB3\^\URQLZLDZ;4-.YW:\W>Z9^-Ff.Vg+dO5)CHaRXfH+MMQdX/GV1_
FK[e5^5HY3S,KWF>=@@>gR_#Q321NICNEfY<3,CU]>=F]gO2Z2_C7_Z#UIV^UO)]
]:.>->edB5<&dOR6A/g5aLU-KV)F2#\3?0g/&Ec^D&,F[?[F^K2M15KALUb+?WVN
/O&GXGaJ7,eLaE>J2?&^JQZc:\1J:3)+.62f16W^:,K9+B>QF/a#a:VO7/N0c?Ca
cPe:?BV.SQO?O;fH[O3RQ[H;SOb+O;2AP17:,TF7a<<BAJV^)QM:_&;O4B13C\Tb
@NN9-<H(0?#)I9(I2K,71baeS[SK#,9/EFM?(CB?bO53g;ea>AIeE0O:f<3FHAWJ
[-OU-d^D[47^NQb=6a7\#@PC5VbeZe3N7@:gLd2<EU&;9aLY3.Y=dCZ.C7?Yg.K]
:-ZY>#JJ)-U9=NYD3;fOgUe)=0aKSZ9-.Y25H^)UOMLF#PV6-e1CC#fF)\e;^a_L
D1O846)E0I^#VfLG8<>QUS?d-1b2]8:g+5]3LTFJC4BTJ3QBgDD,/BO&BgDe9#U.
(HgNd<7g\g@Q3\?fW<aAICe4f3A-7]&ZI/GXK77P-7\37KdVMO;6.6V<X,UEE:b9
AYIUP/3bfSTL\:4+<ZO(d:8?]Dg(SEGLY[+[1V:)<;Sb88K_H4V/N(>[QL=E@:C#
G:2[QWQ3JHN-MD@U2LNUTYG+8AW)1@RYTTKT8G-&e?.JcR@dAG@a3E-.:ZRFM\;4
::dc6@e-R-2A02:(I^<&CX@dQf1\ac6=P]OCG>[<&Rg)ZG\&B(FXe)aXDPZ64U-C
V8YVC-ILW-)]B?+9D,OM:4D+PYJN&KJ15GQd[U334gcH+,4;6aJGg@B91VJFFUS/
+^IJE9&)<dRFG<\()e<6Q;XD\DI&2<c0dI;/[QOU/T&/MAbSa<<T9K55Ibc\K)eK
(CU3&A,@g]6E\eMD?NE:GA=Je=P]Z9D(@P_HQ:ggWGEM78c&2g\\51OAJ1318EU.
Q[490+4?XPWZ39Q=^2&]0d,95&8,O(E1L1a^PLXSEBc>W2+E)C_J66N7/77Y><0T
d)ERKeY7GW>P&?W]0U)bX.?GGQ.ZF^JNNU.\\a(_GP?..+AKaa9-+_5-6Wg(@Ee&
/-?0W5#bG8?Q-g3abcIIYUf:<6Ye<d[e2#;:84#e[aTFR.<17?E,-@.fMSYH:,6b
GBZIR:Y7WD+]9;A[RfB\@HMH>1Wg#0(_-5;2JV]9#J^9_D7KE^0-4_DTV#IC6:bA
SZZ^PUG8M[I(N@<>NaOfHfKQBg5FR:P<_IUe;Qe9KdHWFBD2G7D\e)NFR/H1+?,F
eJ:>J\[W)Of;5e31,d<b^5<L1OH0R=-2<9BTI2c8R60J]Q[[(e=&9TDVWH2bT]b.
/VB&GW]5-Uc9S9-?g12]HG^eGHP@a.0=-OATI+gQEJUF__cXN.I&XUTc_FeSGPZf
g9c?V<=KOLb042f<T+J+<S@21)-<-C8G[#LR-=gM^.Y/COeD8CGCZe@GU?][NX35
A+BN&(C@>TCBDO@MU\DVeQJXCO&3Le(cP<NG/+IDD::;?R?5)Pgf7Ud(64P_64B5
eOX\XUeEIJU7KDGa.#bd4TQ5PE4:;X2&KR@>28C?ZP++XW7.b(<I=D4^TH\^#IJd
fQg,HW>^bJ,T_BZTSTF]f_<H:F^;+7OJ>XUg/eC,;UZ)I(+1d41bJ&O(]_K0Z.Y+
P,Y0_+,F[IXGZN\>64(>1J:UEF4)<Ac@f3cOG&\2M[=62a-?0V0\=A9PK28)<7-8
;4EHTcPX1G(+eLNaWD<:KUg=U?M?8^F/NfD:1eGG;PT<_JdLUa_W&+)NEGB>V5b8
G2=c+=73[c1L_&U_?]UH./NFY#7Q_,I[?U:V>OIfd^>,UCG]6Q5X<>925@:aB@F8
dgcMe],+DP+D3OU+GD+5+7;+6.7c4MF#-e4\b;UZI7QF)-eE)]a^3YUVGX&8P=]S
6Z;T;B3WF,fIa^O/N;F[T;f\WRY@TG/f=BZ_Q02NRaHfGTWVT]>_I(8.G9NGaGU+
.@E5beHZO#^b:Y6/33,S:8PS[df?Q-=Re-Ng\NS:W^J<YYNc[b-;3X0]8R1L.OPE
0[@>1;+g<e+?B>]B#K)V_SJ(4629]RZR)U@#QUKX&UT[5HaLGYA@;HEJY,R&J2O\
V4H4Z205E#>PH2[Wd#4c2EIIZ[YTe;AKN0Kf:8&E>A=ZPGL<7:>\Q@+E?KV05a0S
T+-+g^QfHNb,c(QU?(dKI48ABbJ93g_6@C2X.>6<#We(93RO<:N&3XJ2aUV4D[5,
FIN.CYSZ&A@LHNYNK,>QNT1R/Q8KMMPg^=\P7dI/Y:LC=g&5Zd(0V^S-GHa;^P&e
42C696B,S8HM:7N]7f:fV7MKT??>[3SZ#=OGE^4<c4FW<LTPBQL:VSb[=b6PH1QT
OAaYY/fO#PKBRaSH]d>ACW8,PO>S-OGI1cR@MEB[?4)TI/cR3:AFNG4Md]J70(53
,1R^a:I_bZC3AW2_-^KSSg/,M.>(FcMM^7GREKaR^f-@U7:=U&VH)7_27R#1HEY^
BX3KE9ZWf1RYN3eM.[2Ua4@HQ:aTaU\cXQW7KFce0BJWIA@JGG_/I]:N:1XM(8E,
d9<IP[3@g/@^I68EOg:E:;c3_QF.c2MM:$
`endprotected

    end
  endtask // get_data

  // --------------------------------------------------------------------
  //  Always block to stop packet transmission from dte on sout. This block is
  //  for internal validation of updated software handshaking behaviour.
  // --------------------------------------------------------------------
  always @(negedge rst or event_bfm_on_patrn_rcvd)
  begin
    if(mode_band_operation === `UV_IN_BAND && pkt_cnt_to_send_xoff_pattern_bfm) begin
      while(1) begin
        @(event_start_pkt_send)
        count_rem++;
        if(!pkt_cnt_to_send_xoff_pattern_exception && count_rem==receiver_buffer_size) begin
          start_transmition = 1'b0;
          break;
        end else if(pkt_cnt_to_send_xoff_pattern_exception==1 && count_rem==receiver_buffer_size+1) begin
          start_transmition = 1'b0;
          break;
        end else if(pkt_cnt_to_send_xoff_pattern_exception==2 && count_rem==receiver_buffer_size-1) begin
          start_transmition = 1'b0;
          break;
        end
      end
    end
  end

  // --------------------------------------------------------------------
  //  initialize_bfm_gvar
  // --------------------------------------------------------------------
  task initialize_bfm_gvar;
    integer   i;
    begin
`protected
2LS[cQ=8edOOCR_^[3OaI03a=RgB.QfZ)@9Q50ZAK2_^C5Xe+7RW+)03_0;YG)Cc
cFMJg=&>C0]\N>,T71L1D]9Fa.,HZ2F#5H189ALdSXBU1MVFb7+J-I29>TIEgG,,
gK?-g9D[WCMBWI+Pg33</8O)WA=>>I4/fQ&,Z=4&)FTD]TXH-DC<UE=f=BL34OK(
S&0HI.IB&@<BC_WHaDB)MX7^:]_OIc\)5egLgc\<Yc9Oe-F;P0e#KN)\J23FG85a
Jg9Q9+aW9;?T=>caL0)R,QP68d/8Y/d+[P34dOg;NR[:_Y>3b=8Ug01Q/@:CK=4T
0P>?N(I-gb:Z3BVEDNIaS]P?NCd<IKG)+SM^FbK9#^eG1PV,74GDB]2CT3CVVKS4
4CJB?.<F0>_f4.\gc=f7<JU3=;]2.+@6OPbBUg+B&=YAZCed3JJgdX^:C3?)EZ08
2D+,+>13e[,J8HH04C3Ig)QCLV.?DT8ELVMZ&APF/7Y&-28ACf0</P=Vd6YWOcG>
?)X2a74FQS=\:?>1b4N?<LK,MELR;#,Jc<e4eONGFXdJe6G86QCNO:P_D3_Y\f.=
ILKWDG;U5]WcX_@NQ&cUGUJZE8bKSAW<EO9c(WXR7O4AP9.9R@_B1&7^W4J#E#d=
?_FTcc<#]dMHEc+W#HA0LU-8,_gF;@;L>Z,cV?1(AT(M/OL;;60WFfg5G[9M2PWKQ$
`endprotected

    end
  endtask // initialize_bfm_gvar

  // --------------------------------------------------------------------
  //  initialize_err_flag
  // --------------------------------------------------------------------
  task initialize_err_flag;
    integer i;
    begin: block_initialize_err_flag
`protected
Hb@:bLW=0O;11U4bR.=LU<<1CTgN[g8V_2?)2d?DP^fQSb+ATdWD-)>GWRC[G7W0
g73YcC#:KP32&dN/BJ0<P1O/GV<0MC1Q(@MV00Hd]2I\A3^eVSCG/4>SLPfLA63C
df40;)I((;V:PYe+d+e-OZCPB7Rc)R\CMMJPOKCF2W8)PUTc6e:BH@HBT.4K6\1d
)OZ&c+Gd<G?FQZIQN-V6AeB[4HTEFZ/EJJ&f?W#0H.?A^]bCSD1]AE[BTZ&OCaCD
_^^^9]d;E)>N3S5TW>.fb\U9[TcO3[[@#9OR@aMD3)a0OASGH]ADG#d/&<;C\GH#
,G4B</3>d#.8<ffD2)\E==U;bF?KP090BOQ\4<Z]BG>,g<J_>MfI72d/O$
`endprotected

    end
  endtask // initialize_err_flag

  // --------------------------------------------------------------------
  //  initialize_err_vector
  // --------------------------------------------------------------------
  task initialize_err_vector;
    integer i;
    begin: block_initialize_err_vector
`protected
aWK3YL2ec;bT.VH+Y1?<4R/_E#VGZ2G]TP18ID@fgKXT.WK]W6H@,)-_aV65B&#;
[_3;;-,TgY^9()MAc.P6VO:fET\17b4FUT=HKb&@[[(19>U=Y=QU^a]&S>5AEH?^
7,MYQaH^0a&.GPG8H2=cYZdUMgFCRdC8d_HU:Qe_Kc_3-7\;@B,8EHg+Z]T(WFc(
)d]Qc9N8==E)60U>;ZbGJ;8:I70e4&IN/b6AP+J&J:@21+,#b8FL@0=U&TRJ@1(0
:G;9^^Ca<+HefdAC/KZT/,A1@E^B6Z2-16PbI2YRV(&DS9Ja)N)d^fO6@Rc3CO@;
3]9#>]0ce1M9dDbEPUg1Y]AC\TEN3)&^fNDOR6g@]e2f<2N#3TAcceW#CcT\42)G
P9_?<bR,aEO9+$
`endprotected

    end
  endtask // initialize_err_vector

  //----------------------------------------------------------------------
  //FUNCTION : rand_in_range
  //
  //This  function generates  a random number  between the  given range
  //(min_val,  max_val) and return the random  number generated between
  // given range.
  //----------------------------------------------------------------------
  function [31:0] rand_in_range;
    input             min_val;
    input             max_val;
    integer           min_val;
    integer           max_val;
    integer           random;
    integer           num;
    begin
`protected
]CCPF#?^If8RHBg)&AKWaY4CIL3Z^b^_-YL.9fMe.:_HO,&L]@LZ()A0JFYRb4J]
E7_#D)BU-cO(O-C/a;-A0_9,O]c.+gZVAR,24;6VP-R8dP&]<2/d\(01b_\?5bHA
ca#V9S\6.(Z3874:G[IG\4<A9]#VY5@V7cW\E@DUFDX55\]<>a<7K,Dga.4E]Y54
;9C6@/DYf^FE[^FBRPO&NT=RE_5.8E502&b5KHd<];28Q(R11+,TN?OTM=6C/9OR
@/KAK&?M[:797M/33PWIL>Qb4Y12N#gS9$
`endprotected

    end 
  endfunction // rand_in_range


`protected
[4CK]OEL\gBB4=VgU:gDSf:6_L.47VKM(^)><G5_/=]H++MK36&U.)YC@J&C6e(T
&7a_;>+B2E1^XXMPaWFO0\Me[be]B5OK@d4HM49?@SB8e;;91Oe)b.5)aA>7=\f-
.>I2(HERd1VfF8BOYH71K3&@1([W[X5d:Jg[]>UW_SR8I;O<3UeJ094&95T3E&M5
d8G_F@;N@dUQ0XX-)3262B)I5,VPe1D6-[,??X=;7.8B4HO@R&MaC@=XNI@CDfDJ
:&SSf/cN_YI5.6FDe\:O5QU<W;11\;-8KYEQXH:f8W0ffD6H.C0J+D>7B&TJ4YZ7
0=Lc/d;L^=A,/T#>4>0FB6N2#QT[1AHWPWFI:S_G@c?N8W_HF##R:X/>Y_4+A3MN
g)G[5b15J#@TKUb5\E2-91OfUHJ.;>#-I)bCPI.9=-QRQC=18,0^0G3O49:POA#V
N5b^[/L(01U:CZcQT(7D5WT44PebDN>/?eAeCD@^PJcUaP/d?G29^86B]C#<OUOG
Da^.OI_MB\T74/_@Oge3/+Y@7d<aceLJ,&(HfOFbJ8J=0)]V,Q1-;AZ3fP#GSaE,
;5eW8b^BC42IS.6TGETE#1-.[[(/DC<+6c=Z<g_1-2LQ_,JYF7SPac^N\,1#)])#
8@?9JB9)Iddd-5d0>YTH0(1bO[D8=]BUM1M53JD7G)Tg2L7[.#:I3dVd<b#A+:P7
^^B21JOAPKT)1/O4;&\g6Vd(?>JKU>\+2#?<?,a6;>I17J#;&Hd<K;\8#F\\a+@K
E2N/^Z^DGc<NaWY19I2FLAY1-5<-HAE=76P-RA@N>Ob;IX-+T8S^e<;E\3e4J+f:
3D3)eT^(V\Jc[&X[G&>f;9^3aC76ZeGdM74:TFa3LfF-I_GK[Ff3-P[Bg_E2R^<Y
[dE(J+Q9&6QZS/9BdUgGZbSPaJ(2D57PI^2?KD6=X/0K^+953\K@QcTK=252)CZD
H/.R>&g>Gc7K?Q-ae^Z-PKg5bG8\J<3aEY_1MgLYc6J;:eW3#M@F>M+P=/def7KH
QZ4fb\2HHaI[?2_TMCEF[(dE@OV,;YMT:eHX-L5@75#fWFM_DG6fE>)ZZ0A_,XSf
B2HIN>?MKc?5Kg8Bg=S3eGeXD2gda)PBd@]3BDBE#C]<QDT)]@7af.V#Q^(Gg(D]
:6(IR]P/(FNJgTR)J[D.I5@&>\RBYLV,+]C@dA#_0&G=G3J.9cQPGEdYE):/WX1&
@-SAI0\9?&;-CG9g7B=XQBB)bB=P7d\=dCU>P>:M[<^/U-.:,O?be8aS5&T.[5VW
@>cMR\?(^F5c;SNR/0e=4Qd>_VA2D?1=f64RXQ&PF5-\c8M/U<b\PR;S6>Z-DI9=
gL[1d+:7S;eQT(dG34B(LB>aM>d,8@U=YF>S2K?#MFLJGN.DS[YP8H2We8[<TQ[?
)99D9]UHE&V/\VH[/R-LcTZ=+[9eWafAaNF9egVHD75d\?=T<-D3Cg^-/&Y?R4,4
L@AYNS_cD/GL(Y4c7cF@?NFZf39?02+NZNO)0ZV1)#/C;[O8(e64=6AD+9H_c)=<
VJO<:Z0e5BL<DQGZB.P;^#A^e4^Xe\==)Cc6c;//JT:+aC3O8+C3IS=<+b8EY+J5
OAV?\@RV[4Z(+ZQV1BFPXT2WcD.Wa>MbS_?8+QZLN=&]LUE(@N2?E3S?PBIaD@_=
bV>0SC]9:1M40:O(;V?O&6:+1Xe7UWNc0N:_HH-dZL3N9+eHK?R(_P7=<@IB]##b
#9+GME#Od^PK/Ad;cPc\;S+d7eQ,7]?.d(XKcI=EcVJC/Q1f4Tg_?)(b@3X9RaNe
b?S76_c_(&UJL^+HW/fb3,Nc?BFA2d^OaH@1f:B<T,Q@0+QK(N50IT8->/a\dGC1
T\c(GJ)D1UAT8cL,_A<8RWgdB498(;/cMTRJ:g5M\[a(IfOYB.5[dJD/.)2[Qd7\
+OQPdZ^))9c6F;?,0)</NfK,2f/1D>)=/>fZ.eBJ&ReLBXGI?L=9V+/JKPQC=Yc^
F.CAX4&Jc6K@GWVeDP1,4-U:PXA@]P(5IGIbE&TGU\g\R(B&H)EdLYMS^LLJ@WW]
B9\DFZRK?D_)OP+@)K;Q2d(M7:^;V0Z8NVB^I3V7.dVJ1/fQ?VPLKHOb_^R>F9:b
6f1.C8VH=:>KTHP0JTXR+@HGN5Ug^NM>cUL/2TJ#Vce&\2(K?gFO5^O+T2[V2IXL
&f>=BZagMeIKG2GJ>@_?@[6TWMaa2M91L(1W_1XSeY^cN6V8dgN1:-:6e:K.3];T
,JA9&7I:;>03M4;)L05b)H:#a:&MR;6-\U^G29=9TYaF-JJRR[\+^E-5Idd/@YSM
-:eAbT+_4?+MSd)gV^F.X;-=0WA#W0\:CX3#^_d&MPd_OI^I(;,eJZ)D_R/0(V&)
GKR3H@7DX45L58L2S(\3DTf]\MT0)7MEF#I.]4LFLO:FXd/Sa)1Z1\)LZNJ]NG2;
13YFBc>NI+).XYYUKX#WO/<XK48EW4,FOKHU.F2:b[9;XS]E[WDJ<9TEW9&YLAGO
?@>d8EB[>KT3^?R>BEBUXP+.OY]QS=7@0=0,U^@<JFX11]PIcCC/02fJ;UOGL@OQ
8GVKOQ5Hb;\a/;O)[3L^fX\_XTa.<JT\3dTf7Ya_@7U@Z_OJEOc8RB4)f9=M<:cG
]AX5XE],7T?f18EbJAB7:I5BSIOc<AI3J8,CQ/(5L;Z4KP>9OR_R._VWd?A^@831
a<e7c(ffO?]&)HG+/JFELF8S<;OKCN=<c[OQ_LK@g;M<WY&:K>;)H>a51:Qf@CBI
4FN[3g>WJ;B]TQK_b>B=K(G:Z)9Qf\GP3PPCN]+?S(S(KRV=-Y.,TV=\J5VGN)1D
6A=2.S@fX;2e,;25UWV:@J5@D1NIdDS.Te^5c:[SM@6S?LXIWYZM8CX-@@UVU,@[
5Z^J-bCdP,dC@_.bW#>(?g=94@]gHaU-Ofc@OfVS_706]a/MBW=.APK2E-TZ?@)a
PfCFU[cYG4SZ5Y7D]1bJJ^7:Y?1L3[U/aQ>HGY47>>+_6@YE8T.LE9W#fA-6+5GX
1;a46DA&P]AYGWf6L?YI0#P#ACf_?^U_^Xb?YcE>1UHRR,:[e.gX_d2X1N\]^;@a
99F68Q:\@7eGZ^R+dE8gLI]P@5b>@L>EW+=IOJ8STa[:A,-MWD(SL7(B1C\6E1E3
ac,G\12RfW,&+L\,ASPfc<YQ&ZW:@N35R-K.),FKR]/b=e4\3(YQ]QfPI3gJ_CT:
5RDa.Ld)UKA98;R=:@<[Q29_gTGC/T\LWK^Vg_AgYUSY-C>5-\Ra:<_>PaW3D&]\
:^RO95.b5&A(7&+),VH7OJ+I[+JU)EWg8Q(,2[VJ-caQCAeFY7=3S_MTda5^](O(
K.DJ#3g7-G)SJfa/)M/QJYTWb=If)-SN@?<YR;>e&SI+T/B063V)b4+bCJ_&IJNH
=\JW0Pc4IM)BHf(X?EW+<]@LR;V[K4&YJHYIJ39[5^4?D1+>6SDK]cP7?TK,EO2C
@;G06RX=YRQLQ44gMT3aHLW?>O6CgSF1Y:9fc2\/eY/Tfe7P5Vfb[I<X4PY,aB4G
1DX&(O@AA<G:b-AJT15APL?Kg7/)Me@&X;]V+C<@A0(7c[WC^A4CV,,9IUJ5GCC4
\-bNLW:;4B]>:^8-I4Z[:57A[DKTa0=4FbR_JUOGaLM7D$
`endprotected

  
  //--------------------------------------------------------------
  // Task : wait_for_dtr_n_dsr
  //        This task waits for DTR and DSR. Task exits when both are
  //        detected active.
  //--------------------------------------------------------------
  task wait_for_dtr_n_dsr;
    reg [1:0] check;
    integer   print_count;
    reg [23:0] type_strg;
    
    begin
`protected
a47HGd29)cZ=f:NI,2c=6/7Ig&AdgWeT53GWJLEVY8F+8[-C@L#0&)6;23?51HEE
NFC&Y7?\WUYG?E:97V#66f&:G(Ibb#;G_TaALUgRT)T]HPMOFfPG6P];DdU&H=0/
3XIf;#=?YOgKIc[0T,05/aC8]FE>@G/D@6=QAH\^?/#<_]L97F]c=-ARBQYU(3\S
J6FNa]IB@;cL1#f93cg@.[C32^IbVbfX9,<U5HX-_Ia_:401WMWHf5WI<bAEJNDF
]=JQ:K5b<9@+;1e1bb_>.:SX^LVLH6+18DN\BJUHf&@/ZAd&0&7SP0;.V)URZ(KB
bbLg6\dI&E[Zc5#A/Q_@b8?0e:?68YC#9DN>fXdTA3YBN@(/bFTK>N:cgfJ7I=(Z
SP4.bN3USPTEL.c:OB#N.X>2>;=3.,NHZRc1<Cgdc.+Y=f111U]21YA(/R0-RG\a
a60eg/\+87)b@df?f5HHe<#LNS6.LZW:b<#B<[CR4E;f=0\Z:UJ]^T(f#)+3N,@(
L)4#B,P.,QHN_E^d6UC<ZHW42F=RVJ9]f)+0)3[g3UMT0/8OO5SFJK4fAT[,::3g
_aR74Pf<;07>d&/;f,)?\J>#S;2SIUXg<)=ZJ@F^c=#I7B@dH5?6ZJKNVNU/G5ed
DFI(2RO=c1=d+A:,47]fg?>Z:5_DD0^QbVB5EL@2XV(>&(4T,#<X>Q#G6&>]F)MI
FF(2_g.=:+=HaIN,#eIU,#[?)bU#?TSF([W-H8ee(eR1<NP&e22W/S^.LY)E(6YB
^g,e59g9-bfdU?c@Q@XL+5,GgLe[]YYH62#&U9:DU<(0NO(OF#O#XD2BIJ8]8?AH
F_H@1IN.^3>\b3A]C7SI4>Dg1[+SK+HK@X<&bgI64K=MYg&/38H#<0E6085IY3Y=
N,QD#:)Y8(+fE817e+Q93JM9L#CEN/DCD+.^e.I_Y?R88bVRBGN28-_+.[H[_dY)
-gD5-+&LAO.N4f#.dE)](U_826)-A0Gb>MP?d5WgGTH.BZC4Q=0:_EBP(c[UUWB5
Jab>IF\(eADXTE-CdSe_OLB@J.A@M9cN8(:dLV8f3Pb.&eM_[ZOH:??YCYd^3^IQ
c.I<[+;2CZ3>/1FDF.,e/&FeMHY&9#6D;X0>&8KeS7IW8cQgH[gDGUJ?U[L2d2P9
6YGF6CAc2c[LP8a]<FUP,+)_HbaMfd/Mba0@cG=(<bbOG_BXJI?2=2LZ0[O0&fd-
8]XT:0cg[&W8cQHg&TP4\1)_2$
`endprotected

    end
  endtask // wait_for_dtr_n_dsr

`protected
9KN5U/P4&N_:.?dVE-3=3@4;HeJ7BR2D@e=\I2\9ANN3,I+cgSeQ/)V9R5ZEfI2P
O<2gd^7W41/)fAP)#XcMJC]D\9:AeTIUJK]b@GJ4DPW-6A?0,<HO9YdfJ</6DKBB
ZbVV<5=W.\-V7QE13a[]C2.ZBZQ4@^89c42/7S?_)0L6/I5#W,Qc1b5=FX2M7Y.D
e17P0.<UCc/5Wbg)&_B0>_TM7O8Z+U<XH>M;)2?\:69AG<M#]<#/bP,=5f7U.7HR
3CJM#CC:JTHT&;COE&cO4;,N,WT8OO-<93a1SEBR7.WUS8F@3HddE>K<MZ2K;++=
f3-NFegDXBN.U3ZK_X:\,GAb&GdY3&Y378[1JQ]BYLXO[WY3c#87RA,WTS[Y.?XM
)&X,Lc#)];GW-&8K]Qf1?eO=XH=T2AVKITVR/;&3V;<Jd@/)[2MED?UZced?\N5Q
M(;MOfD<[_G_\=-43f3c^HOVU9(SNHdJM55RYQ4OD77B)S13@KR&0+aUdC;V)_>X
#A+VG+dfVfF<:<0S.^,QKccR)f4:=S[QHd6g#7?K;IXC;7Y5P/?@/0dBgSA)PHa8
,XFS,2FV4T1g,^Q.@FG(gfXGG[XU5S^/eWgdZ>bSR1-85>SOORB5TD_;J,(O29[S
^M1I3[;)EHM(=\c90g,36Mb4feg8SC8L+(g1F:f7MUfOLbC:J1-e&UHd,Te>9&@8
LQS=eJ[^dd^EbIK9EdK>8aW1A_WT&8U4/PVILeNM9@cE-K9GOEE;(<Y^6M+IM?IQ
(,I9CS3bBfR4/MA):_?,VSY78b)IAG5EX+-M@\(;C-.c\Q/@6>,(d_4IbZ<A[[K@
:3=b_;ECHMR6VeE8X9b67OYP7UDC-aSE1F@A_4I2KO8M@]5F[-LQ=\G8R;WFgCYB
19L.A[V:7db1aLD_G)=AOHWH7Xg9>=.Z[OLHc+g((_?G:IV7e3XRb2;4b>).54\:
/2e4?/^O)QGbOX]]c4e2aLPbEdZUeS(ZMP2=IY=&C)ZI&#]\:;A(H76T7=VNTL\B
DaUCfJ<AbLAS_]/>g3;X=Wb-1U4\ITB=+OGG\K)@F9N#/IP4007]S,aCERL-/)<A
#J2A_2T/9-A/RC42c@9W><RO>KgL=?a7faMKS^7G3H?APb??6-5N85__YE)3(@W7
SS=@g,gV\,C2QHMbN/7dFFY4YEOF6(Q=,VV9WB:C9K<F^cIg,cU6@[-&UL(bTVb7
T:ONMdI)a+-Ce#;\+0E8T@<3<DZEee&(I;D;2K9H3]^_3F(d1d&McG:J+9]ZZTRg
QR/4I(A9Ic;&(DA>^[FC_#Q#>4P6ZS&D7UI8A(Rd,B70\(>MMf2]6?OTV//+Sb,c
^]Y)5#28dY9d6g0c79#4YK@-=LOTELA>Xd1[Ce#O#a/0<(19@OC#O?aMPP9VX9RG
;E]L62Rc>/./>F2\N,?>:U;E<ScfAfA<PggY,-Q@QRW8MRRMf5b;NY3#]N#&E6EP
c\4;U+g#eJ[6Od.JQ\<eO=J;.ZeH3LG)<Fa-]Ud7>BB)F0J\7&M<?QN]OR\bV-#(
<H(/W<_dD:E6GR=?CQ_RMIQ=3NdOL-KWcE?S_;SCH+gI(IHPCL7.+eB1aS)49:Re
2@@3SU=]5=FPG0AA4CNbA5;\;#7GTBK(V+^0e==\SH\GK8HL982DLA&D5H[eI-3W
_@YC4IB]_^[5,^,>^64VL5;KLZ4L6[V\gJb.([N(\Mc;]Qc:Q-\4][21U)aOg@<O
\.5IFeVY7NZYLKa9=X<Hd<[XX0<5W5gO>OaC#UKFVZ_A3KU<.[6[XS2__4OUbD?=
EO.XO&dd85\&W7I,b.2g.:Ad>2U9?PH#N0O.92MG,a&4H7[#L?2Ma9VBLe]<B]dK
6Rg/]]^)NO#NgN>c=+0NcOAAT3g8M\K-SNUB&+C7KEVS/MR.4Se?7&PN#^1[Q2J:
A5UbT(\](=F^IFL1PH#B,c+DLFGY<2@c[0GD6S/(Y)<QUc)?5bD91YOJPN&SC^>;
M9a/b,R4AR9S;&TP_Za=&P)-eE/JUUb7gUgII#PE5DQNU\:00+CU-+NUTW428eJ1
.)0Sa<WPQC)5eBY9P8b3FY2a8KY=@=eCQ2RfF1^a5VSB4L1R>AdL]ISRIH_-Z2Y+
Y\-.4]MI3E0d1EU+]L_IXfQaRFX(b2X)2G?d3T^DZ:f#U7ODS])G?SF,.c4Ye;b]
4@1c372LD,T#Z7(2VLcVJd.<_e,]Y;#NV<XNU1+@gKdB/KJU,1C=E()=/=Y9a7CE
2@4YEd9?-PA?B/Y@Y/ZIT60,DF3.gLX@)/92Hb]:V1)5?-KR/07C&ZS3.P:CGf2C
OC2MbLJ6]-AUPU#^;fM[;L_MIcgB&Ta>OA,Abd5?CY1/<7,4H72eSTN;<.+#SJH.
19840S.KMgQ2f5);:O+GASXVRMJ_[6E>OCJ?RJ(A;,QFS7J7[T]2O?DFR<-aASYS
>=)P_V)bg,3QL9QY<Za3:LCaBc=LL/PC0WLJfa.<+H5;8(a9R7].?Q10NCAV)ZLE
C=3S3<[fE(\-Ea@>EN2TO_dfFN@>d>[UM/N.TX=ULaB-VP66a(PafH>\_0\eZJ)/
0gg4],a&_KSUB<UZ3aYgeQ4S&_K@.7d][9FbI@=VY9_CI_Q_R:-R(\:6].fU1dRe
S@e9X2VDI[S4<C1/f=OGECRTF0\AAaVK(EaBV7\ONZ4b[3SU>JR8;LC.ZfOT],cD
2OT?SE;-Q#;Y@,C8DJ9M.]Rg7EL>Z1(+L;2D=6]OBY4ZPKDM+=P0XPO3A9I]/<\2
dEV/=aX?A4<gUO(e&DGbZgb=C.dG&B_[L9WS_cC8g,W@]Vg<_A.82&GdUT,A:UY;
e4T-/VD+D^)P+6].)bKN^5)FRf]0K35W_c#W3GUDGEd^A2JQY?YLX^&V/f+Q.K08
Q2;#7/P2-Y:5&^4VOTE9C?6=<cfd9JTP0R+9,Z?,I;5e<GUX8ZQb^+A;K&ERM#-+
,][<a4D+-#:5,$
`endprotected

endmodule // end nvs_uv_bfm




