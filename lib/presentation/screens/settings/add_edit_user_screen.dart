import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_roles.dart';
import '../../../domain/models/app_user.dart';
import '../../providers/auth_provider.dart';

class AddEditUserScreen extends ConsumerStatefulWidget {
  final AppUser? user;

  const AddEditUserScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  ConsumerState<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends ConsumerState<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late String _selectedRole;

  bool get _isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _usernameController.text = user?.username ?? '';
    _selectedRole = user?.role ?? AppRoles.reader;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authProvider).users;

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFD),
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit User' : 'Add User'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8EAF0)),
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: _inputDecoration('Username'),
                    validator: (value) {
                      final username = value?.trim() ?? '';
                      if (username.isEmpty) return 'Username is required';
                      final duplicate = users.any(
                        (user) =>
                            user.username.toLowerCase() ==
                                username.toLowerCase() &&
                            user.id != widget.user?.id,
                      );
                      if (duplicate) return 'Username already exists';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration(
                      _isEditing
                          ? 'Password (leave blank to keep)'
                          : 'Password',
                    ),
                    validator: (value) {
                      if (!_isEditing && (value == null || value.isEmpty)) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedRole,
                    decoration: _inputDecoration('Role'),
                    items: AppRoles.values
                        .map(
                          (role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ),
                        )
                        .toList(),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Role is required'
                        : null,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedRole = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check_rounded),
              label: Text(_isEditing ? 'Update User' : 'Create User'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFFCFCFD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8EAF0)),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final authState = ref.read(authProvider);
    final existing = widget.user;
    final isLastAdmin = existing?.role == AppRoles.admin &&
        _selectedRole != AppRoles.admin &&
        authState.users.where((user) => user.role == AppRoles.admin).length <=
            1;

    if (isLastAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one admin user is required.'),
        ),
      );
      return;
    }

    final password = _passwordController.text.isEmpty
        ? existing?.password ?? ''
        : _passwordController.text;
    final user = AppUser(
      id: existing?.id ?? const Uuid().v4(),
      username: _usernameController.text.trim(),
      password: password,
      role: _selectedRole,
      createdAt: existing?.createdAt ?? DateTime.now(),
      updatedAt: existing == null ? null : DateTime.now(),
    );

    final notifier = ref.read(authProvider.notifier);
    if (_isEditing) {
      await notifier.updateUser(user);
    } else {
      await notifier.addUser(user);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }
}
