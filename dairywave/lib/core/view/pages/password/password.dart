// ignore_for_file: avoid_print, unused_element, use_build_context_synchronously, unnecessary_null_comparison, unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final pasKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: pasKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please write something";
                    }
                    return null;
                  },
                  controller: passwordController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (pasKey.currentState!.validate()) {}
                  },
                  child: Text(
                    'Save Password',
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
