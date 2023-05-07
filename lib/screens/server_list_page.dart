
import 'package:androidproject/screens/shared_widgets/server_list_widget.dart';
import 'package:flutter/material.dart';
/// class handle list of servers passed by query vpn server stateful widget
class ServerListPage extends StatefulWidget {
  @override
  _ServerListPageState createState() => _ServerListPageState();
}

class _ServerListPageState extends State<ServerListPage> {
  

  List freeServers = [
    [ 'USA',false],
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Servers',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        children: [
          
          SizedBox(
            height: 20,
          ),
         
          SizedBox(height: 30),
          RichText(
              text: TextSpan(
                  text: 'Free ',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w700),
                  children: [
                TextSpan(
                    text: 'Servers',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.normal))
              ])),
          SizedBox(
            height: 20,
          ),
          Container(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: freeServers.length,
              itemBuilder: (_, index) {
                return Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage: ExactAssetImage(
                                freeServers[index][0],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              freeServers[index][1],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, index) => SizedBox(height: 10),
            ),
          )
        ],
      ),
    );
  }
}
