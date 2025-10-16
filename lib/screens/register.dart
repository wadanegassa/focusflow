import 'package:flutter/material.dart';
import 'package:task/route.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.only(top: 150), // smaller margin
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,// shrink column height
              children: [
                Container(
                  width: 70, // smaller width
                  height: 70, // smaller height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // smaller radius
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check_box_outlined,
                    size: 40, // smaller icon
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.blue.withOpacity(0.5),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15), // reduce spacing
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 20, // smaller font
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5), // reduce spacing
                const Text(
                  'Login to continue your productivity journey',
                  style: TextStyle(
                    fontSize: 14, // smaller font
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.topLeft,
                  child: Text('Full name', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                SizedBox(height: 5), // reduce spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                  
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,), // reduce spacing
                Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.topLeft,
                  child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                SizedBox(height: 5), // reduce spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                  
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // reduce spacing
                Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.topLeft,
                  child: Text('Password', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                SizedBox(height: 5), // reduce spacing
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                  
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30), // reduce spacing
               ElevatedButton(onPressed: () {
                 Navigator.pushReplacementNamed(context, Routes.home);
               },
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
               ), child: 
               Text('Login', style: TextStyle(color: Colors.white),),
               ),
                SizedBox(height: 20), // reduce spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
               
               
               )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
