import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class SaveLocal{
  final  List feedList;
  SaveLocal({this.feedList});

  Future <File> get fileFeed async{
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File(dir.path + "/feeds.json");
    if(!file.existsSync()){
      await save(feedList);
    }
    return file;
  }

  read() async{
      final File file = await fileFeed;
      String data = file.readAsStringSync(); // readAsStringSync não é preciso usar o awaait, caso use a readAsString necessit usar o await
      print('teste');
      return json.decode(data);
  }

  save(data) async{
    print(data);    
    final File file = await fileFeed;    
    return file.writeAsStringSync(json.encode(data));
  }
}