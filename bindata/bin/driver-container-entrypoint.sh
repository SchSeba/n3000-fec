#!/bin/bash
set -e

cd /var/extra/

modules=(regmap-mmio-mod.ko.xz intel-fpga-pci.ko.xz ifpga-sec-mgr.ko.xz fpga-mgr-mod.ko.xz
    spi-bitbang-mod.ko.xz i2c-altera.ko.xz intel-fpga-fme.ko.xz pac_n3000_net.ko.xz
    intel-max10.ko.xz intel-fpga-pac-iopll.ko.xz intel-fpga-afu.ko.xz intel-on-chip-flash.ko.xz
    c827_retimer.ko.xz avmmi-bmc.ko.xz intel-fpga-pac-hssi.ko.xz
    spi-altera-mod.ko.xz spi-nor-mod.ko.xz altera-asmip2.ko.xz intel-generic-qspi.ko.xz)

modules_reverse_order=$(printf '%s\n' "${modules[@]}" | tac | tr '\n' ' ')

load_drivers() {
    echo "Inserting modules:" "${modules[@]}"
    for mod in "${modules[@]}"; do
        insmod "${mod}"
    done
}

unload_drivers() {
    echo "Removing modules:" "${modules_reverse_order}"
    for mod in ${modules_reverse_order// / }; do
        rmmod "${mod}"
    done
}

modprobe mtd

trap unload_drivers EXIT

load_drivers

echo "ready" > /tmp/healthy
echo "Sleeping infinitely"
sleep INF