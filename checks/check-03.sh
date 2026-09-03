#!/usr/bin/env bash
# Миссия 03 — журнал решений, триггер, саммари
set -u
fail=0
d="project/docs/decisions.md"
[ -s "$d" ] || { echo "FAIL: нет $d"; fail=1; }
if [ -s "$d" ]; then
  rows=$(grep -cE "^\|.*\|.*\|.*\|" "$d")
  [ "$rows" -ge 4 ] || { echo "FAIL: в журнале меньше 3 записей (строк таблицы: $rows, включая шапку)"; fail=1; }
fi
grep -qi "журнал" "project/AGENTS.md" 2>/dev/null || { echo "FAIL: в project/AGENTS.md нет правила про журнал решений"; fail=1; }
[ -s "project/docs/summary.md" ] || { echo "FAIL: нет project/docs/summary.md"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: журнал, правило-триггер и передаточное саммари на месте"
exit $fail
