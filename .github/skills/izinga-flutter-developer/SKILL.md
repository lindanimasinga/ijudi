---
name: izinga-flutter-developer
description: "Flutter development skill for ijudi (iZinga mobile app) on Android and iOS. Use when building features, fixing bugs, integrating with backend APIs, Firebase, local notifications, geolocation, payments, and core app flows."
argument-hint: "Describe the feature, screen, or backend integration you need to implement"
user-invocable: true
---

# iZinga Flutter Developer Skill (ijudi)

## Outcome
A complete development workflow for the iZinga mobile app (ijudi) that preserves:
- MVVM architecture and state management patterns
- Backend API contracts and error handling
- Firebase integration (Crashlytics, Analytics, Cloud Messaging)
- Local storage and secure credential persistence
- Navigation flow and routing logic
- Reusable component library
- Android and iOS platform-specific handling

Use this skill for:
- Screen/view implementation (login, shopping, orders, payments, merchant dashboards)
- ViewModel business logic and state management
- API integration and backend payload handling
- Firebase services (messaging, analytics, crash reporting)
- Local notifications and geolocation features
- Platform-specific code (Android/iOS native integration)
- Component library enhancements
- Testing and debugging

## Project Technical Baseline

### Technology Stack
- **Flutter**: 2.x+ with null safety
- **Backend**: iZinga REST API (Java/Spring Boot)
- **Firebase**: Core, Analytics, Crashlytics, Cloud Messaging
- **State Management**: MVVM with GetX-like patterns (custom BaseViewModel)
- **Storage**: SharedPreferences (non-sensitive), flutter_secure_storage (tokens/passwords)
- **Maps**: Google Maps Flutter with geolocation
- **Payments**: WebView-based payment gateway (Ukheshe, Yoco)
- **Local Notifications**: flutter_local_notifications + Firebase Cloud Messaging
- **Networking**: http package with custom ApiService wrapper
- **Code Generation**: json_annotation for model serialization

### Project Structure
```
lib/
  ├── api/                      # Backend integration
  │   ├── api-service.dart      # Main HTTP client + all REST endpoints
  │   └── api-error-response.dart
  ├── services/                 # Cross-cutting concerns
  │   ├── storage-manager.dart  # Abstract storage interface
  │   ├── impl/                 # Concrete implementations
  │   │   ├── shared-pref-storage-manager.dart
  │   │   └── secure-storage-manager.dart
  │   ├── local-notification-service.dart
  ├── model/                    # JSON-serializable data models
  │   ├── profile.dart (user profiles, roles)
  │   ├── shop.dart (store info)
  │   ├── order.dart (order details + stages)
  │   ├── stock.dart (menu items)
  │   ├── device.dart (push tokens)
  │   ├── basket.dart (shopping cart)
  │   └── ... (25+ models with .g.dart generated code)
  ├── viewmodel/                # MVVM state + business logic
  │   ├── base-view-model.dart  # Abstract base with lifecycle + error handling
  │   └── *-view-model.dart (one per screen)
  ├── view/                     # Flutter UI widgets
  │   └── *-view.dart (one per screen route)
  ├── components/               # Reusable UI components library
  │   ├── ijudi-form.dart       # Standard form wrapper
  │   ├── ijudi-input-field.dart # Text input with validation
  │   ├── ijudi-dropdown-field.dart
  │   ├── ijudi-address-input-field.dart
  │   ├── basket-component.dart
  │   ├── shop-component.dart
  │   └── ... (35+ shared widgets)
  ├── util/
  │   ├── navigator-service.dart # Centralized route generation
  │   ├── theme-utils.dart       # Design tokens + theme definitions
  │   └── util.dart
  └── main.dart
```

## Architecture Deep Dive

### 1. MVVM State Management Pattern

**BaseViewModel** (`viewmodel/base-view-model.dart`):
```dart
abstract class BaseViewModel extends State {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  ProgressViewModel? progressMv;
  bool _hasError = false;
  String _errorMessage = "";
  
  bool get hasError => _hasError;
  set hasError(bool value) {
    _hasError = value;
    notifyChanged(); // Triggers UI rebuild
  }
  
  @protected
  @override
  Widget build(BuildContext context) {
    if (hasError) return errorBuildFunction(context, errorMessege);
    if (showLogin) return loginBuildFunction(context);
    return buildFunction(context);
  }
}
```

