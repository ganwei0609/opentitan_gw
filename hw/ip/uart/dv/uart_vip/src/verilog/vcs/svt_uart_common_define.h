/** @cond PRIVATE */
//Define for SVT
`ifndef NVS
 `ifdef SVT_UART 
  `define NVS  "svt_" 
 `else
  `define NVS  "nvs_"
 `endif
`endif
//Define for SVT
`ifndef NVS_LIB_GEN_H
 `ifdef SVT_UART 
  `define NVS_LIB_GEN_H  "svt_lib_gen.h" 
 `else
  `define NVS_LIB_GEN_H  "nvs_lib_gen.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_LIB_GEN_HP
 `ifdef SVT_UART 
  `define NVS_LIB_GEN_HP  "svt_lib_gen.hp" 
 `else
  `define NVS_LIB_GEN_HP  "nvs_lib_gen.hp"
 `endif
`endif

`ifndef NVS_MACROS_H
 `ifdef SVT_UART 
  `define NVS_MACROS_H  "svt_uart_macros.svh" 
 `else
  `define NVS_MACROS_H  "novm_uv_macros.svh"
 `endif
`endif

`ifndef NVS_OBJECT_CONTAINER_SV
 `ifdef SVT_UART 
  `define NVS_OBJECT_CONTAINER_SV  "svt_uart_object_conainer.sv" 
 `else
  `define NVS_OBJECT_CONTAINER_SV  "novm_uv_object_conainer.sv"
 `endif
`endif


