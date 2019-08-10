#!/usr/bin/env sh

set -eu

irb \
  -I lib/ \
  -r test_bench/fixture \
  -r test_bench/fixture/controls \
  --readline \
  --prompt simple \
  $@
