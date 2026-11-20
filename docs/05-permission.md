# 05 — File Permission: Siapa Pemilik File Ini?

## Masalahnya
Setelah file masuk lewat `git clone` lalu dipindah dengan `sudo`, pemiliknya adalah **root**.

Apache di Ubuntu berjalan sebagai user **`www-data`**. Kalau `www-data` tidak punya izin baca, browser akan dapat error **403 Forbidden**.

## Cek kondisi sekarang

```bash
ls -la /var/www/halloween
curl -I http://localhost/halloween/
```

## Perbaikan

Ubah pemilik folder dan isinya menjadi `www-data`:

```bash
sudo chown -R www-data:www-data /var/www/halloween
```

Beri permission standar yang aman (*least privilege*):

```bash
sudo chmod -R 755 /var/www/halloween
```

| Izin | Arti |
|------|------|
| `7` (owner) | baca, tulis, eksekusi |
| `5` (group & other) | baca, eksekusi (tidak bisa tulis) |

## Verifikasi

```bash
ls -la /var/www/halloween
```

Pemilik harus `www-data www-data`. Lalu cek dari browser: `http://<IP_VM>/halloween/`.

> Catatan: di langkah 06 kita akan membuat virtual host sendiri. Di sana `DocumentRoot` mengarah ke `/var/www/halloween`, jadi URL-nya langsung `http://halloween.local/` tanpa `/halloween/`.

Lanjut ke [06 — Local Domain & Virtual Host](06-local-domain-virtualhost.md).