//Define for SVT
`ifndef NVS_LIB_GEN_VIH
 `ifdef SVT_UART 
  `define NVS_LIB_GEN_VIH  "svt_lib_gen.vih" 
 `else
  `define NVS_LIB_GEN_VIH  "nvs_lib_gen.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_LIB_GEN_VIHP
 `ifdef SVT_UART 
  `define NVS_LIB_GEN_VIHP  "svt_lib_gen.vihp" 
 `else
  `define NVS_LIB_GEN_VIHP  "nvs_lib_gen.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BASIC_INBOUND_TEST_V
 `ifdef SVT_UART 
  `define NVS_UV_BASIC_INBOUND_TEST_V  "svt_uart_basic_inbound_test.v" 
 `else
  `define NVS_UV_BASIC_INBOUND_TEST_V  "nvs_uv_basic_inbound_test.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BASIC_INBOUND_TEST_VP
 `ifdef SVT_UART 
  `define NVS_UV_BASIC_INBOUND_TEST_VP  "svt_uart_basic_inbound_test.vp" 
 `else
  `define NVS_UV_BASIC_INBOUND_TEST_VP  "nvs_uv_basic_inbound_test.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BASIC_TEST_V
 `ifdef SVT_UART 
  `define NVS_UV_BASIC_TEST_V  "svt_uart_basic_test.v" 
 `else
  `define NVS_UV_BASIC_TEST_V  "nvs_uv_basic_test.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BASIC_TEST_VP
 `ifdef SVT_UART 
  `define NVS_UV_BASIC_TEST_VP  "svt_uart_basic_test.vp" 
 `else
  `define NVS_UV_BASIC_TEST_VP  "nvs_uv_basic_test.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_BFM_DEFINE_H  "svt_uart_bfm_define.h" 
 `else
  `define NVS_UV_BFM_DEFINE_H  "nvs_uv_bfm_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_BFM_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_bfm_define) 
 `else
  `define NVS_UV_BFM_DEFINE_HP  "nvs_uv_bfm_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_GLOBAL_VAR_VIH
 `ifdef SVT_UART 
  `define NVS_UV_BFM_GLOBAL_VAR_VIH  "svt_uart_bfm_global_var.vih" 
 `else
  `define NVS_UV_BFM_GLOBAL_VAR_VIH  "nvs_uv_bfm_global_var.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_GLOBAL_VAR_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_BFM_GLOBAL_VAR_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_bfm_global_var) 
 `else
  `define NVS_UV_BFM_GLOBAL_VAR_VIHP  "nvs_uv_bfm_global_var.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_LIC_VIH
 `ifdef SVT_UART 
  `define NVS_UV_BFM_LIC_VIH  "svt_uart_bfm_lic.vih" 
 `else
  `define NVS_UV_BFM_LIC_VIH  "nvs_uv_bfm_lic.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_LIC_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_BFM_LIC_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_bfm_lic) 
 `else
  `define NVS_UV_BFM_LIC_VIHP  "nvs_uv_bfm_lic.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_V
 `ifdef SVT_UART 
  `define NVS_UV_BFM_V  "svt_uart_bfm.v" 
 `else
  `define NVS_UV_BFM_V  "nvs_uv_bfm.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_VERI_AGENT_SV
 `ifdef SVT_UART 
  `define NVS_UV_BFM_VERI_AGENT_SV  "svt_uart_bfm_veri_agent.sv" 
 `else
  `define NVS_UV_BFM_VERI_AGENT_SV  "nvs_uv_bfm_veri_agent.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BFM_VP
 `ifdef SVT_UART 
   `define NVS_UV_BFM_VP  `NVS_SOURCE_MAP_SUITE_MODULE_V(uart_svt,latest,svt_uart_bfm) 
 `else
  `define NVS_UV_BFM_VP  "nvs_uv_bfm.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_BMON_VERI_AGENT_SV
 `ifdef SVT_UART 
  `define NVS_UV_BMON_VERI_AGENT_SV  "svt_uart_bmon_veri_agent.sv" 
 `else
  `define NVS_UV_BMON_VERI_AGENT_SV  "nvs_uv_bmon_veri_agent.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHECKER_V
 `ifdef SVT_UART 
  `define NVS_UV_CHECKER_V  "svt_uart_checker.v" 
 `else
  `define NVS_UV_CHECKER_V  "nvs_uv_checker.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHECKER_VP
 `ifdef SVT_UART 
   `define NVS_UV_CHECKER_VP  `NVS_SOURCE_MAP_SUITE_MODULE_V(uart_svt,latest,svt_uart_checker) 
 `else
  `define NVS_UV_CHECKER_VP  "nvs_uv_checker.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_CHK_DEFINE_H  "svt_uart_chk_define.h" 
 `else
  `define NVS_UV_CHK_DEFINE_H  "nvs_uv_chk_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_CHK_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_chk_define) 
 `else
  `define NVS_UV_CHK_DEFINE_HP  "nvs_uv_chk_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_GLOBAL_VAR_VIH
 `ifdef SVT_UART 
  `define NVS_UV_CHK_GLOBAL_VAR_VIH  "svt_uart_chk_global_var.vih" 
 `else
  `define NVS_UV_CHK_GLOBAL_VAR_VIH  "nvs_uv_chk_global_var.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_GLOBAL_VAR_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_CHK_GLOBAL_VAR_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_chk_global_var) 
 `else
  `define NVS_UV_CHK_GLOBAL_VAR_VIHP  "nvs_uv_chk_global_var.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_LIC_VIH
 `ifdef SVT_UART 
  `define NVS_UV_CHK_LIC_VIH  "svt_uart_chk_lic.vih" 
 `else
  `define NVS_UV_CHK_LIC_VIH  "nvs_uv_chk_lic.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_LIC_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_CHK_LIC_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_chk_lic) 
 `else
  `define NVS_UV_CHK_LIC_VIHP  "nvs_uv_chk_lic.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_RULE_TASKS_VIH
 `ifdef SVT_UART 
  `define NVS_UV_CHK_RULE_TASKS_VIH  "svt_uart_chk_rule_tasks.vih" 
 `else
  `define NVS_UV_CHK_RULE_TASKS_VIH  "nvs_uv_chk_rule_tasks.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_CHK_RULE_TASKS_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_CHK_RULE_TASKS_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_chk_rule_tasks) 
 `else
  `define NVS_UV_CHK_RULE_TASKS_VIHP  "nvs_uv_chk_rule_tasks.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_COMMON_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_COMMON_DEFINE_H  "svt_uart_common_define.h" 
 `else
  `define NVS_UV_COMMON_DEFINE_H  "nvs_uv_common_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_COMMON_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_COMMON_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_common_define) 
 `else
  `define NVS_UV_COMMON_DEFINE_HP  "nvs_uv_common_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_COMMON_PARAM_VIH
 `ifdef SVT_UART 
  `define NVS_UV_COMMON_PARAM_VIH  "svt_uart_common_param.vih" 
 `else
  `define NVS_UV_COMMON_PARAM_VIH  "nvs_uv_common_param.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_COMMON_PARAM_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_COMMON_PARAM_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_common_param) 
 `else
  `define NVS_UV_COMMON_PARAM_VIHP  "nvs_uv_common_param.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_DEFINE_H  "svt_uart_define.h" 
 `else
  `define NVS_UV_DEFINE_H  "nvs_uv_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_define) 
 `else
  `define NVS_UV_DEFINE_HP  "nvs_uv_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_ERR_MESSAGE_VIH
 `ifdef SVT_UART 
  `define NVS_UV_ERR_MESSAGE_VIH  "svt_uart_err_message.vih" 
 `else
  `define NVS_UV_ERR_MESSAGE_VIH  "nvs_uv_err_message.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_ERR_MESSAGE_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_ERR_MESSAGE_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_err_message) 
 `else
  `define NVS_UV_ERR_MESSAGE_VIHP  "nvs_uv_err_message.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_ERROR_TEST_V
 `ifdef SVT_UART 
  `define NVS_UV_ERROR_TEST_V  "svt_uart_error_test.v" 
 `else
  `define NVS_UV_ERROR_TEST_V  "nvs_uv_error_test.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_ERROR_TEST_VP
 `ifdef SVT_UART 
  `define NVS_UV_ERROR_TEST_VP  "svt_uart_error_test.vp" 
 `else
  `define NVS_UV_ERROR_TEST_VP  "nvs_uv_error_test.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_BFM_H
 `ifdef SVT_UART 
  `define NVS_UV_LIB_BFM_H  "svt_uart_lib_bfm.h" 
 `else
  `define NVS_UV_LIB_BFM_H  "nvs_uv_lib_bfm.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_BFM_HP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_BFM_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_lib_bfm) 
 `else
  `define NVS_UV_LIB_BFM_HP  "nvs_uv_lib_bfm.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_BFM_VIH
 `ifdef SVT_UART 
  `define NVS_UV_LIB_BFM_VIH  "svt_uart_lib_bfm.vih" 
 `else
  `define NVS_UV_LIB_BFM_VIH  "nvs_uv_lib_bfm.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_BFM_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_BFM_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_lib_bfm)
 `else
  `define NVS_UV_LIB_BFM_VIHP  "nvs_uv_lib_bfm.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_CHK_H
 `ifdef SVT_UART 
  `define NVS_UV_LIB_CHK_H  "svt_uart_lib_chk.h" 
 `else
  `define NVS_UV_LIB_CHK_H  "nvs_uv_lib_chk.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_CHK_HP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_CHK_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_lib_chk) 
 `else
  `define NVS_UV_LIB_CHK_HP  "nvs_uv_lib_chk.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_CHK_VIH
 `ifdef SVT_UART 
  `define NVS_UV_LIB_CHK_VIH  "svt_uart_lib_chk.vih" 
 `else
  `define NVS_UV_LIB_CHK_VIH  "nvs_uv_lib_chk.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_CHK_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_CHK_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_lib_chk) 
 `else
  `define NVS_UV_LIB_CHK_VIHP  "nvs_uv_lib_chk.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_GEN_H
 `ifdef SVT_UART 
  `define NVS_UV_LIB_GEN_H  "svt_uart_lib_gen.h" 
 `else
  `define NVS_UV_LIB_GEN_H  "nvs_uv_lib_gen.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_GEN_HP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_GEN_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_lib_gen) 
 `else
  `define NVS_UV_LIB_GEN_HP  "nvs_uv_lib_gen.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_GEN_VIH
 `ifdef SVT_UART 
  `define NVS_UV_LIB_GEN_VIH  "svt_uart_lib_gen.vih" 
 `else
  `define NVS_UV_LIB_GEN_VIH  "nvs_uv_lib_gen.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_GEN_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_GEN_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_lib_gen) 
 `else
  `define NVS_UV_LIB_GEN_VIHP  "nvs_uv_lib_gen.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_MON_H
 `ifdef SVT_UART 
  `define NVS_UV_LIB_MON_H  "svt_uart_lib_mon.h" 
 `else
  `define NVS_UV_LIB_MON_H  "nvs_uv_lib_mon.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_MON_HP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_MON_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_lib_mon) 
 `else
  `define NVS_UV_LIB_MON_HP  "nvs_uv_lib_mon.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_MON_VIH
 `ifdef SVT_UART 
  `define NVS_UV_LIB_MON_VIH  "svt_uart_lib_mon.vih" 
 `else
  `define NVS_UV_LIB_MON_VIH  "nvs_uv_lib_mon.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIB_MON_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_LIB_MON_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_lib_mon) 
 `else
  `define NVS_UV_LIB_MON_VIHP  "nvs_uv_lib_mon.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIC_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_LIC_DEFINE_H  "svt_uart_lic_define.h" 
 `else
  `define NVS_UV_LIC_DEFINE_H  "nvs_uv_lic_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_LIC_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_LIC_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_lic_define) 
 `else
  `define NVS_UV_LIC_DEFINE_HP  "nvs_uv_lic_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_MON_DEFINE_H  "svt_uart_mon_define.h" 
 `else
  `define NVS_UV_MON_DEFINE_H  "nvs_uv_mon_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_DEFINE_HP
 `ifdef SVT_UART 
   `define NVS_UV_MON_DEFINE_HP  `NVS_SOURCE_MAP_SUITE_COMMON_H(uart_svt,latest,svt_uart_mon_define) 
 `else
  `define NVS_UV_MON_DEFINE_HP  "nvs_uv_mon_define.hp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_GLOBAL_VAR_VIH
 `ifdef SVT_UART 
  `define NVS_UV_MON_GLOBAL_VAR_VIH  "svt_uart_mon_global_var.vih" 
 `else
  `define NVS_UV_MON_GLOBAL_VAR_VIH  "nvs_uv_mon_global_var.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_GLOBAL_VAR_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_MON_GLOBAL_VAR_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_mon_global_var) 
 `else
  `define NVS_UV_MON_GLOBAL_VAR_VIHP  "nvs_uv_mon_global_var.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MONITOR_V
 `ifdef SVT_UART 
  `define NVS_UV_MONITOR_V  "svt_uart_monitor.v" 
 `else
  `define NVS_UV_MONITOR_V  "nvs_uv_monitor.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MONITOR_VP
 `ifdef SVT_UART 
   `define NVS_UV_MONITOR_VP  `NVS_SOURCE_MAP_SUITE_MODULE_V(uart_svt,latest,svt_uart_monitor) 
 `else
  `define NVS_UV_MONITOR_VP  "nvs_uv_monitor.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_LIC_VIH
 `ifdef SVT_UART 
  `define NVS_UV_MON_LIC_VIH  "svt_uart_mon_lic.vih" 
 `else
  `define NVS_UV_MON_LIC_VIH  "nvs_uv_mon_lic.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_LIC_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_MON_LIC_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_mon_lic) 
 `else
  `define NVS_UV_MON_LIC_VIHP  "nvs_uv_mon_lic.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_TXRX_V
 `ifdef SVT_UART 
  `define NVS_UV_MON_TXRX_V  "svt_uart_mon_txrx.v" 
 `else
  `define NVS_UV_MON_TXRX_V  "nvs_uv_mon_txrx.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_MON_TXRX_VP
 `ifdef SVT_UART 
   `define NVS_UV_MON_TXRX_VP  `NVS_SOURCE_MAP_SUITE_MODULE_V(uart_svt,latest,svt_uart_mon_txrx) 
 `else
  `define NVS_UV_MON_TXRX_VP  "nvs_uv_mon_txrx.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BASE_TEST_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BASE_TEST_SV  "svt_uart_ovm_base_test.sv" 
 `else
  `define NVS_UV_OVM_BASE_TEST_SV  "nvs_uv_ovm_base_test.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BASIC_TEST_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BASIC_TEST_SV  "svt_uart_ovm_basic_test.sv" 
 `else
  `define NVS_UV_OVM_BASIC_TEST_SV  "nvs_uv_ovm_basic_test.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM1_MON_CHK_V
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM1_MON_CHK_V  "svt_uart_ovm_bfm1_mon_chk.v" 
 `else
  `define NVS_UV_OVM_BFM1_MON_CHK_V  "nvs_uv_ovm_bfm1_mon_chk.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_AGENT_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_AGENT_SV  "svt_uart_ovm_bfm_agent.sv" 
 `else
  `define NVS_UV_OVM_BFM_AGENT_SV  "nvs_uv_ovm_bfm_agent.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_CALLBACK_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_CALLBACK_SV  "svt_uart_ovm_bfm_callback.sv" 
 `else
  `define NVS_UV_OVM_BFM_CALLBACK_SV  "nvs_uv_ovm_bfm_callback.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_DRIVER_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_DRIVER_SV  "svt_uart_ovm_bfm_driver.sv" 
 `else
  `define NVS_UV_OVM_BFM_DRIVER_SV  "nvs_uv_ovm_bfm_driver.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_ENV_SVH
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_ENV_SVH  "svt_uart_ovm_bfm_env.svh" 
 `else
  `define NVS_UV_OVM_BFM_ENV_SVH  "nvs_uv_ovm_bfm_env.svh"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_MON_CHK_V
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_MON_CHK_V  "svt_uart_ovm_bfm_mon_chk.v" 
 `else
  `define NVS_UV_OVM_BFM_MON_CHK_V  "nvs_uv_ovm_bfm_mon_chk.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_RX_MONITOR_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_RX_MONITOR_SV  "svt_uart_ovm_bfm_rx_monitor.sv" 
 `else
  `define NVS_UV_OVM_BFM_RX_MONITOR_SV  "nvs_uv_ovm_bfm_rx_monitor.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_SEQ_LIB_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_SEQ_LIB_SV  "svt_uart_ovm_bfm_seq_lib.sv" 
 `else
  `define NVS_UV_OVM_BFM_SEQ_LIB_SV  "nvs_uv_ovm_bfm_seq_lib.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_SEQUENCER_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_SEQUENCER_SV  "svt_uart_ovm_bfm_sequencer.sv" 
 `else
  `define NVS_UV_OVM_BFM_SEQUENCER_SV  "nvs_uv_ovm_bfm_sequencer.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_BFM_TX_MONITOR_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_TX_MONITOR_SV  "svt_uart_ovm_bfm_tx_monitor.sv" 
 `else
  `define NVS_UV_OVM_BFM_TX_MONITOR_SV  "nvs_uv_ovm_bfm_tx_monitor.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_COMMON_DEFINE_H
 `ifdef SVT_UART 
  `define NVS_UV_OVM_COMMON_DEFINE_H  "svt_uart_ovm_common_define.h" 
 `else
  `define NVS_UV_OVM_COMMON_DEFINE_H  "nvs_uv_ovm_common_define.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_CONFIG_TEST_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_CONFIG_TEST_SV  "svt_uart_ovm_config_test.sv" 
 `else
  `define NVS_UV_OVM_CONFIG_TEST_SV  "nvs_uv_ovm_config_test.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_ENV_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_ENV_SV  "svt_uart_ovm_env.sv" 
 `else
  `define NVS_UV_OVM_ENV_SV  "nvs_uv_ovm_env.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_ENV_SVH
 `ifdef SVT_UART 
  `define NVS_UV_OVM_ENV_SVH  "svt_uart_ovm_env.svh" 
 `else
  `define NVS_UV_OVM_ENV_SVH  "nvs_uv_ovm_env.svh"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_ERROR_SEQ_LIB_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_ERROR_SEQ_LIB_SV  "svt_uart_ovm_error_seq_lib.sv" 
 `else
  `define NVS_UV_OVM_ERROR_SEQ_LIB_SV  "nvs_uv_ovm_error_seq_lib.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_ERROR_TEST_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_ERROR_TEST_SV  "svt_uart_ovm_error_test.sv" 
 `else
  `define NVS_UV_OVM_ERROR_TEST_SV  "nvs_uv_ovm_error_test.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_ERR_VARIABLES_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_ERR_VARIABLES_SV  "svt_uart_ovm_err_variables.sv" 
 `else
  `define NVS_UV_OVM_ERR_VARIABLES_SV  "nvs_uv_ovm_err_variables.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_INC_SVH
 `ifdef SVT_UART 
  `define NVS_UV_OVM_INC_SVH  "svt_uart_ovm_inc.svh" 
 `else
  `define NVS_UV_OVM_INC_SVH  "nvs_uv_ovm_inc.svh"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_MON_CHK_AGENT_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_MON_CHK_AGENT_SV  "svt_uart_ovm_mon_chk_agent.sv" 
 `else
  `define NVS_UV_OVM_MON_CHK_AGENT_SV  "nvs_uv_ovm_mon_chk_agent.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_MON_CHK_DRIVER_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_MON_CHK_DRIVER_SV  "svt_uart_ovm_mon_chk_driver.sv" 
 `else
  `define NVS_UV_OVM_MON_CHK_DRIVER_SV  "nvs_uv_ovm_mon_chk_driver.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_MON_CHK_MONITOR_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_MON_CHK_MONITOR_SV  "svt_uart_ovm_mon_chk_monitor.sv" 
 `else
  `define NVS_UV_OVM_MON_CHK_MONITOR_SV  "nvs_uv_ovm_mon_chk_monitor.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_MON_CHK_SEQ_LIB_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_MON_CHK_SEQ_LIB_SV  "svt_uart_ovm_mon_chk_seq_lib.sv" 
 `else
  `define NVS_UV_OVM_MON_CHK_SEQ_LIB_SV  "nvs_uv_ovm_mon_chk_seq_lib.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_MON_CHK_SEQUENCER_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_MON_CHK_SEQUENCER_SV  "svt_uart_ovm_mon_chk_sequencer.sv" 
 `else
  `define NVS_UV_OVM_MON_CHK_SEQUENCER_SV  "nvs_uv_ovm_mon_chk_sequencer.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_RANDOM_TEST_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_RANDOM_TEST_SV  "svt_uart_ovm_random_test.sv" 
 `else
  `define NVS_UV_OVM_RANDOM_TEST_SV  "nvs_uv_ovm_random_test.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_SCOREBOARD_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_SCOREBOARD_SV  "svt_uart_ovm_scoreboard.sv" 
 `else
  `define NVS_UV_OVM_SCOREBOARD_SV  "nvs_uv_ovm_scoreboard.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_TB_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_TB_SV  "svt_uart_ovm_tb.sv" 
 `else
  `define NVS_UV_OVM_TB_SV  "nvs_uv_ovm_tb.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_VIRTUAL_SEQ_LIB_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_VIRTUAL_SEQ_LIB_SV  "svt_uart_ovm_virtual_seq_lib.sv" 
 `else
  `define NVS_UV_OVM_VIRTUAL_SEQ_LIB_SV  "nvs_uv_ovm_virtual_seq_lib.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_VIRTUAL_SEQUENCER_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_VIRTUAL_SEQUENCER_SV  "svt_uart_ovm_virtual_sequencer.sv" 
 `else
  `define NVS_UV_OVM_VIRTUAL_SEQUENCER_SV  "nvs_uv_ovm_virtual_sequencer.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_OVM_VIRTUAL_SEQUENCE_SV
 `ifdef SVT_UART 
  `define NVS_UV_OVM_VIRTUAL_SEQUENCE_SV  "svt_uart_ovm_virtual_sequence.sv" 
 `else
  `define NVS_UV_OVM_VIRTUAL_SEQUENCE_SV  "nvs_uv_ovm_virtual_sequence.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_POOL_V
 `ifdef SVT_UART 
  `define NVS_UV_POOL_V  "svt_uart_pool.v" 
 `else
  `define NVS_UV_POOL_V  "nvs_uv_pool.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_POOL_VP
 `ifdef SVT_UART 
  `define NVS_UV_POOL_VP  "svt_uart_pool.vp" 
 `else
  `define NVS_UV_POOL_VP  "nvs_uv_pool.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_RANDOM_TEST_V
 `ifdef SVT_UART 
  `define NVS_UV_RANDOM_TEST_V  "svt_uart_random_test.v" 
 `else
  `define NVS_UV_RANDOM_TEST_V  "nvs_uv_random_test.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_RANDOM_TEST_VP
 `ifdef SVT_UART 
  `define NVS_UV_RANDOM_TEST_VP  "svt_uart_random_test.vp" 
 `else
  `define NVS_UV_RANDOM_TEST_VP  "nvs_uv_random_test.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_RULES_VIH
 `ifdef SVT_UART 
  `define NVS_UV_RULES_VIH  "svt_uart_rules.vih" 
 `else
  `define NVS_UV_RULES_VIH  "nvs_uv_rules.vih"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_RULES_VIHP
 `ifdef SVT_UART 
   `define NVS_UV_RULES_VIHP  `NVS_SOURCE_MAP_SUITE_COMMON_VIH(uart_svt,latest,svt_uart_rules) 
 `else
  `define NVS_UV_RULES_VIHP  "nvs_uv_rules.vihp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM0_DRIVER_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM0_DRIVER_SV  "svt_uart_sv_bfm0_driver.sv" 
 `else
  `define NVS_UV_SV_BFM0_DRIVER_SV  "nvs_uv_sv_bfm0_driver.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM1_DRIVER_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM1_DRIVER_SV  "svt_uart_sv_bfm1_driver.sv" 
 `else
  `define NVS_UV_SV_BFM1_DRIVER_SV  "nvs_uv_sv_bfm1_driver.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM_CFG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM_CFG_SV  "svt_uart_sv_bfm_cfg.sv" 
 `else
  `define NVS_UV_SV_BFM_CFG_SV  "nvs_uv_sv_bfm_cfg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM_IF_SV  "svt_uart_sv_bfm_if.sv" 
 `else
  `define NVS_UV_SV_BFM_IF_SV  "nvs_uv_sv_bfm_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM_TRANS_CFG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM_TRANS_CFG_SV  "svt_uart_sv_bfm_trans_cfg.sv" 
 `else
  `define NVS_UV_SV_BFM_TRANS_CFG_SV  "nvs_uv_sv_bfm_trans_cfg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_BFM_TRANS_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM_TRANS_SV  "svt_uart_sv_bfm_trans.sv" 
 `else
  `define NVS_UV_SV_BFM_TRANS_SV  "nvs_uv_sv_bfm_trans.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_CHK_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_CHK_IF_SV  "svt_uart_sv_chk_if.sv" 
 `else
  `define NVS_UV_SV_CHK_IF_SV  "nvs_uv_sv_chk_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_COVERAGE_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_COVERAGE_SV  "svt_uart_sv_coverage.sv" 
 `else
  `define NVS_UV_SV_COVERAGE_SV  "nvs_uv_sv_coverage.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_DEFAULT_COVERAGE_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_DEFAULT_COVERAGE_SV  "svt_uart_sv_default_coverage.sv" 
 `else
  `define NVS_UV_SV_DEFAULT_COVERAGE_SV  "nvs_uv_sv_default_coverage.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_DEFINE_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_DEFINE_SV  "svt_uart_sv_define.sv" 
 `else
  `define NVS_UV_SV_DEFINE_SV  "nvs_uv_sv_define.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_ENUM_PKG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_ENUM_PKG_SV  "svt_uart_sv_enum.pkg" 
 `else
  `define NVS_UV_SV_ENUM_PKG_SV  "nvs_uv_sv_enum_pkg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_ERROR_PRINT_BFM_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_ERROR_PRINT_BFM_SV  "svt_uart_sv_error_print_bfm.sv" 
 `else
  `define NVS_UV_SV_ERROR_PRINT_BFM_SV  "nvs_uv_sv_error_print_bfm.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_ERROR_PRINT_CHK_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_ERROR_PRINT_CHK_SV  "svt_uart_sv_error_print_chk.sv" 
 `else
  `define NVS_UV_SV_ERROR_PRINT_CHK_SV  "nvs_uv_sv_error_print_chk.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_MON_CHK_CFG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_CHK_CFG_SV  "svt_uart_sv_mon_chk_cfg.sv" 
 `else
  `define NVS_UV_SV_MON_CHK_CFG_SV  "nvs_uv_sv_mon_chk_cfg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_MON_CHK_TRANS_CFG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_CHK_TRANS_CFG_SV  "svt_uart_sv_mon_chk_trans_cfg.sv" 
 `else
  `define NVS_UV_SV_MON_CHK_TRANS_CFG_SV  "nvs_uv_sv_mon_chk_trans_cfg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_MON_CHK_TRANS_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_CHK_TRANS_SV  "svt_uart_sv_mon_chk_trans.sv" 
 `else
  `define NVS_UV_SV_MON_CHK_TRANS_SV  "nvs_uv_sv_mon_chk_trans.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_MON_DRIVER_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_DRIVER_SV  "svt_uart_sv_mon_driver.sv" 
 `else
  `define NVS_UV_SV_MON_DRIVER_SV  "nvs_uv_sv_mon_driver.sv"
 `endif
