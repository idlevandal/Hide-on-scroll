import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  ScrollController _scrollController = ScrollController();
  bool closeTopContainer = false;

  final List<Widget> _myList = List.generate(30, (index) => Container(
    margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
    color: Colors.lightBlue.shade200,
    padding: const EdgeInsets.all(8.0),
    child: Text('Item $index', style: TextStyle(fontSize: 20.0),),
  ));

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        closeTopContainer = _scrollController.offset > 50;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide on scroll'),
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            height: closeTopContainer ? 0 :  200.0,
            color: Colors.green.shade200,
            child: Center(
              child: MyContainer(),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: _myList,
            ),
          )
        ],
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      // make contents shrink as the animated container shrinks
      fit: BoxFit.fill,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline_sharp, size: 40.0,),
          SizedBox(height: 10.0,),
          Text('Container', style: TextStyle(fontSize: 70)),
        ],
      ),
    );
  }
}


