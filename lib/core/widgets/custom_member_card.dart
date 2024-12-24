import 'package:flutter/material.dart';
import 'package:task/app/data/models/user_model.dart';
import 'package:task/core/constants/app_color.dart';
import 'package:task/core/constants/app_style.dart';
import 'package:task/core/widgets/custom_card.dart';
import 'package:task/gen/assets.gen.dart';

class CustomMemberCard extends StatelessWidget {
  const CustomMemberCard({super.key, required this.userModel, this.onTap});
  final UserModel userModel;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
          child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: AppColor.kFFFFFF,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(color: AppColor.k6E7591),
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage(
                  userModel.avatarUrl ?? Assets.images.avatarNull.path,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildMemberCardItem(
                  icon: Icons.person_outline_outlined, title: userModel.name),
              const SizedBox(height: 5.0),
              _buildMemberCardItem(
                  icon: Icons.email_outlined, title: userModel.email),
              const SizedBox(height: 5.0),
              _buildMemberCardItem(
                  icon: Icons.phone_android_outlined,
                  title: userModel.phoneNumber)
            ]),
          ),
        ],
      )),
    );
  }

  Widget _buildMemberCardItem({String? title, required IconData icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16.0),
        Text(': $title', style: AppStyle.medium14),
      ],
    );
  }
}
