# 08 — Basic Authentication

## Apa itu?
**Basic Authentication** adalah metode autentikasi HTTP: browser menampilkan pop-up minta username dan password sebelum mengakses halaman atau folder tertentu.

Di langkah ini kita proteksi folder `/var/www/halloween/admin/`.

## 1. Buat folder yang akan diproteksi

```bash
sudo mkdir -p /var/www/halloween/admin
echo "<h1>Area Admin - rahasia</h1>" | sudo tee /var/www/halloween/admin/index.html
sudo chown -R www-data:www-data /var/www/halloween
```

## 2. Buat file kredensial dan daftarkan user `admin`

```bash
sudo htpasswd -c /etc/apache2/.htpasswd admin
```

Masukkan password saat diminta. Flag `-c` membuat file baru, jadi **jangan** pakai lagi untuk user berikutnya (cukup `htpasswd /etc/apache2/.htpasswd user2`).

Lihat isinya (password sudah di-hash):

```bash
sudo cat /etc/apache2/.htpasswd
```

> Kalau `htpasswd` tidak ada: `sudo apt install -y apache2-utils`

## 3. Terapkan konfigurasi Basic Auth ke virtual host

Edit file virtual host HTTPS:

```bash
sudo nano /etc/apache2/sites-available/halloween-ssl.conf
```

Tambahkan blok ini di dalam `<VirtualHost *:443>`, setelah blok `<Directory /var/www/halloween>`:

```apache
    <Directory /var/www/halloween/admin>
        AuthType Basic
        AuthName "Area Admin Halloween"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
    </Directory>
```

Contoh config lengkap ada di `configs/halloween-basicauth.conf`.

## 4. Terapkan perubahan ke service Apache

```bash
sudo apache2ctl configtest
sudo systemctl reload apache2
```

Harus `Syntax OK`.

## 5. Tes

Dari VM:

```bash
curl -k -H "Host: halloween.local" https://localhost/admin/
```

Tanpa login harus dapat `401 Unauthorized`. Dengan login:

```bash
curl -k -u admin:PASSWORD_KAMU -H "Host: halloween.local" https://localhost/admin/
```

Harus dapat `Area Admin - rahasia`.

Dari browser: buka `https://halloween.local/admin/`, akan muncul pop-up login.

## Troubleshooting

| Gejala | Solusi |
|--------|--------|
| Tidak ada pop-up, langsung terbuka | Pastikan blok `<Directory>` ada di vhost yang benar, lalu `reload` |
| `500 Internal Server Error` | `sudo tail -n 50 /var/log/apache2/error.log` |
| Password selalu salah | Ulangi `htpasswd -c` atau cek nama user |

## Penutup
Selamat, kamu sudah menyelesaikan workshop! Ringkasan:

1. Install & jalankan Apache2
2. Deploy website dari GitHub
3. Atur permission `www-data`
4. Local domain + Virtual Host
5. HTTPS dengan self-signed certificate
6. Basic Authentication

**Jangan lupa** ganti password dan hapus certificate buatan sendiri jika VM dipakai untuk hal lain.