`endif
`ifndef NVS_UV_SV_PORT_IF
 `ifdef SVT_UART 
  `define NVS_UV_SV_PORT_IF  svt_uart_if 
 `else
  `define NVS_UV_SV_PORT_IF  nvs_uv_sv_port_if
 `endif
`endif
//Interface Name macro by codeGenSVT 
`ifndef NVS_UV_SV_BFM_IF
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM_IF  svt_uart_sv_bfm_if
 `else
  `define NVS_UV_SV_BFM_IF  nvs_uv_sv_bfm_if
 `endif
`endif
//Interface Name macro by codeGenSVT 
`ifndef NVS_UV_SV_MON_IF
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_IF  svt_uart_sv_mon_if
 `else
  `define NVS_UV_SV_MON_IF  nvs_uv_sv_mon_if
 `endif
`endif
//Interface Name macro by codeGenSVT 
`ifndef NVS_UV_SV_CHK_IF
 `ifdef SVT_UART 
  `define NVS_UV_SV_CHK_IF  svt_uart_sv_chk_if
 `else
  `define NVS_UV_SV_CHK_IF  nvs_uv_sv_chk_if
 `endif
`endif
`ifndef NVS_UV_POOL
 `ifdef SVT_UART 
  `define NVS_UV_POOL  svt_uart_pool 
 `else
  `define NVS_UV_POOL  nvs_uv_pool
 `endif
`endif
//Module Name macro by codeGenSVT 
`ifndef NVS_UV_MON_TXRX
 `ifdef SVT_UART 
  `define NVS_UV_MON_TXRX  svt_uart_mon_txrx 
 `else
  `define NVS_UV_MON_TXRX  nvs_uv_mon_txrx
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_SV_BFM0_DRIVER
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM0_DRIVER  svt_uart_sv_bfm0_driver 
 `else
  `define NVS_UV_SV_BFM0_DRIVER  nvs_uv_sv_bfm0_driver
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_SV_BFM1_DRIVER
 `ifdef SVT_UART 
  `define NVS_UV_SV_BFM1_DRIVER  svt_uart_sv_bfm1_driver 
 `else
  `define NVS_UV_SV_BFM1_DRIVER  nvs_uv_sv_bfm1_driver
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_BFM_VERI_AGENT
 `ifdef SVT_UART 
  `define NVS_UV_BFM_VERI_AGENT  svt_uart_bfm_veri_agent 
 `else
  `define NVS_UV_BFM_VERI_AGENT  nvs_uv_bfm_veri_agent
 `endif
