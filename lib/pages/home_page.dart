import 'package:flutter/material.dart';
import '../data/save_local.dart';
import './trial_two.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _formKey = GlobalKey<FormState>();
  final feedController = TextEditingController();

  List feeds = [];

  @override
  void initState() {
    SaveLocal persistence = new SaveLocal(feedList: feeds);
    persistence.read().then((data){
      setState((){      
        feeds = data; // passa a lista que vem da classe      
      });
    });
    super.initState();    
  }


  @override
  Widget build(BuildContext context) {

    SaveLocal persistence = new SaveLocal(feedList: feeds);    

    return Scaffold(
      appBar: AppBar(
        title: Text('Family Shop List'),
        automaticallyImplyLeading: false, // não mostrar o botão de voltar
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: feeds.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(feeds[index]),
                    leading: Icon(Icons.rss_feed),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrialTwoPage(feed: feeds[index])
                        ) 
                      );
                    },
                  );
                },
              ),
            ),
            TextFormField(
              controller: feedController,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: "Link do RSS",
              ),
              validator: (value){ // Validar os campos
                  if(value.isEmpty) return "Este campo é obrigatório";
              }, 
            ),
            RaisedButton(
              child: Text('Registar'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                if(_formKey.currentState.validate()){                  
                  // feeds
                  setState(() {
                    feeds.add(feedController.text);
                    feedController.text = "";
                     persistence.save(feeds);
                  }); 
                }                
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}