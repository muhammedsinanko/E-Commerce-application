import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarHome extends StatelessWidget {
  const SearchBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 42,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Search for products",
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            )),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