`endif

`ifndef NVS_UV_SV_BFM_TRANS
 `ifdef SVT_UART
  `define NVS_UV_SV_BFM_TRANS    svt_uart_transaction
  `else
   `define NVS_UV_SV_BFM_TRANS   nvs_uv_sv_bfm_trans
  `endif
 `endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_SV_MON_DRIVER
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_DRIVER  svt_uart_sv_mon_driver 
 `else
  `define NVS_UV_SV_MON_DRIVER  nvs_uv_sv_mon_driver
 `endif
`endif


`ifndef NVS_UV_SV_ERROR_PRINT_BFM
 `ifdef SVT_UART 
  `define NVS_UV_SV_ERROR_PRINT_BFM  svt_uart_sv_error_print_bfm 
 `else
  `define NVS_UV_SV_ERROR_PRINT_BFM  nvs_uv_sv_error_print_bfm
 `endif
`endif

`ifndef NVS_UV_SV_ERROR_PRINT_CHK
 `ifdef SVT_UART 
  `define NVS_UV_SV_ERROR_PRINT_CHK  svt_uart_sv_error_print_chk 
 `else
  `define NVS_UV_SV_ERROR_PRINT_CHK  nvs_uv_sv_error_print_chk
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_BMON_VERI_AGENT
 `ifdef SVT_UART 
  `define NVS_UV_BMON_VERI_AGENT  svt_uart_bmon_veri_agent 
 `else
  `define NVS_UV_BMON_VERI_AGENT  nvs_uv_bmon_veri_agent
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_BFM
 `ifdef SVT_UART 
  `define NVS_UV_BFM  svt_uart_bfm 
 `else
  `define NVS_UV_BFM  nvs_uv_bfm
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_MONITOR
 `ifdef SVT_UART 
  `define NVS_UV_MONITOR  svt_uart_mon
 `else
  `define NVS_UV_MONITOR  nvs_uv_monitor
 `endif
`endif

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_CHECKER
 `ifdef SVT_UART 
  `define NVS_UV_CHECKER  svt_uart_checker 
 `else
  `define NVS_UV_CHECKER  nvs_uv_checker
 `endif
`endif

//Define for SVT
`ifndef NVS_UV_SV_MON_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_MON_IF_SV  "svt_uart_sv_mon_if.sv" 
 `else
  `define NVS_UV_SV_MON_IF_SV  "nvs_uv_sv_mon_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_PORT_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_PORT_IF_SV  "svt_uart_if.sv" 
 `else
  `define NVS_UV_SV_PORT_IF_SV  "nvs_uv_sv_port_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_SYS_CFG_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_SYS_CFG_SV  "svt_uart_sv_sys_cfg.sv" 
 `else
  `define NVS_UV_SV_SYS_CFG_SV  "nvs_uv_sv_sys_cfg.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_TOP_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_TOP_IF_SV  "svt_uart_sv_top_if.sv" 
 `else
  `define NVS_UV_SV_TOP_IF_SV  "nvs_uv_sv_top_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_SV_TRANS_SV
 `ifdef SVT_UART 
  `define NVS_UV_SV_TRANS_SV  "svt_uart_sv_trans.sv" 
 `else
  `define NVS_UV_SV_TRANS_SV  "nvs_uv_sv_trans.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_TOP_H
 `ifdef SVT_UART 
  `define NVS_UV_TOP_H  "svt_uart_top.h" 
 `else
  `define NVS_UV_TOP_H  "nvs_uv_top.h"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_TOP_IF_SV
 `ifdef SVT_UART 
  `define NVS_UV_TOP_IF_SV  "svt_uart_top_if.sv" 
 `else
  `define NVS_UV_TOP_IF_SV  "nvs_uv_top_if.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_TRANS_SV
 `ifdef SVT_UART 
  `define NVS_UV_TRANS_SV  "svt_uart_trans.sv" 
 `else
  `define NVS_UV_TRANS_SV  "nvs_uv_trans.sv"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_USER_TEST_V
 `ifdef SVT_UART 
  `define NVS_UV_USER_TEST_V  "svt_uart_user_test.v" 
 `else
  `define NVS_UV_USER_TEST_V  "nvs_uv_user_test.v"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_USER_TEST_VP
 `ifdef SVT_UART 
  `define NVS_UV_USER_TEST_VP  "svt_uart_user_test.vp" 
 `else
  `define NVS_UV_USER_TEST_VP  "nvs_uv_user_test.vp"
 `endif
`endif
//Define for SVT
`ifndef NVS_UV_VERDI_DEFINES_H
 `ifdef SVT_UART 
  `define NVS_UV_VERDI_DEFINES_H  "svt_uart_verdi_defines.h" 
 `else
  `define NVS_UV_VERDI_DEFINES_H  "nvs_uv_verdi_defines.h"
 `endif
`endif
//Define for SVT
`ifdef SVT_UART
  `define SVT_UART_CHECK_RESPONSE_PACKET_FIELDS(req, req_clone, rsp, sequence_name, uart_cfg) \
