## GitHub page Enforcing Https

### **Enforcing Https**

Ke pengaturan GitHub dan Terapkan HTTPS. Setelah itu, diperlukan beberapa jam agar situs Anda aman https.

### **Troubleshooting HTTPS error**

Jika Anda memilih untuk menggunakan [Certification Authority Authorization (CAA)](https://letsencrypt.org/docs/caa/) records, setidaknya memiliki satu `CAA` record harus ada dengan nilai [letsencrypt.org](letsencrypt.org) agar situs Halaman GitHub Anda dapat diakses melalui HTTPS.

Untuk membuat `CAA` record, lihat tautan ini [link](https://sslmate.com/caa/)

Pada dasarnya, tambah `CAA` record yang menunjuk ke letsencrypt.org.

![CAA record di Cloudflare](/IMG/cf-caa.PNG)

Source: [nikhilshares.medium.com](https://nikhilshares.medium.com/publishing-github-page-website-on-a-custom-domain-with-https-enforcement-c034e1e53415)
