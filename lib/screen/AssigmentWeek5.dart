import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Assigmentweek5 extends StatefulWidget {
  const Assigmentweek5({super.key});

  @override
  State<Assigmentweek5> createState() => _Assigmentweek5State();
}

class _Assigmentweek5State extends State<Assigmentweek5> {
  List<dynamic> products = [];
  bool isLoading = false;

  // =========================
  // GET : ดึงข้อมูลสินค้าทั้งหมด
  // =========================
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.get(
        Uri.parse('http://localhost:8001/products'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);

        setState(() {
          products = jsonList;
        });

        print(products);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // =========================
  // POST : เพิ่มสินค้า
  // =========================
  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:8001/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('เพิ่มสินค้าสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );

        fetchData();
      } else {
        throw Exception("Failed to create product");
      }
    } catch (e) {
      print(e);
    }
  }

  // =========================
  // PUT : แก้ไขสินค้า
  // =========================
  Future<void> updateProduct({
    required int idUpdate,
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      var response = await http.put(
        Uri.parse("http://localhost:8001/products/$idUpdate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('แก้ไขสินค้าสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );

        fetchData();
      } else {
        throw Exception("Failed to update product");
      }
    } catch (e) {
      print(e);
    }
  }

  // =========================
  // DELETE : ลบสินค้า
  // =========================
  Future<void> deleteProduct({required int idDelete}) async {
    try {
      var response = await http.delete(
        Uri.parse("http://localhost:8001/products/$idDelete"),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ลบสินค้าสำเร็จ'),
            backgroundColor: Colors.green,
          ),
        );

        fetchData();
      } else {
        throw Exception("Failed to delete products");
      }
    } catch (e) {
      print(e);
    }
  }

  // =========================
  // DIALOG : เพิ่มสินค้า
  // =========================
  void showAddDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('เพิ่มสินค้า'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
              ),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'รายละเอียด'),
              ),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ราคา'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),

            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;

                double price = double.tryParse(priceController.text) ?? 0;

                if (name.isNotEmpty) {
                  createProduct(
                    name: name,
                    description: description,
                    price: price,
                  );

                  Navigator.pop(context);
                }
              },
              child: const Text('เพิ่ม'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // DIALOG : แก้ไขสินค้า
  // =========================
  void showEditDialog(dynamic product) {
    final nameController = TextEditingController(text: product['name']);

    final descriptionController = TextEditingController(
      text: product['description'] ?? '',
    );

    final priceController = TextEditingController(text: '${product['price']}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('แก้ไขสินค้า'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
              ),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'รายละเอียด'),
              ),

              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ราคา'),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),

            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;

                double price = double.tryParse(priceController.text) ?? 0;

                updateProduct(
                  idUpdate: product['id'],
                  name: name,
                  description: description,
                  price: price,
                );

                Navigator.pop(context);
              },
              child: const Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // DIALOG : ยืนยันการลบ
  // =========================
  void showDeleteDialog(dynamic product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ยืนยันการลบ'),

          content: Text('คุณต้องการลบสินค้า "${product['name']}" หรือไม่?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ยกเลิก'),
            ),

            ElevatedButton(
              onPressed: () {
                deleteProduct(idDelete: product['id']);

                Navigator.pop(context);
              },
              child: const Text('ลบ'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // INIT STATE
  // =========================
  @override
  void initState() {
    super.initState();

    // เรียก GET ทันทีเมื่อเปิดหน้า
    fetchData();
  }

  // =========================
  // UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // หัวข้อด้านบน
      // =========================
      appBar: AppBar(
        title: const Text(
          'Product',
          style: TextStyle(
            color: Color.fromARGB(255, 236, 255, 239),
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: const Color.fromARGB(255, 89, 33, 144),

        centerTitle: false,
      ),

      // =========================
      // ปุ่ม +
      // =========================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },

        child: const Icon(Icons.add, color: Color.fromARGB(255, 95, 30, 130)),
      ),

      // =========================
      // พื้นที่แสดงสินค้า
      // =========================
      body: Container(
        color: const Color.fromARGB(255, 217, 245, 206),

        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty
            ? const Center(
                child: Text(
                  'ไม่พบข้อมูลสินค้า',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),

                itemCount: products.length,

                itemBuilder: (context, index) {
                  final product = products[index];

                  return Card(
                    color: const Color.fromARGB(255, 221, 173, 255),

                    elevation: 3,

                    margin: const EdgeInsets.only(bottom: 10),

                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),

                      // ชื่อสินค้า
                      title: Text(
                        product['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // รายละเอียด + ราคา
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),

                        child: Text(
                          '${product['description'] ?? ''}\nราคา: ${product['price']} บาท',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),

                      isThreeLine: true,

                      // ปุ่มแก้ไข + ลบ
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          // แก้ไข
                          IconButton(
                            onPressed: () {
                              showEditDialog(product);
                            },

                            icon: const Icon(Icons.edit),

                            color: Colors.blue,
                          ),

                          // ลบ
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(product);
                            },

                            icon: const Icon(Icons.delete),

                            color: const Color.fromARGB(255, 193, 22, 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
