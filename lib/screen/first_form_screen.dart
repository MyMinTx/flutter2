import 'package:flutter/material.dart';

class CarWashCalculatorPage extends StatefulWidget {
  const CarWashCalculatorPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CarWashCalculatorPageState createState() => _CarWashCalculatorPageState();
}

class _CarWashCalculatorPageState extends State<CarWashCalculatorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _basePrice = 150;
  bool _vacuum = false;
  bool _wax = false;
  int _totalPrice = 0;
  void _calculatePrice() {
    int total = _basePrice;
    if (_vacuum) {
      total += 50;
    }
    if (_wax) {
      total += 100;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คำนวณค่าบริการล้างรถ'),
        backgroundColor: const Color.fromARGB(255, 223, 185, 255),
      ),
      backgroundColor: const Color.fromARGB(255, 196, 255, 224),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                initialValue: _basePrice,
                decoration: InputDecoration(
                  labelText: 'ขนาดรถ',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: 150,
                    child: Text('รถเล็ก (Small) - 150 บาท'),
                  ),
                  DropdownMenuItem(
                    value: 200,
                    child: Text('รถเก๋ง (Medium) - 200 บาท'),
                  ),
                  DropdownMenuItem(
                    value: 250,
                    child: Text('รถ SUV/กระบะ (Large) - 250 บาท'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _basePrice = value;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('ดูดฝุ่น (+50 บาท)'),
                value: _vacuum,
                onChanged: (value) {
                  setState(() {
                    _vacuum = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              CheckboxListTile(
                title: Text('เคลือบแว็กซ์ (+100 บาท)'),
                value: _wax,
                onChanged: (value) {
                  setState(() {
                    _wax = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculatePrice,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 18, 48, 17),
                    backgroundColor: const Color.fromARGB(255, 139, 236, 181),
                  ),
                  child: Text('คำนวณราคา'),
                ),
              ),
              SizedBox(height: 24),
              if (_totalPrice > 0)
                Text(
                  'ราคารวม: $_totalPrice บาท',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}