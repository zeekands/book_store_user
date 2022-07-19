import 'package:book_store_user/app/data/book.dart';
import 'package:book_store_user/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const header(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Katalog Buku Pilihan",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.KERANJANG, arguments: controller.carts);
                  },
                  icon: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.amber,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
            10.verticalSpace,
            Flexible(
              child: StreamBuilder<List<Book>>(
                stream: controller.readBook(),
                builder: (context, snapshot) {
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.h,
                      crossAxisCount: 2,
                      childAspectRatio: .48,
                    ),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        final image = XFile("").obs;
                        final namaController = TextEditingController();
                        final hargaController = TextEditingController();
                        TextEditingController deskripsiController =
                            TextEditingController();
                        TextEditingController kategoriController =
                            TextEditingController();
                        namaController.text = snapshot.data![index].nama;
                        hargaController.text =
                            snapshot.data![index].harga.toString();
                        deskripsiController.text =
                            snapshot.data![index].deskripsi;
                        kategoriController.text = snapshot.data![index].jenis;
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: 0.95.sh,
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Detail Buku",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500)),
                                      IconButton(
                                          onPressed: () => Get.back(),
                                          icon: Icon(
                                            Icons.close,
                                            size: 16.sp,
                                            color: Colors.grey[500],
                                          )),
                                    ],
                                  ),
                                  20.verticalSpace,
                                  Center(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            ScreenUtil().setWidth(10),
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              snapshot.data?[index].images ??
                                                  "",
                                          width: 200.w,
                                          height: 300.h,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  10.verticalSpace,
                                  Center(
                                    child: Text(
                                      snapshot.data?[index].nama.toString() ??
                                          "",
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  15.verticalSpace,
                                  Text(
                                    "Rp ${controller.currency(snapshot.data?[index].harga.toDouble() ?? 0)}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    "Genre : ${snapshot.data?[index].jenis ?? ""}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  20.verticalSpace,
                                  GestureDetector(
                                    onTap: () {
                                      controller.carts.addItem(
                                        snapshot.data![index].id,
                                        snapshot.data![index].nama,
                                        snapshot.data![index].harga,
                                        snapshot.data![index].images,
                                        1,
                                        snapshot.data![index].jenis,
                                      );
                                      Get.back();
                                      Get.snackbar(
                                        "Berhasil",
                                        "Pesanan Telah Masuk Ke Keranjang Anda",
                                        duration:
                                            const Duration(milliseconds: 500),
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: EdgeInsets.all(10.r),
                                      );
                                      print(controller.carts.itemCount);
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          ScreenUtil().setWidth(10),
                                        ),
                                        color: Colors.amber[200],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.shopping_cart_outlined,
                                              size: 28.r),
                                          10.horizontalSpace,
                                          Text("Masukkan ke Keranjang",
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    "Synopsis",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    " ${snapshot.data?[index].deskripsi ?? ""}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                    ),
                                  ),
                                ],
                              ).paddingSymmetric(
                                  vertical: 10.h, horizontal: 20.w),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(10),
                          ),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.h,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  ScreenUtil().setWidth(10),
                                ),
                                topRight: Radius.circular(
                                  ScreenUtil().setWidth(10),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data?[index].images ?? "",
                                height: 300.h,
                                width: 200.w,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    snapshot.data?[index].nama ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rp ${controller.currency(snapshot.data?[index].harga.toDouble() ?? 0)}",
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Icon(
                                        Icons.shopping_cart_sharp,
                                        color: Colors.amber,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    "${snapshot.data?[index].jenis ?? 0}",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  10.verticalSpace,
                                ],
                              ).paddingOnly(top: 10.h, left: 10.w, right: 10.w),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: snapshot.data?.length,
                  );
                },
              ).paddingSymmetric(horizontal: 20.w),
            ),
          ],
        ));
  }
}

class header extends StatelessWidget {
  const header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      children: [
        Image.asset(
          "assets/images/newLogo.png",
          height: 100.h,
          width: 100.w,
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang di Toko Buku",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(10),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      "Belum Tersedia",
                      "Fitur ini belum tersedia",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 18.r,
                        color: Colors.grey[500],
                      ),
                      20.horizontalSpace,
                      Text(
                        "Search",
                        style: TextStyle(fontSize: 12.sp),
                      )
                    ],
                  ).paddingAll(10.r),
                ),
              ).paddingOnly(right: 10.w),
            ],
          ),
        ),
      ],
    ));
  }
}
