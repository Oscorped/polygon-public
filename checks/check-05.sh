#!/usr/bin/env bash
# Миссия 05 — протокол приёмки и релиз
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: не найден корень полигона"; exit 1; }
fail=0
p="project/docs/acceptance.md"
[ -s "$p" ] || { echo "FAIL: нет $p"; fail=1; }
if [ -s "$p" ]; then
  grep -qE "провал|Провал|ПРОВАЛ|прош|Прош|ПРОШ" "$p" || { echo "FAIL: в протоколе нет вердиктов прошёл/провален"; fail=1; }
fi
grep -qE "релиз|Релиз|РЕЛИЗ" "project/docs/decisions.md" 2>/dev/null || { echo "FAIL: в журнале решений нет записи о релизе"; fail=1; }
[ -s "project/index.html" ] || { echo "FAIL: нет project/index.html"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: протокол приёмки и запись о релизе на месте"
exit $fail
