import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeoutAlert extends StatelessWidget {
  final RxInt remainingTime;
  final VoidCallback onInteraction;

  const TimeoutAlert({
    super.key,
    required this.remainingTime,
    required this.onInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onInteraction,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: onInteraction,
              behavior: HitTestBehavior.opaque,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: CupertinoAlertDialog(
              title: const Text('상호작용 없음 경고'),
              content: Obx(() => Text('${remainingTime.value}초 후에 초기 화면으로 돌아갑니다.')),
              actions: [
                CupertinoDialogAction(
                  onPressed: onInteraction,
                  child: const Text('계속하기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}