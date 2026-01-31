import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';
import 'package:usafi_app/core/widgets/app_button.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';
import 'package:usafi_app/core/widgets/app_text_field.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: AppCircleButton(
            icon: back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              AppTextField(hint: "Full Name", controller: fullNameController),
              SizedBox(height: 20),
              AppTextField(
                hint: "Email Address",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              AppTextField(
                hint: "Query...",
                controller: queryController,
                maxLines: 5,
                maxLength: 100,
              ),
              SizedBox(height: 30),
              AppButton(title: "Send Us", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
