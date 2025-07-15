# GMGN Clone - Flutter Web Trading Interface

A pixel-perfect recreation of the GMGN trading interface built with Flutter Web. This project replicates the mobile trading app interface with a responsive design that works on both mobile and desktop web browsers.

## Features

- 🎯 Pixel-perfect UI recreation of the original design
- 📱 Mobile-first responsive design
- 🖥️ Desktop web compatibility with constrained width
- 🔄 Interactive tab navigation
- 📊 Token list with live-style data display
- 🎨 Material Design components with custom styling
- 🌐 Ready for GitHub Pages deployment

## Getting Started

### Prerequisites

- Flutter SDK (3.24.5 or higher)
- Dart SDK
- Web browser

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd gmgn_clone
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app in development mode:
```bash
flutter run -d chrome
```

4. Build for production:
```bash
flutter build web --release
```

## Deployment to GitHub Pages

This project is configured for automatic deployment to GitHub Pages using GitHub Actions.

### Setup Instructions:

1. Push your code to a GitHub repository
2. Go to your repository settings
3. Navigate to "Pages" section
4. Set source to "GitHub Actions"
5. Push to the `main` branch to trigger deployment

The app will be automatically built and deployed to `https://yourusername.github.io/gmgn_clone/`

### Manual Deployment:

If you prefer manual deployment:

1. Build the web app:
```bash
flutter build web --base-href /gmgn_clone/
```

2. Deploy the `build/web` folder to your hosting service

## Project Structure

```
lib/
├── main.dart                 # Main app entry point and UI components
├── widgets/                  # (Future: Custom widgets)
└── models/                   # (Future: Data models)

web/
├── index.html               # Main HTML file
├── manifest.json            # Web app manifest
└── icons/                   # App icons

.github/
└── workflows/
    └── deploy.yml           # GitHub Actions deployment workflow
```

## UI Components

### Main Features Implemented:

- **Bottom Navigation**: 5-tab navigation (Discover, Track, Trade, Monitor, Assets)
- **Header Section**: Profile avatar, search bar, QR scanner
- **Balance Display**: SOL token balance with visibility toggle
- **Action Buttons**: Deposit, Withdraw, Buy (with HOT label), Invite Now
- **Tab System**: Watchlist, Trenches, New, Trending, xStock
- **Filter System**: Sub-tabs and filter controls
- **Token List**: Scrollable list with:
  - Token avatars (using random placeholder images)
  - Token names and contract addresses
  - Trading metrics (volume, market cap, holders)
  - Performance indicators (1m, 5m, 1h, 6h, 24h changes)
  - Buy buttons with flash icons
- **Bottom Banner**: Low balance notification with deposit CTA

### Responsive Design:

- Mobile-first design optimized for 375px width
- Desktop constraint to max 480px width for consistent experience
- Maintains mobile feel on larger screens

## Customization

### Changing Token Data:

Edit the token list in `_TradingInterfaceState._buildTokenItem()` calls around line 427 in `main.dart`.

### Updating Colors:

The app uses a consistent color scheme defined throughout the components:
- Primary green: `0xFF00D4AA` and `0xFF30D158`
- Background: `0xFFF8F9FA`
- Text colors: `0xFF1C1C1E` (primary), `0xFF8E8E93` (secondary)

### Adding New Features:

The modular structure allows easy addition of new features:
1. Add new pages by creating classes similar to `DiscoverPage`
2. Update the `_pages` list in `MainScreen`
3. Add corresponding navigation items

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational/demonstration purposes. Please respect the original GMGN design and trademarks.