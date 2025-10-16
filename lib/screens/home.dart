import 'package:flutter/material.dart';
import 'package:task/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HOmeScreenState();
}

class _HOmeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text('Good Morning, Wada 👋', style: TextStyle(fontSize: 18)),
            Text(
              'Ready to be productive?',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Card(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tasks Completed',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          '5/10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(Icons.trending_up, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Quick Stats',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 174,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Completed'),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                '12 tasks',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 120,
                      width: 174,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Inprogress'),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                '5 tasks',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
                height: 120,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        width: 50,
                        child: Icon(Icons.flash_on_outlined, color: Colors.blue),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Motivation',
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '"Discipline is the bridge \n between goals and accomplishment"',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
            ),
            SizedBox(height: 20),
               Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Quick Stats',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                     Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.check_box_outline_blank_outlined, color: Colors.blue),
                        title: Text('Design new logo'),
                        subtitle: Text('Presonal'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      ),
                      Card(
                        color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.check_box_outline_blank_outlined, color: Colors.blue),
                        title: Text('Review project proposal'),
                        subtitle: Text('Work'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                      ),
                  ],
                )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_outlined),
            label: 'task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
