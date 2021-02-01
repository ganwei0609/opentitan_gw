//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_SV
`define GUARD_SVT_SEQUENCER_SV

/**
 Macro used to implement a sequencer for the supplied transaction.
 */
`define SVT_SEQUENCER_DECL(ITEM, CFG_TYPE) \
/** \
 * This class is Sequencer that provides stimulus for the \
 * #ITEM``_driver class. The #ITEM``_agent class is responsible \
 * for connecting this `SVT_XVM(sequencer) to the driver if the agent is configured as \
 * `SVT_XVM_UC(ACTIVE). \
 */ \
class ITEM``_sequencer extends svt_sequencer#(ITEM); \
 \
  /** @cond PRIVATE */ \
  /** Configuration object for this sequencer. */ \
  local CFG_TYPE cfg; \
  /** @endcond */ \
 \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_component_utils(ITEM``_sequencer) \
`else \
  `ovm_sequencer_utils(ITEM``_sequencer) \
`endif \
 \
  /** \
   * CONSTRUCTOR: Create a new agent instance \
   *  \
   * @param name The name of this instance.  Used to construct the hierarchy. \
   *  \
   * @param parent The component that contains this intance.  Used to construct \
   * the hierarchy. \
   */ \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
 \
  /** Build phase */ \
`ifdef SVT_UVM_TECHNOLOGY \
  extern virtual function void build_phase(uvm_phase phase); \
`else \
  extern virtual function void build(); \
`endif \
 \
  /** \
   * Updates the sequencer's configuration with data from the supplied object. \
   * NOTE: \
   * This operation is different than the reconfigure() methods for svt_driver and \
   * svt_monitor classes.  This method sets a reference to the original \
   * rather than making a copy. \
   */ \
  extern virtual function void reconfigure(svt_configuration cfg); \
 \
  /** \
   * Returns a reference of the sequencer's configuration object. \
   * NOTE: \
   * This operation is different than the get_cfg() methods for svt_driver and \
   * svt_monitor classes.  This method returns a reference to the configuration \
   * rather than a copy. \
   */ \
  extern virtual function void get_cfg(ref svt_configuration cfg); \
 \
endclass

/**
 * Base macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file,
 * and only if the client needs to provide a 'string' suite name. Clients should
 * normally use the SVT_SEQUENCER_IMP macro instead.
 */
`define SVT_SEQUENCER_IMP_BASE(ITEM, SUITE_STRING, CFG_TYPE) \
 function ITEM``_sequencer::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
   super.new(name, parent, SUITE_STRING); \
 endfunction: new \
 \
`ifdef SVT_UVM_TECHNOLOGY \
function void ITEM``_sequencer::build_phase(uvm_phase phase); \
  string method_name = "build_phase"; \
  super.build_phase(phase); \