`ifdef SVT_UART_ENABLE_RESPONSE \
    void'($cast(req_clone,req.clone())); \
    get_response(rsp); \
    begin \
      reg temp_parity; \
      reg wrong_bit; \
      integer packet_length; \
      if(uart_cfg.parity_type == svt_uart_configuration::NO_PARITY) \
        packet_length = 1 + uart_cfg.data_width + uart_cfg.stop_bit; \
      else \
        packet_length = 1 + uart_cfg.data_width + 1 + uart_cfg.stop_bit; \
      if(rsp.packet_count != req_clone.packet_count) \
        `SVT_XVM(report_error)(`SVT_DATA_UTIL_ARG_TO_STRING(sequence_name),$sformatf("Packet_count Mismatch, rsp object value is %0d and req object value is %0d ",rsp.packet_count,req_clone.packet_count)); \
      else begin \
        for(integer i=0;i<rsp.packet_count;i++) begin \
          if(req_clone.break_cond == 1) begin \
            for(integer k=0;k<packet_length;k++) begin \
              if(rsp.received_packet[i][k] != 0) \
                wrong_bit = 1; \
            end \
          end \
          else begin \
            for(integer k=0;k<uart_cfg.data_width;k++) begin \
              if(rsp.payload[i][k] != req_clone.payload[i][k]) \
                wrong_bit = 1; \
            end \
          end \
          \
          if((req_clone.break_cond == 1) && (wrong_bit == 1)) begin \
            `SVT_XVM(report_error)(`SVT_DATA_UTIL_ARG_TO_STRING(sequence_name),$sformatf("Incorrect packet received in rsp object for the sequence set to generate break condition. All the bits of received packet should be 0")); \
            wrong_bit = 0; \
          end \
          else if(wrong_bit == 1) begin \
            `SVT_XVM(report_error)(`SVT_DATA_UTIL_ARG_TO_STRING(sequence_name),$sformatf("Payload Mismatch, rsp object payload[%0d] is %0b and req object payload[%0d] is %0b ",i,rsp.payload[i],i,req_clone.payload[i])); \
            wrong_bit = 0; \
          end \
          \
          for(integer j=0;j<uart_cfg.data_width;j++) \
            temp_parity = req_clone.payload[i][j]^temp_parity; \
          if(uart_cfg.parity_type == svt_uart_configuration::ODD_PARITY) \
            temp_parity = ~temp_parity; \
          else if(uart_cfg.parity_type == svt_uart_configuration::STICK_LOW_PARITY) \
            temp_parity = 1'b0; \
          else if(uart_cfg.parity_type == svt_uart_configuration::STICK_HIGH_PARITY) \
            temp_parity = 1'b1; \
          \
          if((req_clone.break_cond != 1) && (uart_cfg.parity_type != `UV_NONE)) begin \
            if(rsp.received_parity[i] != temp_parity) \
              `SVT_XVM(report_error)(`SVT_DATA_UTIL_ARG_TO_STRING(sequence_name),$sformatf("Parity Mismatch, rsp object parity for payload[%0d] is %0b and req object parity is %0b ",i,rsp.received_parity[i],temp_parity)); \
          end \
          temp_parity = 1'b0; \
        end \
      end \
    end \
`endif 
`endif //SVT_UART 

//Macro to compare the data received on the upstream with XOFF and XON data
`ifdef SVT_UART_VERILOG_TECHNOLOGY
`define SVT_UART_CHECK_UPSTREAM_DATA_FOR_XON_XOFF_PKT \
  if(`UART_DCE.mode_band_operation === 1) begin \
    case(`UART_MON.inst2.mon_data_width) \
      5: begin \
           while((`UART_MON.inst2.mon_received_data[4:0] == `UART_DCE.data_pattern_inbound_on) || (`UART_MON.inst2.mon_received_data[4:0] == `UART_DCE.data_pattern_inbound_off)) \
             @(`UART_MON.inst2.event_mon_pkt_received_over); \
      end \
      6: begin \
           while((`UART_MON.inst2.mon_received_data[5:0] == `UART_DCE.data_pattern_inbound_on) || (`UART_MON.inst2.mon_received_data[5:0] == `UART_DCE.data_pattern_inbound_off)) \
             @(`UART_MON.inst2.event_mon_pkt_received_over); \
      end \
      7: begin \
           while((`UART_MON.inst2.mon_received_data[6:0] == `UART_DCE.data_pattern_inbound_on) || (`UART_MON.inst2.mon_received_data[6:0] == `UART_DCE.data_pattern_inbound_off)) \
             @(`UART_MON.inst2.event_mon_pkt_received_over); \
      end \
      8: begin \
           while((`UART_MON.inst2.mon_received_data[7:0] == `UART_DCE.data_pattern_inbound_on) || (`UART_MON.inst2.mon_received_data[7:0] == `UART_DCE.data_pattern_inbound_off)) \
             @(`UART_MON.inst2.event_mon_pkt_received_over); \
      end \
      9: begin \
           while((`UART_MON.inst2.mon_received_data[8:0] == `UART_DCE.data_pattern_inbound_on) || (`UART_MON.inst2.mon_received_data[8:0] == `UART_DCE.data_pattern_inbound_off)) \
             @(`UART_MON.inst2.event_mon_pkt_received_over); \
      end \
      default : print("err","Incorrect Data Width"); \
    endcase \
  end \
  else begin \
    \
  end
`endif  

// Macro to compare data sent through verilog test cases with that received
// on the bus
`ifdef SVT_UART_VERILOG_TECHNOLOGY
`define SVT_UART_CHECK_BUS_PACKET_FIELD(data_width,load_data,mon_data) \
  begin \
    case(data_width) \
      5: begin \
        if(load_data[4:0] != mon_data[4:0]) \
          printv2("err","Data Mismatch : Sent Data : %b Data Received %b",load_data[4:0],mon_data[4:0]); \
      end \
      6: begin \
        if(load_data[5:0] != mon_data[5:0]) \
          printv2("err","Data Mismatch : Sent Data : %b Data Received %b",load_data[5:0],mon_data[5:0]); \
      end \
      7: begin \
        if(load_data[6:0] != mon_data[6:0]) \
          printv2("err","Data Mismatch : Sent Data : %b Data Received %b",load_data[6:0],mon_data[6:0]); \
      end \
      8: begin \
        if(load_data[7:0] != mon_data[7:0]) \
          printv2("err","Data Mismatch : Sent Data : %b Data Received %b",load_data[7:0],mon_data[7:0]); \
      end \
      9: begin \
        if(load_data[8:0] != mon_data[8:0]) \
          printv2("err","Data Mismatch : Sent Data : %b Data Received %b",load_data[8:0],mon_data[8:0]); \
      end \
      default : print("err","Incorrect Data Width"); \
    endcase \
  end 
`endif  

//Module Name macro by codeGenSVT 
`ifndef NVS_UV_OVM_BFM_MON_CHK
 `ifdef SVT_UART 
  `define NVS_UV_OVM_BFM_MON_CHK  svt_uart_ovm_bfm_mon_chk 
 `else
  `define NVS_UV_OVM_BFM_MON_CHK  nvs_uv_ovm_bfm_mon_chk
 `endif
`endif

`ifdef UV_ENABLE_DEBUG

 `define uart_debug(M)           print("debug",M) 
 `define uart_debug_v1(M,V1)     printv1("debug",M,V1)
 `define uart_debug_v2(M,V1,V2)  printv2("debug",M,V1,V2)
 `define uart_fdebug(M)          fprint("debug",M) 
 `define uart_fdebug_v1(M,V1)    fprintv1("debug",M,V1)
 `define uart_fdebug_v2(M,V1,V2) fprintv2("debug",M,V1,V2) 
`else

 `define uart_debug(M)           
 `define uart_debug_v1(M,V1)     
 `define uart_debug_v2(M,V1,V2)  
 `define uart_fdebug(M)          1
 `define uart_fdebug_v1(M,V1)    1
 `define uart_fdebug_v2(M,V1,V2) 1

`endif

`ifndef UART_DISABLE_TRAFFIC_LOG
  `define uart_print_log(M)             print("log",M)          
  `define uart_print_err(M)             print("err",M)          
  `define uart_print_warning(M)         print("warning",M)          

  `define uart_printv1_log(M,V1)        printv1("log",M,V1)
  `define uart_printv1_err(M,V1)        printv1("err",M,V1)
  `define uart_printv1_warning(M,V1)    printv1("warning",M,V1)

  `define uart_printv2_log(M,V1,V2)     printv2("log",M,V1,V2)
  `define uart_printv2_err(M,V1,V2)     printv2("err",M,V1,V2)
  `define uart_printv2_warning(M,V1,V2) printv2("warning",M,V1,V2)
`else
  `define uart_print_log(M)
  `define uart_print_err(M)
  `define uart_print_warning(M)

  `define uart_printv1_log(M,V1)
  `define uart_printv1_err(M,V1)
  `define uart_printv1_warning(M,V1)

  `define uart_printv2_log(M,V1,V2)
  `define uart_printv2_err(M,V1,V2)
  `define uart_printv2_warning(M,V1,V2)
`endif


`ifdef  UV_STOP_ON_TIME            
`else
`define  UV_STOP_ON_TIME               10000000
`endif

`ifdef  UV_STOP_ON_COUNT         
`else
`define  UV_STOP_ON_COUNT              0
`endif

`ifdef UV_SIMULATION_TIMEOUT
`else
 `define UV_SIMULATION_TIMEOUT 99999999
`endif

`define UV_TIME_OUT                    1000000
`define UV_ONE_STOP_BIT                1
`define UV_TWO_STOP_BIT                2
`define UV_ONE_FIVE_STOP_BIT           3
				       
`define UV_START_BIT_SIZE              1
				       
