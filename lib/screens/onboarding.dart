import 'package:flutter/material.dart';
import 'package:task/route.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Stay Focused",
      "subtitle": "Organize your day and increase productivity.",
      "icon": Icons.center_focus_strong,
      "iconColor": Colors.blue
    },
    {
      "title": "Track Your Tasks",
      "subtitle": "Manage your daily goals efficiently.",
      "icon": Icons.check_circle_outline,
      "iconColor": Colors.green
    },
    {
      "title": "Achieve Your Goals",
      "subtitle": "Complete tasks and improve every day.",
      "icon": Icons.emoji_events_outlined,
      "iconColor": Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _onboardingData[index]['icon'],
                        size: 120,
                        color: _onboardingData[index]['iconColor'],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _onboardingData[index]['title'],
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _onboardingData[index]['subtitle'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom navigation (dots + buttons)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  child: const Text("Skip"),
                ),

                // Page indicators
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                // Next / Get Started button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    if (_currentPage == _onboardingData.length - 1) {
                     Navigator.pushReplacementNamed(context, Routes.login);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? "Start"
                        : "Next",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
