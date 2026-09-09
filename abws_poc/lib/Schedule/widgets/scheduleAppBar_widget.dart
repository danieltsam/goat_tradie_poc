import 'package:flutter/material.dart';

class ScheduleAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int stepTracker;
  final VoidCallback? onBackTap;
  final VoidCallback? onProfileTap;

  const ScheduleAppBarWidget({
    super.key,
    required this.stepTracker,
    this.onBackTap,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 90.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'A Better Weekly Structure',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'HighVoltage',
        ),
      ),
      backgroundColor: Colors.red,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onBackTap ?? () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/back_arrow.png',
            height: 20,
            width: 20,
          ),
        ),
      ),
      // Contains the GOAT profile button
      actions: [
        GestureDetector(
          onTap: onProfileTap ?? () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              'assets/icons/goat_temp.png',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
      // Contains the legend and step count
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          height: 90.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              // The step count square
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      'Step ${stepTracker + 1} of 12',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              // The progress bar and legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // The progress bar
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),

                    // The legend
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: const Text(
                          'legend box',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

