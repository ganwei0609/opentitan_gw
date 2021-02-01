
//----------------------------------------------------------------------
// This confidential and proprietary software may be used only as
// authorized by a licensing agreement from nSys
// In the event of publication, the following notice is applicable:
//
// (C) Copyright 2005-2010 nSys Design Systems
// All rights reserved
//
// The entire notice above must be reproduced on all authorized copies
//
// Model Name     : UART VIP
// Module         : nvs_uv_fifo
// Tasks          : write,nb_write,write_buf,read,set_fhandle,reset,
//                  read_buf,nb_read
// Functions      : None
// 
// $Source: /tmp/nvs_uart/nvm/libraries/nvs_uv_fifo.v,v $
// $Author: 
// $Date: 2018/08/24 $
// $Revision: #1 $
// Identification :
// Abstract       : This file contains the routines for FIFO structures
//                  used by the BFM.
//                 
//
// Classes/procedures/functions/tasks called (if any ) : NA
//                  
//
// Platforms and tool version used : Red Hat Linux ver 7.2, NC-SIM 04.10-s007
//----------------------------------------------------------------------
//Module Name macro by codeGenSVT 
`ifndef NVS_UV_FIFO
 `ifdef SVT_UART 
  `define NVS_UV_FIFO  svt_uv_fifo 
 `else
  `define NVS_UV_FIFO  nvs_uv_fifo
 `endif
`endif
//Declare Module
module `NVS_UV_FIFO ();
`protected
+5,SO-NV?_<JLae\AW#H-g:@H0AeXC49P@S+d:L#BS6IXb4#CM/:5)S--4BeAS@6
.SJ-S-&R^Tb>+YF7a9M^T>@>+GP/ccPa0]7A>V1J-bfW^cIL5[N=(#G@9Z>cX3a;
U(+BUe>.-g^I>;DPIM6T8@6fY;1bH.6gd=C,1K6AW97a;F;CE&Z61=8GL_#D/?SA
d>ZLI.4D8D[FU&_e0Y<[N?C@A_XOK+E9NMCT4.cCUYe?E&SFGKY-LBS2M-@98?U[
T,ZSE>0)DKUTI[(,A?6S)(f[@F9.G3H:XSSUK29N3GLd,/MFZ+.f<Q4;fGYdD/N@
6e,9Z,HK(AEbS-gO1)R3D[4BY:Z;>&d9>UL5X#gF@>)_@]c8NeCB-J1?.fE+G:J@
O?>(K1UCIR]_P]5:Ic[N8Lf1Ob1:HMA408X8g;TP8:(J3,1cXH,M>YYE23.IQ[=@
C<fOZ3]]_Oc^a#QCd8_DNVF,MYX6\Y(DTe_5WM\&XW\V,6REYc-1&L\H,A]#5DD+
3E[D,>d&;HLfMPA#]514[HVL+EWLIVN<M84UDIK2_aR@(QMX716&2-4^+IdF]V-Z
0(<JR5E8JW34)B1b0G;A(Yg\>WH1<11A>+(9:QD<@]R4?[7H_W\VC8K;LK,-WBYP
gIH3>0LbA7#WDMENL&(<_e^IYN9VG9;3PK<e4MWJ\O[Yd-5J0[KPUb6-g-M</3X_
gZKU.S&Gd,?O4&d7B7R^3K3g4#YX7;g25Pc=^+C5Ibb31Ob3UHU^<=4C<76&(+gN
,5S353ETWFUF)=(U51VFb(T&.IKLG(PAV]VJZ.@=dYF3DeQ/46NF<1(dWKGd91b0
eT#6S,UCZ@ZAQeXZXUMO4YYM@FZ69g^3BUdUIRd2U](fd8N&PD:-X^b;41LW=15=U$
`endprotected


`ifdef UV_NVS_PROTECT
   `include `NVS_UV_LIB_GEN_HP 
`include `NVS_UV_LIB_GEN_VIHP 
`else
 `include `NVS_UV_LIB_GEN_H 
