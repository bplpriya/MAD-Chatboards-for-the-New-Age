# 📬 Message Board App

**Chatboards for the New Age**  A Flutter application integrated with Firebase for **authentication, real-time chat, and user profiles** 

---

## 🛠 Features 

* **Splash Screen** on app startup 
* **Firebase Authentication**: Email & password login/signup 
* **Firestore Integration**: Stores users and messages automatically 
* **Message Boards**: Predefined boards (Sports, Tech, Movies) with icons 
* **Real-time Chat**: Messages are stored per board in Firestore, showing sender email & timestamp 
* **Profile Management**: Update user details (first name, last name, DOB, etc.) 
* **Settings Screen**: Logout, toggle dark mode, privacy options 
* **Drawer Navigation**: Quick access to boards, profile, settings, and logout 

---

## 📂 Firestore Structure (Automatically Created) 

```
users (collection)
│
├── userId (document)
│   ├── firstName: string
│   ├── lastName: string
│   ├── email: string
│   ├── role: string
│   └── registrationDate: timestamp

boards (collection)
│
├── boardName (document)
│   └── messages (subcollection)
│       ├── message: string
│       ├── sender: string (uid)
│       ├── senderEmail: string
│       └── timestamp: timestamp
```

> Firestore collections and documents are created automatically when the user signs up or sends a message 

---

## 📱 Screens 

1. **Splash Screen**: App logo & loading animation 
2. **Login Screen**: Sign in using email & password 
3. **Register Screen**: Create a new account with first name, last name, email, password 
4. **Home Screen**: List of message boards with icons 
5. **Chat Screen**: Real-time chat per board 
6. **Profile Screen**: View & edit user profile 
7. **Settings Screen**: Dark mode, privacy, logout 

---

## ⚡ Dependencies 

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.21.0
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.8.0
  provider: ^6.0.5
  uuid: ^3.0.7
  cupertino_icons: ^1.0.8
```

---

## 🚀 Setup Instructions ⭐

1. Clone the repo:

```bash
git clone https://github.com/<your-username>/mad_hw2.git
cd mad_hw2
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure Firebase for Android & iOS 

   * Add `google-services.json` (Android)
   * Add `GoogleService-Info.plist` (iOS)
   * Enable **Email/Password Authentication** 
   * Enable **Cloud Firestore** 

4. Run the app:

```bash
flutter run
```

---

## 💻 Usage 

* **First Launch** → Splash Screen → Login / Register 
* **Login/Register** → Home Screen (Boards list) 
* **Select Board** → Open Chat for that board 
* **Drawer Menu** → Access Profile, Settings, or Logout 
* **Profile Updates** → Immediately reflected in Firestore 
* **Messages** → Stored in Firestore under the corresponding board 


---

## 🔗 Links 

* Flutter Firebase Docs: [Authentication](https://firebase.flutter.dev/docs/auth/overview) | [Firestore](https://firebase.flutter.dev/docs/firestore/overview) 

---

## 📝 Notes 

* Firestore **collections & documents are created automatically**; no manual setup required 
* Chat messages include **sender email** and **timestamp** 
* Dark mode and settings are toggleable in **Settings Screen** 

```}
```
