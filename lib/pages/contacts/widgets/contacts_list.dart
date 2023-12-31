import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/entities/contact.dart';
import '../../../common/style/color.dart';
import '../../../generated/assets.dart';
import '../controller.dart';

class ContactList extends GetView<ContactsController> {
  const ContactList({super.key});

  Widget _buildContactItem(ContactItem contactItem) {
    return InkWell(
      onTap: () => controller.viewChat(contactItem),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: contactItem.avatar!,
          imageBuilder: (context, imageProvider) => Container(
            height: 45.h,
            width: 45.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            height: 45.h,
            width: 45.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.imagesDefault),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 45.h,
            width: 45.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Assets.imagesDefault),
              ),
            ),
          ),
        ),
        title: Text(contactItem.name!),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18),
            child: Text(
              'All Contacts',
              style: TextStyle(
                color: AppColor.secondaryText,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.w,
                    horizontal: 0.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var contactItem = controller.state.contactList[index];
                        return _buildContactItem(contactItem);
                      },
                      childCount: controller.state.contactList.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
