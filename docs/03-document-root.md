# 03 — Document Root

**Document Root** adalah folder utama yang dibaca Apache untuk menyajikan file ke browser. Lokasi default di Ubuntu:

```
/var/www/html/
└── index.html   ← file pertama yang dikirim ke browser
```

## 1. Masuk ke folder Document Root

```bash
cd /var/www/html
ls -la
```

## 2. Cek file bawaan Apache

```bash
cat index.html | head -n 20
```

## 3. Ubah `index.html` dengan teks buatanmu

Cara paling mudah: pakai `nano`.

```bash
sudo nano /var/www/html/index.html
```

Ganti isinya dengan contoh berikut (boleh diubah sesuai selera):

```html
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Website Saya</title>
</head>
<body>
  <h1>Halo dari Web Server saya!</h1>
  <p>Dibuat oleh: NAMA KAMU</p>
</body>
</html>
```

Simpan: `Ctrl+O`, `Enter`, lalu keluar: `Ctrl+X`.

## 4. Lihat hasilnya

```bash
curl http://localhost
```

Atau buka `http://<IP_VM>` di browser laptop. Refresh browser jika masih tampil halaman lama.

## Catatan
- Saat ini file masih dimiliki `root`. Itu akan dibahas di [05 — Permission](05-permission.md).
- Backup dulu sebelum mengubah file bawaan:
  ```bash
  sudo cp /var/www/html/index.html /var/www/html/index.html.bak
  ```

Lanjut ke [04 — Deploy dari GitHub](04-deploy-dari-github.md).
