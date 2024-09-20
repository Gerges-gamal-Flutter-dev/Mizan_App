import 'package:flutter/material.dart';
import 'package:flutter_mizan_app/constants/colors.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'اسم المستخدم'; // تعيين قيمة افتراضية
  String _currentText = ''; // النص الحالي

  @override
  void initState() {
    super.initState();
    // تعيين النص بعد التهيئة
    _currentText = 'اهلا بك فى الميزان يا $name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE8D8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3C3F2B),
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo (2).png"),
              radius: 25,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'ميزان',
                style: TextStyle(
                    fontSize: 24, fontFamily: "Lemonada", color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // الجزء الثابت في الأعلى
          Container(
            padding: const EdgeInsets.all(16),
            width: 350,
            height: 120,
            decoration: BoxDecoration(
              color: kPrimaryColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _currentText,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // قائمة العناصر
          Expanded(
            child: ListView(
              children: [
                buildFeatureTile(
                  image: "assets/images/dolar.png",
                  label: 'حساب تحويل العملات الى الدولار',
                  route: '/currency_exchange',
                ),
                buildFeatureTile(
                  image: "assets/images/aqsat.jpg",
                  label: 'عرض الاقساط و مواعيدها',
                  route: '/view_installment',
                ),
                buildFeatureTile(
                  image: "assets/images/masrouf.png",
                  label: 'تنظيم المصروفات بالنسبه لدخلك الشهري',
                  route: '/Organization_expenses',
                ),
                buildFeatureTile(
                  image: "assets/images/data.jpg",
                  label: 'البيانات الشخصيه',
                  route: '/personal',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFeatureTile({
    required String image,
    required String label,
    required String route,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kPrimaryColor3,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 45,
              ),
              const SizedBox(width: 16), 
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 20, fontFamily: "Handjet", color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
