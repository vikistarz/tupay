# TuPay - Fintech Cross-Border Payment App

A high-performance Flutter fintech application built for seamless cross-border transactions (NGN ↔ RMB/USD/EUR) with institutional-grade security and smooth UX.

## ✨ Assessment Highlights

- **State Management**: Riverpod + AsyncNotifier
- **UI States**: Dart 3 Sealed Classes (`Success`, `Loading`, `Error`)
- **Security**: `flutter_secure_storage` + Privacy Overlay (screen blur on background)
- **Performance**: Background Isolate for heavy transaction processing (mock 5MB JSON)
- **Advanced UI**: `SliverPersistentHeader`, Custom theming, Responsive layout
- **State Restoration**: Restores payment flow state if app is killed
- **Architecture**: Feature-First Clean Architecture

## 🚀 Features Implemented

- **Auth Flow**: Login, Signup, Forgot Password, Reset Password
- **Dashboard**: Balance card with toggle, Quick actions, Wallets, Recent transactions
- **Wallet Detail**: USD Wallet with spending trend, interest, activity
- **Virtual Card Management**: Platinum card with security controls
- **Transfer Flow**: Multi-step payment with real-time conversion
- **Profile**: User info, security status, linked accounts

## 🛠 Tech Stack
- **Flutter** (Dart 3.0+)
- **Riverpod** (AsyncNotifier)
- **flutter_secure_storage**
- **State Restoration**
- **Background Isolates**
- **CustomPainter-ready** (prepared for receipts)



## 🧪 Testing
- Unit Tests for currency conversion logic
- Golden Tests prepared for `BalanceCard` 

## 📋 Assessment Requirements Fulfilled

| Requirement                        | Status     |
|------------------------------------|----------|
| Riverpod + AsyncNotifier           | ✅ Done |
| Sealed Classes                     | ✅ Done |
| State Restoration                  | ✅ Done |
| `flutter_secure_storage` + Privacy Overlay | ✅ Done |
| Background Isolate (5MB mock)      | ✅ Done |
| SliverPersistentHeader             | ✅ Done |
| Clean Architecture                 | ✅ Done |
| Responsive UI                      | ✅ Done |

## ▶️ How to Run

```bash
flutter pub get
flutter run