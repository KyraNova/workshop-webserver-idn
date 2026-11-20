# 06 — Local Domain & Virtual Host

Tujuan: membuka website dengan nama `http://halloween.local` alih-alih IP.

## Alur

```
http://halloween.local
   ▼ cek file hosts di laptop  → 192.168.x.x halloween.local   (IP VM kamu)
   ▼ request ke IP VM, Host: halloween.local
   ▼ Apache pilih Virtual Host yang ServerName-nya halloween.local
   ▼ DocumentRoot /var/www/halloween
```

## 1. Cek IP VM kamu

Di VM:

```bash
hostname -I
```

Catat IP pertama (contoh: `172.23.0.2`).

## 2. Buat Virtual Host untuk halloween

Salin contoh config dari repo (`configs/halloween.local.conf`):

```bash
sudo cp ~/project-web/workshop-webserver-idn/configs/halloween.local.conf /etc/apache2/sites-available/halloween.conf
```

Atau buat manual:

```bash
sudo nano /etc/apache2/sites-available/halloween.conf
```

Isi:

```apache
<VirtualHost *:80>
    ServerName halloween.local
    DocumentRoot /var/www/halloween

    <Directory /var/www/halloween>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/halloween-error.log
    CustomLog ${APACHE_LOG_DIR}/halloween-access.log combined
</VirtualHost>
```

## 3. Aktifkan site dan cek syntax

```bash
sudo a2ensite halloween.conf
sudo apache2ctl configtest
```

Output harus `Syntax OK`.

Nonaktifkan default site supaya tidak bentrok:

```bash
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
```

## 4. Atur file hosts di laptop

Tambahkan satu baris ke file hosts laptop, isi IP VM kamu:

```
192.168.x.x   halloween.local
```

Ganti `192.168.x.x` dengan IP VM kamu.

| OS | File hosts |
|----|-----------|
| Linux / macOS | `/etc/hosts` (edit dengan `sudo`) |
| Windows | `C:\Windows\System32\drivers\etc\hosts` (edit sebagai Administrator) |

## 5. Tes

Buka di browser laptop: `http://halloween.local`

Atau tes dari VM tanpa hosts:

```bash
curl -H "Host: halloween.local" http://localhost
```

## 6. Membuat web ke-2 dengan Virtual Host

Ulangi langkah yang sama dengan website `kopi`:

```bash
sudo mkdir -p /var/www/kopi
sudo cp -r ~/project-web/workshop-webserver-idn/website/kopi/. /var/www/kopi/
sudo cp ~/project-web/workshop-webserver-idn/configs/kopi.local.conf /etc/apache2/sites-available/kopi.conf
sudo a2ensite kopi.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

Tambahkan di file hosts laptop:

```
192.168.x.x   kopi.local
```

Lalu buka `http://kopi.local`. Kalau tampil halaman kopi, Virtual Host kedua sudah berjalan.

> Jangan lupa `sudo chown -R www-data:www-data /var/www/kopi` dan `chmod -R 755` seperti di [05](05-permission.md).

## Troubleshooting

| Gejala | Solusi |
|--------|--------|
| Masih tampil halaman Apache default | `a2dissite 000-default.conf` lalu `reload` |
| `403 Forbidden` | Jalankan ulang `chown` dan `chmod` |
| Domain tidak terbuka | Cek baris di file hosts, pastikan IP benar, VPN aktif |
| `configtest` error | Baca baris yang disebut, biasanya typo di `VirtualHost` |

Lanjut ke [07 — HTTPS & SSL](07-https-ssl.md).
