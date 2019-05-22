import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class GetFeedData {
  Future<List> read({String url}) async {
    http.Client client = http.Client();
    dynamic data = await client.get(url);
    xml.XmlDocument rss = xml.parse(data.body); // faz um parse para xml

    List articles = [];

    rss.findAllElements('item')
      .forEach((node){
        articles.add({
          'title': node.findElements('title').single.text, // .single.text para pegar o texto em vez do xml type
          'link': node.findElements('link').single.text,
        });
      });

    return articles;
  }
}