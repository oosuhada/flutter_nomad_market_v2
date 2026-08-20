# Nomad Market

**Nomad Market** is a location-aware Flutter marketplace that connects local finds, travelers, and nearby buyers in one mobile experience.

The original v2 project already explored traveler profiles, local culture, community, chat, and safe transactions. This version turns those ideas into a cohesive marketplace flow: discover products by place, inspect seller trust, ask questions in chat, create a listing, and manage activity from My Market.

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

- **Marketplace Home** — Nomad Market branding, location context, discovery entry point, categories, rich product imagery, metadata, favorites, and a Material 3 bottom navigation.
- **Search & Category** — text search, category chips, result counts, sorting, and a dedicated empty state.
- **Product Detail** — large product photography, price and location, seller reputation, listing description, trust tags, favorites, and a chat CTA.
- **Create Listing** — image preview, title, price, category, location, description, validation, keyboard-safe scrolling, and a submit interaction.
- **My Market** — trust profile, trade summary, active listings, saved items, messages, culture guide, and safety center access.
- **Community & Chat** — the original traveler/community direction remains part of the product through LIVE/local stories, local tips, and transaction-focused messaging.

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
- Network product imagery with a deterministic visual fallback when an image cannot load

### Demo data

This repository does not require Firebase credentials, API keys, or an account to demonstrate the product. The current v2 codebase uses a deterministic local catalog so every portfolio flow remains navigable offline from backend credentials. Network product images degrade to an in-app fallback instead of leaving empty cards.

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

The representative flows were also exercised on an Android 15 / API 35 Medium Phone emulator, including search filters and empty results, product → chat navigation, message sending, create-listing keyboard behavior and submission, My Market, and Community.

Additional interaction captures are available in `.github/assets/portfolio/06-chat.png` and `.github/assets/portfolio/07-community.png`.