**Screen ViewModel Pattern**:
- Each screen has one ViewModel extending BaseViewModel
- ViewModel holds all business logic, state, and API calls
- UI is purely reactive: state changes trigger notifyChanged() → rebuild
- Error handling: set `hasError=true` to show error dialog
- Login redirect: set `showLogin=true` to show login screen

**Example ViewModel** (login-view-model.dart):
```dart
class LoginViewModel extends BaseViewModel {
  final StorageManager storage;
  final ApiService apiService;
  
  String? _username = "";
  String? _password = "";
  
  void login() async {
    try {
      var loginResult = await apiService.login(_username, _password);
      storage.saveIjudiAccessToken(loginResult.accessToken);
      storage.mobileNumber = _username;
      // Trigger navigation after successful login
      Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, ...);
    } catch (e) {
      errorMessege = "Login failed: $e";
      hasError = true;
    }
  }
}
```

### 2. Backend API Integration (ApiService)

**Core Principles**:
- Single `ApiService` class with all REST endpoints
- Base URL from environment config (ProdConfig, UATConfig, DevConfig)
- Default headers include app version, origin, authorization token
- 60-second timeout for all requests
- Error handling: throw ApiErrorResponse.message on non-200 status

**Main API Groups**:

**User/Auth Endpoints**:
- `login(username, password)` → access token + refresh token
- `registerUser(profile)` → create new user
- `updateProfile(profile)` → update user info
- `logout()` → invalidate tokens

**Shop/Store Endpoints**:
- `findAllShopByLocation(lat, lng, range, size)` → nearby stores
- `findFeaturedShopByLocation(...)` → featured stores
- `getShopById(shopId)` → single shop details with menu

**Order Endpoints**:
- `placeOrder(order)` → create order, get order ID + stages
- `getOrderById(orderId)` → fetch order status + messenger details
- `getOrderHistory(userId)` → list of past orders
- `cancelOrder(orderId)` → cancel active order
- `acceptQuote(orderId, quote)` → accept delivery quote

**Stock/Menu Endpoints**:
- `getStockByShopId(shopId)` → menu items for a shop
- `addStockItem(stock)` → add new menu item (merchant)
- `updateStockItem(stock)` → modify menu item

**Payment Endpoints**:
- `generatePaymentUrl(orderId, amount)` → redirect to payment gateway
- `getTransactionHistory(userId)` → past transactions
- `getWallet(userId)` → wallet balance + recent activity

**Device/Notification Endpoints**:
- `registerDevice(device)` → register push token on first app launch
- `updateDevice(device)` → update device info after login

**Usage Pattern**:
```dart
// In ViewModel or Component
try {
  var shops = await apiService.findAllShopByLocation(lat, lng, 0.05, 20);
  _shops = shops;
  notifyChanged();
} catch (e) {
  errorMessege = e.toString();
  hasError = true;
}
```

### 3. Storage and State Persistence

**StorageManager** (Abstract Interface):
```dart
abstract class StorageManager {
  String? get mobileNumber;
  set mobileNumber(String? value);
  
  String? get accessToken;
  set accessToken(String? value); // Stored securely
  
  String? get deviceId;
  ProfileRoles? get profileRole;
  List<Shop>? get shops; // Cached shop list
  
  bool get isLoggedIn;
  bool get hasTokenExpired;
}
```

**Implementations**:
- `SharedPrefStorageManager`: Plain key-value for non-sensitive data (mobile, device ID, profile role)
- `SecureStorageManager`: Encrypted storage for access tokens, refresh tokens, passwords

**Caching Pattern**:
- Login/user data: stored in both managers
- Shop list: cached in SharedPrefs after each location search
- Current user profile: stored after login or profile update

**Token Lifecycle**:
```dart
// At app startup (main.dart)
if (storage.hasTokenExpired || storage.accessToken == null) {
  Navigator.pushNamedAndRemoveUntil(context, LoginView.ROUTE_NAME, ...);
} else {
  Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, ...);
}

// During API call (ApiService)
Map<String, String> get defaultHeaders => {
  "Content-type": "application/json",
  "app-version": appVersion,
  "Authorization": "Bearer ${storageManager.findIjudiAccessToken()}"
};
```

### 4. Firebase Integration

**Crashlytics** (Automatic):
```dart
// In main.dart
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
```
- All unhandled errors are automatically reported
- Manually log errors: `FirebaseCrashlytics.instance.recordError(e, stackTrace)`

