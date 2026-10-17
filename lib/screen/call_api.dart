import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const call_api());
}

// ignore: camel_case_types
class call_api extends StatelessWidget {
  const call_api({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AQI App',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const AqiScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AqiScreen extends StatefulWidget {
  const AqiScreen({super.key});

  @override
  State createState() => _AqiScreenState();
}

class _AqiScreenState extends State {
  // ตัวแปรสำหรับเก็บข้อมูลที่ได้จาก API
  String? city;
  int? aqi;
  double? temperature;

  bool isLoading = false;
  String errorMessage = '';

  // ใส่ Token ของคุณที่นี่
  final String apiToken = '5745b669de6bcf3eaa40aae0e47ebdc588121a50';
  // ใช้ 'here' เพื่ออิงตาม IP หรือใส่ชื่อเมืองเช่น 'bangkok'
  final String cityName = 'bangkok';

  @override
  void initState() {
    super.initState();
    fetchAqiData();
  }

  Future fetchAqiData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // แก้ไขบรรทัดนี้แล้วครับ
      final url = Uri.parse(
        'https://api.waqi.info/feed/$cityName/?token=$apiToken',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'ok') {
          setState(() {
            aqi = data['data']['aqi'];
            city = data['data']['city']['name'];

            if (data['data']['iaqi'] != null &&
                data['data']['iaqi']['t'] != null) {
              temperature = (data['data']['iaqi']['t']['v'] as num).toDouble();
            } else {
              temperature = 0.0;
            }
          });
        } else {
          setState(() {
            errorMessage = 'ไม่สามารถดึงข้อมูลได้: ${data['data']}';
          });
        }
      } else {
        setState(() {
          errorMessage =
              'เกิดข้อผิดพลาดในการเชื่อมต่อ (Status Code: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'เกิดข้อผิดพลาด: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // ฟังก์ชันสำหรับกำหนดสีพื้นหลังตามระดับ AQI
  Color getAqiColor(int aqiValue) {
    if (aqiValue <= 50) return Colors.green;
    if (aqiValue <= 100) return Colors.yellow.shade700;
    if (aqiValue <= 150) return Colors.orange;
    if (aqiValue <= 200) return Colors.red;
    if (aqiValue <= 300) return Colors.purple;
    return Colors.brown; // Hazardous
  }

  // ฟังก์ชันสำหรับกำหนดข้อความสถานะตามระดับ AQI
  String getAqiStatus(int aqiValue) {
    if (aqiValue <= 50) return 'Good';
    if (aqiValue <= 100) return 'Moderate';
    if (aqiValue <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqiValue <= 200) return 'Unhealthy';
    if (aqiValue <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality Index (AQI)'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(errorMessage, textAlign: TextAlign.center),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1. แสดงชื่อเมือง (City)
                  Text(
                    city != null ? city!.split(',').first : '-',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // 2. แสดงค่า AQI พร้อมกรอบสี
                  if (aqi != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        color: getAqiColor(aqi!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        aqi.toString(),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 20),

                  // ข้อความบอกระดับสุขภาพ (เลียนแบบจากภาพตัวอย่าง)
                  if (aqi != null)
                    Text(
                      getAqiStatus(aqi!),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getAqiColor(aqi!),
                      ),
                    ),
                  const SizedBox(height: 10),

                  // 3. แสดงค่าอุณหภูมิ (Temperature)
                  Text(
                    temperature != null
                        ? 'temperature: ${temperature!.toStringAsFixed(1)}°C'
                        : 'temperature: N/A',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ปุ่ม Refresh
                  ElevatedButton(
                    onPressed: fetchAqiData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
