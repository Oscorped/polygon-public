#!/usr/bin/env bash
# Миссия 04 — разведка и решение по её итогам
set -u
fail=0
r="project/docs/recon-04.md"
[ -s "$r" ] || { echo "FAIL: нет $r"; fail=1; }
if [ -s "$r" ]; then
  grep -qE "^\|.*\|.*\|" "$r" || { echo "FAIL: в разведке нет сводной таблицы"; fail=1; }
  grep -qiE "нет данных" "$r" || { echo "FAIL: в постановке нет правила про «нет данных»"; fail=1; }
fi
grep -qi "разведк" "project/docs/decisions.md" 2>/dev/null || { echo "FAIL: в журнале решений нет записи со ссылкой на разведку"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: разведка со сводом и решение в журнале на месте"
exit $fail
