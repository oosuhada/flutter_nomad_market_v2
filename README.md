# Nomad Market

**Nomad Market** is a cross-border local-shopping marketplace where travelers and local experts surface city-specific products, verify them in person, and connect purchase requests with their next trip.

The original v2 already revolved around **Shopping / Community / Chat / My**, traveler profiles, local trends, culture guides, and safe transactions. The portfolio version keeps that product DNA rather than replacing it with a generic neighborhood marketplace: Paris limited goods, Tokyo flagship exclusives, K-beauty showroom finds, traveler arrival schedules, local-expert purchase requests, LIVE shopping, and culture context are all first-class parts of the app.

## Preview

<p align="center">
  <img src=".github/assets/portfolio/01-marketplace.png" width="31%" alt="Nomad Market marketplace home" />
  <img src=".github/assets/portfolio/02-search-or-category.png" width="31%" alt="Nomad Market category search" />
  <img src=".github/assets/portfolio/03-product-detail.png" width="31%" alt="Nomad Market product detail" />
</p>

<p align="center">
  <img src=".github/assets/portfolio/04-create-listing.png" width="31%" alt="Nomad Market create listing" />
  <img src=".github/assets/portfolio/05-profile-or-seller.png" width="31%" alt="Nomad Market My Market profile" />
</p>

All preview images above were captured from an Android 15 emulator at **1080 × 2400** after navigating the real app.

## Product experience

- **Global Shopping Home** — `Paris → Seoul` trip context, luxury / limited / K-beauty categories, traveler-verified local picks, local trends, recommended experts, and cultural insight.
- **Search & Category** — city/product search, original Nomad-oriented categories, result counts, sorting, and a dedicated empty state.
- **Purchase Request Detail** — local sourcing location, traveler arrival/delivery schedule, expert trust history, in-app chat, favorites, and an interactive purchase-request bottom sheet.
- **Local Find Registration** — travelers can register an item they found locally with photo, expected purchase price, city/store, Korea arrival schedule, notes, validation, and keyboard-safe scrolling.
- **My Nomad** — traveler trust profile, active cities, next `Paris → Seoul` itinerary, local picks, saved finds, purchase-request messages, culture guide, and safety center.
- **Community & Chat** — the original LIVE / Story / Local Tip direction remains central, while the Chat tab is explicitly organized around requests to verified local experts.

## Original v2 DNA preserved

- The original **Shopping / Community / Chat / My** application surface is retained as the primary bottom navigation.
- `TravelerProfileCard`, `LocalTrendCard`, and `CulturalInsightCard` remain product concepts and are upgraded into data-driven, interactive portfolio components instead of being removed.
- `CultureGuideScreen`, `SafetyCenterScreen`, `ChatListScreen`, `ChatScreen`, and the traveler trust model remain connected to the core shopping flow.
- The marketplace is intentionally about **city-specific sourcing and traveler movement**, not a generic local C2C feed.

## Architecture & tech stack

```text
lib/
├── data/       # deterministic demo marketplace catalog
├── models/     # marketplace item domain model
├── screens/    # marketplace, search, listing, detail, chat, community, profile
├── theme/      # Material 3 design tokens and shared visual language
├── widgets/    # resilient imagery and reusable marketplace cards
└── main.dart
```

- Flutter 3.27 / Dart 3.6
- Material 3
- Stateful interactive UI for favorites, filters, form validation, and chat
- Responsive scrolling / SafeArea handling for modern Android screens
- Six portfolio product photos are bundled under `assets/marketplace/` so the core experience does not depend on a remote image service; `MarketplaceImage` still supports a resilient network fallback path.

### Demo data

This repository does not require Firebase credentials, API keys, or an account to demonstrate the product. The current v2 codebase uses a deterministic local catalog plus bundled marketplace imagery so every portfolio flow remains navigable without backend credentials.

The current repository does **not** claim a production backend, authentication system, or cloud image upload that is not present in the source.

## Run

```bash
flutter pub get
flutter run -d <android-device-id>
```

## Validation

The portfolio build is checked with:

```bash
flutter analyze
flutter test
flutter build apk --debug
```

The representative flows were also exercised on an Android 15 / API 35 Medium Phone emulator, including global shopping Home, search/category results, product sourcing detail, purchase-request interaction, chat, local-find registration, My Nomad itinerary state, and Community LIVE.

Additional interaction/state captures are available in:

- `.github/assets/portfolio/06-chat.png` — purchase-request conversations grouped by traveler arrival schedule
- `.github/assets/portfolio/07-community.png` — LIVE local shopping / product verification
- `.github/assets/portfolio/08-purchase-request.png` — interactive local purchase-request sheet
- `.github/assets/portfolio/09-local-experts.png` — local trends, recommended travelers, and cultural insight sections
