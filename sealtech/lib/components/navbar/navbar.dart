import 'package:flutter/material.dart';
import 'package:sealtech/components/navbar/firstTab.dart' as _firstTab;
import 'package:sealtech/components/navbar/fourthTab.dart' as _fourthTab;
import 'package:sealtech/components/navbar/secondTab.dart' as _secondTab;
import 'package:sealtech/components/navbar/thirdTab.dart' as _thirdTab;

//Initial widget
class InitalScreenWidget extends StatefulWidget{
  // InitialScreenWidget({Key key}) : super(key: key);

  @override
  HomeWidget createState() => HomeWidget();
    
}

//State<StatefulWidget> action method
class HomeWidget extends State<InitalScreenWidget>{
  int _count = 0;
  Color _iconPressed = Colors.black;

  //Page controller
  PageController _navPage = PageController(initialPage: 0);

  Widget build(BuildContext ctx){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFFFFFFFF), //white
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                //img src: http://icons.iconarchive.com/icons/hopstarter/square-flags/128/sealtech-Flag-icon.png
                image: AssetImage('assets/idflag.png') ,fit: BoxFit.contain, height: 35,) 
            ],
          ),
         
          actions: <Widget>[
            
            Padding(
              padding: EdgeInsets.only(right: 28.0),
              child: GestureDetector(
                onTap: () {
                  _navPage.jumpToPage(5);
                },
                child: Icon(
                  Icons.more_vert,
                  size: 26.0,
                  color: Colors.black,
                ) 
              ),
            )
          ],
         
          
        ),
        body: PageView(
          controller: _navPage,
          onPageChanged: (int){
            print('Page changes to index $int');
          },
          children: <Widget>[
            new _firstTab.Home(),
            new _secondTab.Search(),
            new _thirdTab.Bookmark(),
            new _fourthTab.Setting(),
           
          ],
          // physics: NeverScrollableScrollPhysics(), //to disable Swipe
        ),
      
        backgroundColor: Color(0xFFFFFCFC), //white ivory
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.only(left: 28.0),
                  icon: Icon(Icons.home, color: (_iconPressed)), 
                  onPressed: () { 
                    setState(() {
                      _navPage.jumpToPage(0);
                      _iconPressed = Colors.red;
                  });}),
                IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.search), 
                  onPressed: () { 
                    setState(() {
                      _navPage.jumpToPage(1);
                  });}),
                IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.bookmark), 
                  onPressed: () { 
                    setState(() {
                      _navPage.jumpToPage(2);
                  });}),
                IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.only(right: 28.0),
                  icon: Icon(Icons.settings), 
                  onPressed: () { 
                    setState(() {
                      _navPage.jumpToPage(3);
                  });}),
                
              ],
            ),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            // showDialog(context: context,
            // builder: (BuildContext context){
            //   return _alert.Alert();
            // },);
          },
          // onPressed: () => setState(() {
          //   _count++;
          //   print('You like sealtech $_count time(s)');
            
          // }),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
    );
  }
}