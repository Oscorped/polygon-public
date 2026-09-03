#!/usr/bin/env bash
# Миссия 01 — структурная проверка конституции
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: не найден корень полигона"; exit 1; }
fail=0
f="project/AGENTS.md"
if [ ! -s "$f" ]; then echo "FAIL: $f отсутствует или пуст"; exit 1; fi
check() { grep -qE "$1" "$f" || { echo "FAIL: в конституции не найден блок про: $2"; fail=1; }; }
check "Тон|тон|ТОН" "тон"
check "Границ|границ|ГРАНИЦ" "границы"
check "готово|Готово|ГОТОВО|done|Done|DONE" "готово (Definition of done)"
lines=$(grep -c "" "$f")
[ "$lines" -ge 15 ] || { echo "FAIL: конституция подозрительно короткая ($lines строк) — похоже на заглушки"; fail=1; }
[ "$fail" -eq 0 ] && echo "OK: конституция на месте, все блоки присутствуют"
exit $fail
