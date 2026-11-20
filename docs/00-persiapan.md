# 00 — Persiapan

## 1. Connect VPN
Hubungkan laptop ke jaringan workshop.

- SSID: `IDN`
- Password: `idnmantab`

## 2. Ambil akun VM kamu
Buka spreadsheet **Dashboard Akses SSH Workshop**:

1. Cari baris berstatus **Tersedia**.
2. Isi namamu di kolom **Nama Peserta**. Baris itu jadi milikmu.
3. Salin kolom **Command SSH** dan kolom **Password** dari baris tersebut.

Contoh: `ssh peserta1@172.23.0.2` dengan password sesuai baris itu.

> Jangan pakai baris peserta lain. Jangan tulis password di repo.

## 3. Login ke VM
Dari terminal laptop:

```bash
ssh peserta1@172.23.0.2
```

Ketik `yes` jika ditanya fingerprint, lalu masukkan password.

## 4. Cek koneksi
Di dalam VM:

```bash
whoami
hostname -I
```

Catat IP VM kamu. IP ini dipakai di langkah local domain (06).

## 5. Update paket (sekali saja)

```bash
sudo apt update
```

Jika selesai tanpa error, kamu siap lanjut ke [01 — Konsep Web Server](01-konsep-web-server.md).
