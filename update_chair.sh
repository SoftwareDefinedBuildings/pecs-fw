#!/usr/bin/env bash
set -ex
sload flash kernel/latest
sload program userland/latest
sload burnfuses --wdt --bor
