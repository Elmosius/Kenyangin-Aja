# ♨️ Kenyangin Aja
Membuat aplikasi menjadi one-stop hub untuk menemukan makanan yang sedang viral, baik di media sosial maupun di kalangan masyarakat sekitar. Fungsinya menggabungkan eksplorasi makanan viral, ulasan pengguna, dan integrasi pemesanan makanan menggunakan Flutter (sebagai Front-endnya) dan NodeJs (sebagai back-endnya)

## 📋 Fungsi Pengguna
- 👥 Pengguna
  - Menjelajahi tempat makanan yang sedang viral berdasarkan lokasi mereka.
  - Melihat daftar makanan dengan rating tertinggi sesuai tren viral.
  - Mengakses detail lokasi tempat makan, termasuk ulasan pengguna lainnya.
  - Menyimpan tempat makan favorit ke daftar pribadi untuk referensi di masa mendatang.
- 🔧 Admin
  - Mengunggah dan mengelola daftar tempat makan yang sedang viral.
  - Menggunakan sistem pencarian untuk menemukan tempat makan yang trending di TikTok.
  - Menentukan secara manual tempat makan viral yang akan ditampilkan di aplikasi.

## 📚 Daftar Branch
- Main
- Secondary

## ⚙️ Teknologi yang dipakai
- Flutter
- Express Js
- Axios
- Tikapi
- MongoDB

## 💻 Demo
- Coming Soon

## ⚠️ Instalasi

**Sebelum memulai, pastikan Anda sudah menginstal:**

*   **Git:**  Untuk mengunduh repository.
*   **Flutter SDK:** Untuk menjalankan aplikasi frontend.  Pastikan Flutter sudah terkonfigurasi dengan benar di environment system anda. Lihat [dokumentasi resmi Flutter](https://docs.flutter.dev/get-started/install) untuk instruksi instalasi.
*   **Node.js dan npm (atau yarn):** Untuk menjalankan aplikasi backend. Download di [nodejs.org](https://nodejs.org/en/download/).
*   **MongoDB:**  Untuk database backend. Anda bisa menggunakan MongoDB Community Edition (diinstal secara lokal) atau MongoDB Atlas (cloud). Download di [mongodb.com](https://www.mongodb.com/try/download/community).

1.  Clone repository:
    ```
    git clone https://github.com/Elmosius/Kenyangin-Aja.git
    ```

### 🛠️ Instalasi Backend (Node.js)

1.  Masuk ke direktori backend:
    ```
    cd Kenyangin-Aja/backend
    ```

2.  Instal dependencies:
    ```bash
    npm install  # atau yarn install
    ```

3.  Konfigurasi environment:
    *   Buat file `.env` di direktori `backend`.
    *   Tambahkan konfigurasi berikut (contoh):

        ```
        PORT=3000
        MONGODB_URI=mongodb://localhost:27017/kenyanginaja  # Ganti dengan URI MongoDB Anda
        TIKAPI_API_KEY=YOUR_TIKAPI_API_KEY #Ganti dengan API key anda dari tikapi
        ```

        **Catatan Penting:**

        *   Ganti `mongodb://localhost:27017/kenyanginaja` dengan URI koneksi MongoDB Anda. Jika Anda menggunakan MongoDB Atlas, URI ini akan berbeda.
        *   Simpan  `.env` file ini dengan aman dan jangan dimasukkan ke dalam repository (gunakan `.gitignore`).
	*   Ganti `YOUR_TIKAPI_API_KEY` dengan API key yang anda dapatkan dari Tikapi.

4.  Jalankan server backend:
    ```bash
    nodemon .  
    ```

    Biasanya server akan berjalan di `http://localhost:3000` (atau port yang Anda tentukan di `.env`).

### 📱 Instalasi Frontend (Flutter)

1.  Masuk ke direktori frontend:
    ```
    cd ../frontend
    ```

2.  Instal dependencies:
    ```
    flutter pub get
    ```

3.  Konfigurasi API endpoint:
    *   Cari file yang menyimpan konfigurasi API endpoint (misalnya, `lib/config.dart` atau sejenisnya).
    *   Ubah endpoint API agar sesuai dengan alamat server backend Anda. Contoh:

        ```dart
        const String apiUrl = 'http://localhost:3000/api'; // Ganti dengan URL backend Anda
        ```

    **Catatan Penting:**

    *   Pastikan URL backend sesuai dengan alamat dan port tempat server Node.js Anda berjalan.  Jika Anda menjalankan backend di emulator Android, Anda mungkin perlu menggunakan alamat IP khusus (misalnya, `10.0.2.2` untuk localhost di emulator).
    *   Jika backend Anda menggunakan HTTPS, pastikan URL frontend juga menggunakan HTTPS.

4.  Jalankan aplikasi Flutter:
    ```
    flutter run
    ```

    Pilih perangkat atau emulator yang ingin Anda gunakan untuk menjalankan aplikasi.

## 🚀 Penggunaan

Setelah kedua aplikasi (frontend dan backend) berhasil dijalankan, Anda dapat menggunakan aplikasi Kenyangin Aja melalui perangkat atau emulator yang Anda pilih.

## 🤝 Kontribusi

Jika Anda ingin berkontribusi pada proyek ini, silakan fork repository ini dan buat pull request dengan perubahan yang Anda usulkan.
