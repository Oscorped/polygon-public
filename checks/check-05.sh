#!/usr/bin/env bash
# Миссия 05 — протокол приёмки и релиз
set -u
fail=0
p="project/docs/приёмка.md"
[ -s "$p" ] || { echo "FAIL: нет $p"; fail=1; }
if [ -s "$p" ]; then
  grep -qiE "провал|прош" "$p" || { echo "FAIL: в протоколе нет вердиктов прошёл/провален"; fail=1; }
fi
grep -qi "релиз" "project/docs/decisions.md" 2>/dev/null || { echo "FAIL: в журнале решений нет записи о релизе"; fail=1; }
[ -s "project/index.html" ] || { echo "FAIL: нет project/index.html"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: протокол приёмки и запись о релизе на месте"
exit $fail
