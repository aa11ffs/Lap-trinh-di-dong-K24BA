import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/modules/admin/main/controllers/admin_main_controller.dart';
import 'package:task/app/modules/member/main/controllers/member_main_controller.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/utils/string_format.dart';
import 'package:task/core/widgets/custom_dialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key, this.isMain = false, this.title, this.onLogout});
  final bool isMain;
  final String? title;
  final Function()? onLogout;

  @override
  Widget build(BuildContext context) {
    if (isMain) {
      return Container(
        color: AppColor.kFFFFFF,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(StringFormat.formatDate(DateTime.now()),
                    style: AppStyle.medium16)),
            GestureDetector(
                onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            title: 'Logout',
                            content: 'Bạn có chắc chắn mốn đăng xuất',
                            onConfirm: onLogout ?? () {});
                      },
                    ),
                child:
                    const Icon(Icons.login_outlined, color: AppColor.k0D101C)),
          ],
        ),
      );
    } else {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(result: true);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: AppColor.kFFFFFF,
        title: Text(title ?? '--:--'),
      );
    }
  }

  @override
  Size get preferredSize => const Size(double.infinity, 58.0);
}
