import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ 이 줄이 꼭 필요
import '../providers/session_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("회원가입", style: TextStyle(fontSize: 24, color: Colors.white)),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Email", labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Password", labelStyle: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(height: 20),
              if (error != null)
                Text(error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: isLoading ? null : () async {
                  setState(() {
                    isLoading = true;
                    error = null;
                  });
                  try {
                    final response = await Supabase.instance.client.auth.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (response.user != null) {
                      Navigator.pop(context); // 회원가입 후 로그인 화면으로 돌아감
                    }
                  } catch (e) {
                    setState(() => error = e.toString());
                  } finally {
                    setState(() => isLoading = false);
                  }
                },
                child: const Text("가입하기"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("이미 계정이 있으신가요?", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
