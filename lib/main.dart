import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zypher/bloc/zypher_bloc.dart';
import 'package:zypher/bloc/zypher_event.dart';
import 'package:zypher/bloc/zypher_state.dart';
import 'package:zypher/data/zypher_repository.dart';
import 'package:zypher/models/category.dart';
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
      home: BlocProvider(
        create: (BuildContext context) => ZypherBloc(repository: NetworkZypherRepository()),
          child: MyHomePage(title: 'Zypher')),
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
 // List<Category> categoryInfo ;
//  ApiService _apiService = GetIt.I<ApiService>();
  @override
  void initState() {
    super.initState();
    debugPrint("Home InitState called");
  }
  @override
  void didChangeDependencies() {
    context.bloc<ZypherBloc>()..add(GetCategoryInfo());
    super.didChangeDependencies();
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
                  child: Center(
                    child: BlocBuilder<ZypherBloc,ZypherState>(builder: (BuildContext context,ZypherState state){
                      if(state is ZypherStateLoading){
                        return buildLoading();
                      }else if (state is ZypherStateLoaded){
                        return buildRowData(state.categories);
                      }else {
                        return Text("No Data available");
                      }
                    }),
                  ),
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

  Widget buildLoading() {
    return CircularProgressIndicator();
  }

  Widget buildRowData(List<Category> categoryInfo) {
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
  }
}
