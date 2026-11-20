# 04 — Deploy Website dari GitHub

Tujuan: mengambil website contoh dari GitHub lalu menaruhnya di document root.

## 1. Pastikan git sudah terinstall

```bash
git --version
```

Jika belum ada:

```bash
sudo apt install -y git
```

## 2. Siapkan direktori project baru

```bash
mkdir -p ~/project-web
cd ~/project-web
```

## 3. Clone repository website

```bash
git clone https://github.com/<USERNAME>/workshop-webserver-idn.git
```

Ganti `<USERNAME>` dengan username GitHub pemilik repo workshop (diberikan instruktur).

Masuk ke folder website contoh:

```bash
cd ~/project-web/workshop-webserver-idn/website
ls -la
```

Kamu akan melihat folder `halloween/` dan `kopi/`.

## 4. Pindahkan file ke document root

Contoh untuk website `halloween`:

```bash
sudo mkdir -p /var/www/halloween
sudo cp -r ~/project-web/workshop-webserver-idn/website/halloween/. /var/www/halloween/
```

Cek hasilnya:

```bash
ls -la /var/www/halloween
```

Ada `index.html` di sana.

## Catatan
- Setelah dipindah dengan `sudo cp`, pemilik file menjadi `root`. Ini dibenahi di [05 — Permission](05-permission.md).
- Kalau nanti kamu ubah file di repo, ulangi `git pull` lalu `sudo cp` lagi.

Lanjut ke [05 — Permission](05-permission.md).
