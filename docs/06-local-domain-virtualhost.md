# 06 — Local Domain & Virtual Host

Tujuan: membuka website dengan nama `http://halloween.local` dan `http://games.local` alih-alih IP.

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

```bash
sudo cp ~/project-web/workshop-webserver-idn/configs/halloween.local.conf /etc/apache2/sites-available/halloween.conf
```

Atau buat manual dengan `sudo nano /etc/apache2/sites-available/halloween.conf`:

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

| OS | File hosts |
|----|-----------|
| Linux / macOS | `/etc/hosts` (edit dengan `sudo`) |
| Windows | `C:\Windows\System32\drivers\etc\hosts` (edit sebagai Administrator) |

## 5. Tes

Buka `http://halloween.local` di browser laptop.

Atau tes dari VM tanpa hosts:

```bash
curl -H "Host: halloween.local" http://localhost
```

## 6. Virtual Host ke-2: games (Pac-Man)

```bash
sudo mkdir -p /var/www/games
sudo cp -r ~/project-web/workshop-webserver-idn/website/games/. /var/www/games/
sudo cp ~/project-web/workshop-webserver-idn/configs/games.local.conf /etc/apache2/sites-available/games.conf
sudo a2ensite games.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

Tambahkan di file hosts laptop:

```
192.168.x.x   games.local
```

Lalu buka `http://games.local`. Game Pac-Man akan tampil dan bisa dimainkan. Kalau halaman kosong, cek console browser (F12).

> Jangan lupa `sudo chown -R www-data:www-data /var/www/games` dan `chmod -R 755` seperti di [05](05-permission.md).

## Troubleshooting

| Gejala | Solusi |
|--------|--------|
| Masih tampil halaman Apache default | `a2dissite 000-default.conf` lalu `reload` |
| `403 Forbidden` | Jalankan ulang `chown` dan `chmod` |
| Domain tidak terbuka | Cek baris di file hosts, pastikan IP benar, VPN aktif |
| `configtest` error | Baca baris yang disebut, biasanya typo di `VirtualHost` |

Lanjut ke [07 — HTTPS & SSL](07-https-ssl.md).