**Analytics** (Manual Events):
```dart
// In BaseViewModel
BaseViewModel.analytics.logLogin(loginMethod: "cellnumber");
BaseViewModel.analytics.logEvent(name: "order_placed", parameters: {"orderId": "123"});
```
- Track user flows, purchases, errors, engagement
- Events appear in Firebase Console → Analytics dashboard

**Cloud Messaging** (Push Notifications):
```dart
// In NotificationService.initialize()
FirebaseMessaging.onBackgroundMessage(_onBackgroundPushMessageHandler);
FirebaseMessaging.onMessage.listen(_onForegroundPushMessageHandler);

_firebaseMessaging.getToken().then((token) {
  var device = Device(token);
  apiService.registerDevice(device); // Register token with backend
});
```
- Backend sends messages via Firebase Admin SDK
- Foreground handler: show local notification + parse payload
- Background handler: log event + handle silent push
- Token refreshed automatically; re-register on logout

### 5. Navigation and Routing

**NavigatorService** (Centralized Route Generation):
```dart
// In main.dart
onGenerateRoute: navigation!.generateRoute,

// In NavigatorService
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginView.ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => 
        LoginView(viewModel: LoginViewModel(...)));
    case AllShopsView.ROUTE_NAME:
      return MaterialPageRoute(builder: (_) => 
        AllShopsView(viewModel: AllShopsViewModel(...)));
    ...
  }
}
```

**Navigation Patterns**:
```dart
// Push new screen
Navigator.pushNamed(context, FinalOrderView.ROUTE_NAME);

// Replace current screen
Navigator.pushReplacementNamed(context, AllShopsView.ROUTE_NAME);

// Clear stack and navigate to (after login)
Navigator.pushNamedAndRemoveUntil(context, AllShopsView.ROUTE_NAME, 
  (Route<dynamic> route) => false);

// Pass data to next screen
Navigator.pushNamed(context, OrderDetailView.ROUTE_NAME, 
  arguments: Order(...));
```

**Route List**:
- `/` (LoginView) - entry point
- `/intro` - onboarding screens
- `/all-shops` - location-based shop discovery
- `/shop/{shopId}` - shop menu and details
- `/cart` - shopping basket
- `/checkout` - delivery options + payment
- `/orders` - order history
- `/order/{orderId}` - order tracking + messaging
- `/messenger-orders` - driver's active orders
- `/profile` - user profile + settings

### 6. Local Notifications and Geolocation

**Notifications**:
```dart
// In NotificationService
Future<bool?> initialize() async {
  var androidSettings = AndroidInitializationSettings('ic_launcher');
  var iosSettings = DarwinInitializationSettings();
  var settings = InitializationSettings(
    android: androidSettings, 
    iOS: iosSettings
  );
  
  await flutterLocalNotificationsPlugin.initialize(settings,
    onDidReceiveNotificationResponse: _onSelectNotification);
}

// Schedule local notification
await flutterLocalNotificationsPlugin.zonedSchedule(
  0, // id
  "Order Ready", // title
  "Your order is ready for pickup", // body
  tz.TZDateTime.now(tz.local).add(Duration(minutes: 5)),
  NotificationDetails(android: androidPlatformDetails, iOS: iosPlatformDetails),
  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
);
```

**Geolocation**:
```dart
// In ChooseLocationViewModel
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  return Geolocator.getCurrentPosition();
}

// Use in shop discovery
var position = await getCurrentLocation();
var shops = await apiService.findAllShopByLocation(
  position.latitude, 
  position.longitude, 
  0.05, // 5.5km range
  20
);
```

### 7. Model Serialization (json_annotation)

**Pattern**:
```dart
// model/order.dart
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Entity {
  String? id;
  String? customerId;
  String? shopId;
  List<BasketItem>? basket;
  OrderStage? stage; // STAGE_0_CUSTOMER_NOT_PAID, ..., STAGE_7_ALL_PAID
  DateTime? createdDate;
  String? messengerId;
  Profile? messenger;
  ShippingData? shippingData;
  
  Order({...});
  
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
```

**Generation**:
```bash
flutter pub run build_runner build
flutter pub run build_runner watch  # watch for changes
```

**Usage**:
```dart
// Parse from API response
var orderJson = json.decode(apiResponse);
var order = Order.fromJson(orderJson);

// Convert to JSON for POST/PATCH
var orderMap = order.toJson();
var body = jsonEncode(orderMap);
```

## Key Flows and Workflows

