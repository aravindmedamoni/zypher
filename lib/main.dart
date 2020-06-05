import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:zypher/models/CategoryModel.dart';
import 'package:zypher/services/apiService.dart';

void setup(){
  GetIt.I.registerLazySingleton<ApiService>(() => ApiService());
}
void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zypher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Zypher'),
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
  List<Category> categoryInfo ;
  ApiService _apiService = GetIt.I<ApiService>();
  @override
  void initState() {
    super.initState();
    debugPrint("Home InitState called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.shortestSide,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.grey[200]
//            gradient:LinearGradient(
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//              colors: [
//              Colors.grey[300],
//            ],
//            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(Icons.sort,size: 30.0,),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 50.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('What would\nyou read, Ariel?',style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40),
                    boxShadow:  [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(2.0, 3.0),
                          blurRadius: 4.0,
                        spreadRadius: 1.0
                          ),
                      BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(-1.0, -1.0),
                          blurRadius: 1.0,
                          spreadRadius: 1.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey
                        ),
                        border: InputBorder.none,
                        hintText: "Title, Genre,Author"
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              Align(
                  alignment: Alignment.topLeft,
                    child: Text('Categories',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),),
                SizedBox(height: 20.0,),
                Container(
                  color: Colors.white,
                  height: 130.0,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                    stream: _apiService.getCategoryInfo(),
                      builder: (context,snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        if(snapshot.hasData){
                          categoryInfo = snapshot.data;
                          print("SNAPSHOT DATA ${snapshot.data}");
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryInfo.length,
                              itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(categoryInfo[index].categoryImageURL),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('${categoryInfo[index].categoryName}')
                                ],
                              ),
                            );
                          });
                        }else{
                          return Text('No data available');
                        }
                    }
                    return null;
                  }),
                )
              ],
            ),
          ),
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void deactivate() {
    debugPrint("Home deactivate state called");
    super.deactivate();
  }

}
