import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

import '../utils/error_handler.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
      return;
    }

    if (password.length < 8) {
      setState(() {
        _errorMessage = 'Password must be at least 8 characters long';
      });
      return;
    }

    try {
      await ref.read(authProvider.notifier).register(name, email, password);
      // Success will automatically trigger GoRouter redirect to /dashboard
    } catch (e) {
      setState(() {
        _errorMessage = extractErrorMessage(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    String? displayError = _errorMessage;
    if (authState.hasError && !isLoading) {
      displayError = extractErrorMessage(authState.error);
    }

    return FScaffold(
      header: FHeader.nested(
        title: Text(
          'Register',
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixes: [
          FButton.icon(
            onPress: () => context.pop(),
            child: Icon(FIcons.arrowLeft),
          ),
        ],
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    color: context.theme.colors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join Eventku to start hosting and participating in events',
                  style: TextStyle(
                    color: context.theme.colors.mutedForeground,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FTextField(
                  control: FTextFieldControl.managed(controller: _nameController),
                  label: const Text('Full Name'),
                  hint: 'Enter your name',
                ),
                const SizedBox(height: 16),
                FTextField(
                  control: FTextFieldControl.managed(controller: _emailController),
                  label: const Text('Email Address'),
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                FTextField.password(
                  control: FTextFieldControl.managed(controller: _passwordController),
                  label: const Text('Password'),
                  hint: 'Enter your password (min 8 chars)',
                ),
                if (displayError != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    displayError,
                    style: TextStyle(
                      color: context.theme.colors.error,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                FButton(
                  onPress: isLoading ? null : _submit,
                  child: Text(isLoading ? 'Creating Account...' : 'Register'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: context.theme.colors.mutedForeground),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: context.theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
