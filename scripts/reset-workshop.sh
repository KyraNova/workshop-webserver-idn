#!/usr/bin/env bash
# Mengembalikan VM ke kondisi awal (setelah 02) untuk mengulang workshop.
# HANYA menonaktifkan site buatan workshop dan menghapus file yang dibuat workshop.
# Pemakaian: sudo bash scripts/reset-workshop.sh

set -eu

if [ "$(id -u)" -ne 0 ]; then
  echo "Jalankan dengan sudo." >&2
  exit 1
fi

a2dissite halloween.conf kopi.conf halloween-ssl.conf 2>/dev/null || true
a2ensite 000-default.conf >/dev/null 2>&1 || true
rm -f /etc/apache2/sites-available/halloween.conf \
      /etc/apache2/sites-available/kopi.conf \
      /etc/apache2/sites-available/halloween-ssl.conf
rm -rf /var/www/halloween /var/www/kopi
rm -f /etc/apache2/.htpasswd
rm -f /etc/ssl/certs/halloween.crt /etc/ssl/private/halloween.key

apache2ctl configtest
systemctl reload apache2
echo "Reset selesai. Apache kembali ke halaman default."
