import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class RunningTextCustom extends StatefulWidget {
  const RunningTextCustom({super.key});
  @override
  State<StatefulWidget> createState() => _RunningTextCustom();
}

class _RunningTextCustom extends State<RunningTextCustom> with SingleTickerProviderStateMixin {
  ScrollController? controller = ScrollController();
  Timer? _timer;
  double _currentPos = 0;
  final String txt =
      "The Bitengos is a team made up of engineers from various fields and software professionals, operating in the field of entrepreneurship and turning the idea into reality. Bitengos has several divisions, where each division deals with the development of maintenance and service in the field in which it specializes, such as: Civil Engineering Division, which includes: consulting, planning, supervision and project management. Systems development engineering: development of software systems according to customer requirements on different platforms. Electrical engineering: execution and project management and more...\n\n\nNowadays, when people want to build / renovate their house, they don't know the cost, not even a close estimate that suits their needs. The system allows by a number of simple questions such as: how many lighting points are there in the house, how many doors are there in the house, what is the size / area of the apartment, how many water points - to issue a detailed report that includes clauses that are in a database that includes: section number, description, price. Depending on the customer's answers, the system can check what the price of the renovation is (a very small deviation) in relation to what is happening in the market today. After the report is published in the system / application, it can be sent to a tender and receive a digital answer with a discount. Once a decision has been made, a digital signature is made between the service receiver and the service provider. After The beginning of the renovation, the service provider has the option to indicate in the system what was done, document it with photos and the system calculates exactly what the cost the customer must pay according to the progress.";

  @override
  initState() {
    log('RunningTextCustom{} initState()');
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      _animateRunningText;
      setState(() {});
    });
  }

  get _animateRunningText {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // Stop the timer when it matches a condition
      // if (timer.tick >= 100) {
      //   timer.cancel();
      // }
      final double lastPos = controller!.position.maxScrollExtent;
      controller!.animateTo(_currentPos == lastPos ? 0 : _currentPos, duration: const Duration(milliseconds: 1000), curve: Curves.elasticOut);
      // print('Tick: ${timer.tick}; i: $currentPos');
      // log('$TAG_CHECK_VALUES offset: ${controller!.offset}; currentPos: $currentPos; lastPosition: $lastPos;');
      _currentPos++;
      if (_currentPos > lastPos) {
        _currentPos = 0;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('checkLifeCycle -> TermsOfUse{} -> build()');
    return GestureDetector(
      onTapDown: (details) {
        _timer?.cancel();
        setState(() {});
      },
      onTapUp: (details) {
        _currentPos = controller!.offset;
        _animateRunningText;
      },
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          controller: controller,
          child: Text(txt),
        ),
      ),
    );
  }
}
