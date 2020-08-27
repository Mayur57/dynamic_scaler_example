import 'package:dynamic_scaler/dynamic_scaler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Abstract out the rootWidget into a seperate class called App()
    ///and pass it as a param to Scalable() which is now the rootWidget
    return Scalable(
      context: context,
      rootWidget: App(),
      printDebugFlag: true,
      ///This flag is for whether the device information should be shown in the Console.
      ///Set this to true once you've declared the scaling factors as vars.
    );
  }
}

// This widget is the root of your application.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Scaler Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dynamic Scaler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Declare the scale factors of the device as shown by Console here for easy usage
  //Values for Nexus 5X
  double heightFactor = 6.83;
  double widthFactor = 4.11;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ///To scale an image, just use the height parameter of the Image.asset()
            ///and replace the hardcoded value with scaleWidgetHeight() with
            ///desired height and the heightFactor previously defined
            ///
            /// This works because the width gets scaled accordingly by Flutter
            /// to maintain the original aspect ratio. To change the aspect ratio
            /// you can add scaleImageWidth() just as you would add width param to
            /// the Image widget
            Image.network(
              'https://itcraftapps.com/wp-content/uploads/2019/03/Flutter-Cover.png',
              height: Scaler.scaleWidgetHeight(130, heightFactor),
            ),

            ///Use scaleWidgetHeight() for height params and
            ///scaleWidgetWidth() for width params of a widget.
            Container(
              color: Colors.blue,
              height: Scaler.scaleWidgetHeight(50, heightFactor),
              width: Scaler.scaleWidgetHeight(100, widthFactor),
            ),

            ///Sized boxes can be scaled too by treating them as normal containers.
            SizedBox(
              height: Scaler.scaleWidgetHeight(20, heightFactor),
            ),

            ///Paddings can just as easily be scaled as shown below.
            ///Though it is advised to use seperate method calls for
            ///horizontal and vertical paddings, both params can be scaled
            ///using vertical scaling with no perceivable difference.
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Scaler.scaleVerticalPadding(50, heightFactor),
              ),

              ///Example of Dynamic Scaler not preserving the aspect ratio of
              ///the widgets. Generally aspect ratios of a widget are not important
              ///therefore this hasn't been worked on.
              ///TODO: Add a provision to also preserve widget aspect ratios.
              child: Container(
                color: Colors.blue,
                height: Scaler.scaleWidgetHeight(50, heightFactor),
                width: Scaler.scaleWidgetHeight(50, widthFactor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
