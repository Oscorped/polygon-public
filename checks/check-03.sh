#!/usr/bin/env bash
# Миссия 03 — журнал решений, триггер, саммари
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: не найден корень полигона"; exit 1; }
fail=0
d="project/docs/decisions.md"
[ -s "$d" ] || { echo "FAIL: нет $d"; fail=1; }
if [ -s "$d" ]; then
  # записи таблицы: строки с | минус шапка и разделитель
  table=$(grep -cE '^\|' "$d"); [ "$table" -ge 2 ] && table=$((table - 2)) || table=0
  # записи списком: строка с тремя разделителями « — » (дата — решение — причина — источник)
  list=$(awk -F' — ' 'NF>=4{c++} END{print c+0}' "$d")
  entries=$table; [ "$list" -gt "$entries" ] && entries=$list
  [ "$entries" -ge 3 ] || { echo "FAIL: в журнале меньше 3 записей формата дата | решение | причина | источник (найдено $entries)"; fail=1; }
fi
grep -qE "журнал|Журнал|ЖУРНАЛ" "project/AGENTS.md" 2>/dev/null || { echo "FAIL: в project/AGENTS.md нет правила про журнал решений"; fail=1; }
[ -s "project/docs/summary.md" ] || { echo "FAIL: нет project/docs/summary.md"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: журнал, правило-триггер и передаточное саммари на месте"
exit $fail
