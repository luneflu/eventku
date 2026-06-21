# Eventku Development TODO

## 1. Backend (Laravel)

### 1.1. Database & Models
- [x] Create/Update Migration for `users` (general user can be both organizer & participant)
- [x] Create Migration for `events`
  - Fields: `id`, `title`, `description`, `date`, `location`, `organizer_id` (foreign key to `users`), `status` (`draft`, `public`, `cancelled`, `finished`), general event requirements (e.g., max_capacity, registration_deadline)
- [x] Create Migration for `participations` (junction table)
  - Fields: `id`, `user_id` (foreign key to `users`), `event_id` (foreign key to `events`), `attended` (boolean), `attended_at` (timestamp)
  - Unique constraint on `(user_id, event_id)`

### 1.2. API Routes & Controllers
- [x] **Authentication API**
  - [x] Login / Register / Logout / Profile
- [x] **Event Management (Organizer)**
  - [x] `POST /api/events` - Create event (default status: `draft`)
  - [x] `PUT /api/events/{id}` - Update event (only allowed if status is `draft`)
  - [x] `POST /api/events/{id}/publish` - Change status to `public` (once public, no editing allowed)
  - [x] `POST /api/events/{id}/cancel` - Change status to `cancelled`
  - [x] `POST /api/events/{id}/finish` - Change status to `finished`
  - [x] `GET /api/my-events` - List events created by the authenticated user
- [x] **Event Browsing & Participation (Participant)**
  - [x] `GET /api/events` - List all public events (for Home screen)
  - [x] `GET /api/events/{id}` - Show event details
  - [x] `POST /api/events/{id}/participate` - Register/Join event
  - [x] `DELETE /api/events/{id}/participate` - Cancel participation (unregister from event)
  - [x] `POST /api/events/{id}/attend` - Scan QR / Record attendance (checks if user is already a participant, errors if not)
- [x] **Certificate Generation**
  - [x] `GET /api/events/{id}/certificate` - Generate and download certificate
    - [x] Only available if event status is `finished` and user has `attended`
    - [x] Use `assets/certificate_template.png` as background
    - [x] Dynamically write text: Participant Name, Event Name, Organizer Name, Date

---

## 2. Frontend (Flutter App)

### 2.1. Authentication
- [x] Implement Sign Up & Log In screens

### 2.2. Main Navigation (Bottom Navigation Bar)
- [x] **Home Tab**: List all public events (tap to view details)
- [x] **Scan Tab**: Direct camera QR scanner to record attendance without opening event details
- [x] **Attended Tab**: List of events the user is participating in or has attended
- [x] **Created Tab**: List of events created by current user

### 2.3. Creator Dashboard (Created Tab)
- [x] Tab/view to display all events created by current user
- [x] Button to create a new event (Form with title, description, date, location, etc.)
- [x] Ability to edit event if it is in `draft` status
- [x] Buttons to Publish (draft -> public), Cancel, or Finish the event

### 2.4. Event Details Screen
- [x] **As Participant:**
  - [x] View event details (form fields disabled)
  - [x] Show "Participate" button to register, or "Cancel Participation" button to unregister/opt-out
  - [x] Show "Download Certificate" button ONLY if event status is finished and user attended (must be inside details screen)
- [x] **As Organizer:**
  - [x] View event details (form fields disabled)
  - [x] Button to "Show Attendance QR Code" (generates unique QR code containing validation token/payload)
  - [x] Display actions to Publish, Cancel, or Finish the event

### 2.5. QR Attendance Integration
- [x] Organizer: Show unique QR code generated from event token/ID
- [x] Participant: Open QR code scanner, scan organizer's QR, and send request to backend to mark attendance

### 2.6. Certificate Download UI
- [x] Request certificate from backend API and save/open PDF or Image on the device
