import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simas/page/SuratMasukPage.dart';
import 'package:simas/page/SuratKeluarPage.dart';
import 'package:simas/page/DashboardPage.dart';

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key}) : super(key: key);

  @override
  _WithTabBarState createState() => _WithTabBarState();
}

class _WithTabBarState extends State<RouterPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[

    DashboardPage(),
    SuratMasukPage(),
    SuratKeluarPage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Surat Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Surat Keluar',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
