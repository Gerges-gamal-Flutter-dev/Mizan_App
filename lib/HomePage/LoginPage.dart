// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_mizan_app/Cache/cache_helper.dart'; // مكتبة لحفظ البيانات في التخزين المؤقت
import 'package:flutter_mizan_app/HomePage/HomePage.dart'; // صفحة الرئيسية
import 'package:flutter_mizan_app/HomePage/signup.dart'; // صفحة التسجيل
import 'package:flutter_mizan_app/classes/ResponsiveScreen.dart'; // مكتبة لعمل الشاشة مستجيبة
import 'package:flutter_mizan_app/constants/colors.dart'; // مكتبة الألوان الثابتة
import 'package:flutter_mizan_app/constants/contries.dart'; // مكتبة أسماء الدول

// إنشاء واجهة تسجيل الدخول
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(); // ربط الصفحة بحالتها
}

class _LoginPageState extends State<LoginPage> {
  // التحكم في الإدخال للحقول النصية
  final TextEditingController _name = TextEditingController(); // اسم المستخدم
  final TextEditingController _email = TextEditingController(); // البريد الإلكتروني
  final TextEditingController _monthlySalaryController =
      TextEditingController(); // الراتب الشهري
  final TextEditingController _bankIncomeController =
      TextEditingController(); // الرصيد البنكي

  // مفتاح النموذج للتحقق من صحة المدخلات
  final _key = GlobalKey<FormState>();

  // متغيرات لتخزين القيم العددية
  num _monthlySalary = 0; // الراتب الشهري
  num _bankIncome = 0; // الرصيد البنكي

  // حالات إظهار/إخفاء قيم الحقول
  bool _isActiveMoney = false; // إخفاء/إظهار الراتب
  bool _isActiveBank = false; // إخفاء/إظهار الرصيد البنكي

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

  // تغيير حالة إظهار/إخفاء الراتب الشهري
  void displayMonthSalary() {
    if (_monthlySalary != 0) {
      setState(() {
        _isActiveMoney = !_isActiveMoney; // قلب حالة الإظهار
      });
    }
  }

