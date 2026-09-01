#!/usr/bin/env bash
# Миссия 01 — структурная проверка конституции
set -u
fail=0
f="project/AGENTS.md"
if [ ! -s "$f" ]; then echo "FAIL: $f отсутствует или пуст"; exit 1; fi
for word in "Тон" "Границ" "готово"; do
  grep -qi "$word" "$f" || { echo "FAIL: в конституции не найден блок про: $word"; fail=1; }
done
lines=$(grep -c "" "$f")
[ "$lines" -ge 15 ] || { echo "FAIL: конституция подозрительно короткая ($lines строк) — похоже на заглушки"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: конституция на месте, все блоки присутствуют"
exit $fail
