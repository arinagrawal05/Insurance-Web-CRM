import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Lotia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Lottie.network(
        'https://assets8.lottiefiles.com/packages/lf20_3xtpb0bw.json',
        // delegates: LottieDelegates(

        //   text: (initialText) => '**$initialText**',
        //   values: [

        //     ValueDelegate.color(
        //       const ['Shape Layer 1', 'Rectangle', 'Fill 1'],
        //       value: Colors.red,

        //     ),
        //     ValueDelegate.opacity(
        //       const ['Shape Layer 1', 'Rectangle'],
        //       callback: (frameInfo) =>
        //           (frameInfo.overallProgress * 100).round(),
        //     ),
        //     ValueDelegate.position(
        //       const ['Shape Layer 1', 'Rectangle', '**'],
        //       relative: const Offset(100, 200),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
