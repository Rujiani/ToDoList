
---

````markdown
# 📝 ToDo App

A clean and minimalistic Flutter application for managing daily tasks efficiently.

---

## ✨ Features

- ✅ Add, edit, and delete tasks  
- 📅 Mark tasks as completed  
- 💾 Local data persistence  
- 🧭 Simple and intuitive interface  
- 🎨 Custom themes and rounded UI elements  

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/<your-username>/todo-app.git
cd todo-app
````

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

---

## 🧰 Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** setState / Provider (depending on version)
* **Storage:** SharedPreferences / local file storage
* **Platform:** Android (iOS planned)

---

## 📁 Project Structure

```
lib/
 ├── main.dart             # Entry point
 ├── screens/              # App screens
 ├── widgets/              # Reusable UI components
 └── models/               # Data structures
```

---

## 🔐 Build & Release

To create a signed APK:

```bash
flutter build apk --release
```

If using your own keystore, ensure that:

* `android/key.properties` is **not committed**
* `.jks` file is **stored securely**

---

## 🧑‍💻 Author

**Roman Khokhlov**
📧 [roman.2006.08.18@gmail.com](mailto:roman.2006.08.18@gmail.com)]
💻 [github.com/Rujiani](https://github.com/Rujiani)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).
