import 'package:flutter/material.dart';
import '../data/get_feed_data.dart';
import 'package:url_launcher/url_launcher.dart';

class TrialTwoPage extends StatefulWidget {
  final String feed;
  // Construtor
  TrialTwoPage({Key key, this.feed}) : super(key:key);

  @override  
  _TrialTwoPageState createState() => _TrialTwoPageState(this.feed);
}

class _TrialTwoPageState extends State<TrialTwoPage> {

  final String feed;
  Future<List> articles;
  
  // Construtor
  _TrialTwoPageState(this.feed);

  @override
  Widget build(BuildContext context) {

    GetFeedData rss = new GetFeedData();
    articles = rss.read(url: this.feed);

    return Scaffold(
      appBar: AppBar(
        title: Text('Share your shop list'),
        leading: Icon(Icons.rss_feed),        
      ),
      body: FutureBuilder(
        future: articles,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return messageTemplate(title: 'A carregar lista...', icon: Icons.refresh);               
            default:
              if(snapshot.hasError){
                return messageTemplate(title: 'Ocorreu um erro', icon: Icons.error);              
              }
              return listArticles(snapshot.data);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  messageTemplate({String title, IconData icon}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 80,),
          Text(title),
        ],
      ),
    );
  }

  listArticles(List articles){
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(articles[index]['title']),
                subtitle: Text(articles[index]['link']),
                leading: Icon(Icons.open_in_browser),
                onTap:() {
                  String url = articles[index]['link'];
                  canLaunch(url).then((isConfirmed){
                    if (isConfirmed) {
                       launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }          
                  });                                   
                }
              );
            },
          ),
        ),
      ],
    );
  }

}