`define UV_CLK_BFM_IDLE                10000
				       
`define UV_CLK_BFM_IDLE_STOP_CNT       100000000         
//----------------------------------------------------------
// Integer one
//----------------------------------------------------------
`define UV_ONE                                  1
//----------------------------------------------------------
// Integer two
//----------------------------------------------------------
`define UV_ZERO                                 0
//----------------------------------------------------------
// True Bit
//----------------------------------------------------------
`define UV_TRUE                                 1'b1
//----------------------------------------------------------
// False Bit
//----------------------------------------------------------
`define UV_FALSE                                1'b0
 //----------------------------------------------------------
 // Baudrate one
 //----------------------------------------------------------
 `define UV_BAUDRATE_300                         300
 //----------------------------------------------------------
 // Baudrate two
 //----------------------------------------------------------
 `define UV_BAUDRATE_600                         600
 //----------------------------------------------------------
 // Baudrate three
 //----------------------------------------------------------
 `define UV_BAUDRATE_1200                        1200
 //----------------------------------------------------------
 // Baudrate four
 //----------------------------------------------------------
 `define UV_BAUDRATE_2400                        2400
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_4800                        4800
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_9600                        9600
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_19200                       19200
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_38400                       38400
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_56000                       56000
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_57600                       57600
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_115200                      115200
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_128000		        128000
 //----------------------------------------------------------
 // Baudrate five
 //----------------------------------------------------------
 `define UV_BAUDRATE_153600			153600
//----------------------------------------------------------
// Baudrate five
//----------------------------------------------------------
`define UV_BAUDRATE_230400			230400
//----------------------------------------------------------
// Default delay
//----------------------------------------------------------
`define UV_DEF_DELAY                            1
//----------------------------------------------------------
// Parity disabled
//----------------------------------------------------------
`define UV_NONE                                 3'b000
//----------------------------------------------------------
// Parity set to even
//----------------------------------------------------------
`define UV_EVEN                                 3'b001
//----------------------------------------------------------
// Parity set to odd
//----------------------------------------------------------
`define UV_ODD                                  3'b010
//----------------------------------------------------------
// Stick high Parity
//----------------------------------------------------------
`define UV_STICK_HIGH                           3'b011
//----------------------------------------------------------
// Stick low Parity 
//----------------------------------------------------------
`define UV_STICK_LOW                            3'b100
//----------------------------------------------------------
// Enable break condition
//----------------------------------------------------------
`define UV_BREAK_EN                             1'b1
//----------------------------------------------------------
// Disable break condition
//----------------------------------------------------------
`define UV_BREAK_DIS                            1'b0
//----------------------------------------------------------
// 
//----------------------------------------------------------
`define UV_WIDTH_DOCFG_PVAL 			32
//----------------------------------------------------------
// STATE MACHINE DEFINES
//----------------------------------------------------------
`define UV_IDLE_STATE_TX			3'b001
//----------------------------------------------------------
`define UV_HAND_TRANS_STATE     		3'b011
//----------------------------------------------------------
`define	UV_TRANSMIT_STATE			3'b100
//----------------------------------------------------------
`define UV_IDLE_STATE_RX			3'b010
//----------------------------------------------------------
`define UV_HAND_RECE_STATE      		3'b101
//----------------------------------------------------------
`define UV_START_DETECT	        		3'b110
//----------------------------------------------------------
`define UV_RECEIVE_STATE        		3'b111
//----------------------------------------------------------
`define UV_DWORD_ZERO				0
//----------------------------------------------------------
`define UV_DWORD_ONE				1
//----------------------------------------------------------
`define UV_DWORD_TWO				2
//----------------------------------------------------------
`define UV_DWORD_THREE				3
//----------------------------------------------------------
`define UV_DWORD_FOUR				4
//----------------------------------------------------------
`define UV_DWORD_FIVE				5
//----------------------------------------------------------
`define UV_DWORD_CFG_CONTINUE			0
//----------------------------------------------------------
`define UV_DWORD_BREAK				1
//----------------------------------------------------------
`define UV_DO_ERR_INVAL_PARITY                  2
//----------------------------------------------------------
`define UV_DO_ERR_INVAL_STOP_BITS               3
//----------------------------------------------------------
`define UV_DO_ERR_BREAK_CONDITION               4
//----------------------------------------------------------      
`define UV_DWORD_WIDTH				32
//----------------------------------------------------------
`define UV_TRANS_CFG				5
//----------------------------------------------------------
`define UV_INC 					1'b1
//----------------------------------------------------------
`define UV_BYTE 				1'b1
//----------------------------------------------------------
//`define UV_WAIT_FOR_DSR				1000001
////----------------------------------------------------------
//`define UV_MAX_WAIT_FOR_START_AFTER_DSR 	1000002
//----------------------------------------------------------
//----------------------------------------------------------
// DO ERR
//----------------------------------------------------------
`define UV_SOUT_INVAL_ASSER			0
//----------------------------------------------------------
`define UV_DTR_INVAL_ASSER			1
//----------------------------------------------------------
// Value changed from 2 to 0 to resolve error encountered 
// after '-ntb_opts check = all' was added in 
// make/include/VkiTest.cfg
`define UV_INVAL_PARITY				0
//----------------------------------------------------------
// Value changed from 4 to 1 to resolve error encountered 
// after '-ntb_opts check = all' was added in 
// make/include/VkiTest.cfg
`define UV_INVAL_STOP_BITS			1
//----------------------------------------------------------
`define UV_BREAK_CONDITION			5
//----------------------------------------------------------
`define UV_START_TIME_OUT        		6
//----------------------------------------------------------
`define UV_DOERR_INDEX                          8
//----------------------------------------------------------
//----------------------------------------------------------
// DO CFG
//---------------------------------------------------------- 
// Insert clocks between commands. The number of clocks is 
// specified in the packet_count field.
//---------------------------------------------------------
`define UV_IDLE                         	0
//---------------------------------------------------------
`define UV_SEV_CHG                              1
//---------------------------------------------------------
`define UV_MODE_FILE_HANDLE                     2
//---------------------------------------------------------
`define UV_MODE_CFG_CONTINUE                    3
//---------------------------------------------------------
`define UV_DTR_ASSERT_DELAY_TIME		4
//---------------------------------------------------------
`define UV_RECEIVER_BUFFER_SIZE			5
//---------------------------------------------------------
`define UV_RECEIVER_NOT_READY                   6
//---------------------------------------------------------
`define UV_BREAK                                7
//---------------------------------------------------------
`define UV_MODE_PKT_SZ		                8
//---------------------------------------------------------
`define UV_INTER_CYCLE_DELAY                    9
//---------------------------------------------------------
`define UV_DELAY_RTS                            10
//---------------------------------------------------------
`define UV_BAUD_RATE                            11
//---------------------------------------------------------
`define UV_CRYSTAL_FREQ                         12
//---------------------------------------------------------
`define UV_SET_PARITY                           13
//---------------------------------------------------------
`define UV_DELAY_CTS                            14
//---------------------------------------------------------
`define UV_BUFFER_FLUSH_DELAY                   24
//---------------------------------------------------------
`define UV_DISABLE_RTS_CTS_HANDSHAKE            22
//---------------------------------------------------------
`define UV_DISABLE_DTR_DSR_HANDSHAKE            23
//---------------------------------------------------------
`define UV_DISABLE_BFM_ERROR                    25
//---------------------------------------------------------
`define UV_1KB					1024
//---------------------------------------------------------
// `define UV_ONE_STOP_BIT				1
//---------------------------------------------------------
`define UV_COMM_OFF				100
//---------------------------------------------------------
`define UV_OFF					1
//---------------------------------------------------------
`define UV_NUM					2
//---------------------------------------------------------
`define UV_DWORD		                2001
//---------------------------------------------------------
`define UV_MODE_OF_OPERATION                    2002
//---------------------------------------------------------
`define UV_IN_BAND	                        1	   
//---------------------------------------------------------
`define UV_OUT_OF_BAND                          0

//---------------------------------------------------------
`define UV_MODE_BAND                            15
//---------------------------------------------------------
//---------------------------------------------------------
`define UV_WAIT_FOR_DSR                         18
//---------------------------------------------------------
//---------------------------------------------------------
`define UV_MAX_WAIT_FOR_START_AFTER_DTR         17
//---------------------------------------------------------

`define UV_DOCFG_INDEX                          2017

`define UV_STOP_BITS                            16        
`define UV_PARITY_BITS                          20 
`define UV_DATA_SZ                              21
`define UV_XON_DATA_PATTREN                     26
`define UV_XOFF_DATA_PATTREN                    27
`define UV_SEND_XON_DATA_PATTERN                28
`define UV_SEND_XOFF_DATA_PATTERN               29
`define UV_DTE_WAIT_FOR_XON_AFTR_POWER_UP       30
`define UV_MAX_DELAY_TO_XON_AFTER_XOFF          31  
`define UV_DRIVE_DTR_SIGNAL                     32  
`define UV_DRIVE_DSR_SIGNAL                     33

`define UV_ENABLE_TX_RX_HANDSHAKE               34
`define UV_IS_ACTIVE                            35

