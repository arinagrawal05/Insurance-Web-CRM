import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

void handleKeyEvent(RawKeyEvent event, ScrollController controller) {
  var offset = controller.offset; //Getting current position
  if (event.logicalKey.debugName == "Arrow Down") {
    if (kReleaseMode) {
      //This block only runs when the application was compiled in release mode.
      controller.animateTo(offset + 50,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    } else {
      // This will only print useful information in debug mode.
      // print(controller.position); to get information..
      controller.animateTo(offset + 50,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  } else if (event.logicalKey.debugName == "Arrow Up") {
    if (kReleaseMode) {
      controller.animateTo(offset - 50,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    } else {
      controller.animateTo(offset - 50,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
}
