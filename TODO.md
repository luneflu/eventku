# Eventku Development TODO

## 1. Backend (Laravel)

### 1.1. Database & Models
- [ ] Create/Update Migration for `users` (general user can be both organizer & participant)
- [ ] Create Migration for `events`
  - Fields: `id`, `title`, `description`, `date`, `location`, `organizer_id` (foreign key to `users`), `status` (`draft`, `public`, `cancelled`, `finished`), general event requirements (e.g., max_capacity, registration_deadline)
- [ ] Create Migration for `participations` (junction table)
  - Fields: `id`, `user_id` (foreign key to `users`), `event_id` (foreign key to `events`), `attended` (boolean), `attended_at` (timestamp)
  - Unique constraint on `(user_id, event_id)`

### 1.2. API Routes & Controllers
- [ ] **Authentication API**
  - [ ] Login / Register / Logout / Profile
- [ ] **Event Management (Organizer)**
  - [ ] `POST /api/events` - Create event (default status: `draft`)
  - [ ] `PUT /api/events/{id}` - Update event (only allowed if status is `draft`)
  - [ ] `POST /api/events/{id}/publish` - Change status to `public` (once public, no editing allowed)
  - [ ] `POST /api/events/{id}/cancel` - Change status to `cancelled`
  - [ ] `POST /api/events/{id}/finish` - Change status to `finished`
  - [ ] `GET /api/my-events` - List events created by the authenticated user
- [ ] **Event Browsing & Participation (Participant)**
  - [ ] `GET /api/events` - List all public events (for Home screen)
  - [ ] `GET /api/events/{id}` - Show event details
  - [ ] `POST /api/events/{id}/participate` - Register/Join event
  - [ ] `DELETE /api/events/{id}/participate` - Cancel participation (unregister from event)
  - [ ] `POST /api/events/{id}/attend` - Scan QR / Record attendance (checks if user is already a participant, errors if not)
- [ ] **Certificate Generation**
  - [ ] `GET /api/events/{id}/certificate` - Generate and download certificate
    - Only available if event status is `finished` and user has `attended`
    - Use `assets/certificate_template.png` as background
    - Dynamically write text: Participant Name, Event Name, Organizer Name, Date

---

## 2. Frontend (Flutter App)

### 2.1. Authentication
- [ ] Implement Sign Up & Log In screens

### 2.2. Main Navigation (Bottom Navigation Bar)
- [ ] **Home Tab**: List all public events (tap to view details)
- [ ] **Scan Tab**: Direct camera QR scanner to record attendance without opening event details
- [ ] **Attended Tab**: List of events the user is participating in or has attended
- [ ] **Created Tab**: List of events created by current user

### 2.3. Creator Dashboard (Created Tab)
- [ ] Tab/view to display all events created by current user
- [ ] Button to create a new event (Form with title, description, date, location, etc.)
- [ ] Ability to edit event if it is in `draft` status
- [ ] Buttons to Publish (draft -> public), Cancel, or Finish the event

### 2.4. Event Details Screen
- [ ] **As Participant:**
  - View event details (form fields disabled)
  - Show "Participate" button to register, or "Cancel Participation" button to unregister/opt-out
  - Show "Download Certificate" button ONLY if event status is finished and user attended (must be inside details screen)
- [ ] **As Organizer:**
  - View event details (form fields disabled)
  - Button to "Show Attendance QR Code" (generates unique QR code containing validation token/payload)
  - Display actions to Publish, Cancel, or Finish the event

### 2.5. QR Attendance Integration
- [ ] Organizer: Show unique QR code generated from event token/ID
- [ ] Participant: Open QR code scanner, scan organizer's QR, and send request to backend to mark attendance

### 2.6. Certificate Download UI
- [ ] Request certificate from backend API and save/open PDF or Image on the device