`include `NVS_UV_LIB_GEN_VIH 
`endif

`protected
5?ZDD-=\#S0CO:Nge28.NRJ7__A)&fYT&&e-#fOEG40D4M\CJNTD&)3YVd=&O&gL
;b<ERfB3NK?>TI[8,9?_C4Y&<#X/_CV&.N4X81PGLP&,(_PKX<ZgFDI82,E5BC-@
Bg&1S]VENb9DMVXO]FH&NEHcZDL92@[.4>M9CYQ3_JL_LTCP;ObKU_2TGL_=3F7d
H_3CQNGEa&_0RX-GVgg)Uf@=H35VN:#GR,MF?WPf<d(63WQYOR+-&ADa(/1GIQb^
>Z@F52HH4g(0gd.?._=35KL8b-V^YX=aR&^VI:W:C8DT??_8?-#.&+EG24T=:gQ)
OM9CYN3LYKCUFG9CUXL.(UOaN7C)=1LQ30,A\77[JLHN+6HF2JA81fEf,faYFEM3
M)#2@:5A70H?D[;I?)5^QW2cFTOE[AH6NK=_eFSFV[GE/<77EdOI:+L9NZ5+<I:#
6)N0Y<ICJ1#A4^>04,^:e82SG\(;88&8U?<&caTKeI4gL^^5]ga,JYR(=2K9K1IG
_WGRT_8V-6EY6-8CAebTE=c5@?^ZGSVK)(AE]F:Z\DGD3BJXfDB2V17AUY3+FR5F
4M),Pb9/#5.4^B>3g-XL4T3=dU?:5&MWLf:Z+_#6d<OT6+N;WELJgMOZ^6>/?FgE
a(fR-1O+?#g3K3BGfN1N;]T5<(^E3VISTQcL0_+X&g31ON4S70WB-[__CT/[e,QK
=P^9)<Y[RL/5T-):g_8IF\/L2\]W&(Z@eZM0<SKWQcdSSFf7F:f16\@P@7G@]dX/
B<M[Z5FV9&MO^K&g1_),FNJMD-^+H^VX,NL+D1V>Na8)B_Z\WB5[\b&:(>S.46)W
GCZK7+DV6bD3?TAH<g5HCF&Sd9Y8e+9BK9?^3;dY;5J;_QI_=LZFU8f6M>Y?1AeI
.RYWP>Q[SaZcN+GfRHNTBG?[D;1\6\FdEZe[C/=&B;J_g5M\3fJY4^?8VVB):cQ7
GB82b]\TOOC.bG<^caU?&SN[,)>O&[/eCGSEa3E?<V;-e@S9_92EXV>S2[ab&+2>
ZYASPP^=+G@K5Sg-R,(<<X-a)cMS:5I6D<1QZe5HY)_?bT=2KfFd636P^O,;577J
532TLF(-8T7[;W?3_f1A_^e<Q6bKdK1^)D0D@PcFKU91@)B/8@YC-BOMS9/UP)V^
RB2(YFR(7aWL[N[)&,5Z)@#,V1R+,4M>_AGH_+.^7KZA<A]Z-F8QFfJUR5A,E:JI
+]0)]PHZSMHQZZS#=ga+T#+9O]8PCLUAMZBAX\8Z@Z+]Q3L2^6TAf#/P=7:E(3&&
>)+QN^?a4U(/DJ#]AgUMg_5&C#16W+D4BVT/Ag7^2T@04/cd&AL8P/d<d^)a/9/f
[]b@U/38U59+Ea\A,S./..]4Wb4=TccLP)1=<ASVf6Y5g=\+[=+\+6Fg@+XaFcVI
^3dX(YP47fN<=T,EA@7@GC?)5f/G3[ZeS&c>T:M)>TO>VEf[a4NJP(U6K+EfH4E[
cb2,0<8dPb@D@V56UU1/>bA-V<[3b?;_F0cZb.(^>H(F@5C]5c-,,@JIT?a-e[S^
N6I.CWcHe&@2O+&eYZS9bD8FD[(BfVVBDe[@/O4CVa(^&QP4]+&N9^c_fCHQOJcH
#D4K?aGPE+EFG9X[EM)-edOBY)G)+PQTEQ.L/EeMH&NBY,bCUR=bHX9.]IOf^6(a
g8B<I;/L_QDFaCQ\aZ[1d]94_KBd/K/,36WCPE+.FAWH<^\T=O.)H#;/=:1A:OGd
9>0]=)/6-D.=6QXON:E)1BT].]EfXW_,c).=OL_O?&+=?I/1HWVR[Ta>3D#@B)P\
CE[L]3-ZH-GS.4a2,B:cW2O4(Q0SCGF>\1&U0b[LVGRba3QW7+@HB0,LP;9c?B:_
G7#)^#G3),+]L1.F5O.SU:ddYWT[?-Ef;G]<^897PP:gX-DDQYD:/R(T=-A]<)8a
;ON:-#f?GbZ1K1+\VcW8DgYgU<NQSg7Ke&186.&-;&MXW0QUH=d-1G2cNV(3#GaW
eHJG8.BPBB=_7IH\T1]N@#DEF^^XTP[(0@;)@[=LX/A^-HKaJ/9K3g?G0,>>4d6P
[c9A+cC?RV)\REe&2;-/SMC:dG0QOJ36C1R#_8)f;>fcE50CCK-;ME<OCTO3c<I9
83D/?,SO7#E&c^(^,8N49b-/a:bIK=EAX0E2=bEG,IIZe4_5#26-:=(JFae+H7ER
S019g3&F4H^7-MR6EC.AI,G<[Gc@K0B;2^7N88D1#,RHG^WH2\TA<0(gEYId,,@d
D>U3\[4-D@:/5&[BD],P8(CC?:\Q;@V0NX-T[[:;&6S>ba=(BO,QQ6F52a&Z@)aK
BR+]I&bNF3S)O>WW5-W<YN.ZV0(A8D8T+f#\6aNBO906>@c]Q_WL+T(b,,&N8X0P
@Yc@>>b151QPcY,+HT(a94\cU28HL/OZ+L39=\F_1?LF#;dJ)cQQOVb#/#V&RYUP
&cPLO<6fC,G],BNKc,eS;XFHa?HAM&VYHC8_@EN]?)Z2_9eNgR#4(I7\fXK\#YBM
Z;aCYXcNV<29BIE:?eNbaf]gH^XHDQO<E?+Qg+AHfaCD>D\/DPLU_OD.WBd(_;#8
XUV1S4HbNN5\9fO(?2NHQGP2@8-WRa6PF(CG9]Y&#1M5YW2R/ES<#T+X3AB719GB
@SMMMI/8(<0RbK@-SX#6./dIOQ[TB7?Z,F7H4C_RDQ?O3QZ06c(VG_BRe@F(]8BU
X\124N=CUY<IC]&f5aJ-FS>dd&HH6G\@(IO)a;R[ZT2Uf_/-RGUA[PEGEYgMLMZN
G5?d@.).=O(4^S(8F+c;]]>+C-1.=9C+eA5\e4(eOU)BZW2)R\X8U39J\R9#3\4)
bf,9R]T-Oee;=a3K;I6)BY40]Ga4=W+J8JM9GP=.?NQ-T]PF(09[NU/dB_8M]C9O
4F?JXZB_H\@<=G00BJeG#TUS^0-8-4WE;VgZ:1(AE]NSA6@G.WON8=<eZYC@A[FT
::NHA05cB.+0K6P&J\,3DW2SVLa/.93S&P4(d6.N[J:c>55)Z8Bf93&EXPUaC0CF
]:e&OL?)>&MaOH4F4U5G4@/3I-HN<_A4G69Sb^D/0]b>=GVe.,QPYcQZ#e3ZA0.D
XMdLJ\O[+g5/@=e]6JSU<3Y./?_?8,e(19EV9VK_&[J:-5/Of9)E3fKV4bO-b1(I
_&4HF,@aBY,8ODcc]H[\fGaB,VBX(CY/.f8LaZdZPE2WgfU?4VT7+gOGH#aZ#.J;
,2X1)+MR5(f\SYD2(d0N^C;92#7X_\;O\ODa,+UNA_S0BJ-@?RFJV_Q]&:YNeRDL
fC#fS&RdMcMEbUUY\fDJZ;ea@^#1[d<2P+\=FU)GX#d?+[ef,eY63EaR#R5S@g>M
SR5E#<ZQVONT2R,c]T8JCXXRN&433#<@2LFA2(L+T?N<G-#O[&Cd(GN&#:A8+NfF
E<0c?E8b3WWad(72BYNILQ.6KTWW[,VW08F@RYf)SKVGc)HR+;IQ0T1BU67-MNa#
;I^>N&Ld)(fEC-R_fDG[0b1#aIa)/?T\,3GacZCbW4WE&C.EF@fL+,dbS&<0+=SB
<K2D]Dcf.Q,Xf:3\5WU7_c<e0&C>cLe15QB[b+TAMg+5daOC2RC<Lb;H+TP[eE^6
C\C6GSD(8=6ZV50/YH7fAJ=H73ee0A_0\>#b]4b=(@Z2-A;=I,E)U/\.d[E,XL>>
PV6cS<(1I(\RAYK0VE]H1ed>XF[-FfD^=\ZDXM#\&^2M^?@3DWbXQT\QGbKdIK[6
E/-F7:M2B6[I<JS(@JBO)U#E?^325/XS.a_?83IE?Ee4:5]M1VcP7g;DS\W##UK:
>3G):[XE27(Z>F6JO]+P+0SLX4\e.^2I&]e#42g7UEOX+Y7Q[-5Z>=+E=TFX[egM
RB;agG90/U3Z)<;bD@ge2fbdSM#NW(PJCWL[^T>cLIP?G6df76bMg:VKZE&b_U@/
3e74\SgCVUB=0Q^ODa5b?M;XfI2Pf=1Ig/<cI65E2:6>Pc-NfL)>]P.4]Ud&\DB0
_Q#aAH5K6O+c4M@\9N+]P(@^EU(<0dK3gRS&2CacYXA<:IK22/2)9=,QB<b<@#gK
[OVDIA0]]X;_Ia/#W52C/>QFXM;>SQ>@e1R/P02[[b[I/M02UZCe?6:]X0_6&f,Q
+B)gXOJZ:19QM1FWaH_g1e_A9H4M9,([B]L?115Y7[FYV);&Kge<Xc-US@TVaaT;
,bJ3MGXC]16;RZ\aXRJ8@1/FXP]1CF3dX,FdE\/b/&MVbS9UGg\0SX3@7#4N&LRa
J.1I>ROfL#dUB-GcZ)USH(?.9M2V#<<&:X4eB5Yc&,J#^L6#Y)a(JP7cW;P6(aCY
g-c72@XCFQF^Pcd.Y+T@Q>O74#45QJ-EFMA2.I8(.><b+L>KQ[]OJ44+Edg)/4A8
<49;W..@)0@/>DgRWa#8M&UXL>f/Na>EV7QfX<EfKOL--<.SCe+)_HcUNCCIgXHg
XX4;3).V7NeCT=F7@F&3?V;FYW\QF\.B.IDBCNM3\1M<9?Q7_4IQA\J_K89:PWQa
QEc<M:L/4/)1(M8=LZ=QcVNR.=2dedI3b35Q/6acSW@RW>4.@d&R.36bQf&56(AJ
_/DK3DS3gTIDG?O=&c>)cc?3)MUZHT2ICAeWVT,^).T;@=9?ISXZe.2a9P,?A?DI
J?GMSeJcb:?CD1.;aWBWWT0B1//G3JH]SCRGNc5a12C#\D#]Z#]J0?,.HP5I76M-
67a/B.4<C\Q16ZAVb(&2d/5U46>1YF4<.^=?NYUcP4H&2cX]#U@0^e[Qa3A2VX73
H9-E@@DA1KcVbC#N-1RPUD-<+7R>.4)TeSN)+A8294)5=GRY[?+/(;?FYX)4AWG/
4b8H51>SIb&4Y\SL#gJHSc6^KL?-cZNeb_DdI@V/-XA:+K,dW^4@7YZ[0:?<VCa)
740c1GS2<(5)G(IM&Y4VUfSS2_=#c/2@LV.DbH-/@E5UJHBKGaR:F_S^#+UH,-R3
L83RM6,Iab\NU9H]-J7OVE.7+dTH-B&/W3eY3e5DYO8f0OfHST+gD2P+ML,M=^,T
PU.KIU;0#N1M&?KJM\WT8)4/_PAYJNA#;A0Q[A4+cA#Bc+ZYT+#\cX<?+BSVCMg>
?E[F-f:bXD]7S+^Y>P0N6^EW:PNa)7eIV@(E[IY&CP\1/6YcG\]V:+9\N[[XTMUf
:2a<XW6#U3IF0FZD7Ca<+,G(/FI>95?2??8dOV&ZK3d7\&NWZM5<QfW&K,,BS#80
+Zb7GP]Yg3O)Q<_c-?MPW+Z]GfeI6H-dSL4F#e5^[5I2=@\SY86+1V)+aPL&\EAe
+9-aB8+/O^RW&@d64Y?W,KSG8g4\f]+)@b@.T6B[D4J5DW;O?e5XVZO\)4^#?LR9
CTOQ6UBO_\EEP)8/e&H\Z3D0B(=<[X)Yf26-8IgFJd<-dNg+g-[.=BY32gGW0&<#
:F@(Oa>DJM\A4UODX4&T\.[N4]REVb3d=/c,J4UR<NTaJ_XbbgPY48)J?T\#B;I/
_Nba]P<94/e3=C@WXU#F,1[N7$
`endprotected
  
endmodule


//*************************************END OF FILE*******************************************

