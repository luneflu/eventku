import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'All fields are required';
      });
      return;
    }

    try {
      await ref.read(authProvider.notifier).login(email, password);
      // Success will automatically trigger GoRouter redirect to /dashboard
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    String? displayError = _errorMessage;
    if (authState.hasError && !isLoading) {
      final error = authState.error;
      if (error is DioException) {
        final data = error.response?.data;
        if (data is Map && data['message'] != null) {
          displayError = data['message'].toString();
        } else {
          displayError = error.message;
        }
      } else {
        displayError = error?.toString().replaceFirst('Exception: ', '');
      }
    }

    return FScaffold(
      header: FHeader(
        title: Text(
          'Sign In',
          style: TextStyle(
            color: context.theme.colors.foreground,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  'Welcome to Eventku',
                  style: TextStyle(
                    color: context.theme.colors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Access your event management panel',
                  style: TextStyle(
                    color: context.theme.colors.mutedForeground,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
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
                  hint: 'Enter your password',
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
                  child: Text(isLoading ? 'Signing In...' : 'Sign In'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: context.theme.colors.mutedForeground),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/register'),
                      child: Text(
                        'Register',
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
