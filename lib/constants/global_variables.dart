import 'package:flutter/material.dart';
import 'package:second_hand_mobils/models/product_model.dart';

String uri = 'http://<your ip address>:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
}

List<Product> products = [
  Product(
    image:
        'https://th.bing.com/th/id/OIP.vw41Gxzq1c4VRDVZrNPuiAHaIQ?pid=ImgDet&rs=1',
    name: 'iPhone 14 pro Max',
    price: '₹1,27,999',
    description: ''' 
Dynamic Island, Always-On Display, Pro Motion Technology with Adaptive Refresh Rates Upto 120 Hz, HDR Display, True Tone, Wide Colour (P3), Haptic Touch, Contrast Ratio: 20,00,000:1, Max Brightness: 1,000 nits, Peak Brightness: 1,600 nits, Peak Brightness (Outdoor): 2,000 nits''',
  ),
  Product(
    image:
        'https://rukminim2.flixcart.com/image/416/416/xif0q/mobile/k/1/o/-original-imagmg6gz3bsgan7.jpeg?q=70',
    name: 'SAMSUNG Galaxy S23 Ultra 5G ',
    price: '₹1,04,999',
    description: ''' 
Get a smartphone for yourself that can detect your moods and react appropriately. The Samsung Galaxy Ultra's potent processor and advanced camera sensor can handle low light and noise reduction. The phone's Snapdragon 8 Gen 2 processor, which also provides a long battery life to carry you through even the busiest days, also enables quick gaming and video streaming. You can also launch Expert RAW to take high-resolution RAW photos that are vivid and packed with information. Moreover, Dynamic AMOLED 2X offers clear, brilliant details in both bright and low-light conditions. Additionally, to smooth up gaming and save power, the refresh rate is automatically optimised with 120 Hz technology.''',
  ),
  Product(
    image:
        'https://rukminim2.flixcart.com/image/416/416/xif0q/mobile/c/4/d/-original-imaghx9qygjjg8hz.jpeg?q=70',
    name: 'APPLE iPhone 14 Plus',
    price: '₹64,999',
    description: '''
Stay productive and improve your performance with the Super Retina XDR display that is comfortable for the eyes. Powered with a 12 MP main camera, enjoy taking pictures with friends and family. With a built-in rechargeable lithium-ion battery and equipped with the MagSafe wireless charging, you can charge your phone quickly up to 50 % in just half an hour by using a 20 W adapter. This phone is loaded with a horde of exciting features such as Siri, face ID, barometer, ambient light sensors etc., and is also resistant to dust and water as it is IP68 rated.''',
  ),
  Product(
    image:
        'https://rukminim2.flixcart.com/image/416/416/xif0q/mobile/n/r/i/-original-imagtyxhuehakdc4.jpeg?q=70',
    name: 'SAMSUNG Galaxy F14 5G',
    price: '₹11,490',
    description: '''
The Samsung Galaxy F14 smartphone uses a segment-only 5nm processor that enables you with easy multitasking, gaming, and much more. It has a 6000 mAh battery that will last you for up to 2 days on a single charge. Thanks to the 5G connectivity, you can enjoy high speed browsing on this smartphone. It has a large display of about 16.72 cm (6.5) full HD+ display that enables you with immersive viewing. The 12 GB of RAM with RAM Plus offers enough storage space to store all your data. This smartphone’s OS updates and security updates keeps you updated and protected.''',
  ),
];