//---------------------------------------------------------
`define UV_BAUD_DIVISOR                         36
//---------------------------------------------------------
`define UV_DRIVE_BAUDOUT_PIN                    37
`ifdef SVT_UART
`define SVT_UART_ERR_STAT_IDX                   38
`endif
`define UV_ENABLE_FRACTIONAL_BRD                39
`define UV_FRACTIONAL_DIVISOR                   40
`define UV_FRACTIONAL_DIVISOR_PERIOD            41
`define UV_FRACTIONAL_MULT_MEDIAN               42
`define UV_ALL_DO_CFG_DONE                      43
`define UV_SAMPLE_RATE                          44
`define UV_RESYNC_RX_AT_EACH_BYTE               45
`define UV_ALLOW_AUTOFLOW_TRIGGER_RX_BUFFER     46
`define SVT_UART_DE_POLARITY                    47          
`define SVT_UART_RE_POLARITY                    48          
`define SVT_UART_DE_ASSERTION_DELAY             49   
`define SVT_UART_DE_DEASSERTION_DELAY           50 
`define SVT_UART_DE_TO_RE_TAT                   51         
`define SVT_UART_RE_TO_DE_TAT                   52         
`define SVT_UART_TRANSFER_MODE                  53        
`define SVT_UART_ENABLE_RS485                   54        
`define SVT_UART_DEASSERT_AUTOFLOW_HNDSHK_BEFORE_STOP_BIT    55
`define SVT_UART_PKT_CNT_TO_SEND_XOFF_PATTERN   56
`define SVT_UART_PKT_CNT_TO_SEND_XOFF_PATTERN_EXCEPTION   57
//`define SVT_UART_RE_ASSERTION_DELAY             55   
//`define SVT_UART_RE_DEASSERTION_DELAY           56 
`define UV_MODE_SEV_CHG                `UV_SEV_CHG
`define UV_DTE                                  0
`define UV_DCE                                  1

`define UV_MODE_OUTBAND                         0
`define UV_MODE_INBAND                          1

`define UV_RTS                                  0
`define UV_CTS                                  1
`define UV_SOUT                                 2 
`define UV_SIN                                  3
`define UV_DTR                                  4
`define UV_DSR                                  5
`define UV_DRIVE_ALL                            6

//Defines added for setting the sys_cfg class values.
//Required by reg script
`define UV_SET_BAUD_RATE                        38400
`define UV_SET_CRYSTAL_FREQ                     1843200
`define UV_SET_BAUD_DIV                         2
`define UV_PARITY                               1
`define UV_SET_DATA_SZ                          8
`define UV_BAND_MODE                            0
`define UV_STOP_BIT                             2
`define UV_DISABLE_RTS_CTS_HANDSHAKING          0
`define UV_DISABLE_DTR_DSR_HANDSHAKING          0
`define UV_DATA_PATTERN_ON                      11
`define UV_DATA_PATTERN_OFF                     13
`define UV_MAX_DEALY_XON_AFTR_XOFF              9000
`define UV_DTE_WAIT_XON_AFTR_POWER_UP           0
`define UV_EN_TX_RX_HANDSHAKE                   1

// Defines added for agent configuration variables
`define SVT_UART_MIN_BAUD_DIVISOR               1
`define SVT_UART_MAX_BAUD_DIVISOR               65535
`define SVT_UART_MIN_RX_BUFFER_SIZE             1
`define SVT_UART_MAX_RX_BUFFER_SIZE             2048
`define SVT_UART_MAX_DELAY_XON_XOFF_MIN_VAL     1
`define SVT_UART_MAX_DELAY_XON_XOFF_MAX_VAL     99999
`define SVT_UART_MIN_FRACTIONAL_DIVISOR         0
`define SVT_UART_MAX_FRACTIONAL_DIVISOR         9999
`define SVT_UART_MIN_FRACTIONAL_DIVISOR_PERIOD  4
`define SVT_UART_MAX_FRACTIONAL_DIVISOR_PERIOD  256
`define SVT_UART_MIN_FRACTIONAL_MULT_MEDIAN     1
`define SVT_UART_MAX_FRACTIONAL_MULT_MEDIAN     9999

`define SVT_UART_ENABLE_FRACTIONAL_BRD_DEFAULT       0
`define SVT_UART_FRACTIONAL_DIVISOR_DEFAULT          5
`define SVT_UART_FRACTIONAL_DIVISOR_PERIOD_DEFAULT   256
`define SVT_UART_FRACTIONAL_MULT_MEDIAN_DEFAULT      5
`define SVT_UART_SAMPLE_RATE_DEFAULT                 16

`define SVT_UART_MIN_SAMPLE_RATE  2
`define SVT_UART_MAX_SAMPLE_RATE  16

`define SVT_UART_PARITY_ERROR  1
`define SVT_UART_FRAMING_ERROR 2
`define SVT_UART_NO_OP_ERROR   3
   

//Modelsim on Verilog need `timescale on every module so defining
//define `UV_VERI_ON_MODEL

`ifdef INCA
`else
 `ifdef VCS
 `else
  `ifdef SVT_UART
  `else
   `define UV_VERI_ON_MODEL 1
  `endif
 `endif
`endif

//Define for SVT
`ifndef NVS_UV_SV_ENUM_PKG
 `ifdef SVT_UART 
  `define NVS_UV_SV_ENUM_PKG  svt_uart_enum_pkg
 `else
  `define NVS_UV_SV_ENUM_PKG  nvs_uv_sv_enum_pkg 
 `endif
`endif

/** @endcond */

// Defines for setting a component as active/passive.
`define SVT_UART_ACTIVE 1
`define SVT_UART_PASSIVE 0

/** @cond PRIVATE */

`define SVT_UART_BFM_IF     `NVS_UV_SV_BFM_IF   
`define SVT_UART_MON_IF     `NVS_UV_SV_MON_IF   
`define SVT_UART_CHK_IF     `NVS_UV_SV_CHK_IF 
`define SVT_UART_DTE_WRAPPER `NVS_UV_SV_BFM0_DRIVER
`define SVT_UART_DCE_WRAPPER `NVS_UV_SV_BFM1_DRIVER

`define SVT_UART_DTE_WRAPPER_INTANCE(INST_NAME, PORT_IF) \
        INST_NAME (PORT_IF            , \
		   PORT_IF.bfm_if     , \
		   PORT_IF.bfm_mon_if , \
		   PORT_IF.bfm_chk_if )



