// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// xbar_peri_bind module generated by `tlgen.py` tool for assertions
module xbar_peri_bind;

  // Host interfaces
  bind xbar_peri tlul_assert #(.EndpointType("Device")) tlul_assert_host_main (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_main_i),
    .d2h    (tl_main_o)
  );

  // Device interfaces
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_uart (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_uart_o),
    .d2h    (tl_uart_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_gpio (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_gpio_o),
    .d2h    (tl_gpio_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_spi_device (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_spi_device_o),
    .d2h    (tl_spi_device_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_rv_timer (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_rv_timer_o),
    .d2h    (tl_rv_timer_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_usbdev (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_usbdev_o),
    .d2h    (tl_usbdev_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_pwrmgr (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_pwrmgr_o),
    .d2h    (tl_pwrmgr_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_rstmgr (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_rstmgr_o),
    .d2h    (tl_rstmgr_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_clkmgr (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_clkmgr_o),
    .d2h    (tl_clkmgr_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_ram_ret (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_ram_ret_o),
    .d2h    (tl_ram_ret_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_otp_ctrl (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_otp_ctrl_o),
    .d2h    (tl_otp_ctrl_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_lc_ctrl (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_lc_ctrl_o),
    .d2h    (tl_lc_ctrl_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_sensor_ctrl (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_sensor_ctrl_o),
    .d2h    (tl_sensor_ctrl_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_alert_handler (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_alert_handler_o),
    .d2h    (tl_alert_handler_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_sram_ctrl_ret (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_sram_ctrl_ret_o),
    .d2h    (tl_sram_ctrl_ret_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_nmi_gen (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_nmi_gen_o),
    .d2h    (tl_nmi_gen_i)
  );
  bind xbar_peri tlul_assert #(.EndpointType("Host")) tlul_assert_device_ast_wrapper (
    .clk_i  (clk_peri_i),
    .rst_ni (rst_peri_ni),
    .h2d    (tl_ast_wrapper_o),
    .d2h    (tl_ast_wrapper_i)
  );

endmodule
