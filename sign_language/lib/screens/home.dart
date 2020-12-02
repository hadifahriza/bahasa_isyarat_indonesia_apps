import 'package:flutter/cupertino.dart';
import 'package:sign_language/screens/sign_text.dart';
import 'package:sign_language/screens/text_sign.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: Builder(
          builder: (context){
            return Text(
              'Bahasa Isyarat Indonesia',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: CupertinoColors.black,
              ),
            );
          },
        ),
      ),
      child: CupertinoTabScaffold(
        backgroundColor: CupertinoColors.systemBackground,
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.textformat,),
              label: 'Teks - Gambar',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.photo_camera,),
              label: 'Gambar - Teks',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        tabBuilder: (context, i){
          return CupertinoTabView(
            builder: (context){
              switch (i){
                case 0 : return Text_Sign();
                case 1 : return Sign_Text();
              }
            },
          );
        }
      ),
    );
  }
}
