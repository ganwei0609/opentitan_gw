`ifdef SVT_UART_VERILOG_TECHNOLOGY
`ifdef INCA
`else
(*RTIME_UDF_LIST_VmtModelManager=`SVT_SOURCE_QUOTE_DESIGNWARE_HOME(vip/common/latest/C/lib/${VERA_PLATFORM}/VipCommonNtb.dl)*)
`endif
`endif

//---------------------------------------------------------------------
// Include Files
//---------------------------------------------------------------------
`ifdef UV_PROTECT
`include `NVS_UV_MON_DEFINE_HP 
`include `NVS_UV_LIC_DEFINE_HP 
`include `NVS_UV_LIB_GEN_HP 
`include `NVS_UV_LIB_MON_HP 
`include `NVS_UV_COMMON_DEFINE_HP 
`include `NVS_UV_DEFINE_HP 
`else
`endif // `ifdef UV_PROTECT

`ifdef UV_VERI_ON_MODEL
 `timescale 1ns/1ps
`endif

//--------------------------------------------------------------------
// nvs_uv_monitor
//--------------------------------------------------------------------
//Declare Module
module `NVS_UV_MONITOR (
		       rst,
		       clk,
		       sin,
		       cts,
		       dsr,
		       dtr,
		       rts,
		       sout,
		       baudout
		       ); // end module nvs_uv_checker

  // --------------------------------------------------------------------
  // Reset input pin
  // --------------------------------------------------------------------
  input rst;

  // --------------------------------------------------------------------
  // Clock input pin
  // --------------------------------------------------------------------
  input clk;

  // --------------------------------------------------------------------
  // Serial input pin
  // --------------------------------------------------------------------
  input sin;

  // --------------------------------------------------------------------
  // Clear   to send
  // --------------------------------------------------------------------
  input cts;

  // --------------------------------------------------------------------
  // Data set ready
  // --------------------------------------------------------------------
  input dsr;

  // --------------------------------------------------------------------
  // Data terminal ready
  // --------------------------------------------------------------------
  input dtr;

  // --------------------------------------------------------------------
  // Request to send
  // --------------------------------------------------------------------
  input rts;

  // --------------------------------------------------------------------
  // Serial output pin
  // --------------------------------------------------------------------
  input sout;

   //--------------------------------------------------------------------
   //Baudout pin from BFM
   //--------------------------------------------------------------------
   input baudout;
   
   wire in_rts;
   wire in_cts;
   wire in_dtr;
   wire in_dsr;
   reg 	disable_mon_rts_cts_handshake;
   reg 	disable_mon_dtr_dsr_handshake;
   event   event_wait_lic_checkout;
   event   event_lic_checkedout;
   
   assign in_rts = disable_mon_rts_cts_handshake === 1'b0 ? 1'b0 : rts ;
   assign in_dtr = disable_mon_dtr_dsr_handshake === 1'b0 ? 1'b0 : dtr ;
   assign in_cts = disable_mon_rts_cts_handshake === 1'b0 ? 1'b0 : cts ;
   assign in_dsr = disable_mon_dtr_dsr_handshake === 1'b0 ? 1'b0 : dsr ;

`ifdef UV_PROTECT
  `include `NVS_UV_LIB_GEN_VIHP 
  `include `NVS_UV_LIB_MON_VIHP
  `ifndef SVT_UART
    `include `NVS_UV_MON_LIC_VIHP
  `endif
  `include `NVS_UV_COMMON_PARAM_VIHP 
`else
  `include `NVS_UV_MON_DEFINE_H 
  `include `NVS_UV_LIC_DEFINE_H 
  `include `NVS_UV_LIB_GEN_H 
  `include `NVS_UV_LIB_MON_H 
  `include `NVS_UV_COMMON_DEFINE_H 
  `include `NVS_UV_DEFINE_H 
  `include `NVS_UV_LIB_GEN_VIH 
  `include `NVS_UV_LIB_MON_VIH
  `ifndef SVT_UART
    `include `NVS_UV_MON_LIC_VIH
  `endif
  `include `NVS_UV_COMMON_PARAM_VIH 
