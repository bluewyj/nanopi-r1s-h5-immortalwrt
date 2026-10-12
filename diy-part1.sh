#!/bin/bash
#
# diy-part1.sh
# 执行时机：`./scripts/feeds update -a` 之前
#
# 说明：ImmortalWrt 25.12 自带的 feeds 里已经包含 luci-app-passwall、
#       luci-app-openclash、samba4、aria2、transmission、dockerman、diskman 等。
#       本脚本额外追加 iStore（luci-app-store）第三方源。
#
set -e

OPENWRT_DIR="${GITHUB_WORKSPACE:-$(pwd)}/openwrt"
FEEDS_FILE="${OPENWRT_DIR}/feeds.conf.default"

echo "==> [diy-part1] 源码目录: ${OPENWRT_DIR}"
echo "==> [diy-part1] 当前 feeds.conf.default:"
cat "${FEEDS_FILE}"

# ---------------------------------------------------------------------------
# iStore 软件中心（易有云 / iStoreOS）
# 官方集成方式：https://github.com/linkease/istore
# 依赖 luci-compat（已在 configs/nanopi-r1s-h5.config 中启用）
# ---------------------------------------------------------------------------
echo >> "${FEEDS_FILE}"
echo 'src-git istore https://github.com/linkease/istore;main' >> "${FEEDS_FILE}"
echo "==> [diy-part1] 已追加 istore feed"

# ---------------------------------------------------------------------------
# 可选：如果你想要上游最新版的 PassWall（比 ImmortalWrt 自带的新，但会和自带
#       的同名包冲突，二选一），打开下面两行注释即可。
# ---------------------------------------------------------------------------
# echo "src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git;main" >> "${FEEDS_FILE}"
# echo "src-git passwall_pkg  https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "${FEEDS_FILE}"

# ---------------------------------------------------------------------------
# 可选：换用国内镜像抓源码（GitHub Actions 在美国跑，一般不需要；本地编译可以开）
# ---------------------------------------------------------------------------
# sed -i 's#https://github.com/immortalwrt/packages.git#https://mirror.sjtu.edu.cn/git/immortalwrt/packages.git#' "${FEEDS_FILE}"

echo "==> [diy-part1] 完成后的 feeds.conf.default:"
cat "${FEEDS_FILE}"
echo "==> [diy-part1] 完成"