`elsif SVT_OVM_TECHNOLOGY \
function void ITEM``_sequencer::build(); \
  string method_name = "build"; \
  super.build(); \
`endif \
  begin \
    if (cfg == null) begin \
      if (svt_config_object_db#(CFG_TYPE)::get(this, "", "cfg", cfg) && (cfg != null)) begin \
        /* If we got it from the config_db, then make a copy of it for use with the internally generated objects */ \
        if(!($cast(this.cfg, cfg.clone()))) begin \
          `svt_fatal(method_name, $sformatf("Failed when attempting to cast '%0s'", `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
        end \
      end else begin \
        `svt_fatal(method_name, $sformatf("'cfg' is null. An '%0s' object or derivative object must be set using the configuration infrastructure or via reconfigure.", \
                                       `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
      end \
    end \
  end \
endfunction \
 \
function void ITEM``_sequencer::reconfigure(svt_configuration cfg); \
  if (!$cast(this.cfg, cfg)) begin \
    `svt_error("reconfigure", "Failed attempting to assign 'cfg' argument to sequencer 'cfg' field."); \
  end \
endfunction \
 \
function void ITEM``_sequencer::get_cfg(ref svt_configuration cfg); \
  cfg = this.cfg; \
endfunction

/**
 * Macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file.
 */
`define SVT_SEQUENCER_IMP(ITEM, SUITE_NAME, CFG_TYPE) \
  `SVT_SEQUENCER_IMP_BASE(ITEM, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE_NAME), CFG_TYPE)

// =============================================================================
/**
 * This report catcher is provided to intercept and filter out the following message,
 * which is generated by UVM/OVM whenever a sequencer generates a sequence item and
 * exits but there is a subsequent put of a 'response' for the sequence.
 *
 *   "Dropping response for sequence <seq_id>, sequence not found.  Probable cause: sequence
 *    exited or has been killed"
 *
 * This message has resulted in a great deal of confusion on the part of SVT users, so
 * by default this message is removed for all svt_sequencer instances. It can be re-enabled
 * simply by setting the static data field, svt_configuration::enable_dropping_response_message,
 * to '1'. This will enable the message across all svt_sequencer instances.
 */
class svt_dropping_response_report_catcher extends svt_report_catcher;

  function new(string name="svt_dropping_response_report_catcher");
    super.new(name);
  endfunction

  function action_e catch();
    if (!svt_configuration::enable_dropping_response_message) begin
`ifdef SVT_UVM_TECHNOLOGY
      // NOTE: In UVM wildcard is '.*' and match is negative...
      if (!uvm_re_match("Dropping response for sequence .*, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`else
      // NOTE: In OVM wildcard is '*' and match is positive...
      if (ovm_is_match("Dropping response for sequence *, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`endif
        set_action(`SVT_XVM_UC(NO_ACTION));
      end
    end

    return THROW;
  endfunction

endclass: svt_dropping_response_report_catcher

// =============================================================================
/**
 * Base class for all SVT model sequencers. As functionality commonly needed for
 * sequencers for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
virtual class svt_sequencer #(type REQ=`SVT_XVM(sequence_item),
                              type RSP=REQ) extends `SVT_XVM(sequencer)#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequencer class then an objection will be raised when the
   * Run phase is started and dropped when the Run phase is ended.
   * It can be set explicitly or via a bit-type configuration entry on the
   * sequencer named "manage_objection".
   *
   * If the VIP or testbench provides an override value of '0' then this setting
   * will also be propagated to the contained svt_sequence sequences via the
   * configuration.
   */
  bit manage_objection = 1;

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif
   
  /** UVM/OVM report catcher used to filter the 'Dropping response...sequence not found' message. */
  static protected svt_dropping_response_report_catcher dropping_response_catcher;

//svt_vcs_lic_vip_protect
`protected
1B-UB4?b:8,.a#B@]aM-5?,Ag8e8BgX2IWNI0L=P=9D:M9D&W#g\((beR[[IG_1M
(1Z@c#A2\H8L+6-IV^.\Kc]ULEYJYW\=.6CO3/RY\D1?M<2PG1])96^:+#cXS@c&
e-NT<=3d&CQ5TX:/T,-C#8<YXc)VFRK.FQQ,/(E#R6YF.]099[WQL#.()Yd6@2a<
6-+4;b@2<8L3(@-GF+abCfe(g,K=].bQ_@W^S)BD@FO18VNEX,+b658[#?ONR;9+
(d;>VXa0gGDgFW/;3ga1[K(/?ZA&b7BI@=7,C-GcNP,,>_>5[bV=ALAR;5cA5;MJ
FO\IA1d:<a#:;2,>(:H+e(ZPU>20[?E-X<+0cCPSMb]Rc9KUP/=GKV-gQ;;FT.SF
BS\PYSWfDGIJ1[]05gSFXbQcQ;VO&f2XBM1.@9a@P.[/M@:GMLcea&GeefB&O^9D
b.Eg_<AO3:ZQP/<61D:c]YI#LT.DZ+?d<7Je90XD0AN,G@aNaKN0/,2)C0,a49XJ
CL.Y\g86KQYQT.GR[\-?4^)TUG6XWAf7&)9VH[?7B(c+<g<OTga(29V@6]X#EGLX
B?.9M#PZ89Y(ddaHK\(R.gK=-=F51A7BA?@f,06@bf_LU-Le><UZJ8e+^@^\S0BU
X>(L^E0R&g?=FQ2JT>F/]g9UALBJc.^CHDNR05&W-H2e\>Hb>TQcXNd6PeMMQdWJ
X(]#ZS1?Z0AO7IA@RIC[C;?OB[EJQ.F8dH]@-a).K>WW?e9(B6fW>W)KE?7E##FeT$
`endprotected


`protected
08N<:\e:4;>#U1R5&XcO&6S>K8)?,ZD:CV6-H6.6C\XU6_JcSE:L1)MZFT=TO:K?
Od>A1Z[I,PG:MF=^@:)JI0A_V?#P@V:Dg^J][.,+WW1T:.P)EFd_#(\=N/23QE2c
($
`endprotected


//svt_vcs_lic_vip_protect
`protected
]JSG_^P9//6)C>H.BL;B.3Q6d28SG9W7<+CMdVT/B-V2U05Rb8g;7(a5G>DGEWO1
)SR_H[75L+8e.YIS<6A)5KU\AP]0+W/<d[G\8?eJR[,F.O;TXJ/7F;E\F.]ZXfEJ
I=b5U9@F^>\<Wd=9<OQ57/?@bbUS_C,dVA&H.40Me\],)RD=ED<-(K:OXAJP>^)O
9U8ID5LdaC?#D/5K/^]:]_gfefVb<&8Xb</(]2SN2043><bD08<D44H8KG/4<7.9
B1/4J<61CR6B&dCVY\gIa6TLTA,R6/<eI7^=fcZ[>I0(PT(9@d_3e6NK=0=VQH;<
CHU&e5=JSDgL@gB0ZALEA7.>41.>5a)),I\EP>JDOMQP_/O:aWLcY>B.#Y-bL(c4
;KHEA8e2f2Uf<LW3H38A13bDf_K3FNKUfZ6NE01d>IR,G<S;A\8b//&H?[,?H;G(
<.>&?73QM[RbebS=5#Ac)0695VJf-)^#\6<C(17.DSeLNJ#PEK-T4I\9C.8X/6S+
009[CU)(ANFb-$
`endprotected


  /** Class name of the transaction that this channel is customized with */
  local string xact_type;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name = "");

  // ---------------------------------------------------------------------------
  /** Build phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

//svt_vcs_lic_vip_protect
`protected
e-2064d8CP>I+B[65I_JSA<\N\J@^JY9-W.V17]=_>T)cE>#f4XP-(OgIM/_R.G2
ICeYCWHW.C2/C_[HZeGO=;QUNHLdD>?I/B^+F/[83K89RN4W4bW/,22>U/AVWVCa
>#V9,.)HWb0KH@R&BGNg+EN1/^.A(CW\@GPBDZcJL499b^O_c2:VZQZPUN\Z(cV4
c:?Z<d=HH=X?9AS7#E<(=V95b\3f[IHbIedNQC=TN:T42Od7]]K2fF(6]HWJL3(f
3MI0]:(A&=P/RU)E5HV>I04LbS308_FC1^XI:f(K\.,\]L9]^NS)/B.U@CO+_@YX
6XID<ZC1HJ]O<gV]:^fX/53,NS]dJ&QMbKZ.3H:986@&\<,eC>S3_^_P9Z)3B1I3
3Z9Ve815NaYa2LI^d&f?aPIBY=-S1I;:;ecE>K:>_8=PJ[R;1S-a(^-Pd40_Q#Jg
OT>[8LeKdXcbX(Pb,;1-Va:f#Gf7T?&A,W4R.:^OY5bQ;X1W1dCc(>-PI$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
@4K-_3dB(41KO8Z?\M12[S#I@\UV:(,=JgQD2^Vc-g<JRVQ23cZF.)U@U):I&2e@
H=H3af&/#U/MD.aZfG3O;b=Cf5b;W([T8fec+#EW<EF;OEcYH^)/H-faO8OP,29)
ZQf.=2_[D_R#165\I-1C;<=C1$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Implementation of port method declared in the `SVT_XVM(seq_item_pull_imp) class.
   * This method is extended in order to write sequence items to FSDB.
   * 
   * @param t Sequence item supplied by this sequencer
   */
  extern virtual task get_next_item (output REQ t);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

endclass

// =============================================================================

`protected
TZI-F#.4c97X^1MFI,L.U:6g]<=C]bg/R;(@c\2=14?bV_<cPAac0)+30O.VaS?d
cLa<2[cPVDVPb]?I1]/JT):?<5E].D?=PV\.feHR78SLgT1JEW_[\\\?[55-KO:8
ZeCL\ddcNV,^HK>KeA2=<g<8:3b\cg--;<]0&UOScD/_DT#A_K5aM1(HJVPVZ4VQ
_0)bcFCQFB@NV.,^R7P]aDGC];E5C_A[5T13]LP38+O/YTEAW@YYL4H+d#A(49dI
X@^20dcWXe.;<c7^Z.G^DFITOGG,4W#[_R9d\E3:#NLTP+@ad6]]>Q^HZM;QMOWJ
B+f-UMGT5F-6eTXUP7X_I<6/fQ7=0>A2Z=<[5Pb2V#ZS+A]TYQ@KY]\fbA0&dDPM
Y/PI/\F4P_W((B#8cI[P_bgQc5g[Ae)07a^E\T0d;JHLL+f@ONe&>6=RM?F8b^_F
6/Af\Ag(@C#3H<L?G+WH.NPGT,?H[eN3/=8HEfEaPNHN2P^MJJcD(<fBO):>W#SH
5DNI:O>:FfQ,4/b(C-1C@)dRDIa6a#ECT\gEI#/5,+ZXHL4B6+,f82,1?RGXSLZZ
[+EXCcfHf^abBR]IR7:DOVZ+dU\ZN/6;0V2-F-.^WVGM/5\9)OA<;+bVeC#)B)5F
)Gg5:8ZP4QM.=[210-9#G6@[(JTQMG=g1&.4c2VH-;MV/V?g\.UN7E:\TIeR:;D)
K8+7EQL\)Te#+9W#P-[(Lb^/T4Q-/92#M)(>-ea7][@HV_D-RE?Z1I(@F4ZA9G7E
;&(LgCaKOPS72bM?+=?3>O\L+M=c,e\H\QIG-[H=:aML,ZBNe79b5/_^Ea]CXc\e
GFI@(d+,O/aSKdKKGfDBBRJcF1/>1A[VKQd^]W\;O2EQ1>Vc3745)BJYb0<LQf[<
:ZH^N2eAINIJf-0)]]4a^]FOSXM2&GQ+>L#A3YTHB,BbA1:_gdUAH+R&]2gPY:\3
KFLD[5;H,eOB(dB9;DU:J,Q.?;.c8f.#AN(&GeSL<R[)G)fcIf5\+F;4\M9TT6;.
,IAR1QOLJ:GFH?\2fKP/N/c?/^.;E6KFHAP(E_GaO7FAJY.Z297Z#H)e9_OBg60N
)fYNAA_4QLF,6C:1#@c?8cJ3;;O9TEK;7eH6#C\7S7,@D4BBF-+V?g:N?Gb>BP]a
<=?KV;D6Z^W;G4C7>_GO-SBfAJPc:E84;,N<H3SP.^LfZf8fZL;:GV0B;[<@Q,KC
K,/&ANYT?GMML6=VTA:W8/CaE7XUW+O_>6Sf9?:b;T+1d1?T-EW.#Sf7YHM+D[;d
A5LC8eI2(L=-\G)2X2a10B0NEPFSA(<aJ)OHM5aJ8RB?>d35N-K].2<,A3RMQ,RE
?<0HGO[:#1_9KH6.H4=]OgKY2?(2d-7RdF6QbaMYL49&?>e<HYf3,18U?3Y&0Ug(
-1\MSd:Q_Mf[(,cRR@6TLQ&bFX)>4@CI]D]C76_3::aQCc.N<@PSO[N756E,JbA(
/\]Mf^67Dc&3L^_@#_9F5JX1f[1^D,Q((g)0O43SU\@ga+=86&g&MJ7>>A>f@3PO
?]39T8-)UX)R6b_@d4E51M@C[.)L&f2#B]b@W0E38SIMRIGU[De>3bf?8]UW@5<C
TYV4P+M6PWFU9=8-]);:f(G2E<M7:1NW2[b@Y7G\YbLXH<^D(/;K]Nd0<:C.7gLN
6BDW2PDMge\d5@aK:0^XS8RZ?bFBL6-8KNDg&HOQX7&-NP=W>UR/XO2MYUY&MHH&
b3/DJR18HTD7N3^LWO<Cb6UbY]3#1:,X(47->]MA#I8OS&0ZAHc0?;2F>&.+V]\W
bC)JH3/CD)4Z6[@LRARRT7^JTf=d2E0AdW6QgX@;[e6WN&E.W6ZEP(ISM_g_/DXF
==2]=)08WQU\G#,c4)=\3-S+<//N,^.^150SQ^^;8J:KJD[)6R\^:BGLOLf?d(MN
ECCC(XaWS3,aM1Ua5,6TJce2FNHM]#7=WYa<E_4G]gF[c)CFF_/@.W2NcfL#)_d^
VQ4FG+2\UP;RdW<3+HL+SFDNcJW21.:G:#]W#DP+(AT,TCS&P(K[1[DC=gG)Zc7^
de-I,2MKfcR)7^D8^2:\#&9d65?;._a_[V1Q?gMO5c;dDUN@S>2X0bN@Y15D\RN5
H6MQ]_.#&_ePF^e=Q>)O<;+HAKN\C/cTQae(/R@?e[If6fC3;1-.R4<EcXce0dL8
>LE3ZF68UPcS:C[_b-)B#R@WOFWSeXac>c1]^\U2b0E^U=1.C)5U#I1BR1<b<]7b
-P19IOgQ??1[),TPHP)_BR9F0@G0a.>WH(M\[3[X-Ld+J_Mb;N+B\IgaZ(bD^bGR
[\dcfZc)He)6D1d93)H4T^/B7,\<23H,S;-+bHL-;fg_,\FPeMPRXV(cM]KDaEg)
NL.B=LO+K92/377ZJe9_F,[PeGK4/3,5AD05:WHUg<->]6PH)?_N;:@WU@1EF#(O
+Z8\-703;0=_IcCbP4VJ9A?CDf&XddLVXd6LICX(<SA1/2ZEDK,N<V4EP,BA\YR_
b(EX1?5\X4c,)91OU9+Qe?^T?O7-:J?VIH8O.Ze157#I/5F2gGDdT<4#V(FMPXL[
5V#b8)J-/YY3S@)Cg?3/eM&L9&?ZbHRP9;OO&0A/KfWXCefgOIgCI1/D]cJTIX<-
R\0(LWBUW#b_]]Qb4&^WZ0fJ\aRJ33L\FGg#8O/,dB<EL+WKQ91a0?E.NDTd7\HR
SOF06eW->N^dG9T-W(N[H=)NX1[Y?/<(R8QR,WMXYW5(&>8g4Je3f,>],1?GKJ/0
@87G\62dM&^OR1gfT.bd/J\_X;UF.9b_7;>,AKW/36ZKA(ID2LDJZ3/Z1@2SI78f
NSK&#BYKZRIGYg:8W&U0U1QUM&=7FLWMOfaf_R4)6/.:8KXGI499AfQGMBAQ[@d#
d4,R^M/HLcQ]^EJ-HL#>1-TA&K6D@KK8[G,bI7-X2.b&Uc#KO4+Y2U;AH86eQM9d
Sd:B#>KB\2C2,U8F70K>\&I8dV.>EDe)KZGN)&YI:159UL;<79PTgCCQK]>T2/B]
_@+D^9E[YG\NUC339]Y+:2X\Y4I2,Z.V8]JLB(Y=G;YZeQJ)C2#.[be\Z,_]RKMW
U2BNC+O.<@H-)J;/fL^Y#f?Wb?#Eb^H&(WE2F.>X2>:E+4eZ<e8(2,;P>IRXUB5C
,DM0(+NK63ONE0+2d-89]3c:&bIcO_Rc2[dZKB):D5f4(-#1;:@ZYKT@72#W9_;X
U//WMb^&a(TG+ed?N0,@,2#CS_?SPAL,8[c\/^gR=(B[e]I6M0T<b2B>U]R.)ZS-
I:YSBeJ;8EdWQ=/G]&E)06SQAPegB&I\WRc949XUeK/cWFgQA9<9cR&a4<J(Y\IJ
+[RJP7Z?3#K0RF]H(#4<;D[-UY5.:LO[fdOfJ&WZd52,4FKeR+bS::AW/Z+TRKe5
#AIA1f+M466J_UG:]<AaD,7_Ag&0>B&0fU9e?C(;?B=3:6FbFZR^TY])S,)84IS?
@7/[Za1I4D]N5#c7Q<6[P/D?8G-\U=GL[Ja6ZRB.,b@?+766?1\8bFA^[.XE1-#c
<BWFJCG4[B,IQ5WP0I#=_^?H>FCI-^P)]K(+U<IQXP&(/83&FJ.-PQ7-@\ad;M_A
<5EJX&X6,c<])ZGDGDE)K3S-+X/DI@Hc@##5J-Z838[A1^6b&6A+L.c+4:@(S@Y=
g=8+YQ0fEC@;LGISOI-5=eIBPLNOc4-)0B6HceD-I5WQWbb/FG7?W.^>/RL6X;CG
b?Q6[bKag5R[.VDJ1-LG+8/:DZQBZ:3)b@UIaRQW-1<TJ:5Sf[BVL:GJA_\4fF4G
K1C^5@1e@.RK4g-G,47D8/K,bd/U.WQE27S,L<=.Q//JS3GZS&Z(+>>P8aUY+V#?
.OaT8?\.-)>cf1-+SZF^L91Y&?5#W6Z,a;NM2-/Og4Fbb.cITD;=1\>1g4]82DVP
?5@)c&P1]Rf-C,7(.C/SG=B>fX74VWg-.3_^)B<=e_)eLdF)551.)(9KX\gdZ0O8
^RE/[gMLGb;gUXLLH58]faJa=I<^HW1M)3GU>Lg@?Hd_&O^dWfb[\KUAeAWFaB/^
M0>K>VKfQS@C_M^+,;;VB<ER_G@R7/aUJ70C-[PJ?\<AS6T43BI:a(VTMf_.TV;[
)>RDS[=0^+D9.fdXM;d3B/JWX(_<MWUK)]MOMV_+ZSBLF\dP8B,)79[c6<e-/aK5
03JQ4D/U/57bZ/(WN)Z\+a-_89.E>>Ye7c?Z6JJHM.Y2L6SN9+)\:^bB3=B<4^QW
?R[9N#)@=N3_fX58eYVeKS?==ELaUM\YM58Q2K6;[c,g-JS>H9J2+eX@BB>I<4e;
^W8T3?fKWSRMc>@(]E.??c&#K,&&:6d4AS,-Qd^a+JPbWdd.,6-WS:c]X_b>,306
_2RYX4S#81,<M-a_?cEB+3.6)H3d[H@2Q3Y)eI01&]0ZIPV/cZf@,gRL/UfMT]\P
WP.1MP4Ic1QSV^Ae]JBH,=Z-+M:QYaLV2\7TAB6E3?KUa9Cde7D.XFPeJ.3#>MEF
Ka8b7XbgFP^WE>G#/Oa+G&Td;L<Cf@O?A:9T?Md<Q7-Y._ELeR+Z)+1X)+4/_2RF
B=Pc+<L8J)Rd1DbQUE4gHH._VW:+M\\YC)c>NR6Ba@Z(I0BBVGEf8Z(1):bR679R
H7g;;]SDZXe>c9b#R@Bb=[)ET8BgUf-A]U<c3<><99^7FL&^G-BEF3>9CU_0_.F3
@f,]&[S[72^JLE=P7?,6,Q@bUOg:J=5N&bf\/5S:GA6COW9H],4?d\(/QE[bgY/e
GV;MKbN-QVQER\UQ<:2bS^?CL4e<f=IW:_[R^HCH;YS/=02O8I19PMg_NCH?g-B:
G8(67dfb.+ET0Z:7eD>;OK#X_INVJH,cfXKaIUHR#I3CC]M5O6WV_2D-U4Z#E&:0
=-XI]3E?R]0@F4==0BcZK_,Q(JPT2;FM?^);39F.cIZM4f1cT^4@G5FW05DTA\WI
#URe:UQZgP_XSB:7bUg9Y7@XCIdXdaPH<Ic[e6I?+E(;MS3d]-M(P@A],O43-3=1
XfbO9^-]2LOA&7Y6Vc?Q1B<<27/)IWSE0M+c/ca]/fB=Oe.N)Pa\<7/,_]5C[=[C
+R;6Q)[9VZ=cP9f/QH/e7bGeR02+/Od1^?>fC\V7)GYI08I2<B^H)Ac-PN53b>Z]
0151-P1@Q/KOL-b_JT<DZYQ]0L#R8/G<F1Zffe(WcIK\PG^&H6UWJfG3-1a1QT]W
EKa.aaPQ.F[A9W=P86@)DNAR3HG>Hd^47f?Qg4C]V]=WI+..^R6:)@P5CK<dg;32
.aM):7<9-L2U&-G>G=9\<faabDROURLHM9744<X^I<GZ)]T<9T2BU:]P>/Q>DL[G
Q)f#8e>faAH]QOTH5/HW1KGJSDg\f8[_YE5?EJ#g&ba=Af^DR65Q7DY8,<2G4#1c
c<&90Y6FYd7^F(d=fEQ&9Vfc(=_1Y,EZ.(I>R)NVP,7N<@CTCZYTG=+Y(HAT:4Cd
]<UXFIe?Q,8G0Q6/aSEJ[>=4Ff#&53_BdC?Sf/HQ0+/,<+db?#LHB?6CIPOI9KH0
&2^3dDY;TD4LR5.JL7\Ha-Y#.GPf86?KYE\dBWDO<\RS@2]8ES8L?9R42WcLMfQF
8A<[>Q,W2VeD2:G1R\ZZ4aCBOdSef)HSZL>[D;A.9I94N@ad9REEI)34;0cIOSA7
DfOg:DScMF?=WIE:Z[@<2d;Z]MH./R_2AC+(a\[^C>1-ZC/I^)>4/c0162JY6TM_
&F_DaVQ&;C9<71)K40QZS<R9O_R5>@@1&S>1aNd=78=+gFR#&:1UWI&bQPT6>bXF
PIZR&2[NQ(.WQ[Y,c=BY_;U)JJHYBG7ceEZV=+a&R3\\Ic+ERL6c<A7A<MHJ\Igc
4fHNQL[GfI#1PLV]&^((P2;&Eg=D@;N:Z#<LSL0JRJ/C94\6536dTN##K34)-/HK
W)T>5.PAW>c6T@T@-c556,PXHd+Rg;Rd8AW[aCd=V#E3Y+/:Tfcf#@>Q_d:8G.B8
[V=UKUC-eAV?F3YLVF.D&79S&-g=7V]f=PU5P;+7R_#4caa8,?_/_6cY+LVW#aHP
R-;XPgB)FJ^>56aOB3-9Zf3PK<VC5C3^Pc_2P+5#,-_MeTNRQ8ESbZF3=?9N2F8+
5;[beeX&6EL[QeK:=,dU\Dc+b;-\P.b:(PQcaR8QEE.GPH[0d&XC-TTbB\)c0)=:
NFL68f>;T5dJ72P7L7-Ua49^;9C4dIS527YaCe5;cNFe6,A7f=H_1bW[T@e1NYN4
JP.UED\SeB7N_]?G@ZEVXZB,bYFNcP]395gQC[4X5]2LQ,<Q[JSFN-gDATESL]3(
0IeYI&1W23M0-+?8eIEV2IaG/Mcg9<VX/^FQM=[M504@614Sc?PU8E=MV,X[LE;g
EL>SQH(]c0cb?W];BC?c?Q()Edf^1P;OX+,+5R&/bE^7WCKIJ(#LO45M((X9GU2c
[;CIe]?)B52-Ef?b2QJD2E]O/1Q2g>U\F_8W+f;.OaK[;/@=cf,W:H.@S5RT#J#)
40[<UNcCK49-V//S4Zb65D#8&fdK:D.e<CG0a>J<CO)#P,K1Z^gf8d8;B\GZ-5LT
c3:fLPI/.Q,#U=9.A\7HRc]E#N8gDQVK]M0#2Bd1V3-KV807_;GOe6D.[5<GgbGM
8dK&U7f4Z^Z6KAaZE2(c/^]+fZ2)+88<d\d+G509EH;ebNOH\C]E^&/)H=>+4FSJ
]fE=-:Pb9OV2E]DA5E&5AUa&Ic(e(?2E^gO6HI/P>QW^\M;CZX+QcSd&0D8;eFIO
cM=,FBM#/<J4#+.@MHGR?Z7)2IYR/VS,eXXKMN;e-ENPR)ZG<^NG#80\;Q8JDWE&
e-0dJb+#?+V0/AO[F1/3<5=Fa_>VE?]>(?(N;BZ1dIV2_a33H^>IETC?)#)KKK<0
<\JN[RCT>J)g0JOWe].H>a<Y@cKgO?58QDVD1MaN5+YI;;BfT>YE;eY&fNBC+I/_
B^USTc,O0aS1_L3Ib47Pdd\EO4-.G(0(OA&aY3@6^>VDSH:2+C?<e4D>bV@2=4&8
99F9PU?dR.2^_Ab&.)B]700]7O6L+,00MC,f=&W3>]&6)^IO-WM>ALe#;?2cTI:K
Zf4#e?#139g3]SF3fNE^NH4LfUWS?NAE&9]:&D.[>dMP5@5&/#]fJ47FWfFb#LJT
EZU0ff@<+,_3XPB&b0=0(QHaOEFfH?,BY5BfgDa@C_0c+A\.BaU<Y.55_IHd060-
c)D:E8c@7G;W2fQT[[611;&OI1+N^G<]-b?g66geDLM3B(^:T8fZGKf;\)+GXZ;8
NS1>A-^HVg+R?=b3\A<;1&&DV7/dM9Va9MQ[\8Z1-E]#\FJJ(11T]bM1fC1ScePR
&RQ/@#Q;Z44HIcI2)]?[1Q-RR<B9Y8Nb6,CKZK&(/.5.RRV<)>8T9Xg4?&P<=7HW
e;O81O<Q/a.5c[I7UgJcRDc.:gc1B;N:TUAU^3-f6D7NNCYMN5KU&?:_RE]M7J<E
K.+>CD1cTVDI<e;=ec>A@&^EJbCW<UQ6(P)6)6&eRcZL@1Q)F/&0&3\E/dU@YeU<
//1RX3;>CNA131VaH=b&VY)+4_G4VC^@ZY;X3,cJJQcX_=S/NXY?2PS:IA(/WW]O
WGI.dL2,/Oc[@fD(UG>Q7M]bMRNS#>_TB.==NIC2G=/d-;Y87OANFT1-]IP8G1_3
UYb]dL5>G^G(2#^_HLeFH[P@]2NF\.4Db+FSB#>)gE?DZ8ZBJC&YF4Z[G+,]ZNg1
413UI]8PaA^Z8]cIUGIa6TSMR\XN_aJD.Va<0#\\676<6L6V)LZU0&J@_?ABAeGO
e52C\6@F6K^S20=.@D9#U0_<?H>/#:FK)I,TWD12\I..#)ZI=fbSH9Z(I46O_>\9
6RcLdZ&AL6M08-YI9+c5<BA.^#8[]-0LP:FW@33HE)g]SNc<L]3AM_NWK,e3#>I=
bA/3RL;RC8SK#cID<bOSfQc1-Vc=eBVXR(dVE\9bN72]X=_&4e&[QJe[F,5Q76bA
[Z:4]4HD(<HOAMMKKDY8.\5KYdR@]T#GEeLCNP(&gWSC[dYM+O4,A0@cBG>>ZYf.
B8@4V8F<[a4Sg&GYHZ6]W7/M3=UE<@,e@/PTBL^DPWNdK;;\:?7,L^K1M#OPIZVe
+3F\U=4&LfR_IB_^-EZ7,>Ua=V+^X3Y@\aDZV=4Q9=(IXB7LDgD7Gc;E8H]d+S)R
@SK7Q#0UK^>Q03,>JAE7V#9?7B;GQaRP3(U?c5G_M^7cR]f@P\R,<X3#PX>/g//O
C=[EG:J_dU\D#/3Y5189=T49IG^C65XOBM:V7#eaA.Y;IIWVbU2S9Q[L1-[WBR])
a\7fQ<Xb:@;Y9c:?RG2F[NCDT(8N#)T0:?/JOT8U)Ee6E<(3/KbK/DTH40LKG.P=
>GF]a#@cB08_(UB:;4c_gM20DMHDF;8^5CRF^B-gJTMBRT&a\5f^[/Q/<_)X@QJQ
_;@VO3@5LU>d.C;N_OX1XXbTI=.4a^JRBT5R#eW#-A(ZT6F-&->4E#8YC7Cc,-dI
E+4D-.OJ_<[:BEf\(3Ag0S^N35/L-NA6>9ddP.>1AEL16Q63ZM:.-^TC/1Z.4:FV
\)FCN#bfVbJ[4Y(K?6,[fB7[8b/5M]2U&4G^>7G/ED4Wd(0N8@(Lc7M9Gf2T3KRC
1#-K-5J42B\^f/Bc=F+>^+3gXcJMLOdG=4\C[Cc[/AOAEMD?NP+g[f-WO=>9cK>-
,0RX&&/V2/]3O\JP>1;[Qa1H_e#,AZ#C5S,FU[-8C?-O\@MFKKBe@LeZ;Zc2SG-#
OII[3a(\)61(A&&Y,/ZOVVP;FZB;C-M#b)>(?Q#bd^QXUa+:K,W5>YC0MfK^TEAS
]fV8<1LT#WF[fRDHD9^2#^&Y<3cG>8Z3^/]O<A3If_\8\1.=.84dYNLW;I0\QWW;
F(F;)8cM>;4#F/92B@.J[&FV,89aKCBV8eEW(TcbgE)CTF\]@)EKV/;H6W?.aGW9
Y4ZN^DM.E28E8E2(Gd[J+AHRYRC>D.<F+P4e?UT(7,;=8WR&-;VCL/<HK?\.K0Y8
&_RCSB;Ne2cO[^cTDHC^G<0K2.?<Z=)OeTK0&\P>9Bb:A6RINC&&J9ONfOf?YV]U
U8OW2,>^)&cCO^U^SEdEaL_;Ya2aHG<=/?(9NJ<Cf,=US+b]RW/AH8OL?Y:I[Gc2
C\7A&L/@N-&\@F3Z^eDPeJ+HGN=c>bQIZE-D6b1=+9#S:VTb@VB+-Jb(=M9VB^&^
+S;N_PWMLf;@1=MWL83ZfB:+[K)9E]SEJ[+:.9XWNH16MJE2bED(9LDbWM3f]3B&
/(C+(g\K(H(Z.d_YESUI8,+;/R)Y[.S:74)<U28IcG+U^fR7gUJ:2JA[W4J7AK.C
P0XVZIWVRW@TGNDb-3HZV&Y=WQ.ILBE7#G9[M?5bU0O,Q][8]QV<LQG0c7-UQ&E_
KERf43<T]F@A)IH-]0L&>0-6LS1S0,+)#1:E4dAS;=XdEY8_)D#=1LCcS9SIJH-Y
ES_7_P?EOa96GQgJbffg198e@>V&^FFYQI?b+VS.MF0=aJ>T:LL)\D/O:=#b;V,d
RfI:fBGH5d^UZ#02aONZOXQ\a:=OI^g4e(,^?KUQf-5#89@R)OMf3-#dWL:U.]LU
J]XKPIS@S7R_,5S84b.5I1S2BT53+\Dg&Q=D[L^E)XK<&<:1gH2:^R)/(04(^D]g
_B5&-TbE>8;8P-53PFV#7IK[X(9Ya#S/(0OT8Rb#N+Ne/gOV6+2+DT_Kf50a68(3
f[=J4<PEBGa&54E.(EW[#5L2DWQfX/N>-3[&dO]HMY7T5LdC-ZZ)-P)Y2O_SBLc>
1N[D0>XN+TFTdF8R#ZFIOO4eRY1=1<?/PZWTCZ0OZS(?Q5)TLX?)g(@N;@WeHHMS
S9HV.NV@H8(US3cK>6NL#ONJ\eHQD5UTLSaV)>,1a;S,@3Q9.-dN6&P.7PPYXC5/
-<QIK9]>F9J4#Z)eL]+?6QEY+W^GM9_g_0+bVaYJCb2GaY389II_cd7^IPCea1X,
10A(@/g,GP^]V[RbcR.Pd4M@ET6RPBg_8/>aAJ9<5MS?7J>ZeH\B(#,cSGFKNf#F
HF3d)UW9b3/G2..HVC3:PH])NLfYQ_H>ZJX/\HcMNd(AB9;-(L7R6V[J9[/CbJOX
^a&H@6>>Lg,HM-6PW(P>OP^J^,fY;E&C+4=Y#9N)-1[7Se]^(C,//IHQ0&0.FV8T
YTeF3-N7(AM-0MBT)=cH<6M9-U&:f1I6bc<K8MO_JVgG61VcH,FT)f]PK4_cEL/[
.0.06#:_Vg@-De?5a8WH>1YI)49RU&U]RZ/M/A2JM9[JX9A-10S2S(cZ;@Q]6C#]
Q:\9AKf_U<8(6DFPJ>BOXZf(WI)b,0F8#P@WA)_QOD>,AdT\B=;eBcaBC@Z3-Ea\
>PcCLN59dMX:V/4;K__f).0g-W;#H-071S?+)BQ;.S)T^+Y+7RAS^69=eZCH9f&:
80PF<02aPIa:*$
`endprotected


//svt_vcs_lic_vip_protect
`protected
D&3)5]HH1WA87LUAE#a5?f1A^[I;VAP=2K6C\7b[Y2ed+DFB&U91-(>T7;6MDH3W
<\9cPRA;C:60B&_6I9L28[We;R>+/-VWHC3HUAM-gb]?_I(Uc+8+9P[F/^+d#:4B
7REK5XEAX2Y31U>Ob?7[IFVVG5LQJ14+[fI-BT]1C=gfbaK_V?\g#2KeW@PW+a+&
0a#8bb_8>CKHO)YTCK;4[9XZ+@#.IWN,<42g2/^WL;VBBM(aW9LO^D2BS6V)T2R>
eT<]PJc>-]D/-cY.3BR_#WdA(bV8#?4cXHL,36:,/MN67UKc1SY:2NcRUR4.)2e:
O0Gf@-FU4,A9PfG^QX8&\\D#:/C\6,A3;8,6b@(@4Uc15)6>@&4bd00[T.(8L=PE
F#J;<O(Z]V^T0.c?Y0cYgRTEK2/d/OKf\3_6.dZc?E]RI/-RO=dPHRO(bcb0LZH6
ANASYA-HE7PK\Z+(LW=0JD(3\4T,D53beJb1Zb<cWfBMX=62[Q<Wb]7US&S:Ld()
a/SO[&SYU/8XE<c/cQc1QERUZK-Ea6b?PWVWUCSObb_]S=e,8-8YP0QF?,>W5^fY
d9d@W\/1+ZX_)9^;+OLZU8T>KB30=f/6ZA?1B(feAX3,e1Ve:^MJ(]8E/?SEfSSK
PfLW.cUfOWcNGJ7+EMUDA?7#_8-@[FfW:N,TbQP<X/\V>ePLX,Dfc&G[[;PUK@J6
T,E\cc6;4FOXPKSI#_;<b#?)VT?f;b5B-1F1T#]VD/-Bg52D?R@U8D?TEWef^&0f
CHfEJ#e,QJLa,6(>A()0#f;JI/eO@^&CY>&FYTbVbNW:TP\ESV<He7G^cP)-H0Dd
U/Fg3Va;d2?/eCCJV@X7]Yc8W?d&0Oba<_bRK8R(F.V?cJJ5M>9X[M_GHY3FbGE.
WL/2Z0?]N5BYbK3=b3<&Q>-QEP>8/2\@G?PdIT&?9<W5E7?M8,gD81R_/^MD:,;7
F^A[N^[_4ZBGYK;V;c0a.J#G5LSC7Q,E-J[?4IZg34,:6WR41d.&0>48T=7)LLc_
#BT^F[LRPO8BHF1dH:SOLe-&3#L4>]fW^f8Bg<40,(:.USF6AGeCNM^QgN+C2_/^
C@&c+V2?a+XB>e@a4PL:F0?:(.O=EG.8J^U/AaIC1A<G:SR6L]L0A8A(DcP+88g4
96L/5KIbg;fL#I[@,&cLNV)SDP[+F-+>^?3]11ZN4cJW#0g)_\QK/A>Y44+VZ#K;
>A/?W7d:&89/&+Pd#;AXR/g\D.F_J.+^g,f]0-S]0Jc5.:L&D9YC:L\RH8X+P51c
G=7:ggUX.W4]IN6E@ef2@c\2\:J9^]?Z2N-b_=&:JQD/D1?L&&1Tc?0AFP?Yf3D^
0P#U/)>.X3_]US,F)ZJ#[?QAcXZB9_1@-,GSf2;ZUN]5b@3_bJ,aG.+LM(RU3?\&
/V1d47\cN:3THQCJMdV+--Z3F#FcZ@R8NRY/Ra)e?f;^K(]<#\6BIRN\SXZK21=/
5/^Ag^X]^PGaYT858OJ:X4DPE.g>OeRc4XM_04L.0?3FL1)0(9;Y&@aNI;1REDM#
de^b1+N(XVTD54=P4O]KHP(g4If=?7Ke#&9]8Q(^Q1\g-CT\<RF.6LF&I@dU\fF>
_+OGG#1GL.WLbB5U]2G70C)()3b(A\3D;STeg-L=f[IJ^cA_=J5e3QL;H59R>eJ<
CY,IdC0X()@>d]A[B(2N,-Ld247[ce<e=/K6Qf9:[O5cg9O0?D9F4:7WFM(BU?NQ
6X=&1#S7f1IgbPZGNG0-fUG0J.eVRLE[?@_a;L-9]B\YIQ66dN/HAK>T,03<W3N=
6+-Hg9,WH3II#&^g#D>9T(]5&L9IW=T]5A;GR:\,dU>ROF5bVK[FQVHX>DEWDd\=
[\fAXd^RPaBOWM]]e&3=Sd.&F\IH[9>GT@W3UT+cDS,3)JY2+a@gTA+g[?1?6WV3
DQZ=.(R0V\/G5DEKZ7#-R4^H2<7:34COPYBJU?@O3W^[)c:SPCL0BY6FE9XRLJQc
AB\J8(;73AcbSMZXG>IA(N1bf@C3W7]gA[[75:@c0e\XL()^/KI61:TO)=LLSK5S
cK7.H84.Qb#6SYIW=?0#13f^D_6&E]9T.H)?LcUVb2gAZfQA6LI]C75B1?>U)&3K
a<,VXQUdEE2P889)J418[@&4F7ZT@b,LEMU/D1BTV&I[f@e83@<dY+/>P&fLQ4XM
-<VIML>E@ULM7\fITXccV[/b@7>O#74<3@beO/f80]c?KW\-.:I)KE7;3Sf?C&:g
CcNbCNUCBB7<d,H1-,R8;GQ26)K::&g_ZMcK/WYH?0PXdbe0SJE^]+TA6]^.;AM,
U1DR]Bd+M:@K+?b8LE(:Y_]4E_PZC7N<H1/5,-..?eR5L\+6OXTXUKJ<.RPD-+;\
BJ#d(d#4JY^&]=5U5A+QL(QcG[@\d7aCaOI)\FRO&RM&,8Mfa[>:05KU4BOd4?1[
K_IB>?^T(W2Q-bEde.Z=eH)Q7QC;@[A#C4)O2TRYg,A__,=)c,CZJ)A2RA2.MPFH
bbA5V@KMf3bP&]8?c=HXS1QC.=N5.3V7WWML\>9JVegGPL3(O^AYGH]KDZ5)ILZ4
Z(1F-]@C,GO]&=NR)G;/?G\F0=(9\^.d#NEdN@N_dNY5aYQ>_(c1DEJ;bGXWEP<:
FGgVe?8;4P5F]Pa;VFFPD3gS-ZgKN2AC?JX1&/GL(MQA5V02=Z;Q_#aCFfI\_9_4
-8[>[9>/P6He;X/a7c<5d\QX^WFDW)V^6G:_0P-BY<B;-F+Oc:fQG?f=A&CKZE(7
:ZC<6J++69_Sb(:7,d)5#1ZPeI9O+XR^W@JO3,<HG0I8Q]0@O=9-8PLa//SQW6D(
HA3NA,M>COLNC@<TZ-d:#1)e\bV-XR+W#acWfP5WIX.ST#a/eJP>3[9dY@aG^I,[
9S1YK[X8;3R[df8EA.CeAA>NJ>4UKcP^:+S99aW\E[N7K;S58?.#94(U2X(RD:=?
+64+c]5Bc\LBSbB4)]=Se=L8>a9G<Hdb@4[6G?QO4D(UR@ZQ<C6.BDG.OMEXV0-K
bZ&NHfL+2/_S=e9,K\(PgEQV,79SSS81UcZ7#)ST_\6>.[;b]X0PLJA9>dg<G/3c
Bdc@29R:@1(K_#3QG927\XNYI^NB(0Oc#/Rb:/3W(aMSa6C]b4gDWIMQ5CO3gH-^
>?TOgbOE?L12aW/P4@Pa5+US-IFG>A/Ab>C56[=6X@[F08Y@CD@U0<_9Mc+Y/LE.
JCYO/-S1aU&L[g0A;[VOHII>95c:#MA.#46Wb]&ZL7KA;92)dZ9&_cE]@\+7SIPG
9I,[CfD1N-)46M??;T&1/Z?bNXZY1BZaUK.OG+;TIJ:GO4XB8@NEf[g?+Q5N?SO)
NFcWKOf5a_R21&&<IYI\U@/AD:<^a9f_g,)]5#P4?2[c2K(02:=HOg\/2g.&5XTB
Vg&96CCM@[T[g5NNfQ6e9X5L6.MHg&[Zd?].^X,7SLa?PgVC(Y^Kc;F0#L[.?ge)
^CI+>UEN-ZJXa(bR^<+>?DW+\+VQ4MB5N^a.7eLOHW<UdgCVR_bKDe28_EYO(+@C
2>TAQ]\1Qb<)@1-Ug>BeJ1e5VPXT^QW<6d)Y@W6;5QB_@HDK&D88G/PTN&_T1:\\
@Af24DTY@<V,PNRZJ@[+PP,K4GODSb\49&dI)FV#QME=VB<3\:<>X<\@agWM3;LY
=F^?@D&WZBdHLQ_FD^F8BW4\&P42=RMS>I(X0GUKY,Y4&:.[753KW?]:-R1XBIVH
=(O:AAX;Db_&/Ja16V66DDIeaN3/9F(W;5bGQ\3Pc5+/AdHKCQ_DAG@<dI4&a04/
\=4,eY]V:dADE4\23SJc;]Y+=4F>3d2/NUEe^OVE_5Q9dC<#A\/\FRNc0D^_CMX1
9I7Z\,eNQf&^]A8fR8g&\+N5OPC<\Z@RL=YS;Y75:bd8?agSPHT7X_670D4;21GB
3R-;,OV5U&>KGb1=O@O>OLWW#=/-?59\U8]C),f+XWX_0UBM1^]K&/YBZNfP8G0_
)U,dA6Fgg=7ZL=MBJ?3;UOJS::4JFB&9VG_)(^<c91=^A>N5+2K93_^RLGYB^I2^
V6/0ZeECC+0^U[-Hf>XHN-]9O+c6Qf9\(_JFa2^+6.\8_IVNR;Z6a3TN5.2\6QTI
II:^Vd4d?KSS7)c)R;ZWRRD?8FKA3O0,SD[W?GZWO>>c[4#S&LG\8QSP#6,GUOA)
N9AgZ[IcW(+:[:D9A#GI=DIM#aLE5_3>3AF[NX@XA+;6E3b5DKO&GMCeO_&[8W0+
=HYaS_Qf3?<4IZ\(Xd>O[5[.S@O1cL/bf[\^N=7IE-U.UdQ<C-5dT)P_LP9#EFH+
ES5XSQL<X++f+3CLcR+P?:.:8g:+FRJZX+KAB^7@Z[e]ZJ-S_].39P1N-4b-LQeD
WYE7,<7fRf>3^TK^(EK@8X(=^&RN]>NW+.K/VbN.Uf=-D)/&_ePASNE&/D0X2)O<
,(JQ<LF,a@<S\3Z_J:Z^40\-47EBF7WNMfAFP+UBd]OH9E(2eSO-HeG&&NfC#H?b
XJKI\E/MS>=DB0dV@gQWg:KSWJeP;6N7CL#B72IU/HX:+Y5Gfb:G(NYe5Z1H7?PB
,93T_\)UMaRgQe>W_=I.C;BT)\/YL]NcN\6(YWO)?IcGScO2I:+XJZT1L,A,WNS2
S)L2LeJ.I?:W/[fQgXg,;Id<B)2;MG[.O\PH9fVeaeS+P40Tc]>f&VF7JZENQ#<V
X:87WANBWSL[)[]0<OGJg=AdU]]gc^G-NQ=bL;JaVb2U(WK#_2:VHG9<)Z-4G9TN
^+K=N^L1EPdHN4g>cT8-5&]30,;dR]WQOR)db4G=RDYH),NgPX):;Q^dZFTZ>CeJ
aeU3H)Y>3MD[.DA[)#OS6-RcJ(\GXeP0L1f0<KU2G8R=6EW^/94PCK6D))dQB#T>
B/Lc&FCfF93(7cbV..5[([<XbDKD@9_(2e0.7Gb9H)gN;P1-N.DO>5J@9M,EL,OJ
?#DW5J?&ZC)3J2A1Ha1gRf[U@<KC.+E<Ea78T_?IO-Jc\7<f.Xe7_?.81U&E2BgO
)0<T#UF+Q./Xe<?A]OFJ(ZCC9g&&U\>E#,,bR3VS?&^V@D:Pf&b6FI#dT71[NcRH
Qa\V)AS<])]Z(UQ=;Z03[+BTB^#D)bK?eSI1U+H&X;4_Te3D^+6HLT,g+GTF&;@Q
dNUgYEf+(a_P?85a5[(.H(^91G<V-\/421.b:#S8:C[S)b>.-R?FJSS9Z>B@4^8D
?7?aD,1/Ia__3)Y1AAdWH-REe-3+gc:61#-d?<I+CU>Z<XK3gZI#_,\ZU^19(Cd.
5W.f.Y1<M_F-@eTSWG.Y.?-72beFR;IF(A#[AY3Se(+6BgWX:YJO0V)UEJb.+<;A
d?C[3VcW2ZW5aR>:@,IbIEXd)WM=[-b7P-T-:PCS?1[AQBAL-2.g98YEVBFJLDCL
Y8SO8^Fad]0E2/LG;a790:=Td@Y/3&.#,V,#:[bcJ&40]bRVQ@>M_/-b+XQV3QGb
B348B1@S==R5I6FKce4I&QX<<Q^aS[):HBF:CSS](\:2G,N):WcLE8+924-NS,T6
<g?O((KA2A2W=c+9J:RMKCJc3IH(f=<+[UU4ET)Rf4fG]N<A-6gC?[TN]D7^Y(BK
4IcT&&0OEA\,C+#_&NYK^U#=N)(I51gO4U?W_D9^+dbZI=G3=#<d:2V_bT0b=bQ\
)IA:UA#P:]7T_,D8;fX<#[EA^&TXObT>+V.A(C0e=g_=8AK2YT7J]QS]Sf?WMDDA
M]6a/\::&Tf7VOG+_]PU\EHXSUQK3DIf@NPcN/)acF)0Ka93&Vbf#B0c6@PNL[WQ
ZMMJY^9N+D7VCB723+_A5VdSRRI0VDL.YK,J0b7UcRf=f6bcE_W6==:IE01J-GD[Q$
`endprotected


`endif // GUARD_SVT_SEQUENCER_SV
