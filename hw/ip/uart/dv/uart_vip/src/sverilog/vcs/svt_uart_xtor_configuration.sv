
`ifndef GUARD_SVT_UART_XTOR_CONFIGURATION_SV
`define GUARD_SVT_UART_XTOR_CONFIGURATION_SV        

/**
 *  Synthesizable transactor port configuration class contains configuration information
 *  which is applicable to individual synthesizable ENET XTOR components.
 *  Any configuration parameter that conflicts in this class takes precedence
 *  over equivalent SVT VIP configuration parameters.
 *  The svt_configuration::inst property specifies the full path to the
 *  synthesizable BFM module/interface instance in the synthesizable testbench that corresponds
 *  to this VIP instance.
 **/

class svt_uart_xtor_configuration extends svt_configuration;

  /** 
   * Reference to a specialization of the C++ svt_hw_platform class
   * that specifies the nature of the hardware platform
   * where the synthesizable portion of the VIP is executing.
   * 
   * If null (default), the hardware platform specified in the default C runtime descriptor.
   */
  chandle hw_platform = null;

  /** 
   * enable_receive_polling_frequency controls whether VIP should poll XTOR, checking whether
   * there are packets in XTOR receive buffer queue, those which can be retrieved from C side and sent back to SV. 
   */
  bit enable_receive_polling_frequency = 1;

  /** 
   * SVT VIP polls XTOR,checking whether packet is available or not.
   * receive_polling_frequency controls at which frequency VIP should poll XTOR
   * for packets.
   */
  int receive_polling_frequency = 5;

  /** This property enables scoreboard in XTOR environment. */

  bit enable_scoreboard;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new (string name = "svt_uart_xtor_configuration");

  // ***************************************************************************
  //   SVT shorthand macros
  // ***************************************************************************
  `svt_data_member_begin(svt_uart_xtor_configuration)
  `svt_data_member_end(svt_uart_xtor_configuration)

  // Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to);
  //----------------------------------------------------------------------------
endclass

// -----------------------------------------------------------------------------


function svt_uart_xtor_configuration::new(string name = "svt_uart_xtor_configuration");
  super.new(name);
endfunction: new


//vcs_vip_protect 
`protected
.3377,aHN0#=_<XOI)S=,BHEB../^&gUSK=gXBf2_G:[N;I/LR<N((e;Baed<5?E
F\=(Hg+d#-:_cIc7/S>1+SG3d[EB<[9>/YBcSS>4V]41[A;@WCGUTF]1V,>#3gEF
>:JZEfM7#0FLHE[+M7&^Pe<#>(e(_/8ecWYa;QFd);:&C\H&T;_E#,KB:1LJZ;QC
RI&F>WRL[bg_DC7/XTH^0fL:-H7Xe1=)N&TV]3<?Y?a-B-E1JLESP4VS>U3J+?Db
/+>_Z_X?&c#96;g0A-b?8]1=>+X+H92cScU39>]Pe_<-.TDZZ-F2g^YWb:K]g?KG
b)OM6_2=>&]Q?aLKc1A_U8:dTHb;F;74&:72W?OI[HIRPW^2:+:L1VDV&K^AW@9f
JWF696J[D@WN=JcfYWQ^cFZS_8>R_;SMg9>?5ER(;[>Qe_L(6f1OM0c;M]P_9KMP
_A+&Tg3BY)Z,X=A:_=G]:ZKdf+K)cO7H6@(O<CRUgCPST,2BX4F)<GD;.F,Of\a9
<M9@IB6O&C8e=a)N1Vc:11;YK4U^&//.,\AXd;LXfI2;T_+]=-B\F^JC7P)fd57C
<.I);+>SIT3>a[M\Df2FLU95?#73(;<?JLZ@K5=#B4f=9dHe?EOJAMJg/9[Z)N0;
?-#08HQ5?1(RE]bd05K4JFe.\PHFKQJ-/\[<XdL6OI(<7\Eb3?e\R)^2^=6b\c,2
F3QK#OXUEaCI\IFd-KM411_Q^@8)P6V[=5=R^g3DV\K3^g>^dVZX-a-[?/KT0=S-
/2IG7Wc@;\IU)R69I9R\J]_CJ,O.F2-72Db)90PV^\KaKOF5Qf@b0H<JdF5B0CF<
UdAJ#cE)UT[)GP\C5,E8T4-90HELd<I02_]c9<S8R=f^5^_9=8fKOV\bHEU>N)LL
O1OUM^\MP7<I3AI>.9#fa[&_Z:0SY9,KScC_P.P1258U.R-DHE^U;Z@:1<60(6-T
.ZGBJYF8S?MIgB7Hd>PB0QZNEUQaY3H9E4.#LbQff,Sbb<X\_?6R?7M/0+#TOQb7
V#5\Jc4D1#&RIf<a\##J,b,@D)3X_E.Q.E^U&))09gX>5:SL\g.R8ZY5HLfZ^?GN
7-F)SL:SE>20P9d#L,@Ig>;HAS66N\;M6.?S5bbP0Y;W83eNd8#4fS:G<2S2H^a4
Ye3b.SRP5MSRW8<W2\/;cfJJO((ZS@.Eea:I34^KSBALI5RM7,0DcN/=2I?WEd/A
17G]W-H,HVNVUSHE5OSa3MJJ4$
`endprotected

`endif // GUARD_SVT_UART_XTOR_CONFIGURATION_SV


