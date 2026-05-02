import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_permissions.dart';
import '../../core/constants/app_roles.dart';
import '../../domain/models/app_user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isLoading;
  final AppUser? currentUser;
  final List<AppUser> users;
  final String? errorMessage;

  const AuthState({
    required this.isLoading,
    required this.users,
    this.currentUser,
    this.errorMessage,
  });

  const AuthState.loading()
      : this(
          isLoading: true,
          users: const [],
        );

  const AuthState.ready({
    required List<AppUser> users,
    AppUser? currentUser,
    String? errorMessage,
  }) : this(
          isLoading: false,
          users: users,
          currentUser: currentUser,
          errorMessage: errorMessage,
        );

  bool get isLoggedIn => currentUser != null;

  bool hasPermission(String permission) {
    final user = currentUser;
    if (user == null) return false;
    return AppRoles.permissionsForRole(user.role).contains(permission);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.loading()) {
    loadSession();
  }

  static const usersKey = 'villabooks_users';
  static const loggedInUserIdKey = 'villabooks_logged_in_user_id';

  Future<bool> login(String username, String password) async {
    try {
      final normalizedUsername = username.trim().toLowerCase();
      final users =
          state.users.isEmpty ? await _loadUsersFromPrefs() : state.users;
      final matchedUser = users.where((user) {
        return user.username.toLowerCase() == normalizedUsername &&
            user.password == password;
      }).firstOrNull;

      if (matchedUser == null) {
        state = AuthState.ready(
          users: users,
          errorMessage: 'Invalid username or password',
        );
        return false;
      }

      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(loggedInUserIdKey, matchedUser.id);
      state = AuthState.ready(users: users, currentUser: matchedUser);
      return true;
    } catch (error, stackTrace) {
      debugPrint('[Auth] Login failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      state = AuthState.ready(
        users: state.users,
        errorMessage: 'Unable to log in. Please restart the app and try again.',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(loggedInUserIdKey);
    } catch (error, stackTrace) {
      debugPrint('[Auth] Logout persistence failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      state = AuthState.ready(users: state.users);
    }
  }

  Future<void> loadSession() async {
    try {
      debugPrint('[Auth] Loading saved session.');
      final users = await loadUsers();
      final preferences = await SharedPreferences.getInstance();
      final loggedInUserId = preferences.getString(loggedInUserIdKey);
      final currentUser = loggedInUserId == null
          ? null
          : users.where((user) => user.id == loggedInUserId).firstOrNull;

      debugPrint(
        '[Auth] Session loaded. users=${users.length}, loggedIn=${currentUser != null}',
      );
      state = AuthState.ready(users: users, currentUser: currentUser);
    } catch (error, stackTrace) {
      debugPrint('[Auth] Failed to load session: $error');
      debugPrintStack(stackTrace: stackTrace);
      state = AuthState.ready(
        users: [_defaultAdminUser()],
        errorMessage: 'Local session could not be loaded.',
      );
    }
  }

  Future<List<AppUser>> loadUsers() async {
    try {
      var users = await _loadUsersFromPrefs();
      if (users.isEmpty) {
        users = [_defaultAdminUser()];
        await _saveUsers(users);
      }
      return users;
    } catch (error, stackTrace) {
      debugPrint('[Auth] Failed to load users: $error');
      debugPrintStack(stackTrace: stackTrace);
      return [_defaultAdminUser()];
    }
  }

  Future<void> addUser(AppUser user) async {
    final users = [
      ...state.users,
      user.copyWith(
        id: user.id.isEmpty ? const Uuid().v4() : user.id,
        createdAt: user.createdAt,
      ),
    ];
    await _saveAndSetUsers(users);
  }

  Future<void> updateUser(AppUser user) async {
    final existing =
        state.users.where((item) => item.id == user.id).firstOrNull;
    if (existing == null) return;

    if (existing.role == AppRoles.admin && user.role != AppRoles.admin) {
      final adminCount =
          state.users.where((item) => item.role == AppRoles.admin).length;
      if (adminCount <= 1) return;
    }

    final users = [
      for (final existing in state.users)
        if (existing.id == user.id)
          user.copyWith(updatedAt: DateTime.now())
        else
          existing,
    ];
    await _saveAndSetUsers(users);
  }

  Future<void> deleteUser(String id) async {
    if (state.currentUser?.id == id) return;
    final target = state.users.where((user) => user.id == id).firstOrNull;
    if (target == null) return;

    if (target.role == AppRoles.admin) {
      final adminCount =
          state.users.where((user) => user.role == AppRoles.admin).length;
      if (adminCount <= 1) return;
    }

    final users = state.users.where((user) => user.id != id).toList();
    await _saveAndSetUsers(users);
  }

  bool hasPermission(String permission) {
    return state.hasPermission(permission);
  }

  bool canManageUsers() {
    return hasPermission(AppPermissions.manageUsers);
  }

  bool isAdmin() {
    return state.currentUser?.role == AppRoles.admin;
  }

  Future<List<AppUser>> _loadUsersFromPrefs() async {
    final preferences = await SharedPreferences.getInstance();
    final rawUsers = preferences.getString(usersKey);
    if (rawUsers == null || rawUsers.isEmpty) return [];

    final decoded = jsonDecode(rawUsers) as List<dynamic>;
    return decoded
        .map((json) => AppUser.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveAndSetUsers(List<AppUser> users) async {
    await _saveUsers(users);
    final currentUser = state.currentUser == null
        ? null
        : users.where((user) => user.id == state.currentUser!.id).firstOrNull;
    state = AuthState.ready(users: users, currentUser: currentUser);
  }

  Future<void> _saveUsers(List<AppUser> users) async {
    final preferences = await SharedPreferences.getInstance();
    final encoded = jsonEncode(users.map((user) => user.toJson()).toList());
    await preferences.setString(usersKey, encoded);
  }

  AppUser _defaultAdminUser() {
    return AppUser(
      id: const Uuid().v4(),
      username: 'admin',
      password: 'admin',
      role: AppRoles.admin,
      createdAt: DateTime.now(),
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }
}
