import 'package:flutter/material.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/callbacks_enum.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class speedtest extends StatefulWidget {
  @override
  _speedtest createState() => _speedtest();
}
/// class test internet download and upload rates
class _speedtest extends State<speedtest> {
  final internetSpeedTest = InternetSpeedTest();

  double downloadRate = 0;
  double uploadRate = 0;
  String downloadProgress = '0';
  String uploadProgress = '0';

  String unitText = 'Mb/s';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speed test'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Progress $downloadProgress%',style: TextStyle(height: 15, fontSize: 15),),
                  Text('Download rate  $downloadRate $unitText',style: TextStyle(height: 15, fontSize: 15)),
                ],
              ),
              RaisedButton(
                child: Text('start testing'),
                onPressed: () {
                  internetSpeedTest.startDownloadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                      
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = '100';
                      });
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
                      print(
                          'the transfer rate $transferRate, the percent $percent');
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    fileSize: 20000000,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                 
                  Text('Progress $uploadProgress%'),
                  Text('Upload rate  $uploadRate Kb/s'),
                ],
              ),
              RaisedButton(  
                //flutter pub run dartdoc
                child: Text('start testing'),
                onPressed: () {
                  internetSpeedTest.startUploadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                      print('the transfer rate $transferRate');
                      setState(() {
                        uploadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        uploadProgress = '100';
                      });
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
                      print(
                          'the transfer rate $transferRate, the percent $percent');
                      setState(() {
                        uploadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        uploadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    fileSize: 20000000,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
