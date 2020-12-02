import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class Text_Sign extends StatefulWidget {
  @override
  _Text_SignState createState() => _Text_SignState();
}

class _Text_SignState extends State<Text_Sign> {
  // static MediaQueryData queryData;
  // static double _height = queryData.size.height;
  // static double _width = queryData.size.width;
  final List<String> _arr = new List();

  final myController = TextEditingController();
  
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void StringToArray(String str) {
    for (int i=0; i<str.length; i++){
      _arr.add(str[i].toUpperCase());
    };
  }

  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildList(),
            buildInputText(),
            CupertinoButton(
              color: CupertinoColors.activeOrange,
              child: Text(
                'Reset',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.white
                ),
              ),
              onPressed: () {
                _arr.clear();
                myController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return AspectRatio(
      aspectRatio: 20/21,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 8, right: 8),
        itemCount: _arr.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: buildCard(context, _arr[index])
          );
        },
      ),
    );
  }

  Widget buildCard(BuildContext context, String str) {
    return CupertinoButton(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CupertinoColors.quaternarySystemFill,
        ),
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/$str.png'),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Huruf $str',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
      onPressed: (){},
    );
  }

  Widget buildInputText() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: CupertinoTextField(
              placeholder: 'Masukkan teks',
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.go,
              textCapitalization: TextCapitalization.sentences,
              controller: myController,
              onSubmitted: (String value){
                _arr.clear();
                myController.clear();
                StringToArray(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}