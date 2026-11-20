#!/usr/bin/env bash
# Cek cepat status workshop di VM peserta.
# Pemakaian: bash scripts/cek-status.sh

set -u

ok()   { echo "[OK]   $*"; }
fail() { echo "[GAGAL] $*"; }

echo "== Apache =="
if systemctl is-active --quiet apache2; then ok "apache2 running"; else fail "apache2 tidak running"; fi
if sudo apache2ctl configtest 2>&1 | grep -q "Syntax OK"; then ok "konfigurasi valid"; else fail "konfigurasi error (jalankan: sudo apache2ctl configtest)"; fi

echo
echo "== Website =="
for d in halloween kopi; do
  if [ -d "/var/www/$d" ]; then
    owner=$(stat -c '%U:%G' "/var/www/$d")
    if [ "$owner" = "www-data:www-data" ]; then ok "/var/www/$d owner $owner"; else fail "/var/www/$d owner $owner (harus www-data:www-data)"; fi
  else
    fail "/var/www/$d belum ada"
  fi
done

echo
echo "== Virtual Host aktif =="
sudo apache2ctl -S 2>/dev/null | grep -E "namevhost|port (80|443)" || true

echo
echo "== Tes HTTP lokal =="
for h in halloween.local kopi.local; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -H "Host: $h" http://localhost/)
  echo "$h -> HTTP $code"
done