  // تغيير حالة إظهار/إخفاء الرصيد البنكي
  void displayBankIncome() {
    if (_bankIncome != 0) {
      setState(() {
        _isActiveBank = !_isActiveBank; // قلب حالة الإظهار
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // إعداد الشاشة للتصميم المستجيب
    ResponsiveScreen.initializeScreen(context);
    return Scaffold(
      backgroundColor: Colors.white, // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.white, // لون خلفية AppBar
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ميزان', // نص العنوان
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25), // تنسيق النص
          ),
        ),
        centerTitle: true, // توسيط العنوان
      ),
      body: SingleChildScrollView( // تمكين التمرير العمودي
        child: Padding(
          padding: const EdgeInsets.all(8.0), // إضافة مسافة حول المحتوى
          child: Form(
            key: _key, // مفتاح النموذج للتحقق من المدخلات
            child: Column(
              children: [
                // صورة متحركة في أعلى الصفحة
                Container(
                  height: ResponsiveScreen.screen_height * 0.30, // 30% من ارتفاع الشاشة
                  width: double.infinity, // ملء العرض
                  color: Colors.white,
                  child: Image.asset("assets/images/login.gif"), // صورة متحركة
                ),
                const SizedBox(height: 10), // مسافة بين العناصر

                // حقل إدخال الاسم
                CustomTextField(
                  obscureText: true, // النص غير مخفي (حقل غير سري)
                  validator: (value) {
                    return validate(value!, 'Name', 2, 20); // التحقق من صحة الاسم
                  },
                  controller: _name, // التحكم في الحقل
                  labelText: "الاسم", // نص التسمية
                ),
                const SizedBox(height: 10), // مسافة بين العناصر

                // حقل إدخال الايميل
                CustomTextField(
                  obscureText: true, // النص غير مخفي (حقل غير سري)
                  validator: (value) {
                    return validate(value!, 'Email', 10, 20); // التحقق من صحة البريد الإلكتروني
                  },
                  controller: _email, // التحكم في الحقل
                  labelText: "الايميل", // نص التسمية
                ),
                const SizedBox(height: 10), // مسافة بين العناصر

                // حقل إدخال الراتب الشهري مع خيار إظهار/إخفاء
                CustomTextField(
                  keyboardType: TextInputType.number, // نوع الإدخال رقمي
                  icon: Icons.visibility, // أيقونة الإظهار
                  obscureText: _isActiveMoney, // إخفاء النص بناءً على الحالة
                  onPressed: displayMonthSalary, // عند الضغط على الأيقونة
                  validator: (value) {
                    return validate(value!, 'monthlySalary', 0, 1000000); // التحقق من صحة المدخل
                  },
                  controller: _monthlySalaryController, // التحكم في الحقل
                  onChanged: (newValue) {
                    try {
                      _monthlySalary = num.parse(newValue); // تحويل المدخل إلى رقم
                    } catch (e) {
                      showSnackBar(context, "من فضلك قم بأدخال أرقام في هذه الحقل"); // عرض رسالة خطأ
                    }
                  },
                  labelText: "الراتب الشهري", // نص التسمية
                ),
                const SizedBox(height: 10), // مسافة بين العناصر

                // حقل إدخال الرصيد البنكي مع خيار إظهار/إخفاء
                CustomTextField(
                  keyboardType: TextInputType.number, // نوع الإدخال رقمي
                  icon: Icons.visibility, // أيقونة الإظهار
                  obscureText: _isActiveBank, // إخفاء النص بناءً على الحالة
                  onPressed: displayBankIncome, // عند الضغط على الأيقونة
                  validator: (value) {
                    return validate(value!, 'bankIncome', 0, 1000000); // التحقق من صحة المدخل
                  },
                  controller: _bankIncomeController, // التحكم في الحقل
                  onChanged: (newValue) {
                    try {
                      _bankIncome = num.parse(newValue); // تحويل المدخل إلى رقم
                    } catch (e) {
                      showSnackBar(context, "من فضلك قم بأدخال أرقام في هذه الحقل"); // عرض رسالة خطأ
                    }
                  },
                  labelText: "الرصيد البنكي", // نص التسمية
                ),
                const SizedBox(height: 10), // مسافة بين العناصر

                // اختيار الدولة من قائمة منسدلة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10), // إضافة مسافة داخلية
                  decoration: BoxDecoration(color: Colors.grey.shade300), // تنسيق الخلفية
                  alignment: Alignment.topLeft, // محاذاة النص لليسار
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر بالتساوي
                    children: [
                      const Text(
                        "أختر بلدك", // نص العنوان
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'ReadexPro',
                        ),
                      ),
                      CustomDropList(
                        value: _country, // القيمة الحالية
                        valueChanged: (String value) {
                          setState(() {
                            _country = value; // تغيير الدولة المختارة
                          });
                        },
                        list: items1, // قائمة الدول
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // مسافة بين العناصر

                // زر التسجيل
                SizedBox(
                  height: ResponsiveScreen.screen_height * 0.07, // 7% من ارتفاع الشاشة
                  width: ResponsiveScreen.screen_width * 0.30, // 30% من عرض الشاشة
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor3, // لون خلفية الزر
                      foregroundColor: Colors.white, // لون النص
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // شكل الزر
                      ),
                    ),
                    onPressed: _login, // عند الضغط على الزر
                    child: const Text(
                      "تسجيل", // نص الزر
                      style: TextStyle(
                        fontSize: 20, // حجم الخط
                        fontWeight: FontWeight.bold, // سماكة الخط
                        fontFamily: 'ReadexPro',
                        color: Colors.black, // لون النص
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

  //Functions 
  // عملية تسجيل الدخول
  void _login() {
    if (_key.currentState!.validate() && _country != null) {
      // حفظ البيانات في الخدمات
      CacheHelper.saveData(key: 'name', value: _name.text.trim());
      CacheHelper.saveData(key: 'email', value: _email.text.trim());
      CacheHelper.saveData(key: 'monthlySalary', value: _monthlySalary);
      CacheHelper.saveData(key: 'bankIncome', value: _bankIncome);
      CacheHelper.saveData(key: 'country', value: _country?.trim());

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

//functions
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

//Classes for SnackBar
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

// Classes for Custom DropList
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
