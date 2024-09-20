// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mizan_app/Cache/cache_helper.dart';
import 'package:flutter_mizan_app/HomePage/LoginPage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define TextEditingController for each input field
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/type.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          "انشاء حساب",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _buildTextField(
                          controller: usernameController,
                          hinText: 'ادخل اسمك',
                          labelText: 'اسمك',
                          icon: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ارجو ادخال اسمك';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        _buildTextField(
                          controller: emailController,
                          hinText: 'ادخل بريدك الالكتروني',
                          labelText: 'البريد الالكتروني',
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ارجو ادخال بريدك الالكتروني';
                            } else if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return "ارجو ادخال بريدك الالكتروني مع بعض العلامات @gmail.com";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        _buildTextField(
                          controller: passwordController,
                          hinText: 'ادخل كلمة المرور',
                          labelText: 'كلمة المرور',
                          icon: Icons.lock,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ارجو ادخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        _buildTextField(
                          controller: phoneController,
                          hinText: 'ارجو ادخال رقمك',
                          labelText: 'رقم الهاتف',
                          icon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ارجو ادخال رقمك';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        _buildTextField(
                          controller: dobController,
                          hinText: 'yy/mm/dd',
                          labelText: 'تاريخ الميلاد',
                          icon: Icons.date_range_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ارجو ادخال تاريخ الميلاد';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await CacheHelper.saveData(
                                key: "Username",
                                value: usernameController.text,
                              );
                              await CacheHelper.saveData(
                                key: "Email",
                                value: emailController.text,
                              );
                              await CacheHelper.saveData(
                                key: "Password",
                                value: passwordController.text,
                              );
                              await CacheHelper.saveData(
                                key: "Phone",
                                value: phoneController.text,
                              );
                              await CacheHelper.saveData(
                                key: "DateOfBirth",
                                value: dobController.text,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          },
                          child: const Text('تأكيد'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required String hinText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        hintText: hinText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: validator,
    );
  }
}
