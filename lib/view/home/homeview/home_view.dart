import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project/service/authservice/emailauth/authentication.dart';
import 'package:project/view/auth/hostelid_auth/hotelid_controller.dart';
import 'package:project/view/home/components/header_widget.dart';
import 'package:project/view/home/components/hostel_card.dart';
import 'package:project/view/home/homeview/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final EmailAuthMethod emailAuth = EmailAuthMethod();
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final HostelidController hostelidController = Get.find();
    return Obx(() {
      return Scaffold(
        body: Column( 
          children: [
            Header(Fireauth: fireAuth, homeController: homeController),
            const SizedBox(height: 30),
            Stack(
              children: [
                hosteldetails(
                  place: hostelidController.place,
                  accomodation: hostelidController.accomodation,
                  highlights: hostelidController.highlights,
                ),
                Positioned(
                  top: 5,
                  left: 43,
                  child: FadeInLeft(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              hostelidController.name.value,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120),
            _FeatureContainer(),
          ],
        ),
      );
    });
  }

  Widget _FeatureContainer() {
  return Expanded(
    child: Stack(
      children: [
        // Background Image
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/hostellogin.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        // Gradient Overlay
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.5), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        // Content
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                     final icons = [
                      IonIcons.chatbox_ellipses,
                      IonIcons.accessibility,
                      ZondIcons.notifications,
                      IonIcons.fast_food,
                      Icons.spatial_tracking_outlined,
                      Icons.payments_outlined,
                      IonIcons.bus,
                      IonIcons.settings,
                      IonIcons.person,
                    ];  

                    final texts = [ 
                      'Notify them\n',
                      'Rules',
                      'Notification',
                      'Food Menu',
                      'Announcements',
                      'Payment',
                      'Ksrtc Booking',
                      'Settings',
                      'Profile',
                      
                    ];

                     void onTap(int index) {
                      print("Tapped on: ${texts[index]}");
                     }

                    return GestureDetector(
                      onTap: () => onTap(index),  
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index], 
                            size: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),  
                          Text(
                            texts[index], 
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Contact info",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
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