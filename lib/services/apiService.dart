
import 'package:dio/dio.dart';
import 'package:zypher/models/category.dart';

class ApiService{

  //logic for get list of todoItem
  Stream<List<Category>> getCategoryInfo() async*{
    Dio dio = Dio();
    try{
      Response response = await dio.post('https://newprod.zypher.co/ebooks/getHome',data: {
        "userId": "5ec972e92d2da600109e8844"
      });
      dynamic jsonData;
      // print("status code ${response.statusCode}");
      if(response.statusCode == 200){
        jsonData = response.data;
        print("JSONDATA $jsonData['items']");
        List<Category> taskItems = [];
        if(jsonData['category'].length!=0){
          for(var json in jsonData['category']){
            Category taskData = Category();
            taskData = Category.fromJson(json);
            taskItems.add(taskData);
            yield taskItems;
          }
        }else{
          yield null;
        }
      }else{
        yield null;
      }
    }catch(e){
      yield null;
    }
  }
}