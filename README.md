# Workshop Web Server — ID-Networkers

Repo materi workshop **Web Server (Apache2)**. Semua langkah ada di folder `docs/`, urut dari 00 sampai 08.

## Peta Materi

| Urutan | File | Isi |
|-------:|------|-----|
| 00 | [docs/00-persiapan.md](docs/00-persiapan.md) | Connect VPN, ambil akun SSH dari spreadsheet, login ke VM |
| 01 | [docs/01-konsep-web-server.md](docs/01-konsep-web-server.md) | Konsep web server, client-server, apa yang terjadi saat buka website |
| 02 | [docs/02-install-apache.md](docs/02-install-apache.md) | Install Apache2, cek status, halaman default |
| 03 | [docs/03-document-root.md](docs/03-document-root.md) | Document root, ubah `index.html` |
| 04 | [docs/04-deploy-dari-github.md](docs/04-deploy-dari-github.md) | Deploy website dari GitHub (git clone) |
| 05 | [docs/05-permission.md](docs/05-permission.md) | Kepemilikan file, `www-data`, `chown` & `chmod` |
| 06 | [docs/06-local-domain-virtualhost.md](docs/06-local-domain-virtualhost.md) | Local domain (`hosts`) dan Virtual Host |
| 07 | [docs/07-https-ssl.md](docs/07-https-ssl.md) | SSL/TLS, self-signed certificate, HTTPS |
| 08 | [docs/08-basic-auth.md](docs/08-basic-auth.md) | Basic Authentication |

Ringkasan target: setelah workshop kamu bisa menjelaskan fungsi web server, menginstall & menjalankan Apache2, men-deploy website sederhana, membuat local domain dengan Virtual Host, mengaktifkan HTTPS, dan menambahkan Basic Authentication.

## Cara Pakai Repo Ini

```bash
# di VM kamu (sebagai user peserta, dengan sudo)
git clone https://github.com/<USERNAME>/workshop-webserver-idn.git
cd workshop-webserver-idn
```

Lalu ikuti dokumen `docs/` satu per satu. Isi folder `website/` dan `configs/` bisa langsung disalin (`cp`) ke lokasi yang ditunjuk di setiap langkah.

## Struktur

```
docs/       panduan langkah demi langkah (baca ini)
website/    contoh website yang akan di-deploy
configs/    contoh file konfigurasi Apache (VirtualHost, SSL, Basic Auth)
scripts/    skrip bantu (cek status, rollback)
```

## Catatan Keamanan

- Password di spreadsheet hanya untuk workshop. **Ganti** password setelah workshop selesai.
- Jangan commit kredensial, private key, atau file `.htpasswd` ke repo.
