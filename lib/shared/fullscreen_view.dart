import 'package:flutter/material.dart';
import 'package:health_model/shared/style.dart';

class FullScreenBannerPage extends StatefulWidget {
  final String name, bannerUrl;
  FullScreenBannerPage({required this.bannerUrl, required this.name});

  @override
  _FullScreenBannerPageState createState() => _FullScreenBannerPageState();
}

class _FullScreenBannerPageState extends State<FullScreenBannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      // appBar: AppBar(
      //   title: Text(widget.name),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Center(
            child: Container(
              width: double.infinity,
              child: Image.network(
                widget.bannerUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: heading(widget.name, 18),
          )
        ],
      ),
    );
  }
}
