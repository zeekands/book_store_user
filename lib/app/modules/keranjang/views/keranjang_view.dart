import 'package:book_store_user/app/modules/home/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controllerH = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeranjangView'),
        centerTitle: true,
      ),
      body: Container(
        height: 0.9.sh,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            const Text('Pesanan Anda', style: TextStyle(fontSize: 20))
                .paddingSymmetric(horizontal: 20.w),
            SingleChildScrollView(
              child: controllerH.carts.items.isNotEmpty
                  ? SizedBox(
                      height: 0.53.sh,
                      width: 1.sw,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controllerH.carts.items.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              controllerH.carts.removeSingleItem(controllerH
                                  .carts.items.values
                                  .elementAt(index)
                                  .id);
                            },
                            background: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ).paddingOnly(right: 10.w),
                            ),
                            child: ListTile(
                              title: Text(controllerH.carts.items.values
                                  .elementAt(index)
                                  .title),
                              subtitle: Text(
                                  "${controllerH.carts.items.values.elementAt(index).quantity} Item(s)"),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: controllerH.carts.items.values
                                      .elementAt(index)
                                      .image,
                                  height: 50.h,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              trailing: Text(
                                  "Rp ${controller.getCurrency(controllerH.carts.items.values.elementAt(index).price.toDouble() * controllerH.carts.items.values.elementAt(index).quantity)}"),
                            ),
                          );
                        },
                      ).paddingOnly(top: 10.h, left: 20.w, right: 20.w),
                    )
                  : Container(
                      height: 0.53.sh,
                      width: 1.sw,
                      alignment: Alignment.center,
                      child: const Text('Keranjang Kosong'),
                    ),
            ),
            SizedBox(
              height: 0.3.sh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rincian Harga",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal'),
                      Text(
                          "Rp ${controller.getCurrency(controllerH.carts.totalAmount)}"),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pajak (11%)'),
                      Text(
                          "Rp ${controller.getCurrency(controllerH.carts.totalAmount * 0.11)}"),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: List.generate(
                        800 ~/ 10,
                        (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey,
                                height: 2,
                              ),
                            )),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Harga',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      Text(
                          "Rp ${controller.getCurrency((controllerH.carts.totalAmount * 0.11) + controllerH.carts.totalAmount)}",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  20.verticalSpace,
                  Center(
                    child: SizedBox(
                      height: ScreenUtil().setHeight(40),
                      width: 0.8.sw,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerH.carts.items.isNotEmpty
                              ? Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/newLogo.png',
                                                height: 100.h,
                                                width: 100.w,
                                              ),
                                              Text(
                                                'Silahkan Isi Form Berikut \nUntuk Memproses Pesanan',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                          TextField(
                                            controller:
                                                controller.namaController,
                                            decoration: InputDecoration(
                                              labelText: 'Nama Lengkap',
                                              labelStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          20.verticalSpace,
                                          TextField(
                                            controller: controller.hpController,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              labelText: 'No Handphone',
                                              labelStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          20.verticalSpace,
                                          TextField(
                                            controller:
                                                controller.alamatController,
                                            decoration: InputDecoration(
                                              labelText: 'Alamat',
                                              labelStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          40.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(40),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: Colors.amber,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Cek ulang pesanan",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              20.horizontalSpace,
                                              Flexible(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (controller
                                                            .namaController
                                                            .text
                                                            .isNotEmpty &&
                                                        controller.hpController
                                                            .text.isNotEmpty) {
                                                      await controller.addOrder(
                                                        controller
                                                            .namaController
                                                            .text,
                                                        controller
                                                            .hpController.text,
                                                        controllerH
                                                            .carts.totalAmount,
                                                        "menunggu",
                                                        controller
                                                            .alamatController
                                                            .text,
                                                        controllerH
                                                            .carts.items.values
                                                            .toList(),
                                                      );
                                                      controllerH.carts.clear();
                                                      Get.back();
                                                      Get.back();
                                                      Get.bottomSheet(Container(
                                                        height: 0.5.sh,
                                                        width: 1.sw,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/newLogo.png',
                                                              height: 200.h,
                                                              width: 300.w,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            20.verticalSpace,
                                                            Text(
                                                              "Terimakasih\nPesanan Kamu Sedang \nDipersiapkan",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 20.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                    } else {
                                                      Get.snackbar(
                                                        "Error",
                                                        "Silahkan Isi Form Terlebih Dahulu",
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText: Colors.white,
                                                        icon: Icon(
                                                          Icons.error,
                                                          color: Colors.white,
                                                          size: 20.sp,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: ScreenUtil()
                                                        .setHeight(40),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.amber,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Konfirmasi",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          20.verticalSpace,
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                    ),
                                  ),
                                )
                              : Get.snackbar(
                                  "Keranjang Kosong",
                                  "Silahkan Tambahkan Pesanan",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.all(10),
                                );
                        },
                        child: const Text('Lanjutkan Pesanan'),
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(top: 20.h, bottom: 10.h, left: 20.w, right: 20.w),
            )
          ],
        ),
      ),
    );
  }
}
