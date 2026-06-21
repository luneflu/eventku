# Eventku — AI IDE System Instruction

## Project Overview
Eventku event management app.
- Backend: Laravel (REST API)
- Frontend: Flutter (Mobile)
- Refer `TODO.md` for full feature scope.

---

## Backend (Laravel)

### Core Stack
- PHP 8.2+, Laravel 11+
- DB: MySQL

### Required Libraries
- **Authentication**: `laravel/sanctum` — token-based auth for mobile clients
- **Authorization**: Laravel Policies (built-in) — enforce organizer-only actions
- **API Filtering/Sorting/Pagination**: `spatie/laravel-query-builder`
- **Request Validation + API Responses**: `spatie/laravel-data`
- **Certificate Generation**: `intervention/image` v3 — render text onto `assets/certificate_template.png`

### Conventions
- Use API Resource Controllers (`--api` flag)
- Use Route Model Binding
- Response must be JSON
- Use Laravel Policies for authorization, never inline `if ($user->id !== $event->organizer_id)`
- QR attendance use `qr_token` UUID column in `events` table — no external QR library needed on backend

---

## Frontend (Flutter)

### Core Stack
- Flutter (latest stable), Dart
- Min SDK: Android 21 / iOS 13

### Required Libraries
- **HTTP Client**: `dio`
- **API Client**: `retrofit` — annotation-based REST client built on top of `dio`, use `@RestApi` for all API service classes
- **State Management**: `flutter_riverpod` — use `AsyncNotifier` for all API-driven state
- **Models & Serialization**: `freezed` + `json_serializable` — all models must use `@freezed`
- **Navigation**: `go_router` — use for bottom nav and nested routes
- **Secure Token Storage**: `flutter_secure_storage` — store Sanctum token, never use SharedPreferences for auth
- **QR Code Display**: `qr_flutter` — render event `qr_token` from API as QR widget
- **QR Code Scanner**: `mobile_scanner` — use in Scan tab
- **Permissions**: `permission_handler` — camera (scanner), storage (certificate download)
- **File Save & Open**: `path_provider` + `open_filex` — save certificate image and open
- **UI Components**: `forui` — use Forui library UI for Flutter (refer forui.dev/docs)

### Design Palette (Noir & Gold)
- **Primary / Background**: Obsidian `#12110F`
- **Surface / Card bg**: Charcoal `#1E1C18`
- **Elevated surface**: Ash `#2D2A23`
- **Accent / CTA / Active**: Gold `#C9A84C`
- **Pressed / Disabled gold**: Bronze `#8C7030`
- **Primary text**: Ivory `#F5F0E8`
- **Secondary text**: Dust `#9E9484`
- **Dividers / borders**: Smoke `#3A3629`
- **Selected row / chip bg**: Gold tint `#C9A84C` (13% opacity)
- **Success / Available**: Emerald `#4CAF7D`
- **Error / Sold out**: Crimson `#E05252`
- **Warning / Limited**: Amber `#D9923A`

### Conventions
- Inject Sanctum token via `dio` interceptor, never per-request
- Run `dart run build_runner build` after `@freezed`, `@JsonSerializable`, or `@RestApi` changes
- Use `AsyncValue` (`.when(data, loading, error)`) for all API-driven UI states
- Never use `setState` for API state — Riverpod only
- Navigation must go through `go_router` — no direct `Navigator.push`