#!/usr/bin/env bash
# Миссия 02 — бриф и скелет витрины
set -u
fail=0
[ -s "project/docs/brief-01.md" ] || { echo "FAIL: нет project/docs/brief-01.md"; fail=1; }
if [ -s "project/docs/brief-01.md" ]; then
  blocks=$(grep -cE "^#{1,3} |^[0-9]\." "project/docs/brief-01.md")
  [ "$blocks" -ge 5 ] || { echo "FAIL: в брифе меньше пяти блоков (найдено $blocks)"; fail=1; }
fi
[ -s "project/index.html" ] || { echo "FAIL: нет project/index.html — скелет не построен"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: бриф из пяти блоков и скелет витрины на месте"
exit $fail