`endif
 
`include `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_mon_license)
`protected
(IMS#ZS^0^NFJVRWHca4WL&f@8a/FO0La>ENBaC?FW7]OV8([8.d2)H2M3D&,>g,
Q)Z#6C=+H+;)dC7XQTDg8CX18F-4VN]4e4UWUf;WK9X).R5f87^W_]Ia5K=W_F+a
#^NY+I9#3,b+f,YI)Z2Z:V7CKRCD\Q/QI[BWF@T72WLHGb(g6;1;U3^9??/T4+^O
c_91<)B;BKgA\4&@P[EJ_efQUdNEg5V]<H)Ie<30W0=.];QBe/REF<3Zf3Q(65+g
R?1VLIaJ6OEDRNB?3:F+G).E72@acKL&H8</=0[^+[e@LOVBR+4We+#_[9>NI]fD
g1U0)GK.NYfV;WB(/YN<+]MR@?>4K<V(3Y6?DI;N0d\_E]CILR0A.W.BI+SKY0?7
bLQ=88FM^VgO]?E<^NDbL1b(f@UJW>[G0-b[>GTPE+Sg=SG,<6^4G<A2-Y2>L?=e
?ID))(I0d9<:GBJKV]B2]4/#+(fT;?Q?#<bJeg81;;(O,(BgQgF=\cQ\4KTVIEU7
YN&>SbRMOWO3W:P;V0.I=B-=a?0&-CACP#^JE:O@:aYU<LPEKc^8<Z#Y&GG.RPTX
eAB[8-A56M9E?aF,>G:@^+.>RB-[XR^d[\7C^bf#9-T1+#Qf@X?aVd9N/E&P;_EY
;X(Z5XL#Y(/_RSX(U^NU=(,c;gY9[cA<B5[,\a3I:9DaE^<<fdE(/NZ<P&QS9<L0
UR@(N#4.V/g5DN-DB[NULQ[A2+(<^[Y_0a0FB.CMRYCHB3MHWaX-=7?3]aN9\315
LW/YP^M32Ig6,OHf2gTeZGY9XX1WE548K._<fH4VcNC4Y^&AI3<YZ^:I5A#2C05X
2=H(:49OG\bWIZCGF7W-BS&R^3OUP655e4g4-_>;IL(B3=2a16DJeS0@\f,UJ#gI
K?Geb);A0\#)_KWIPE@)>,8N_UMJTK=OV#aCZ8:)+-6+<U294b(.P-6M(2/0,-?E
R3O@3U[63@ATeU-.SF&RZfd8?PQT8(59^.LA5KDaa>/K#-eRQf31eGX6OAQg3f-D
C:\EL[TO)ZRVSIDC69d=MXf^Dd6[g,;9JYYS^/cJg.ZU?8F/^GeCaFZ7dH8gDV;H
GGC(R4#4/OU\K(93[bR37F6f]\KOgG]e@g,Hf,4K2dCE_Qa8C-a8VR+_/gAS[f^S
Y?)JaVUQ=1MW6Qe]?S&M#2S?=[QRLN@e](ePK:WJ&3&143KeM;J#ee7#R/ED]T(E
UG&OA<NQ)KN9(8ZW,>#:ad&P(OLL3N#YTA4?TXaPSWRB:XLQ[M](DTTf:2G##;#;
gAT&K0E;UPH-fEY\X1SD=PC=.>:X>YbCOWC.a0c6><^2-94Ec1eVFK]T+K&9:.&b
5&O3]C]=593/6.3QSP#@Q2RaHb7,?F#WZgB7J08dcfM]P:GaXbVQeZc]5W\?&W5\
Z=6QV2ac9#/K=D-P9]WAK=MP5EfbM38FX/IgO2MH#6_-eOLbN/VYYGQNY=b_5]4B
7a#@c995?L[g&:#H&Y9Y^]1V-PYOQNL4?_Q&G9N7XCELBB,ZIC:MK/A+K.<Ag:R=
ZD&L(>-fQF-7TOM;>X#+_K@1/G<Of2VA^,dE\@S<F^3NGMfB-/-E1LS-)KKQYLTd
(T0A.IK6:&BFB?,2BKb8FcM&?(IG5B><?I:?GULfX_G;8[SLQ,F36^YQVa>_QN_4
_YK=@e-O4#[Y>6CO]JUP8f3<+b>F0[.J.D>M,4AZ5/4aWTgQbcEY=Oa.ROfHT,dD
Ra]3e,T2609@3X>7END)>F2)TOU,_UASUDG.a4O<Sc]A\Cf7Pc-H3T-+)4;566-^
YI;)Q?@ON0V&P0&4JI-;M_VX[f7]SUY:/6B(^_S6][<b7K51^LcJRM9VVU5&2,(#
GFOBc3F#C\Q#aNK9Xaf@-d1IJgHADLa+Nb-Z)H&e.HFDN1^/HRY5V_>e:6dB?,_9
L:.BRUA2eR&;ON33/#;JAQ?#Q;H15,,\#;#]((-V-gP@]I53A7f9)=?Q<QZ-YSM0
+YXW]O&DYOT+g/?b+/RW>7:22HYS92IcLG;\G+Z7Xb9VBXEf0NBL_6.@2MaIbPIO
8,EP1dG^1XBW(?1R1@))Od^TG:=L#?>^1P]O9#I&QX0APa>\FE-eOdN38,G<P_dQ
gU#-Y;&7O,+5f15P1VZE.@=5SKNYKABAa9c=Q9[a8a/=T&d>@+OBAZG#[g;R>;=]
6,@BK&:T?6#7F)\86f(eH8VPX).1C>G@gF2AI)OAPcN:,PA=gAZWQ<H^U52GCL4&
UE\#dUNI1b]\^cR/14?^.VL4FA9<\GY\B\L9/[4Xg+^:+U-,?fPTSJ>#V+<4_Qg:
/DgeS583_+Sd\0@8:RVGTLc4&E[\+3\9SKK_N7g<62&fN=+3b)>bU-],->KXN,K3
?3bAD)]I@^CMU\>1M-g.@2YfE?U:F+CK?;^:L9R+QL_-&G4VX&TF8e0LXCB]0QTe
Jd(8Wf#a40Qg>8<+#_bVZ7:Yd,ef.dcT??.ZKS7^3C\B^;faf2a5B+9J,W]Qfc6U
d/UeK(YM[>@Q+U&@ZbZKgUJW7Vad??G?aJ,62?9Bb4PR8:C12G;-gXZCc3#DH\FI
[RS=D3IZBC3f^E]T>=AT6cGNXONDQa^6PcQ^8[gb/Kbg[(,bQHK4RL/TOCYa.==:
CYQF49C#7@X:>Yf,UB[>:KCJ)1c\?,Pa2U3_+F?1Le0KX>QIH<N5b@HO2,+8,,BJ
W0L#9;><aUW<^eY:ES?@\<K..RX7ENUG,6XWIaH.dW@bW0M1&f\DYSP>@dJPYb]O
b>A@??PJ[P^Yd;L-@[&U[N[POUPPc2HZ>[9^:/J;.X-c]B+AOE:H(ATWf<(Ee5S+
;Afg;\S^:PAEADP]6KP\Z,BIUge:P1(]N4UH^8]_P7GVT,PFK9gC(P6N3)J3]A-O
.-HB>e:[O_RH)OdAg7(aG;-118Scd.1S=Z+^R,eE)H26gW,CIY;dXTd8V6SSg,=T
67eb#Q#(A[==JX4N;13c+0e.</#BYb>436LHa1?YKfJQ?)Q#;:-@:e#_JfV@CZ93
/Q5L&9-S20K7JQ(R5(b7V4/A5H3&-)c2E_/BFL46@b6KDEI3-LI=7T->,C\)<cPM
KA/=c>CBeED5_S32VNS4V#P/c#]-:4ML>VK-1[5Bb/(0RDD<;4BZ&]28GI2HB[Mb
4E)(56@e:UJGTf5>_TYC2_aWb78N;KE4JX]fB,^EK>&QB:<Nb2>J4g7EKCJH2<9K
0\GcDJWE>:adNOX)).a)AbZ4Y)J/VRGQe+&Pd?XBUc<-^.&IGH]/M9Qg3cIM?C2c
T)?L#RBf2&IB;R4/AH<W0FT\XUY@_61=H+P^49/R2F5>ZJ.0P(7U&Za4;124ULba
Sab8fQ#_V]C:2[^&c9G#d5c^#H?/Y0NEQdPF/@O9SX,]Xa<E:NN;fL7-F[&5=.,5
Z3_\AFG]>SD[4P#,9NR(@J27GPVXXYF5fJ,4^M./N8a\aR,gCPf>_]S2AH(@@8<f
#E\P6f?6OE#_LA>=-2OgZ-8(UG[SRPM=R)a#,8QS4CUPZYWE?daNE+&816YHQH5f
SRCNg.TC=gROJP2:]&b2a(?XBE#:(0P_A>GV?d)I+3^[-(4.:/C,UB:-,gQB)#S=
d5Q6#SMI>a@=R:2+.0]27DSc0->7KLFe0L=7]IMC+d+b#.b;&f/Fe<;.>f./_N;T
3?912UY_N@Q-Q)Q7J&G)?d=R(XUH0H1N878VPU?3@KKN_@Y2AID:Ea8cX01@f>92
>3(eKAe=T(4D?Z)AFX;<Z#,VW3[Tc>KXe\TB+1b0>(P;,7.45ZI>T=NH\fD/#O>N
6FXefTbN=4V:W-CYIfLZS\bS/BLQ75Z_M\/]WCCA0/8+&\-B?A50-^/N]]OKTL?0
^5:&CXZAO?<?J>B)ELM#dB0F5d8IRfXLLaQLXLU&42J=HNXbfb+J_)HSWAWSX-,Q
g-J8=^77T)ZG@J-^f.27f)<,JYWI5g:Z78:&6ag(.XeSb6V7>T#4=JeVGT3?8HHI
RT7PEI[;NIg.1MXW1^JFLG7Y84Q8KR8[_/_5J5eM=R-S6B0IK[EF1SBZeXS2-c-Q
&A1-AREH^ZG@B]G?I#BF=Td;0G5DfYJ;;-fOC>5fO(/ZF0^GS=<d_.)\M2IW#?QE
/>c@MPCXggcU;3;F]AE.(1b5(Ya,0PZ63Pe>^3\X?QDf82RUcf(:?f:49dNUHK:[
LFfWeIE4+(WFD3+WKN&LdW-8XgG/?@O642(218faK]L1QRF3:TZ8CY8A&<C#CDZO
I\dQPZD>Kb9^AP:aR_c-;F?#KFG>QZ,>JB(E\5Z,9P+UB@ZCaPDP:b6fNU.8b)=#
R5ZN#DecR<(RM>C><]-JD0eS6IX=&d;TPaTd/@\2fEE\DKgQEd)_3-2&/A_B_TcE
)2W<>U\<E<2Md?ZdE53/SP+?T1M[.EUYQBO4F29JQ9)FD#-=@K:B4J[AQ^c,KQ>H
Le.(GEC9YOV@I(2?9RGAH?3G;@#?7J^3P(a5Zg:aB.ID+E>@G,6]c1\.8/9C\P8;
e309Z+C[<L)9CZ]23Cb/CH6>4=&XHSB&E0SFb3VMAP_d]&\?,.I,:U-.b=^U1IDC
RJPH9Efd9Y#3+^Z1T#P^fOdO@RG;]TN<X/#aZ@6e&QbPPTHUf&^\5PWCS\]O>d>g
-#B]=OCS\1]0MGYV(CPVG9d^+P/fX)N1[VgbGRP1>48C./-QPA-TM9Z05=(81<ba
@V3S[a\e/&GX718V5D3-A,QT3I:OAfZ5ED6NS#;I4^YNO-.M,Ig3+a)MV&@[3cbb
&UO:=?@H0Q1[W-<AaL9/Kd@]F^P?;BP]3Ee-DdYPX24BZ:@Y;Q#\@G&E8[3:4DK\
f1;YeRZ8K;9RE;UIf4Db\_)5370W;>df]C0(QVE]P1?IFe1,O0\^7T57e@\\d1<(
=]>fgK-35\/+M#G;ScW^dI5=KH00g&MH1d;G\2M^b/K#0FgLc_eHMe]F0DP;V9QI
#L9g-cf)5V3X8_f>CG)#:JfF824_;VY;2T1MHe79cbfSaI&RJ8P?0R\]/9S.X^T:
=dI-<,9+,X4aZ<@a#Dc1AEA(XT/)1dS4XQ)DU__]47]JUg^&+f_7(53M+28^9/<g
O#&R>dM(5LcfW;WA/PZFO;CS)J>@gZ,C)MYD)?)&DC:0=/NRK8GW-57ddIaE&=7<
_?UbFK]^[a^>)&)GAAL7Z3XP^]?55LW-BJF31P;2c(HcB&5+2A-NdBddgW[bJa:>
C(?&eIcf07]O5_LIECM7VEC^<Z1HJc5VQ[HA9WR3g;+b)0/QM,NETOYfC<V)H?WI
EDc.1E5>6YVRWJ2)3N.IYE.X5T<A94:0+=[P;M__@;8]A\eOL;?0QB0M0bI0[gB+
]C&f=RWI^=>^=g#;UXZ6SS:^T#4DG-L3M(\Y?[7-R)X0(g2cUgBAg8(FZMF]JQA@
)QUE1BMJIDLFaDNCc<DXVLR)@N&(\5O/LXA:?I9,C7Z+f=7(Z(I:gQ7)0g+LR,/H
=326?L6SH1.A7bQF_+AU47(8AU)(,YSK36eVD@+Zb6&GGcBXRDO[<fDDRF+5DOOI
H7UW/0X?O\6WE>0R5)b-7LX@,<Y<E)HX&(bHH@<8Ee:U/VXMJSG\fQBP76aCA]7J
.@,0&43\Zd8=4==:VZW-37Z3D)Q,W2JHP=2[V)OOd(S2M&RB]Y.6dF6ZRc;aR;N3
KMVC6=(:.ZK(?N?).6+c>R@7VMEUZ&BPC2LRQ?O6BO>QaaPUCPFFJ+9AU4&S^^cb
>25B#&aec1.:\K1D^Q&LV^.DRH>S+-,U>V5NA5AEBQPa=1?UF=:T5NY41B2b+M[0
DEd+#>cIGdg<J8WB?I&LJ408I0G64UPKC;2[6+9&<A:2DM9beZ#&##UBQ_e??=9Q
-1/+,K#&AcOV2-M61+F[;&]6d)CQ=BR\82[FceT/T+)0,g[ZdEHW2?^^HWV+J,g(
&)ggOCT7J:(\G/c4ZENY)55X,FJW#J[Y\_2bP]\N3)T6J\_cfN;O]Ug1TQC2&:JI
dMg:N<TR7U.UR]-Bd_=EF[YaWf7.JSWg7ED&\E144RNP416Z3=1IJ6CWQ5cSM16=
(J>[=5dH)ZD@:,R]CMHQ^K>1:Y=N<P[?3dC#PN@/ZUNe^ABQR&3C>TAL:W8\&b>N
X,FFZKH&T6?S]6(2]52A>:0(R#G,=RNeI^DAI&0\R-/5CdK^1]e,8T.-P+IQROP2
[\C\,JU<9&#bU[5:\&+M]b>Z]-P&1Y0T7FB/>3Qe0DCP4S#414.1SB_U=ced0-T#
dUG8H3GR1g.9LIY8\:K,=LQM0G]a7Q5dQ)._G\].eV2c[9Je_(@Ef&619^:WUZUO
I\YZS1#D@G@9TMLeZgUFGdA8K<A;9XDJ?+1U]eDSD6@gQDd(G463dY80YDPfGZbR
UKP7e_a8X:J0.F=XNF:4?A\30EU+\OfJYbWg.-@U1OIS4eBKC-7GX_C-HS_WFWKT
[8ZgcSP^b,54&KWd@53QD=A8LQ+,G5[^0R,B[5AZQBQg)@a[@[8)d@B@>:AJ?-?0
)U4+\_J=JP;aMS:7a+b>-[Q[R\K]:6_b_-6^)G3T)]6e8bBZCR8A6F=7D.S]<54M
Ve_e?:<7_bEcf^P7CC\cOZDD,>&F:.Z5Q+<L9ZQL#ILE&g4)Z6KKa26Y#bS,a8=f
RCZ;R^EW=R/E8FK1dHUe?0JR0e3Z2U):Ua_^E:8)/UH(Z#O(JZQD(caY/g/6F5fe
BE9J4AWDc+9>RYXJM,Rc2)?&#PC(69],.=HA=D0]P[4@PbTHG-@)7PDW[4G[GAa]
e)YL95\CQ5))VX:W)eN+cY4_+QYP0e3@#B02UTM6.2LB>aDCa7F&ES,=NFV:I,IH
&4aD(#7R>,KM+d:R+T2YTA@/=Pe/QXGM+c>5W(G_[\9ZW8-OA63-:=I_]5NG7bO.
KJ38,4@NYUB]HI\gaF<))^;L/J\69HS.:G^5&O1-a=&U?b(fG8=]Z5<,(3>)Nb2N
PP-P#O/K1a5fPO_+\R]CKK[#c[\3Z#8F)NdR\6JcJP,1E.#QFeFZOSNO=?B,,C)M
gK8^Qd.b+F[#ba5?T8G_0T\I?LbRWEMAX2MO01aeaTP.SB=d)3X]4->DI;[U3O_#
dP2WUCW,>eL6.963WKR&.HI22@7[#LMG1(@Sa;K^I(]=Fa/ET\feW:9d,-BB:#Af
N2<D^O@L5S0Q5eYeL04#43TF=>QU5Q,(P&[-Va1g>/I&)&=)>2bHZ8Q6[eX#VP&#
d4O&WO2##O5_#&bRP(1-E.O\-[UNC/WE)VH>L8A.\B+3CO7+?Ya#LHP0gX&=M[PI
c]&2?C-:\G8BZ-3)4/_3(Y;cc8c[A[H;UC,/;B=?6/5W+bHJ6CHgI3FR?gBO@R(_
g+]5LK?bb+K^dM3AdIeYP02_C&f(&eOgdNVU-.cRV3FH8Q9gM]H\KI9OO#4U\c56
cN;4gD1+F@dPN_39B2WV10#>+>UXN1>&;7.E]NDOKQ[@PLQG\X?1P@1I95f][dbG
KZ8D#2YCAMF4YTd<2CB-.#HdV_X;@V8OV,5V23[,[dV&4P:5a.S2dT^()-/J;-LW
#ONE2;1^:@dY&#cMd@[b\=Q.-ZP/=7VF@,NKLFg8P+a:/7ZI77W:F6D@ERIPf64P
>/GVDRHSF@;AXVO\?<^:[#E&QG-@:^KddA365ePC>@H>9>WH3GcVK@e1.LJE8JS,
/IP5fRC>7))GcK@.H1-XEBC3a.a;+LY?MDY&dG)8?^:^:R>P6ZAP>RCDTN8W,YUR
RSV/Z6[]TDI48C?[^Egc/cLd;d+@fc>B2<g7UKII&J.OEMY(OMaG@PT8CgI?aaCc
/P7g;6/EO6]ZgB6=WY+,P9/-7M#68M,T2eM1ZMM:/PCJ,_F.4K,_-bC@SbbK3Kdf
9\4,6IP[E:ee+#Ee&ZEaf&^c-#C\>cS.##BKHG7A->L_<>\DIF\<Ub<=CbaG&@;7
RB?DSWAT>6>ZeH3C^<3HJI(SB&+C&[PcW1EZ28IHI:XVH)MUGJP8U\MYYB\&TdVF
+-eR_6LZO>F:<?#f@f+GHF@(@O6G2C0c?eXCXI39G@>TLN+F>(1C&]S;X7e:R[gP
)0c/E-KUa^6WI)JfK?I2#I2]Z.&JYMbgf5U7=aJ0D8T2IUcDU+4N1If1YSgV@LE=
aZ-0+[7E7cMR)5+-?g;ZaWIC:c4#33[Af?Lef3/\NZMH^#C6)g_P.8@/:#O1W6,3
<K+1<_#LCL::>-]]fR)bB7XMQR:2E^_/-<=7M?YY&R5B=G=5bQ)Y<bX9GC<-R_fd
T?##/_&=Ged\P6[;-D:&:Y8P/GC83A[]W&/1G]UE6-]P9A7?&630U\B;0.<)HO[0
2O>D(2g<[#C5dD<QN-R.O]-JfbI[.2YH:END9\@JUZ@R8G/\@RZdc?H-AX<TFZ,A
R746-/L\?FFOe]?O4[:90MV8)7Vc[SUZA52#2N6KZP#Y^Kg/QOT=VB_YSf83K]5<
a(G[AYX[U?&T[V8/<L^@]EC\@A9=M+P&1.<)bXR9S&.=VHHEL<]ZQ\5MVH1@ZadU
/f-D.2Pc0CKQNIW2?5?-\INDZ=1W.\SZ^EBD/@FV38]H:>76MJL2;ZU[1PB0_510
.Kbg.>fWgeIG5eB75#R[;/7-H)CMB[L;0;GdFHOCY2T)-cBd/YXO^K&6&KBE.SRZ
35)?_<bIT^c:A)2@HA3K1N?J;.9(]E.^ADfET11O0N:#23(T4)/JZS0HFH-FO=Q8
CK[fL7Cc52(-L(GP^HE3@],L^e6SYL/9#&2gT-62WNefFA.cWW@/[OY2V^3bd)BW
9Lc>eRM88,F)>M3L:7MX=/]>d##,-dVCW>G9ZK9f-<X9-3I<ePTBZR155b/.&,Rc
S]XVHRS[8\XEd8bWbKNR9Y2J0<aG@_Z;7,7-LL.0&K#L6aDFG3gS=/c-a/5<CD#^
Y:^LTRAA[\XdD.PJ5HJaKS8YQ\T#)H;b=Y[Hd17G,aTc@fD.aC7e80?\ZU=Xe99V
BB.gE2(QYCA-G2:;=P2NDTX;ZP?0O<<1Tfc^Ab]PLP134U/RHA:[)IPf^U^ST\U>
HdcK4fR-X4:.=P6HTYG_+P8GO?,[XgAZ0UGMTC>Z@Abc30&HZ0VVQ]Z;c2O8^dg6
5,Ic_PZFC2]V;3_QSO0<D_H;BMgGNI=.]0:#\;=J+97)+d?)^<(aF&Zbg0U1N;g7
=9WN?aHVOTLN3Y^APWc@YT-)XN?KXa,MG@ZZE,_@5S0^]WU<6Uc]cHZA\2X(-YS2
53A4fD6G4R0-cJ/-CLQ--(.6(BYI;eDO>IIZZ7Ld?g,0<#5DB0,8B?+EeBD./8c0
D=&N2E0CTIQ58E48CY;cQ=W0<Ue.gCJf(P0L1g_=d/S-+e+I5Q+Y&ScPW?2[_g[/
BBU;A:BNV5^Zc)#_]PGNM^#1:55]\ELMLG;&1Y:\WaS3[]LdfJWC<YQH2/ZORX^#
,^@Y0JI5+DJ^[+HcX+df4)C.SeTLANCNd-bUJSL-TJEM>1H0M]>3SF:T0BgC?72<
=EH18gSa=PW[-#Q)FHL)4Ua?=/d;cI58X<K\2fc73dOf_7O[&)@,_cg863M#=Q?a
/8+3&QS3U(\^47I;U-]G&/4/.WRG39_8F5Q9d;2WcY:+N8H)g0(B&CD@,RUNTE7Y
1(5]>@1:HZ_:9WKUB[&V_WQ_^JR91^P;>d5VT[/(g#C9GPP39ZNIDd5]AISa<F\E
Rb076^cV:(>3&I=1S;<Z5Y?-5V6Ua(Q.RI(-8,>-aHWf^=Q8D1#[1K#DG?TVCgR8
9SJLN\9RMP,IQPf6WR6:(:Y#JC;/SK0fXE:HBQ/-X8&Wa8cJaF_)RT:V;.BVBC_O
dZ:\XP3[HCD\UR&8dd8S2^O[&NSCG4<M+?0^_TGCINXf<W=YX=IQU&3;fJ[Y@Pg2
U#3[8->COB+4TP]e,LQYCJB?JOdXE]+>DQ?=5XEX4&IPFI0R[4gHT[1?8=9_OIRA
/C0[LT0NN52BZP^QQMC(XSD1H]5D70R/dK9A:aUR(7903M:/LC&#7S7<b_BE1<)6
##LFUO;<;I)T]8/g;]]58^9R7>=V,U[R3HLLEY?B(;/HYfX<5]MKYCGdDJ2D5\#J
bWDC79(Yg:+0X-Y&#3]Z(7R/aLEcX##569V9)f];b27O(dN71fFd5d;GgGH3eQ3(
4U[AcK/WNaN+f+Ng:S([g08O=baN+<4TM4bWU4d_W<)+>>H-b_2.^d51.WgM:@fF
@]P[L1,YL3>VTgEA&cdWLX#/B&BUc5MYa[2&aN2A/-+AO\[NJ?\F3X9c(,Gd3.C^
Ia-g_:^Sb9,KcI-BYINZ0M]D#d_9Q>(IgQW^(DMBgEfOJ0@AIH-VS0NgOYIG2e2(
T;<]DN</UAAR+0PWSSeLCG52MKW:Q(bHH;+:9C<..LRVWM>0.IP&U3EQPYaRBQA?
S+VKPHH4,7W<,7JZF,(fU&Z2KQZU35\;c.YSVX)+0;Ta_ROOZV<R:UeF5&S7V-2)
g=DGJ(G45,<[B?Sgg[aSKIg>PB1:HcGeGGE@)])a-0-6AITW_#=8TQ2<GMZPF[R)
=0A65=.NN?N4/E)-28D@ae[JHg&XKQ>3>ZL6,e;I5;A,.(AHYc\TacfS0D,0B=b8
4311X@a>@AJU)UL&46g_[A<C_AIU<5G,/-f--^dA5+PQcA->L__D_]6D;TWI9;(\
fS^RZF3^+K;)XC3bX^?73]_.;_HR.B-7YD_DC8OVd\R>A;I_TW/:6ZIb>?=#DH.G
+(<3=BC)U1Z:f-37IUB[#/;B]0?^;A]>,#HD\RM46)WG0HA<FP)^FfaV^>?9@DF5
05g;ALZgU1W#NH>E2T&6=XNCbH<N)IJ#H;RgPWW(:0dH+[,=UGW]b3A1UYc([.S_
L-@HM+/ZfX37X;,FP)]4g3e<7-[@#8;[0O=4e6=A4M-1Of.S8S@TcRATGXS8:e)\
UPB6HV4L-1155cf.H/:3HUY_8G@+G4-G=cO66f_4F^(T6I9\>3/Sc3/E<OKSJYeP
4.F<Qf@g#X[;FCGSb)S2M\Z;#Q\M0c8PGLRG?Tc8>4PORUTe^>TI=c9HMBK,MD.g
LJJ2@O3g2De5f5[HdYG2&UdFfUJaO+?MY.[Z]_a,,I??A?>7HR,J5R/#g_P>21T9
Z=ZVX/V9)8A//;@P@a0BI&/g,NR=E.T4,&bc\N7]:K)f.4/Z@I#,,JQ@=?#3UgGL
(+Gg<#gbb]@Z:4GRZ;TC_:&@b<A<eBVX:+G5S-D>8Kcf+_,])]21935<9BeCZV_e
A=f-]H>gL];?N0OWS^/>_+-+H)5H9ON7POd,JE&Cb4.Ae&S,EEZXY5W5G3Q;c/CM
\H936g647F(+1^GTGN]TI[PbITKTA-K98EbO#NdB=+QRHE;:gP5-1@^6ON(O)=eU
e^ZJ,+Q.S.RCL1/9cQ&EOJL&VSNDCW14@A+_1X_.19PO6&/:5O,.8CX0d)Z,d1VY
CJG4b;,_g,gUNYDTB#Ac]SG6V5IQ4f#X6O6TTeV>\2K0e#_4^K;6A71bU24CGMW)
@f[X^WFGEMdQ?/A68/7,Ee6>Ra/)=(,_8]+_0\8?L-Hc,QZ)Yb+F7MMVgebHf[fG
1,?LK9c2=^@#d+GI=L].H7.@C9AEQ)\RG5g,H7+V90=<eb7UN[c=^_=HV&)DA=<9
;(>0/ZE,B4)5NAJ=4@L;3ZB,66.Dc,BT[<\81+:-A,0Uc4/W#X+TUIJ=@(^f\aVF
<K]JF6;^6-SaYDDIAP7<B]((YB#7_Y@dHAL.C44(Q(L^-:dA(R;6bYR<E@RJ8Y;_
W0V<0V18?M[DT+JFA<VCe)ePPQ+g;Q@EIfFRSWH3EK[A6:>XMAV&2T#a8+>78\9D
MaaWe^f.@IM?OR=YgIEKN9,3[ffg8S?TRbIANK#L=S<c9HZ)Q@R:&gVG8bDO^I>Q
e?J/1WcQUT]FMFCT_J@<4Z#7Af=Ecg-9B6/SQ:PR4^_d:(07C,\PYJ;S1O42NHE4
AW@L[UI2HV0:8d/<9F63CZ^?RQI9\N];5.de;]/+HC:b(_JK\;N5;AVOI0]O1LfW
Y.>6KN:Q+WT?H=4S^5YGF<QfME#H,HD3T7LT4d6Pca#D;N300M[XQ8KDW?Y6GHE4
3[<]?.Hd2_OGfB6_afK8Rg=CF@125a25.&Q:&b0c7X3+XXS&X>1JMHgMT#J83fRI
M@&>We_;3FDW\ARFGeG+agc9U@Ze:e/]Bd^H]Ub+&06=P,SBWP[8NN:_HE[VT7=Q
K-J=O?\^.\eBD^LMZWMAIA=WbO6A1Z.@M@cKX+BfS^/=7K9Sa(4.&L,-3JF1?fU^
bQ?F60OL(9T1#1Sa=X&31DH[XJgW.<I.&)^>X=R5>#f?FDL=bDVIFBL#Z1X>aUB_
\,gL]_VAS@BP\?MceDIaT2)=7QS_POG1/RLa84T_H(&ZDLDRc./3[L4XJTO1X8J\
7N[g.XQab+8@7]4VG/S<J4Y+gQBgPdTM;Ve^F\aRASFWSP?UMc=9Pc)@S2]/&_4L
g&Le,bgI&We@)$
`endprotected
  
endmodule // nvs_uv_monitor