`define SVT_UART_STOP_ON_TIME  `UV_STOP_ON_TIME
`define SVT_UART_STOP_ON_COUNT  `UV_STOP_ON_COUNT
`define SVT_UART_SIMULATION_TIMEOUT  `UV_SIMULATION_TIMEOUT
`define SVT_UART_TIME_OUT  `UV_TIME_OUT
`define SVT_UART_ONE_STOP_BIT  `UV_ONE_STOP_BIT
`define SVT_UART_TWO_STOP_BIT  `UV_TWO_STOP_BIT
`define SVT_UART_START_BIT_SIZE  `UV_START_BIT_SIZE
`define SVT_UART_CLK_BFM_IDLE  `UV_CLK_BFM_IDLE
`define SVT_UART_CLK_BFM_IDLE_STOP_CNT  `UV_CLK_BFM_IDLE_STOP_CNT
`define SVT_UART_ONE  `UV_ONE
`define SVT_UART_ZERO  `UV_ZERO
`define SVT_UART_BAUDRATE_300  `UV_BAUDRATE_300
`define SVT_UART_BAUDRATE_600  `UV_BAUDRATE_600
`define SVT_UART_BAUDRATE_1200  `UV_BAUDRATE_1200
`define SVT_UART_BAUDRATE_2400  `UV_BAUDRATE_2400
`define SVT_UART_BAUDRATE_4800  `UV_BAUDRATE_4800
`define SVT_UART_BAUDRATE_9600  `UV_BAUDRATE_9600
`define SVT_UART_BAUDRATE_19200  `UV_BAUDRATE_19200
`define SVT_UART_BAUDRATE_38400  `UV_BAUDRATE_38400
`define SVT_UART_BAUDRATE_56000  `UV_BAUDRATE_56000
`define SVT_UART_BAUDRATE_57600  `UV_BAUDRATE_57600
`define SVT_UART_BAUDRATE_115200  `UV_BAUDRATE_115200
`define SVT_UART_BAUDRATE_128000  `UV_BAUDRATE_128000
`define SVT_UART_BAUDRATE_153600  `UV_BAUDRATE_153600
`define SVT_UART_BAUDRATE_230400  `UV_BAUDRATE_230400
`define SVT_UART_DEF_DELAY  `UV_DEF_DELAY
`define SVT_UART_WIDTH_DOCFG_PVAL  `UV_WIDTH_DOCFG_PVAL
`define SVT_UART_DWORD_ZERO  `UV_DWORD_ZERO
`define SVT_UART_DWORD_ONE  `UV_DWORD_ONE
`define SVT_UART_DWORD_TWO  `UV_DWORD_TWO
`define SVT_UART_DWORD_THREE  `UV_DWORD_THREE
`define SVT_UART_DWORD_FOUR  `UV_DWORD_FOUR
`define SVT_UART_DWORD_FIVE  `UV_DWORD_FIVE
`define SVT_UART_DWORD_CFG_CONTINUE  `UV_DWORD_CFG_CONTINUE
`define SVT_UART_DWORD_BREAK  `UV_DWORD_BREAK
`define SVT_UART_DO_ERR_INVAL_PARITY  `UV_DO_ERR_INVAL_PARITY
`define SVT_UART_DO_ERR_INVAL_STOP_BITS  `UV_DO_ERR_INVAL_STOP_BITS
`define SVT_UART_DO_ERR_BREAK_CONDITION  `UV_DO_ERR_BREAK_CONDITION
`define SVT_UART_DWORD_WIDTH  `UV_DWORD_WIDTH
`define SVT_UART_TRANS_CFG  `UV_TRANS_CFG
`define SVT_UART_SOUT_INVAL_ASSER  `UV_SOUT_INVAL_ASSER
`define SVT_UART_DTR_INVAL_ASSER  `UV_DTR_INVAL_ASSER
`define SVT_UART_INVAL_PARITY  `UV_INVAL_PARITY
`define SVT_UART_INVAL_STOP_BITS  `UV_INVAL_STOP_BITS
`define SVT_UART_BREAK_CONDITION  `UV_BREAK_CONDITION
`define SVT_UART_START_TIME_OUT  `UV_START_TIME_OUT
`define SVT_UART_DOERR_INDEX  `UV_DOERR_INDEX
`define SVT_UART_IDLE  `UV_IDLE
`define SVT_UART_SEV_CHG  `UV_SEV_CHG
`define SVT_UART_MODE_FILE_HANDLE  `UV_MODE_FILE_HANDLE
`define SVT_UART_MODE_CFG_CONTINUE  `UV_MODE_CFG_CONTINUE
`define SVT_UART_DTR_ASSERT_DELAY_TIME  `UV_DTR_ASSERT_DELAY_TIME
`define SVT_UART_RECEIVER_BUFFER_SIZE  `UV_RECEIVER_BUFFER_SIZE
`define SVT_UART_RECEIVER_NOT_READY  `UV_RECEIVER_NOT_READY
`define SVT_UART_BREAK  `UV_BREAK
`define SVT_UART_MODE_PKT_SZ  `UV_MODE_PKT_SZ
`define SVT_UART_INTER_CYCLE_DELAY  `UV_INTER_CYCLE_DELAY
`define SVT_UART_DELAY_RTS  `UV_DELAY_RTS
`define SVT_UART_BAUD_RATE  `UV_BAUD_RATE
`define SVT_UART_BAUD_DIVISOR  `UV_BAUD_DIVISOR
`define SVT_UART_CRYSTAL_FREQ  `UV_CRYSTAL_FREQ
`define SVT_UART_SET_PARITY  `UV_SET_PARITY
`define SVT_UART_DELAY_CTS  `UV_DELAY_CTS
`define SVT_UART_BUFFER_FLUSH_DELAY  `UV_BUFFER_FLUSH_DELAY
`define SVT_UART_DISABLE_RTS_CTS_HANDSHAKE  `UV_DISABLE_RTS_CTS_HANDSHAKE
`define SVT_UART_DISABLE_DTR_DSR_HANDSHAKE  `UV_DISABLE_DTR_DSR_HANDSHAKE
`define SVT_UART_ENABLE_RTS_CTS_HANDSHAKE  `UV_DISABLE_RTS_CTS_HANDSHAKE
`define SVT_UART_ENABLE_DTR_DSR_HANDSHAKE  `UV_DISABLE_DTR_DSR_HANDSHAKE
`define SVT_UART_DISABLE_BFM_ERROR  `UV_DISABLE_BFM_ERROR
`define SVT_UART_1KB  `UV_1KB
`define SVT_UART_COMM_OFF  `UV_COMM_OFF
`define SVT_UART_OFF  `UV_OFF
`define SVT_UART_NUM  `UV_NUM
`define SVT_UART_DWORD  `UV_DWORD
`define SVT_UART_MODE_OF_OPERATION  `UV_MODE_OF_OPERATION
`define SVT_UART_IN_BAND  `UV_IN_BAND
`define SVT_UART_OUT_OF_BAND  `UV_OUT_OF_BAND
`define SVT_UART_MODE_BAND  `UV_MODE_BAND
`define SVT_UART_WAIT_FOR_DSR  `UV_WAIT_FOR_DSR
`define SVT_UART_MAX_WAIT_FOR_START_AFTER_DTR  `UV_MAX_WAIT_FOR_START_AFTER_DTR
`define SVT_UART_DOCFG_INDEX  `UV_DOCFG_INDEX
`define SVT_UART_STOP_BITS  `UV_STOP_BITS
`define SVT_UART_PARITY_BITS  `UV_PARITY_BITS
`define SVT_UART_DATA_SZ  `UV_DATA_SZ
`define SVT_UART_XON_DATA_PATTREN  `UV_XON_DATA_PATTREN
`define SVT_UART_XOFF_DATA_PATTREN  `UV_XOFF_DATA_PATTREN
`define SVT_UART_SEND_XON_DATA_PATTERN  `UV_SEND_XON_DATA_PATTERN
`define SVT_UART_SEND_XOFF_DATA_PATTERN  `UV_SEND_XOFF_DATA_PATTERN
`define SVT_UART_DTE_WAIT_FOR_XON_AFTR_POWER_UP  `UV_DTE_WAIT_FOR_XON_AFTR_POWER_UP
`define SVT_UART_MAX_DELAY_TO_XON_AFTER_XOFF  `UV_MAX_DELAY_TO_XON_AFTER_XOFF
`define SVT_UART_DRIVE_DTR_SIGNAL  `UV_DRIVE_DTR_SIGNAL
`define SVT_UART_DRIVE_DSR_SIGNAL  `UV_DRIVE_DSR_SIGNAL
`define SVT_UART_ENABLE_TX_RX_HANDSHAKE  `UV_ENABLE_TX_RX_HANDSHAKE
`define SVT_UART_DRIVE_BAUDOUT_PIN `UV_DRIVE_BAUDOUT_PIN
`define SVT_UART_IS_ACTIVE  `UV_IS_ACTIVE
`define SVT_UART_MODE_SEV_CHG  `UV_MODE_SEV_CHG
`define SVT_UART_DTE  `UV_DTE
`define SVT_UART_DCE  `UV_DCE
`define SVT_UART_MODE_OUTBAND  `UV_MODE_OUTBAND
`define SVT_UART_MODE_INBAND  `UV_MODE_INBAND
`define SVT_UART_RTS  `UV_RTS
`define SVT_UART_CTS  `UV_CTS
`define SVT_UART_SOUT  `UV_SOUT
`define SVT_UART_SIN  `UV_SIN
`define SVT_UART_DTR  `UV_DTR
`define SVT_UART_DSR  `UV_DSR
`define SVT_UART_DRIVE_ALL  `UV_DRIVE_ALL
`define SVT_UART_SET_BAUD_RATE  `UV_SET_BAUD_RATE
`define SVT_UART_SET_CRYSTAL_FREQ  `UV_SET_CRYSTAL_FREQ
`define SVT_UART_PARITY  `UV_PARITY
`define SVT_UART_SET_DATA_SZ  `UV_SET_DATA_SZ
`define SVT_UART_BAND_MODE  `UV_BAND_MODE
`define SVT_UART_STOP_BIT  `UV_STOP_BIT
`define SVT_UART_DISABLE_RTS_CTS_HANDSHAKING  `UV_DISABLE_RTS_CTS_HANDSHAKING
`define SVT_UART_DISABLE_DTR_DSR_HANDSHAKING  `UV_DISABLE_DTR_DSR_HANDSHAKING
`define SVT_UART_DATA_PATTERN_ON  `UV_DATA_PATTERN_ON
`define SVT_UART_DATA_PATTERN_OFF  `UV_DATA_PATTERN_OFF
`define SVT_UART_MAX_DEALY_XON_AFTR_XOFF  `UV_MAX_DEALY_XON_AFTR_XOFF
`define SVT_UART_DTE_WAIT_XON_AFTR_POWER_UP  `UV_DTE_WAIT_XON_AFTR_POWER_UP
`define SVT_UART_EN_TX_RX_HANDSHAKE  `UV_EN_TX_RX_HANDSHAKE
`define SVT_UART_VERI_ON_MODEL  `UV_VERI_ON_MODEL
`define SVT_UART_BREAK_EN  `UV_BREAK_EN
`define SVT_UART_BREAK_DIS  `UV_BREAK_DIS
`define SVT_UART_FALSE  `UV_FALSE
`define SVT_UART_TRUE  `UV_TRUE
`define SVT_UART_ENABLE_FRACTIONAL_BRD `UV_ENABLE_FRACTIONAL_BRD
`define SVT_UART_FRACTIONAL_DIVISOR `UV_FRACTIONAL_DIVISOR
`define SVT_UART_FRACTIONAL_DIVISOR_PERIOD `UV_FRACTIONAL_DIVISOR_PERIOD
`define SVT_UART_FRACTIONAL_MULT_MEDIAN    `UV_FRACTIONAL_MULT_MEDIAN   
`define SVT_UART_ALL_DO_CFG_DONE `UV_ALL_DO_CFG_DONE
`define SVT_UART_SAMPLE_RATE `UV_SAMPLE_RATE
`define SVT_UART_RESYNC_RX_AT_EACH_BYTE `UV_RESYNC_RX_AT_EACH_BYTE
`define SVT_UART_ALLOW_AUTOFLOW_TRIGGER_RX_BUFFER `UV_ALLOW_AUTOFLOW_TRIGGER_RX_BUFFER

`ifndef SVT_UART_ENABLE_OBJECTIONS //Kept for BC.
`define SVT_UART_DISABLE_OBJECTIONS
`endif

`ifdef SVT_UART_DISABLE_OBJECTIONS
`define SVT_SEQUENCE_DISABLE_OBJECTIONS
`endif

/** @endcond */
//vcs_vip_protect 
`protected
50#3)b[37=)BP+9[IYcNR5=Q>VK0JVDZE@A4N()0EJOJ51aYBI@++(>HFR/CF7;X
81bc-8Y(;gPB)$
`endprotected



//**************************End Of File*********************************
