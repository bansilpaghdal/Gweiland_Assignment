import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarIcon(image: 'assets/images/eshop.png', name: '€-\$hop'),
            NavBarIcon(image: 'assets/images/exchange.png', name: 'Exchange'),
            const SizedBox(
                height: 70,
                width: 65,
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/metaverse.png'),
                )),
            NavBarIcon(image: 'assets/images/launchpad.png', name: 'Launchpad'),
            NavBarIcon(image: 'assets/images/wallet.png', name: 'Wallet')
          ],
        ));
  }

  Padding NavBarIcon({String? image, String? name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 20, width: 30, child: Image(image: AssetImage(image!))),
          const SizedBox(
            height: 5,
          ),
          Text(
            name!,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          )
        ],
      ),
    );
  }
}