### Customer Shopping Flow
1. **AllShopsView** → Geolocation + nearby shops list
2. **ShopProfileView** → Browse menu items (Stock list)
3. **ShoppingCart** → Add/remove items, calculate total + delivery fee
4. **CheckoutView** → Select delivery address + schedule
5. **PaymentView** → WebView redirect to Ukheshe/Yoco gateway
6. **OrderHistoryView** → Track active and past orders
7. **OrderDetailView** → Real-time tracking + messenger contact

### Merchant Dashboard Flow
1. **MyShopsView** → List all owned stores
2. **StockManagementView** → Add/edit menu items + pricing
3. **MyShopOrdersView** → Accept/prepare orders + messaging
4. **PayoutHistoryView** → Transaction history + settlements

### Delivery Driver Flow
1. **LoginView** → Driver identification
2. **MessengerOrdersView** → Available nearby orders
3. **OrderAcceptanceView** → Accept delivery quote
4. **OrderProgressView** → Navigate + update status
5. **PayoutView** → Earnings dashboard

### Payment Flow
1. **CheckoutView** → Confirm order + total
2. **PaymentView** → Generate payment URL via backend
3. **WebView** → Redirect to Ukheshe/Yoco payment gateway
4. **PaymentCallbackView** → Process result (success/failure)
5. **OrderHistoryView** → Show confirmed order

## Development Patterns and Best Practices

### 1. Screen Implementation Checklist

**Create View** (UI):
- Extend `MvStatefulWidget<YourViewModel>`
- Define static `ROUTE_NAME` constant
- Implement `initialize()` method
- Build UI using viewModel data and callbacks
- Use reusable components from component library

**Create ViewModel** (State + Logic):
- Extend `BaseViewModel`
- Inject services via constructor: `ApiService`, `StorageManager`, `NotificationService`
- Declare state properties with getters/setters that call `notifyChanged()`
- Implement business logic methods that interact with API
- Set `hasError`, `errorMessege` on failures
- Set `showLogin = true` if session expired (401)
- Log important events with `analytics.logEvent()`

**Register Route**:
- Add case in `NavigatorService.generateRoute()`
- Return `MaterialPageRoute(builder: (_) => View(viewModel: ViewModel(...)))`

**Error Handling**:
```dart
Future<void> loadShops() async {
  try {
    var shops = await apiService.findAllShopByLocation(...);
    _shops = shops;
    notifyChanged();
  } on SocketException {
    errorMessege = "Network error. Check your connection.";
    hasError = true;
  } on ApiErrorResponse catch (e) {
    if (e.statusCode == 401) {
      showLogin = true; // Redirect to login
    } else {
      errorMessege = e.message;
      hasError = true;
    }
  } catch (e) {
    errorMessege = "Unexpected error: $e";
    hasError = true;
    FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
  }
}
```

### 2. API Endpoint Implementation

**In ApiService**:
```dart
Future<YourModel> yourNewEndpoint(String param) async {
  logger.log("fetching data from /endpoint/$param");
  var url = Uri.parse('$apiUrl/endpoint/$param');
  
  var response = await http.get(url, headers: defaultHeaders)
    .timeout(Duration(seconds: TIMEOUT_SEC));
  
  if (response.statusCode != 200) {
    throw ApiErrorResponse.fromJson(json.decode(response.body)).message;
  }
  
  return YourModel.fromJson(json.decode(response.body));
}
```

**Naming Convention**:
- GET: `findX()`, `getX()`, `listX()`
- POST: `createX()`, `registerX()`, `submitX()`
- PATCH: `updateX()`, `saveX()`
- DELETE: `removeX()`, `deleteX()`

### 3. Component Reuse Pattern

**Standard Form**:
```dart
IjudiForm(
  child: Column(children: [
    IjudiInputField(
      hint: "Enter name",
      text: () => viewModel.name,
      onTextChanged: (val) => viewModel.name = val,
    ),
    IjudiDropdownField<String>(
      hint: "Select option",
      items: options,
      onSelectionChanged: (val) => viewModel.selectedOption = val,
    ),
    IjudiAddressInputField(
      hint: "Enter address",
      onAddressChanged: (address) => viewModel.address = address,
    ),
  ]),
)
```

### 4. Testing Pattern

**Unit Tests** (`test/` directory):
- Test ViewModels in isolation
- Mock ApiService and StorageManager
- Verify state changes and API calls

**Widget Tests**:
- Test UI rendering given ViewModel state
- Mock NavigatorService for route testing

**Integration Tests**:
- Full flow end-to-end
- Use real backend (UAT config) or mocked responses

