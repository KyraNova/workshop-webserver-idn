# 04 — Deploy Website dari GitHub

Tujuan: mengambil website contoh dari GitHub lalu menaruhnya di document root.

Ada dua website untuk workshop ini:

| Folder di repo | Asal (GitHub asli) | Domain nanti |
|----------------|--------------------|--------------|
| `website/halloween/` | [bedimcode/responsive-halloween-website](https://github.com/bedimcode/responsive-halloween-website) | `halloween.local` |
| `website/games/` | [masonicGIT/pacman](https://github.com/masonicGIT/pacman) | `games.local` |

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

## 3. Clone repository workshop

```bash
git clone https://github.com/KyraNova/workshop-webserver-idn.git
```

Masuk ke folder website:

```bash
cd ~/project-web/workshop-webserver-idn/website
ls -la
```

Kamu akan melihat folder `halloween/` dan `games/`.

## 4. Pindahkan file ke document root

Website Halloween:

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
- Website `games` (Pac-Man) dipasang dengan cara yang sama di [06](06-local-domain-virtualhost.md), dengan folder tujuan `/var/www/games`.

Lanjut ke [05 — Permission](05-permission.md).
