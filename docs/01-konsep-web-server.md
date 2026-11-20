# 01 — Konsep Web Server

## Web server itu apa?
Web server adalah **software** yang menerima *request* dari client (misal browser) lalu mengirim *response* berupa halaman web atau resource yang diminta.

```
Browser  ──request──▶  Web Server
Browser  ◀─response──  Web Server
```

## Client & Server

| Peran | Contoh |
|-------|--------|
| Client | Web browser, mobile app, desktop app |
| Server | Web server, database server |

## Apa yang terjadi saat kamu membuka `http://halloween.local`?

1. Browser cek alamat domain ke file `hosts` di laptop (atau DNS).
2. Didapat IP tujuan, browser membuka koneksi ke port **80** (HTTP) atau **443** (HTTPS).
3. Browser mengirim request: `GET / HTTP/1.1` dengan header `Host: halloween.local`.
4. Web server mencari file di *document root*, lalu mengirim response (`200 OK` + HTML).
5. Browser merender HTML.

## Layanan Web Server
Di workshop ini kita pakai **Apache HTTP Server** — web server open-source yang melayani website lewat protokol HTTP/HTTPS.

Kenapa Apache?
- Stabil dan matang, ekosistemnya besar
- Banyak dipakai di dunia nyata
- Konfigurasi fleksibel
- Mendukung Virtual Host
- Punya banyak modul

## Cek pemahaman
1. Apa beda client dan server?
2. Port berapa untuk HTTP dan HTTPS?
3. Apa fungsi header `Host` pada request?

Lanjut ke [02 — Install Apache2](02-install-apache.md).