## Common Issues and Troubleshooting

### 1. Token Expiry
**Problem**: "401 Unauthorized" errors after extended use.
**Solution**: 
- Check `storage.hasTokenExpired` in ViewModel before API calls
- If expired, set `showLogin = true` to redirect
- Implement token refresh endpoint: `refreshToken()` on backend

### 2. Push Notification Not Arriving
**Problem**: Firebase messages not triggering foreground handler.
**Solution**:
- Verify Firebase project ID and API key in android/build.gradle and ios/Podfile
- Check app has INTERNET + POST_NOTIFICATIONS permissions (Android 13+)
- Ensure device token registered with backend: check `registerDevice()` was called
- Review NotificationService initialization order in main()

### 3. Geolocation Permission Denied
**Problem**: "Permission denied" when fetching location.
**Solution**:
- Request permission explicitly: `Geolocator.requestPermission()`
- Add permissions to AndroidManifest.xml + Info.plist
- Handle `LocationPermission.deniedForever` (user disabled permanently)

### 4. WebView Payment Gateway Redirect Fails
**Problem**: PaymentView doesn't load payment URL correctly.
**Solution**:
- Verify payment URL is valid HTTPS
- Enable JavaScript in WebView: `webViewSettings.javaScriptEnabled = true`
- Check WebView plugin version compatibility in pubspec.yaml
- Test on physical device (WebView behavior differs on emulator)

### 5. Model Serialization Errors
**Problem**: "Could not find JsonSerializableGenerator for class X" at runtime.
**Solution**:
- Run `flutter pub run build_runner build` after model changes
- Verify model has `@JsonSerializable()` annotation
- Check model has `factory X.fromJson()` and `toJson()` methods
- Delete generated .g.dart file and rebuild if corrupted

## Development Workflow

### Adding a New Feature
1. **Design Data Model** (if needed):
   - Create model.dart with @JsonSerializable()
   - Run build_runner to generate serialization code
   - Update ApiService with new endpoints

2. **Implement ViewModel**:
   - Extend BaseViewModel
   - Add state properties and business logic
   - Implement error handling and analytics logging

3. **Build UI**:
   - Create View extending MvStatefulWidget
   - Use component library for consistency
   - Bind to ViewModel methods and state

4. **Register Route**:
   - Add to NavigatorService.generateRoute()
   - Test navigation from parent screen

5. **Backend Integration**:
   - Verify API contract with backend team
   - Test with UAT environment first
   - Implement retry logic for flaky networks

6. **Test**:
   - Unit test ViewModel logic
   - Widget test UI rendering
   - Integration test full flow
   - Manual testing on Android + iOS devices

### Debugging
- **Enable logging**: Add `logger.log()` calls in ApiService
- **Check Firebase Console**: Real-time error and crash reporting
- **Use DevTools**: Flutter DevTools for widget tree inspection
- **Network debugging**: Charles proxy or Fiddler to inspect API calls
- **Local notifications**: Use `logcat` (Android) or Xcode (iOS) to verify FCM registration

## Configuration and Environments

**Config Files** (config.dart):
- `ProdConfig`: Production izinga.co.za API
- `UATConfig`: UAT testing environment
- `DevConfig`: Local development server

**Switching Environments**:
```dart
// In LoginViewModel
void switchEnvironement() {
  if (isUAT) {
    Config.currentConfig = Config.getProdConfig();
  } else {
    Config.currentConfig = Config.getUATConfig();
  }
  notifyChanged();
}
```

**Build Flavors** (optional future enhancement):
```bash
flutter run -t lib/main.dart --flavor prod --dart-define=ENV=prod
flutter run -t lib/main.dart --flavor uat --dart-define=ENV=uat
```

## Related Skills
- Use **izinga-backend-developer** for backend API changes or contract clarification.
- Use **furniture-delivery-angular-developer** for companion web/dashboard integration patterns.

## Example Prompts to Use This Skill
- "Add a new order tracking screen with real-time status updates and messenger contact info"
- "Implement geolocation permission request and fix 'Permission denied' error in shop discovery"
- "Add push notification handler for order status changes from backend"
- "Create a merchant dashboard screen for accepting/preparing orders"
- "Fix WebView payment redirect not loading payment gateway URL"
- "Add analytics event logging to track user engagement in the checkout flow"
- "Implement local token caching and refresh token flow for extended sessions"
- "Add validation to address input field and integrate Google Places autocomplete"
