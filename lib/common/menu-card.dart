import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCard extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String title;
  const MenuCard(
      {Key? key, required this.color, required this.icon, required this.title})
      : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var iconName = widget.icon;
    String cardTitle = widget.title;
    return GestureDetector(
      onTap: () {
        debugPrint("clicked");
      },
      child: Card(
        color: widget.color,
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [
            Positioned(
                left: -25,
                top: -35,
                child: Icon(
                  iconName,
                  size: 120,
                  color: Colors.white30,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: screenWidth,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Colors.black12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 6, left: 10, right: 10),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Text(
                            cardTitle,
                            style: GoogleFonts.comfortaa(
                              fontSize: 16,
                            ),
                          ),
                          const Positioned(
                              right: 0, child: Icon(Icons.arrow_right_alt))
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
