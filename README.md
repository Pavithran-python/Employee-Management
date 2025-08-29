# Employee Management (Flutter)

A pixel-perfect Flutter app to manage employees with local persistence and BLoC.  
Supports Android and Web (Firebase Hosting).

**Live demo:** https://employee-management-c7391.web.app/  
**GitHub:** https://github.com/Pavithran-python/Employee-Management

---

## ✨ Features

- Add / Edit / Soft Delete (swipe) with **Undo**
- Local DB: `sqflite` (mobile) and `sqflite_common_ffi_web` (web)
- BLoC state management
- Custom calendar popup with quick actions: **Today**, **Next Monday**, **Next Tuesday**, **After 1 week**, and **No date** (for end date)
- “**Today**” label when a date equals the current day
- Responsive sizing via `AppSize` / `AppSizes`

---

## ▶️ Run locally

### Prerequisites
- Flutter (stable) 3.x
- Dart 3.x
- (For web deploy) Firebase CLI and a Firebase project

### Get the code
**Option A (Git):**
```bash
git clone https://github.com/Pavithran-python/Employee-Management.git
cd Employee-Management
