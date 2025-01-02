import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';
import 'package:project/widgets/customtextfield/customtextfield.dart';

class HostelidView extends StatelessWidget {
  const HostelidView({super.key});

  @override
  Widget build(BuildContext context) {
  final HostelidController controller = Get.find();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/hostellogin.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.1), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/hostelLogo.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: " ",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 180),
                  CustomText_FormField(
                    label: "please enter your hostel-id",
                    controller: controller.hostelIdController,
                    type: TextInputType.text,
                    prefixIcon: Icons.password_rounded,
                    hintText: "Enter Hostel ID.",
                  ),
                  const SizedBox(height: 150),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.verifyHostelId(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
