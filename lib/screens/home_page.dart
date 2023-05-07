/// line 3 to 19 are flutter imports 

import 'package:androidproject/screens/server_list_page.dart';
import 'package:androidproject/screens/speedtest.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:internet_speed_test/internet_speed_test.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'shared_widgets/server_list_widget.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/callbacks_enum.dart';

import 'package:flutter/services.dart';
import 'dart:io';

///class to create stateful widget
///for the home_page and interact with api
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //_fluttervpn varible vpn  disconnect state

  FlutterVpnState _flutterVpnState = FlutterVpnState.disconnected;
  //charonstate varible check error strongswan connection
  CharonErrorState charonState = CharonErrorState.NO_ERROR;
  // isactive variable handle toggle button
  bool isactive = false;
  // ip string default
  String _ip = 'No ip';
  

  /// gettingIP method extract device ip

  gettingIP() async {
    await Permission.location.request();
    final info = NetworkInfo();
    var hostAddress = await info.getWifiIP();
    return hostAddress;
  }


   
///initstate initialization method called at the startup of application
  @override
  void initState() {
    FlutterVpn.prepare();
    FlutterVpn.onStateChanged
        .listen((s) => setState(() => _flutterVpnState = s));
    super.initState();
    
  }

/// build method render the whole application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'PROJECT VPN',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Center(
                    //display connection state
                      child: Text(
                    '${connectionState(state: _flutterVpnState)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                  SizedBox(height: 8),
                  Center(
                      child: _flutterVpnState == FlutterVpnState.disconnected
                          ? Text(' No ip address')
                          : Text(
                              
                              '172.105.187.237  Australia/Sydney',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Color.fromRGBO(37, 112, 252, 1),
                                      fontWeight: FontWeight.w600),
                            )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    //button to handle toogling between states connect and disconnect
                    child: InkWell(
                      onTap: () {

                        if(_value == '172.105.187.237'){
                        if (_flutterVpnState == FlutterVpnState.disconnected) {
                          FlutterVpn.simpleConnect(
                            "172-105-187-237.ip.linodeusercontent.com",
                            'vpn',
                            'vpn',
                          );

                           
                      
                        } else {
                          FlutterVpn.disconnect();
                        }}
                      },
                      child: Material(
                        elevation: 2,
                        shape: CircleBorder(),
                        color: _flutterVpnState == FlutterVpnState.disconnected
                            ? Colors.grey
                            : Color.fromRGBO(37, 112, 252, 1),
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.power_settings_new,
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(height: 10),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Column(
                        children: [
                          Text(
                    '${connectionButtonState(state: _flutterVpnState)}',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(37, 112, 252, 1)),
                  ),

                
           DropdownButton(
              value: _value,
              items: [
                
                DropdownMenuItem(
                    child: Text("Select server"),
                    value:"Select server"
                ),
                DropdownMenuItem(
                    child: Text("172.105.187.237"),
                    value: "172.105.187.237"
                )
              ],
              onChanged: (value) {
                setState(() {
                  _value = value.toString();
                });
              }),
          

                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  
                  
                 

                  Spacer(),


             
                  RaisedButton.icon(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: MediaQuery.of(context).size.width / 4.5),
                    color: Color.fromRGBO(37, 112, 252, 1),
                    onPressed: () {

                      

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return   speedtest();
                      }));
                  
                    },
                    icon: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    label: Text(
                      'speed test',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ));
  }

///method handle states of the connection for the strongswan api
  String connectionState({required FlutterVpnState state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'You are connected';
      case FlutterVpnState.connecting:
        return 'VPN is connecting';
      case FlutterVpnState.disconnected:
        return 'You are disconnected';
      case FlutterVpnState.disconnecting:
        return 'VPN is disconnecting';
      case FlutterVpnState.genericError:
        return 'Error getting status';
      default:
        return 'Getting connection status';
    }
  }


  String connectionButtonState({required FlutterVpnState state}) {
    switch (state) {
      case FlutterVpnState.connected:
        return 'Connected';
      case FlutterVpnState.connecting:
        return 'Connecting';
      case FlutterVpnState.disconnected:
        return 'Disconnected';
      case FlutterVpnState.disconnecting:
        return 'Disconnecting';
      case FlutterVpnState.genericError:
        return 'Error';
      default:
        return 'Disconnected';
    }
  }


/// default string of server selected in dropdownButton

String _value = 'Select server';

///show downloadspeed
  double downloadRate = 0;
  //show upload speed 
  double uploadRate = 0;
  String downloadProgress = '0';
  String uploadProgress = '0';

  String unitText = 'Mb/s';
  List itemList = [];
  final internetSpeedTest = InternetSpeedTest();
  var itemSelected; // value
}
