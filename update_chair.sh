#!/usr/bin/env bash
set -ex
git pull origin master
sload flash kernel/latest
sload program userland/latest
sload burnfuses --wdt --bor
