import 'package:book_store_user/app/data/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KeranjangController extends GetxController {
  //TODO: Implement KeranjangController

  final currencyFormatter = NumberFormat.decimalPattern('en_us');
  CollectionReference ref = FirebaseFirestore.instance.collection('menu');
  TextEditingController namaController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  final orderRef = FirebaseFirestore.instance.collection('order');

  String getCurrency(double price) {
    return currencyFormatter.format(price);
  }

  Future<void> addOrder(String nama, String hp, double total, String status,
      String alamat, List<Cart> data) async {
    final docRef = orderRef.doc();
    final a = data.map((e) => e.toJson()).toList();
    await docRef.set({
      'id': docRef.id,
      'nama': nama,
      'hp': hp,
      'status': status,
      'total': total,
      'alamat': alamat,
      'data': a,
    });
  }

  final count = 0.obs;

  void increment() => count.value++;
}
