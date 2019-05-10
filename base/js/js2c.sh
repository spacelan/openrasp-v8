#!/bin/bash

set -ex

cat console.js checkpoint.js context.js error.js flex.js rasp.js > builtins

xxd -i builtins > js.h

rm builtins