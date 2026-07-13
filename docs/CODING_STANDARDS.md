# Joojo Chat Coding Standards

## Table of Contents

1. [Dart Naming Conventions](#dart-naming-conventions)
2. [Flutter Best Practices](#flutter-best-practices)
3. [Riverpod Rules](#riverpod-rules)
4. [GoRouter Rules](#gorouter-rules)
5. [Repository Pattern Rules](#repository-pattern-rules)
6. [Provider Naming](#provider-naming)
7. [Widget Naming](#widget-naming)
8. [File Naming](#file-naming)
9. [Folder Naming](#folder-naming)
10. [Error Handling](#error-handling)
11. [Logging](#logging)
12. [Async Programming](#async-programming)
13. [Null Safety](#null-safety)
14. [Code Formatting](#code-formatting)
15. [Import Ordering](#import-ordering)
16. [Responsive UI Rules](#responsive-ui-rules)
17. [Performance Rules](#performance-rules)
18. [Animation Rules](#animation-rules)
19. [Testing Guidelines](#testing-guidelines)

---

## Dart Naming Conventions

### Classes and Types

- **PascalCase** for class names
- **PascalCase** for enums, typedefs, and type parameters
- **PascalCase** for extensions

```dart
class UserProfile {}
enum UserStatus {}
typedef UserId = String;
extension UserExtensions on User {}
```

### Variables and Functions

- **camelCase** for variables and functions
- **camelCase** for parameters
- **camelCase** for top-level variables and functions

```dart
String userName = 'John';
void getUserData() {}
final userAge = 25;
```

### Constants

- **lowerCamelCase** for local constants
- **lowerCamelCase** for private constants
- **lowerCamelCase** for top-level constants (unless they are enum-like)

```dart
const maxRetryCount = 3;
const _privateKey = 'secret';
const apiBaseUrl = 'https://api.example.com';
```

### Private Members

- Prefix with underscore `_` for private members
- Use **camelCase** after the underscore

```dart
String _privateVariable;
void _privateMethod() {}
class _PrivateClass {}
```

### Libraries and Files

- **snake_case** for library names
- **snake_case** for file names

```dart
// file: user_profile.dart
library user_profile;
```

### Prefixes and Suffixes

- Use descriptive prefixes for boolean variables: `is`, `has`, `can`, `should`
- Use descriptive suffixes for collections: `List`, `Map`, `Set`

```dart
bool isLoggedIn = true;
bool hasPermission = false;
List<User> userList = [];
Map<String, User> userMap = {};
```

---

## Flutter Best Practices

### Widget Composition

- Prefer composition over inheritance
- Break large widgets into smaller, reusable components
- Use `const` constructors where possible
- Prefer `StatelessWidget` over `StatefulWidget` unless state is needed

```dart
class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAvatarWidget(),
        UserNameWidget(),
        UserStatusWidget(),
      ],
    );
  }
}
```

### Build Method Optimization

- Keep build methods focused and readable
- Extract complex logic into separate methods
- Avoid expensive operations in build methods
- Use `Builder` widget for context-dependent builds

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Builder(
      builder: (context) {
        return _buildContent(context);
      },
    ),
  );
}

Widget _buildContent(BuildContext context) {
  // Complex build logic here
}
```

### Keys

- Use keys for widgets that need to be identified
- Use `ValueKey` for widgets with unique identifiers
- Use `GlobalKey` only when necessary (access widget state from outside)

```dart
ListView.builder(
  key: const Key('user_list'),
  itemBuilder: (context, index) {
    return ListTile(
      key: ValueKey(users[index].id),
      title: Text(users[index].name),
    );
  },
)
```

### Context Usage

- Use `BuildContext` only within the build method scope
- Pass context to methods that need it explicitly
- Avoid storing context references in class fields

```dart
// Good
void _navigateToProfile(BuildContext context) {
  Navigator.push(context, ProfileRoute());
}

// Bad - storing context
class MyWidget extends StatefulWidget {
  late BuildContext _context;
}
```

### Theme Usage

- Use `Theme.of(context)` for theme access
- Define custom theme extensions for app-specific theming
- Avoid hardcoded colors and sizes

```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineMedium,
)
```

---

## Riverpod Rules

### Provider Declaration

- Use `@riverpod` annotation for code generation
- Declare providers in separate files by feature
- Use descriptive names for providers

```dart
@riverpod
Future<User> user(UserRef ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser();
}
```

### Provider Naming

- Use **camelCase** for provider names
- Add `Provider` suffix for provider references
- Use descriptive names that reflect the data they provide

```dart
@riverpod
class UserNotifier extends _$UserNotifier {
  // Implementation
}

final userProvider = userNotifierProvider;
```

### Provider Watching

- Use `ref.watch()` for reactive dependencies
- Use `ref.read()` for one-time reads in callbacks
- Use `ref.listen()` for side effects

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final user = ref.watch(userProvider);
  return Text(user.name);
}

void _onRefresh(WidgetRef ref) {
  ref.read(userProvider.notifier).refresh();
}
```

### Provider Scoping

- Use `ProviderScope` at app root
- Use `ProviderScope.container` for testing
- Avoid nested provider scopes unless necessary

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

### State Notifiers

- Extend `StateNotifier` for complex state management
- Use immutable state objects
- Keep state notifiers focused on single responsibility

```dart
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User build() {
    return User.initial();
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }
}
```

### Family Providers

- Use family providers for parameterized dependencies
- Use autoDispose for providers that should be disposed when not in use

```dart
@riverpod
Future<User> user(UserRef ref, String userId) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserById(userId);
}
```

---

## GoRouter Rules

### Route Definition

- Define routes in a centralized location
- Use descriptive path names
- Use typed routes for type safety

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/profile/:userId',
      name: 'profile',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        return ProfilePage(userId: userId);
      },
    ),
  ],
);
```

### Route Navigation

- Use `context.go()` for navigation
- Use `context.goNamed()` for named routes
- Use `context.push()` for modal navigation

```dart
context.go('/profile/123');
context.goNamed('profile', pathParameters: {'userId': '123'});
context.push('/settings');
```

### Route Guards

- Use redirect callbacks for authentication guards
- Use redirect callbacks for permission checks

```dart
redirect: (context, state) {
  final isAuthenticated = ref.watch(authProvider);
  if (!isAuthenticated && state.matchedLocation != '/login') {
    return '/login';
  }
  return null;
}
```

### Error Handling

- Implement error pages for route errors
- Use `errorBuilder` for custom error handling

```dart
errorBuilder: (context, state) => ErrorPage(state.error),
```

---

## Repository Pattern Rules

### Repository Interface

- Define repository interfaces in the domain layer
- Use abstract classes for repository interfaces
- Keep interfaces focused on business needs

```dart
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<List<User>> getUsers();
  Future<void> saveUser(User user);
}
```

### Repository Implementation

- Implement repositories in the data layer
- Use dependency injection for data sources
- Handle data mapping between layers

```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> getUser(String id) async {
    final userDto = await remoteDataSource.getUser(id);
    return UserMapper.toEntity(userDto);
  }
}
```

### Data Sources

- Separate remote and local data sources
- Use abstract classes for data source interfaces
- Handle API errors at the data source level

```dart
abstract class UserRemoteDataSource {
  Future<UserDto> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserDto> getUser(String id) async {
    final response = await apiClient.get('/users/$id');
    return UserDto.fromJson(response.data);
  }
}
```

### Mappers

- Use separate mapper classes for data transformation
- Keep mapping logic isolated
- Handle null safety in mapping

```dart
class UserMapper {
  static User toEntity(UserDto dto) {
    return User(
      id: dto.id,
      name: dto.name ?? '',
      email: dto.email ?? '',
    );
  }

  static UserDto toDto(User entity) {
    return UserDto(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }
}
```

---

## Provider Naming

### Provider Names

- Use **camelCase** for provider names
- Add descriptive suffixes for clarity
- Use `Provider` suffix for provider references

```dart
final userProvider = Provider<User>((ref) => User());
final userNotifierProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
final userFutureProvider = FutureProvider<User>((ref) async => await fetchUser());
```

### Notifier Naming

- Use `Notifier` suffix for state notifiers
- Use descriptive names that reflect the state they manage

```dart
class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User.initial());
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());
}
```

### Family Provider Naming

- Use descriptive names that include the parameter type
- Use `Provider` suffix for family providers

```dart
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  return await fetchUser(userId);
});
```

---

## Widget Naming

### Widget Classes

- Use **PascalCase** for widget class names
- Use descriptive names that reflect the widget's purpose
- Add `Widget` suffix for custom widgets

```dart
class UserProfileWidget extends StatelessWidget {}
class UserAvatarWidget extends StatelessWidget {}
class UserNameWidget extends StatelessWidget {}
```

### Widget Files

- Use **snake_case** for widget file names
- Match file name to widget class name
- One widget per file for large widgets

```dart
// file: user_profile_widget.dart
class UserProfileWidget extends StatelessWidget {}
```

### Widget Parameters

- Use **camelCase** for widget parameters
- Use descriptive parameter names
- Use `final` for widget parameters

```dart
class UserProfileWidget extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final VoidCallback? onProfileTap;

  const UserProfileWidget({
    required this.userName,
    required this.userAvatar,
    this.onProfileTap,
    super.key,
  });
}
```

---

## File Naming

### File Names

- Use **snake_case** for all file names
- Use descriptive names that reflect the file's content
- Match file names to the main class or function they contain

```dart
// file: user_profile.dart
class UserProfile {}

// file: user_repository.dart
class UserRepository {}

// file: user_utils.dart
String formatUserName(String name) {}
```

### File Organization

- Group related files in the same directory
- Use index files for barrel exports
- Keep file names consistent across the project

```dart
// file: features/user/index.dart
export 'user_profile.dart';
export 'user_repository.dart';
export 'user_notifier.dart';
```

---

## Folder Naming

### Folder Names

- Use **snake_case** for all folder names
- Use descriptive names that reflect the folder's content
- Follow the frozen architecture structure

```dart
features/
  auth/
    data/
    domain/
    presentation/
  profile/
    data/
    domain/
    presentation/
```

### Folder Structure

- Follow Clean Architecture layering
- Keep folders shallow and focused
- Avoid deep nesting (max 3-4 levels)

```dart
lib/
  features/
    auth/
      data/
        datasources/
        repositories/
        mappers/
      domain/
        entities/
        usecases/
        repositories/
      presentation/
        pages/
        widgets/
        providers/
```

---

## Error Handling

### Exception Types

- Use custom exception classes for domain errors
- Use built-in exceptions for standard errors
- Provide descriptive error messages

```dart
class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);

  @override
  String toString() => 'UserNotFoundException: $message';
}
```

### Error Handling in Repositories

- Wrap data source calls in try-catch blocks
- Convert data source exceptions to domain exceptions
- Provide fallback values when appropriate

```dart
@override
Future<User> getUser(String id) async {
  try {
    final userDto = await remoteDataSource.getUser(id);
    return UserMapper.toEntity(userDto);
  } on ServerException catch (e) {
    throw UserNotFoundException('User not found: $id');
  }
}
```

### Error Handling in UI

- Use error widgets for build errors
- Show user-friendly error messages
- Provide retry mechanisms for recoverable errors

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final userAsync = ref.watch(userProvider);
  return userAsync.when(
    data: (user) => UserProfileWidget(user: user),
    loading: () => CircularProgressIndicator(),
    error: (error, stack) => ErrorWidget(
      message: 'Failed to load user',
      onRetry: () => ref.refresh(userProvider),
    ),
  );
}
```

### Error Logging

- Log errors with appropriate severity levels
- Include context information in error logs
- Avoid logging sensitive information

```dart
try {
  await riskyOperation();
} catch (error, stack) {
  Logger.error(
    'Operation failed',
    error: error,
    stackTrace: stack,
    context: {'userId': userId},
  );
}
```

---

## Logging

### Logging Levels

- Use appropriate log levels for different situations
- **debug**: Detailed information for debugging
- **info**: General information about application flow
- **warning**: Potentially harmful situations
- **error**: Error events that might still allow the application to continue
- **fatal**: Severe error events that will lead to application termination

```dart
Logger.debug('User data loaded', data: userData);
Logger.info('User logged in', userId: userId);
Logger.warning('API rate limit approaching', remaining: 100);
Logger.error('Failed to save user', error: error);
Logger.fatal('Critical system failure', error: error);
```

### Logging Best Practices

- Use structured logging with key-value pairs
- Avoid logging sensitive information
- Use correlation IDs for request tracking
- Log at appropriate abstraction levels

```dart
Logger.info(
  'API request completed',
  endpoint: '/users/$userId',
  duration: duration.inMilliseconds,
  statusCode: 200,
);
```

### Logging in Production

- Disable debug logs in production
- Use error reporting services for production errors
- Implement log aggregation for monitoring

```dart
void main() {
  Logger.level = kDebugMode ? LogLevel.debug : LogLevel.info;
  runApp(MyApp());
}
```

---

## Async Programming

### Async/Await Usage

- Use `async/await` for asynchronous operations
- Avoid using `.then()` and `.catchError()` when possible
- Use `await` for sequential operations

```dart
// Good
Future<void> loadUserData() async {
  final user = await fetchUser();
  final profile = await fetchProfile(user.id);
  return user;
}

// Avoid
Future<void> loadUserData() {
  return fetchUser().then((user) {
    return fetchProfile(user.id);
  });
}
```

### Parallel Operations

- Use `Future.wait()` for parallel operations
- Use `Future.wait()` with error handling

```dart
Future<void> loadAllData() async {
  final results = await Future.wait([
    fetchUser(),
    fetchProfile(),
    fetchSettings(),
  ]);
  final [user, profile, settings] = results;
}
```

### Error Handling in Async

- Use try-catch blocks for async error handling
- Handle errors appropriately in async operations
- Provide fallback values when appropriate

```dart
Future<User> getUser(String id) async {
  try {
    final user = await fetchUser(id);
    return user;
  } catch (error) {
    Logger.error('Failed to fetch user', error: error);
    return User.empty();
  }
}
```

### Stream Usage

- Use streams for continuous data flows
- Dispose streams when no longer needed
- Use `StreamController` with proper lifecycle management

```dart
class UserNotifier extends StateNotifier<User> {
  StreamSubscription? _userSubscription;

  UserNotifier() : super(User.initial()) {
    _subscribeToUserUpdates();
  }

  void _subscribeToUserUpdates() {
    _userSubscription = userService.userStream.listen((user) {
      state = user;
    });
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}
```

---

## Null Safety

### Null Safety Best Practices

- Enable null safety in all new code
- Use nullable types only when necessary
- Use `late` for variables that are assigned later
- Use `required` for non-nullable constructor parameters

```dart
class UserProfile {
  final String id;
  final String name;
  final String? bio;

  UserProfile({
    required this.id,
    required this.name,
    this.bio,
  });
}
```

### Null Handling

- Use null-aware operators (`?.`, `??`, `??=`)
- Use null assertion (`!`) only when you're certain the value is not null
- Use null checks with `if` statements for complex logic

```dart
// Good
final userName = user?.name ?? 'Unknown';
final userBio = user?.bio ?? 'No bio';

// Avoid unless certain
final userName = user!.name;

// Complex null handling
String getDisplayName(User? user) {
  if (user == null) return 'Guest';
  if (user.name.isEmpty) return 'Anonymous';
  return user.name;
}
```

### Nullable Collections

- Use nullable collections only when necessary
- Use collection-if and collection-for for conditional elements

```dart
// Good
List<String> getTags(User? user) {
  return user?.tags ?? [];
}

// Collection-if
Column(
  children: [
    if (user != null) UserProfileWidget(user: user),
    if (isAdmin) AdminPanelWidget(),
  ],
)
```

---

## Code Formatting

### Dart Format

- Use `dart format` for code formatting
- Set line length to 80 characters
- Use trailing commas for multi-line lists

```dart
// dart format
final user = User(
  id: '123',
  name: 'John',
  email: 'john@example.com',
);
```

### Linting

- Use `dart analyze` for static analysis
- Fix all lint warnings before committing
- Use strict linting rules

```dart
// analysis_options.yaml
include: package:lints/recommended.yaml
linter:
  rules:
    - prefer_const_constructors
    - avoid_print
    - prefer_single_quotes
```

### Code Style

- Use single quotes for strings
- Use trailing commas for multi-line parameters
- Use const constructors where possible

```dart
const user = User(
  id: '123',
  name: 'John',
);
```

---

## Import Ordering

### Import Groups

- Group imports in the following order:
  1. Dart SDK imports
  2. Flutter imports
  3. Package imports
  4. Relative imports

```dart
// Dart SDK
import 'dart:async';
import 'dart:convert';

// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Packages
import 'package:supabase/supabase.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// Relative
import '../../shared/domain/entities/user.dart';
import '../data/repositories/user_repository_impl.dart';
```

### Import Organization

- Use `package:` for package imports
- Use relative imports for files within the same package
- Avoid unused imports
- Use barrel exports for cleaner imports

```dart
// Good
import 'package:joojo_chat/shared/domain/entities/user.dart';

// Avoid
import '../../../shared/domain/entities/user.dart';
```

---

## Responsive UI Rules

### Responsive Design

- Use `LayoutBuilder` for responsive layouts
- Use `MediaQuery` for screen dimensions
- Use responsive breakpoints for different screen sizes

```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MobileLayout();
        } else if (constraints.maxWidth < 1200) {
          return TabletLayout();
        } else {
          return DesktopLayout();
        }
      },
    );
  }
}
```

### Breakpoints

- Define consistent breakpoints across the app
- Use named breakpoints for clarity

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1200;
  static const double desktop = 1200;
}
```

### Adaptive Widgets

- Use adaptive widgets for platform-specific behavior
- Use `Theme.of(context).platform` for platform detection

```dart
Widget build(BuildContext context) {
  final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  return isIOS ? CupertinoButton() : ElevatedButton();
}
```

---

## Performance Rules

### Widget Performance

- Use `const` constructors for static widgets
- Avoid rebuilding large widget trees
- Use `ListView.builder` for long lists
- Use `AutomaticKeepAliveClientMixin` for preserving state

```dart
// Good
const Text('Hello');

// Good for long lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(title: Text(items[index]));
  },
)
```

### Image Optimization

- Use cached network images
- Optimize image sizes
- Use placeholder images while loading

```dart
CachedNetworkImage(
  imageUrl: user.avatarUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

### Memory Management

- Dispose controllers and subscriptions
- Use `ValueKey` for list item identity
- Avoid memory leaks with proper cleanup

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
```

### Build Optimization

- Extract expensive computations outside build method
- Use `memoized` values for expensive calculations
- Avoid expensive operations in build methods

```dart
class MyWidget extends StatelessWidget {
  final List<User> users;

  const MyWidget({required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((u) => u.isActive).toList();
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) => UserTile(filteredUsers[index]),
    );
  }
}
```

---

## Animation Rules

### Animation Controllers

- Use `SingleTickerProviderStateMixin` for single animations
- Use `TickerProviderStateMixin` for multiple animations
- Dispose animation controllers

```dart
class AnimatedWidget extends StatefulWidget {
  @override
  _AnimatedWidgetState createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Animated Widgets

- Use built-in animated widgets when possible
- Use `AnimatedBuilder` for custom animations
- Use implicit animations for simple transitions

```dart
// Implicit animation
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  color: isPressed ? Colors.blue : Colors.grey,
  child: Text('Button'),
)

// Explicit animation
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.rotate(
      angle: _controller.value * 2 * pi,
      child: child,
    );
  },
  child: FlutterLogo(),
)
```

### Performance

- Use `RepaintBoundary` for complex animations
- Avoid animating large widget trees
- Use hardware acceleration when possible

```dart
RepaintBoundary(
  child: AnimatedContainer(
    duration: Duration(milliseconds: 300),
    color: Colors.blue,
  ),
)
```

---

## Testing Guidelines

### Unit Testing

- Test business logic in isolation
- Use mock objects for dependencies
- Test both success and failure cases
- Use descriptive test names

```dart
test('should return user when repository call is successful', () async {
  // Arrange
  final mockRepository = MockUserRepository();
  final useCase = GetUser(mockRepository);
  const tUserId = '123';
  const tUser = User(id: tUserId, name: 'John');

  when(mockRepository.getUser(tUserId))
      .thenAnswer((_) async => tUser);

  // Act
  final result = await useCase(tUserId);

  // Assert
  expect(result, equals(tUser));
  verify(mockRepository.getUser(tUserId));
  verifyNoMoreInteractions(mockRepository);
});
```

### Widget Testing

- Test widget behavior and appearance
- Use `testWidgets` for widget tests
- Use `find` utilities to locate widgets
- Test user interactions

```dart
testWidgets('should display user name', (tester) async {
  const user = User(id: '123', name: 'John');
  await tester.pumpWidget(
    MaterialApp(
      home: UserProfileWidget(user: user),
    ),
  );

  expect(find.text('John'), findsOneWidget);
});
```

### Integration Testing

- Test complete user flows
- Use integration tests for critical paths
- Test on real devices when possible
- Use real data or realistic mocks

```dart
testWidgets('should login and navigate to home', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.enterText(find.byKey(Key('email_field')), 'test@example.com');
  await tester.enterText(find.byKey(Key('password_field')), 'password');
  await tester.tap(find.byKey(Key('login_button')));
  await tester.pumpAndSettle();

  expect(find.byType(HomePage), findsOneWidget);
});
```

### Test Organization

- Organize tests by feature
- Use test groups for related tests
- Keep tests independent
- Use setup and teardown methods

```dart
group('GetUser', () {
  late GetUser useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUser(mockRepository);
  });

  tearDown(() {
    // Cleanup
  });

  test('should return user', () async {
    // Test implementation
  });
});
```

---

## Conclusion

These coding standards ensure consistency, maintainability, and quality across the Joojo Chat project. All team members and AI agents must adhere to these standards to maintain code quality and project integrity.

For any questions or clarifications, refer to the project constitution or consult with the lead architect.
