import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_svg/flutter_svg.dart';

import '../components/blank_container.dart';
import '../global/colors.dart';
import '../theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('الرجاء الانتظار', style: textTheme().displayLarge),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              SvgPicture.asset('assets/images/frame.svg'),
              SizedBox(height: size.height * 0.18),
              InfiniteRotation(),
              SizedBox(height: size.height * 0.18),
              Material(
                elevation: 5,
                color: LIGHTCOLOR,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                    onPressed: null,
                    minWidth: size.width * 0.8,
                    height: 60,
                    child: SvgPicture.asset('assets/images/loading.svg',
                        width: 38)),
              ),
            ],
          ),
        ),
        BlankContainer()
      ]),
    );
  }
}

class InfiniteRotation extends StatefulWidget {
  @override
  _InfiniteRotationState createState() => _InfiniteRotationState();
}

class _InfiniteRotationState extends State<InfiniteRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    timeDilation = 1.0; // Reset the time dilation if you've used it before

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        'assets/images/loading.svg',
      ),
    );
  }
}
