# 02 — Install Apache2

## 1. Install Apache

```bash
sudo apt install -y apache2
```

## 2. Cek status service

```bash
sudo systemctl status apache2
```

Harus tertulis `active (running)`. Keluar dengan tombol `q`.

Alternatif singkat:

```bash
systemctl is-active apache2
```

Output: `active`.

## 3. Cek halaman default
Dari VM:

```bash
curl http://localhost
```

Atau dari laptop, buka browser ke `http://<IP_VM>` (IP dari langkah 00).

Kamu akan melihat halaman **"Apache2 Ubuntu Default Page"**.

## Troubleshooting

| Gejala | Solusi |
|--------|--------|
| `Unit apache2.service not found` | Ulangi `sudo apt install -y apache2` |
| Halaman tidak muncul dari laptop | Pastikan VPN aktif dan pakai IP VM yang benar |
| Status `failed` | Cek `sudo apache2ctl configtest` lalu `sudo journalctl -u apache2 -n 50` |

Lanjut ke [03 — Document Root](03-document-root.md).
