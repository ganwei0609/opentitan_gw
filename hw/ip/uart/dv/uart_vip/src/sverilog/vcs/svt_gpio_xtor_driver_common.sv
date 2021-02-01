//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV

import "DPI-C" context function chandle svt_reset_gpio__get(string path);

import "DPI-C" context task svt_reset_gpio__configure(input chandle           api,
                                                      input byte    unsigned  min_iclk_dut_reset,
                                                      input byte    unsigned  min_iclk_reset_to_reset,
                                                      input longint unsigned  enable_GPi_interrupt_on_fall,
                                                      input longint unsigned  enable_GPi_interrupt_on_rise);
  
import "DPI-C" context task svt_reset_gpio__drive_xact(input chandle          api,
                                                       input byte    unsigned cmd,
                                                       inout longint unsigned data,
                                                       input longint unsigned enabled,
                                                       input int     unsigned delay);
  
class svt_gpio_xtor_driver_common extends svt_gpio_driver_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Reference to the C API if using the synthesizable VIP */
  protected chandle m_C_api;

  /** 
   * Static associative array of references to instances of this driver 
   * class, where each reference is a back-reference from the associated C++ API 
   * instance for the corresponding synthesizable BFM module instance.
   */
  static svt_gpio_xtor_driver_common back_reference [chandle];

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter UVM report object used for messaging
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task run_phase();

  /** Initialize output signals */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  /** Eventually called by the C API::interrupt() callback */
  extern static function void route_interrupt(chandle          Capi,
                                              longint unsigned data,
                                              longint unsigned enabled,
                                              int     unsigned delay);

  extern virtual function void interrupt(longint unsigned data,
                                         longint unsigned enabled,
                                         int     unsigned delay);


endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
J-(8A-YXCI)[Z/[EBS>M]6YMcH5d],?4\27bdB=1HQ\W.&]=Y;fG3(>1S1)F/V77
Ag:Le:RJY[e?&L@OM^6bU&UAb8#F?TUW6/edS-,_SNb1Kd1Fd\2+UUF0L-:7RN3S
QSTeB1L7<E;RBIc9eSeg;GbCHQVI7[[_^..;BVMR9ENR-LE7f-Z9<0<XD,=@F)>B
IfY+beBNF5Sa9>1d9XV:gec+&N(XGZO1XMgZ/\0=@^,0H>Y7CYTT#0f<BcY1P,<a
<F^F,2NMNP5K([5WGB:SE:[RG^#^8FAL_.cd65#+=^<]eOb.0<D:LZK<4(0#FUAA
;AbNA74F3)gdbI^G>GL8O4YU-:&YO1R;([;de)f7a5f>2B,dX8+O:3HdWXf:W+C<
dTCG3U,3Y^,-JEKgD:YPYT>=;c)0(^Tg_UIC7J.=,61U3[Y3aOc</]S[dE+?d7aa
a2ONN\W([V.06Bg1>69WfLUG;+A>V?>7EYXIR3.gUK&6&&JUB#Acb/P8CVgEV55#
Y[RZOO-2D,A84PW+[BVOUFOBPf5F3\#<RbTQFF]_a&dI2;]HD1XC600d#F=dCQ9J
M+2H>QbB=<+L?R>I:5/UA1IX+/TI0</._IIc;#Z0d;b/0+O0Yc-K4/PZQE]/-EV]
]>?X#JJda@aaBTZ/7.#IU\1]6,fG1]=]dZ<)fU[.Q?WZS(0084)#:7e7Nb^0Ca8e
PS@L2e;eO.Re#&3a-6NM]I=3(Q4JTeG+8(H3M/6E@B@4[&:U8?c7>c5W0CJB7S[_
GTQ1PgH[DK,E-:+(BP-O2Ge^11-\bgLEXL@@0@dS0JCRYGbCXUO25(X[THCOb=9Y
</,eY]EI9W\P](DHTAdg9F/_TN/3B+MFHFKH0ZMaT0f?FNP>?S98HaH\+JJ]KYWE
J<f_ZBM8O<M)JF9QF5W&1.J_JJ6W3V,]=#9.9824,_BR<e_QV-3=e6)Y&XaW&2Y#
6-75GUa7IeULdPcYGbC\f#a:TS\F36,e)(<XLRFOQM)T3]g04SE3BVSO]I=L9MbM
6MV]:OXMCS3N?-^2II35/WD1_</9G8N-Y>d@EB<e7a&aE1FEJPf,^J-=6aY8LCA9
b+)c9MEgB.F<<WB=IS](/d6.1B-5-U134cXC=g:XE/PK?U:PCb0009Z8@@K:64V+
#KaQ:WK-1=7.UD;>gKTBc>#-:U&9&=MJ.\g>T6U2&DddDTJBG]I4a)Q_&XIK#-)A
SAWB5<V,I(FgP4fZ?;N.[^VTIeI2L/E08Q<Z1=O\+2d64/IQ8eZAO2<SYC<B)?GO
30R8cNF&Q&NF?@Ee0Q5eRO#,_U6ee?&K]C0G\8(((]d/11/?Da[-)fK;JDF7?4US
PZD\aW_UeeTSKUCI19K8TVEA=P>-ce^aB+GPY<Q/PHe<0VJF?<S8W&VB6d<d_QFY
#+MVD&ac<R/e^CXf5.\Na2],FN0I79W>QSE4P,O\K0,PXc]VMJH;LQ3#^f^(W<\O
_T)LN6KF?=a7bC1GbP7;0=UU,N,E74J[L#_a1bd&6A7F0<KDIZNWXafbG.MCd9^P
EfFD>T[Ug[1LO&E_D&IMGW4^)NV-I,\>\Og\7:887eTFN1.b8,Vgb3_UDZTePJcA
P<^bFcaYMD@UU[[U,0[^)^M-_Jb@9D5Q:TD7TfdQb\^20bOS/2P4Pa>\E3;0NPTM
;a/YA+9@a.b>,?S<-\8<(K/+W/2?2;CNW/[TZ^(K-#b66<>DE[D0LNAS<U6T2XfD
^.XKgEL8HOb,LP;bY>@[2Xa4(U5+RH1#]D]:?BK@J[0XJG-HMR5ZaU0e7Yc]JI1W
eRacW&?17<4)#OUZVg7-^&C)AEU<4?3ZAgLES:K?\X@W^d&d8#<2X\fT<O7?Q8c6
e\a6Y&U2IF@gKfDfW5I:N<Y)EbZ]#:eHFT;^9#^<Tfe=>dVN/JPdYe9T0_.Z.Y>7
+3UD37SR(S66WNObBHRY,]Ne&FAG,AdY[,gPg-W;2a1R1YT6A^IT::fJ-]a^GCZU
E^GJ[T>7K,=\SHU0U-XLe\9dWCgQ/NaF>a71GZg<&Q?VeR[A4ZLG4_@WB[;+.YO(
..+-D3fe-)S,W46e_Rg&L:g(>CB3J85D.1EgCBW8,1\ZcY4=6g:VE#OBO,4+fgB_
E97+3</&=,<DaJ^KPX9+A<NH,<>VY3(M2V8^0]<Z7>eYWAA@<54GGaW<A1c4+Z,a
\,8BKWL#6>[YJ[/)I.BP+7FFZWBgI_X5gc>#1;9^=)QFM-_E2P8,T8)Le_\LAP,c
_V_#KPbHBH3NXbT[2_6\;U]Ag1WQT&)gQSBUCT[GAD@baPR=Y#9DAHUKS]IbESVW
>K^/VB<XB&&U>;(#GV<LcS?CY=g.DUQI<UHZ@=A][ZVVZ<L7#WHB#WgXV]W7(=Tc
E(@/c\A9d/Rb2</I/(Zd?^#ZOWR4:V62?6gH2;7?_9R1[7UQN+LFN&.+LOa@fd8G
TZ?OVc\&e<5X2].0L9eET9]N;Z;>Lc+:_(KB[4LDH=cTDDUCMRM1[0X5/daD]/Bc
TNR4DJO,+OG(;#d1H<7PBZ?ea_0]#X=;6F\G-J.c:F<E^SHJF<R5X#/Q54)/+R#R
e;d8\<R1S\ITeJDP/[YBC6_R4@?)&^K\P-)X8fPQMPG#TG@SE78_(.A7:=VQM[-c
PXGUba\ZVb.D(W8Qe8LTKDMHQC9DCVeSB+[d22,P\a_NJ8#D0[1E=e>;K\2ddPE6
C3&1)2;]@L0Z(JNLB=>e:9f_-:[.9(\G9CJ#3W>)YS03c;&=PcLRL3Nab6KL^\H4
#5K,<[]FINR)H/J=/<ABCf(7YTPWDB^4)\UY\L]8dEe[2K8KAgH;b]5[RF:EWZEY
B?G?Q@\3+^LbA<,2>)04WB92QWN_DE+f<@<E]8[Ng-K7TH3dB/]_8#PLMBg]5>Yd
^RdfgF)XC@?RdR>,\2M4&>+;F;JeF]M]SY?c6H^CEMP[c:gQ3Yd/10[M-;+GN[-\
g2Y8\f8D1RNHE>.I5J+^-D>;JM3.VZ#BBGWGL0c,KK4VL66VKe9,.9==Hb#].E64
L@[H8,WdQK=W65B5@8fQBf]EbG/P7NOf<Lc7K,[U8/@:G(QLOF@W_(V74[cTV\S8
NAN+NLL(VN<aUS(_2XIFUN(<?F6+<2Mb)T]H0F&8_OJ:/2GN[DV<>BgFKZK.-/^?
\72B[TN80.@XT)K+g&U2T.H858;]-)&=A>Be0)dRN3KX_Q70@PCX^#)c50P,;[eK
&7XJRdJKYJ60<U@[8,0D<\&(QBZK6G0PO@K?2UcF^)D<_dRVQLO1&X3?Ja_gBScY
@1W1XP(^(,Y]g?:O:gQcUN(M(F(JKAdDLJ9G\0/MHJ_c[:E;RAg5Q9cWM(29f[Sg
[WF&JZH<?FU+:d]__9U:+-]0gSF6f[QMF3.U/[IN_LF/O/L\-,K^/(3IcO9<U_g&
@619:(QWCPgM+=]M:B0U[0P7(HP,/K4YfGD)J^:-IBb/P0)Uc-J<O/c59,:5[-R&
M)Nb5[=+^A(TN:H7cOV]XNJ#/EDAVe<:JF-b;0;X#IE]]Ge3Z7@KZLaP7f4INf4X
=Ub^G6B+^/D&X]a\+R<7=SZbd#aJ&2CU@8aCJ:P\=We,>\9ROg7X)WW)4\F\KBJ@
c#d^5R@TgU.4.O[AMO=a,_b3LDI,+J382abU.2G.eU&(fYJ/3f-2GDZUQPB:)CW2
A7-?WIX/M4=(fNU4LAHSQ9@8N8UFP0Je0X-.H300MPbe\G),]-0&N+X1ID=EDUa:
\<]5BNV85<0(+Y::2LTP1[e:>R+1DLW)T_OPAa85X9;5<OF>L8_;F^[.AB)#L72.
1UC1:)P);Od3^]_.MKB@_(g6+P_-@G@8g5DJ#RE.+HHWb:,#.&G+TX;KFAe:L\Sf
7O^WPO/&A);G-S/F+[+DQ<ND&]7/ae>93B4c?S?+TH<8^WFb@b4AUgcZe3]bZ1RJ
QTd^>@4.)fNLUP@c@/B.,a<XA=.L4(:N?0B?PXPUW-W+M(&8Z.G7fE)>3f<LT5_9
?TJ&SC;SE2>FKF;/\JO4TfSB:3:_=O>NQ+A#QA1W\dQY6fbBXe8D3NI3[0=bePX9
J5d3UcV>CG0cN-O->YRA>9>GgB>4CZ>1]MUU\:.Re9[6M.0^eB4T&N_E>WS/--.K
B074K(LA(Cc?fTAX&+IV<N@TQ^4M32ORPK&A_d,F=d3QdGC7[g/b)X:8S9L-.[Yd
1K:ddU46(D8b+[K\Q10e>#)3IL_AC-b#.UTEP8L_Z1E\Jd^]WdYXFgU(FL9.KT)E
,<&KBXH[+OU_B/2V]a:XKQT_HXQK<cf)Z.PN_3H-);b+[HU^(QDM5YS-2]F.>M3;
5?cV_O(DfG9RTI.K#6&B@N+3a20PKBP5Z9MC@A=+@S\?A36OTS[SGU^C?W^dCKbM
;Bg1B>)82B&UOYP(A6K<:1.gWH@N(:)CM5TG]E_d8g)BPgTBC\RHXQIWJ[-6KVUH
BO])G-WRG#cDS7HS3.cP\)>\2(ee]Kd]ZIMSN=-gEK+87#M0\>O;BCF[KZOd@\@0
fS/BcDV:,PEK5-gcUb<)4#.5X62CI<>4G+\@G3PdPL^TbTeWJZ##;^8b]90(F=YL
T/\#,IY+H?LD#X0[<7T93NN;ZcL4DT5I.5e8).gM&,I6g\\1.f.b(D1.gY[@.4#>
#BK4PbRgZb(.8G>Hb4eH71M,#0H&B[;(^J5=>+>OK=]L:<:NQ:570?IbF][dC>M)
0VE[KHVD]^:#aF2\ALF+aQ0;O,Z=O/9T72I3C&ZBUg<cQS@&<]QL.fT-eb+.8D.+
c;K^0Hc0U>H5F>AJ.M?4S\.(S8dO@dKF9R6X)?C,D1OU7K7aO[,PUeCP#2]A7(NW
eZbGZH^0a#BbI\F5(/,>25,/0C)9@c8.9D@O]c^R7G:VYPTeX61<e/U_^A)g=_^]
B#bfW@WQNBYaa\4SOOY<(P_-2^<HQAa4g9^FTWKFSR),8^>)Ib&#2f+L<4gI1dOP
gcF:.D^65KRObVMLG>#-#D)-a_M8I#Y^/_\6Kb8f9H2^dETQPI#/f>-ESJ+aM9H8
Eg8AM\d,\S0cK^V_gg<E3b7SA?2NbZ_D>/U0BJ\6;<J(FX0O[>.)f7&SDd^L3Q[G
aEQA-^Q:6Z)WT+-f@Dc=Qd3g([+2^Y5LS#3daC-TTc(O#0b5EJV9R7Qe;-J,<aSJ
?3K#FPDE,BaQ#/0)DJbVL<2D)]/QIBYc5,@&b[7Q<6T,LUe&Y^B]+WK-RY4/6TBK
-1Ec@L:/#5Nd,C:f4RfBbR&#Y@?-9_fX\AK4B<[L2b;D5H9?[&E00)-:CS#S7Y]@
RBXJD.9B>0dS=Hc)#Y1H5^-L0MC@<X4.?AQBg^;OIHb,-?^O<.;[O(J5dYQK#+A8
K;O/[3g,H0&Z+#]JE=(]16)c+TTT1UG<K6T5U#]C#;T>>9MQCg?K9FDeK\T,-D0Y
.Z=a0RQ7Kag3F57U6?<#,DW65eg1?L1PPD4C.SCb1MRPB/FRRF[5J0>IE2fSEC3L
fbaU1664L:@X<P,e]5?F():\TE2@?^ASTC9?U,[0#A^&ZD03g03KRO^^[UdTbBg0
W6OYNCMG=7eP89:YMd22JUcGG4FS_KZR<f\-beD[,=D4UPPcKNeb4aaKM>;G_C?A
XU0Z&<eU1cGISN?,_F<:#B+S^?<^G)GQfB.WD(N>>LZL05G9.-b6PKGPLfNQdf&#
?bdd@;TLF_(;87:DHT?+ACf>0O(5N)IM(@E^7-?KWXdN6E)UfI+0UCg-A][J9O#O
1OgQVg0F^X4+gAI2FB6RAE+f7HgN:@gJCIV[?X.FE^W+FVI:4NbgG,](,6[B_ZRI
@IS#T<QV8GTQ;L7,C/]G&XCScS69+4dT#/2?827JO.R]E>f[5?^BQSS^9R?UWVdg
-5V9d^8gbY]65</GG<15^=-R4/M0=1O-()6K#Na\+Xa@#+.B)O^)JCReH(476N+V
L\<)OdQB;-d4a.^dadK>,GXUd<OO-<+g>)(&^JJ,86Zc\c/dQa4O1T/&(KQ6e:CbV$
`endprotected


`endif
