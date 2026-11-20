# 07 — HTTPS dengan Self-Signed Certificate

## Apa itu SSL/TLS?
**SSL** (Secure Sockets Layer) adalah protokol untuk mengenkripsi data antara server dan client. SSL awalnya dikembangkan Netscape di tahun 1990-an. Sekarang standarnya sudah digantikan **TLS**, tapi istilah SSL masih sering dipakai.

## Kenapa butuh HTTPS?

| | HTTP (port 80) | HTTPS (port 443) |
|--|----------------|------------------|
| Data | Teks polos (plaintext) | Terenkripsi (TLS) |
| Risiko | Mudah disadap (sniffing / MITM) | Jauh lebih aman |

## 1. Aktifkan modul SSL di Apache

```bash
sudo a2enmod ssl
sudo systemctl restart apache2
```

## 2. Buat private key & certificate sekaligus dengan OpenSSL

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/halloween.key \
  -out /etc/ssl/certs/halloween.crt \
  -subj "/C=ID/ST=Jawa Barat/L=Bandung/O=Workshop/CN=halloween.local"
```

Penjelasan:
- `-x509` : buat certificate langsung (self-signed)
- `-nodes` : private key tidak diberi password
- `-days 365` : berlaku 1 tahun
- `-newkey rsa:2048` : buat key baru 2048-bit
- `-subj` : isi identitas, `CN` harus sama dengan domain

## 3. Buat Virtual Host HTTPS

Salin contoh dari repo:

```bash
sudo cp ~/project-web/workshop-webserver-idn/configs/halloween-ssl.conf /etc/apache2/sites-available/halloween-ssl.conf
```

Isinya:

```apache
<VirtualHost *:443>
    ServerName halloween.local
    DocumentRoot /var/www/halloween

    SSLEngine on
    SSLCertificateFile    /etc/ssl/certs/halloween.crt
    SSLCertificateKeyFile /etc/ssl/private/halloween.key

    <Directory /var/www/halloween>
        Options -Indexes +FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/halloween-ssl-error.log
    CustomLog ${APACHE_LOG_DIR}/halloween-ssl-access.log combined
</VirtualHost>
```

## 4. Aktifkan dan cek

```bash
sudo a2ensite halloween-ssl.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
```

Tes dari VM:

```bash
curl -k https://localhost -H "Host: halloween.local"
```

`-k` dipakai karena certificate buatan sendiri tidak dipercaya oleh sistem.

## 5. Buka di browser

Buka `https://halloween.local`. Browser akan memberi peringatan *"Your connection is not private"* — ini **normal** untuk self-signed. Pilih *Advanced → Proceed* (Chrome) atau *Advanced → Accept the Risk* (Firefox).

Cek gembok di address bar, lalu lihat detail certificate: `CN=halloween.local`.

## 6. (Opsional) Redirect HTTP ke HTTPS

Tambahkan di `halloween.conf` (blok port 80):

```apache
<VirtualHost *:80>
    ServerName halloween.local
    Redirect permanent / https://halloween.local/
</VirtualHost>
```

Lalu `configtest` dan `reload`.

Lanjut ke [08 — Basic Authentication](08-basic-auth.md).
