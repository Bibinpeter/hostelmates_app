import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class hosteldetails extends StatelessWidget {
  const hosteldetails({
    super.key,
    required this.place,
    required this.accomodation,
    required this.highlights,
  });

  final String place;
  final String accomodation;
  final String highlights;

  @override
  Widget build(BuildContext context) {
    return FadeInRightBig(
      delay: const Duration(seconds: 1),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white60.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Brand(Brands.maps),
                const SizedBox(width: 5),
                Text(
                  place,
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Brand(Brands.myspace),
                const SizedBox(width: 5),
                Text(
                  accomodation,  
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Row(
                children: [
                  const Icon(OctIcons.verified),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    highlights,
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
