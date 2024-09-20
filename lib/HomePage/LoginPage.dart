// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_mizan_app/HomePage/HomePage.dart';
import 'package:flutter_mizan_app/HomePage/signup.dart';
import 'package:flutter_mizan_app/classes/ResponsiveScreen.dart';
import 'package:flutter_mizan_app/classes/Services%20.dart';
import 'package:flutter_mizan_app/constants/colors.dart';
import 'package:flutter_mizan_app/constants/contries.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // التحكم في الإدخال للحقول النصية
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _monthlySalaryController =
      TextEditingController(); // تمت إضافة هذا
  final TextEditingController _bankIncomeController =
      TextEditingController(); // تمت إضافة هذا

  // مفتاح النموذج للتحقق من المدخلات
  final _key = GlobalKey<FormState>();

  // متغيرات لتخزين القيم العددية
  num _monthlySalary = 0;
  num _bankIncome = 0;

  // حالات إظهار/إخفاء القيم
  bool _isActiveMoney = false;
  bool _isActiveBank = false;

  // الدولة المختارة
  String? _country;

  @override
  void dispose() {
    // التخلص من Controllers لتجنب تسريب الذاكرة
    _name.dispose();
    _email.dispose();
    _monthlySalaryController.dispose();
    _bankIncomeController.dispose();
    super.dispose();
  }

  // تغيير حالة عرض/إخفاء الراتب الشهري
  void displayMonthSalary() {
    if (_monthlySalary != 0) {
      setState(() {
        _isActiveMoney = !_isActiveMoney;
      });
    }
  }

  // تغيير حالة عرض/إخفاء الرصيد البنكي
  void displayBankIncome() {
    if (_bankIncome != 0) {
      setState(() {
        _isActiveBank = !_isActiveBank;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // إعداد الشاشة للتصميم المستجيب
    ResponsiveScreen.initializeScreen(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ميزان',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                // صورة متحركة في أعلى الصفحة
                Container(
                  height: ResponsiveScreen.screen_height * 0.30,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.asset("assets/images/login.gif"),
                ),
                const SizedBox(height: 10),

                // حقل إدخال الاسم
                CustomTextField(
                  obscureText: true, // لا حاجة لإخفاء النص هنا
                  validator: (value) {
                    return validate(value!, 'Name', 2, 20);
                  },
                  controller: _name,
                  labelText: "الاسم",
                ),
                const SizedBox(height: 10),

                // حقل إدخال الايميل
                CustomTextField(
                  obscureText: true, // لا حاجة لإخفاء النص هنا
                  validator: (value) {
                    return validate(value!, 'Email', 10, 20);
                  },
                  controller: _email,
                  labelText: "الايميل",
                ),
                const SizedBox(height: 10),

                // حقل إدخال الراتب الشهري مع خيار عرض/إخفاء
                CustomTextField(
                  keyboardType: TextInputType.number,
                  icon: Icons.visibility,
                  obscureText: _isActiveMoney,
                  onPressed:
                      displayMonthSalary, // تغيير الحالة عند الضغط على الأيقونة
                  validator: (value) {
                    return validate(value!, 'monthlySalary', 0, 1000000);
                  },
                  controller: _monthlySalaryController,
                  onChanged: (newValue) {
                    try {
                      _monthlySalary = num.parse(newValue);
                    } catch (e) {
                      showSnackBar(
                          context, "من فضلك قم بأدخال أرقام في هذه الحقل");
                    }
                  },
                  labelText: "الراتب الشهري",
                ),
                const SizedBox(height: 10),

                // حقل إدخال الرصيد البنكي مع خيار عرض/إخفاء
                CustomTextField(
                  keyboardType: TextInputType.number,
                  icon: Icons.visibility,
                  obscureText: _isActiveBank,
                  onPressed:
                      displayBankIncome, // تغيير الحالة عند الضغط على الأيقونة
                  validator: (value) {
                    return validate(value!, 'bankIncome', 0, 1000000);
                  },
                  controller: _bankIncomeController,
                  onChanged: (newValue) {
                    try {
                      _bankIncome = num.parse(newValue);
                    } catch (e) {
                      showSnackBar(
                          context, "من فضلك قم بأدخال أرقام في هذه الحقل");
                    }
                  },
                  labelText: "الرصيد البنكي",
                ),
                const SizedBox(height: 10),

                // اختيار الدولة من قائمة منسدلة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "أختر بلدك",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'ReadexPro',
                        ),
                      ),
                      CustomDropList(
                        value: _country,
                        valueChanged: (String value) {
                          setState(() {
                            _country = value;
                          });
                        },
                        list: items1, // قائمة الدول
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // زر التسجيل
                SizedBox(
                  height: ResponsiveScreen.screen_height * 0.07,
                  width: ResponsiveScreen.screen_width * 0.30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor3,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      "تسجيل",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ReadexPro',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ليس لديك حساب؟",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ),
                        );
                      },
                      child: const Text(
                        "انشاء حساب",
                        style: TextStyle(
                          color: Colors.red,
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

  // عملية تسجيل الدخول
  void _login() {
    if (_key.currentState!.validate() && _country != null) {
      // حفظ البيانات في الخدمات
      Services.saveData(key: 'name', value: _name.text.trim());
      Services.saveData(key: 'email', value: _email.text.trim());
      Services.saveData(key: 'monthlySalary', value: _monthlySalary);
      Services.saveData(key: 'bankIncome', value: _bankIncome);
      Services.saveData(key: 'country', value: _country?.trim());

      // الانتقال إلى الصفحة الرئيسية بعد النجاح
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showSnackBar(context, "من فضلك تأكد من صحة ادخال البيانات");
    }
  }
}

String? validate(String value, type, [int min = 0, int max = 0]) {
  if (value.isEmpty) {
    return "This field is required";
  }
  if (value.isNotEmpty && type == "Name" && value.length < 2) {
    return "This $type  less than $min characters";
  }
  if (value.isNotEmpty &&
      type == "Email" &&
      value.endsWith("@gmail.com") == false) {
    return "This $type not end @gmail.com";
  }

  if (value.length < min) {
    return "This $type less than $min";
  }
  if (value.length > max) {
    return "Mus'nt be $type longer than $max";
  }
  return null;
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            fontFamily: "ReadexPro",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFB7C89C),
      ),
    );
}

Widget alert(
    BuildContext context, String title, String content, List<Widget> actions) {
  return AlertDialog(
    backgroundColor: Colors.green.shade400,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(),
    ),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(),
    ),
    actions: actions,
  );
}

class CustomDropList extends StatelessWidget {
  final String? value;
  final List<String> list;
  final ValueChanged<String> valueChanged;
  const CustomDropList(
      {super.key, this.value, required this.valueChanged, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButton(
          iconEnabledColor: Colors.green,
          dropdownColor: const Color(0xFFB7C89C),
          borderRadius: BorderRadius.circular(15),
          iconSize: 35,
          value: value,
          items: list.map((country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (newValue) {
            valueChanged(newValue!);
          }),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final IconData? icon;
  final TextInputType? keyboardType;
  const CustomTextField(
      {super.key,
      this.controller,
      this.labelText,
      this.validator,
      this.hintText,
      this.obscureText,
      this.icon,
      this.onChanged,
      this.onPressed,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText == null || obscureText == false ? true : false,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: obscureText == null || obscureText == false
                ? Colors.grey
                : Colors.blue,
          ),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
