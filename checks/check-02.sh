#!/usr/bin/env bash
# Миссия 02 — бриф и скелет витрины
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: не найден корень полигона"; exit 1; }
fail=0
b="project/docs/brief-01.md"
[ -s "$b" ] || { echo "FAIL: нет $b"; fail=1; }
if [ -s "$b" ]; then
  # блок = заголовок, нумерованный пункт или жирная метка вида **Для кого:**
  blocks=$(grep -cE '^(#{1,3} |[0-9]+\. |- \*\*|\*\*)' "$b")
  [ "$blocks" -ge 5 ] || { echo "FAIL: в брифе меньше пяти блоков (найдено $blocks)"; fail=1; }
fi
[ -s "project/index.html" ] || { echo "FAIL: нет project/index.html — скелет не построен"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: бриф из пяти блоков и скелет витрины на месте"
exit $fail
