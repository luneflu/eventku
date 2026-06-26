# Laporan Keamanan Eventku

## 1. Backend (Laravel)
- **Authentication**: Laravel Sanctum (Token-based). Token di-hash di DB. (Bukan JWT plain).
- **Authorization**: Laravel Policies → Cegah IDOR (Insecure Direct Object Reference). Hanya *organizer* valid yang bisa akses/modifikasi data *event* miliknya.
- **SQL Injection**: Eloquent ORM via PDO → *Parameterized queries* otomatis. Celah SQLi tertutup kecuali pakai `DB::raw` sembarangan.
- **Validasi Input**: `spatie/laravel-data` → DTO ketat. Payload *reject* jika tipe data salah atau *malicious*.
- **Mass Assignment**: Perlindungan `$fillable` di model → User ga bisa inject kolom terlarang (misal: `is_admin = true`).
- **Rate Limiting**: Middleware `throttle:api` → Cegah *brute-force* & DDoS API.

## 2. Frontend (Flutter)
- **Token Storage**: `flutter_secure_storage` → Pakai Android Keystore / iOS Keychain. Token terenkripsi, OS-level. (Jangan pakai *SharedPreferences*).
- **Network Request**: Dio Interceptor → Injeksi token otomatis. Aman, tidak bocor di log manual. Wajib jalankan di koneksi HTTPS (TLS/SSL).
- **Permissions**: `permission_handler` → Akses kamera (scanner) & storage (sertifikat) *on-demand*. (Prinsip *Least Privilege*).
- **State Leakage**: Riverpod `AsyncValue` → Cegah UI menampilkan data *cache* user lain jika state tidak di-reset saat *logout*.

## 3. Checklist Produksi (Wajib)
- Enforce HTTPS di *web server* (Nginx/Apache).
- Set `expiration_minutes` di `config/sanctum.php`.
- Aktifkan *ProGuard* / *Obfuscator* saat build APK/AAB Flutter (`--obfuscate --split-debug-info`).
