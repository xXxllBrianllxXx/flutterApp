import 'package:flutter/material.dart';
import 'package:flutterapp/src/pages/dashboard.dart';
import 'package:flutterapp/src/pages/form.dart';
import 'package:flutterapp/src/pages/galery.dart';
import 'package:flutterapp/src/pages/maps.dart';
import 'package:flutterapp/src/pages/qr.dart';
import 'package:flutterapp/src/pages/score.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {

    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Inicio',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        DashboardPage()
      )
    );
    
    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Notas X Estudiante',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        ScorePage()
      )
    );

    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Maps',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        MapsPage()
      )
    );

    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Formulario',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        FormPage()
      )
    );

    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'QR',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        QrPage()
      )
    );

    items.add(new
      ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: 'Galeria',
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.8), fontSize: 23.0 ),
          colorLineSelected: Colors.black,
        ),
        GaleryPage()
      )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.grey[850],
      backgroundColorAppBar: Colors.black,
      screens: items,
        //    typeOpen: TypeOpen.FROM_RIGHT,
        //    enableScaleAnimin: true,
        //    enableCornerAnimin: true,
        //    slidePercent: 80.0,
        verticalScalePercent: 90.0,
        contentCornerRadius: 20.0,
        //    iconMenuAppBar: Icon(Icons.menu),
        //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
        //    whithAutoTittleName: true,
        //    styleAutoTittleName: TextStyle(color: Colors.red),
        //    actionsAppBar: <Widget>[],
        //    backgroundColorContent: Colors.blue,
        //    elevationAppBar: 4.0,
        //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
        //    enableShadowItensMenu: true,
        //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}