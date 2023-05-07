import 'package:flutter/material.dart';



class ServerItemWidget extends StatelessWidget {
  const ServerItemWidget(
      {
         Key? key,
      required this.label,
      
      
      @required this.onTap,
      this.isFaded = false})
      : super(key: key);

  final String label;
  
  
  final  onTap;
  final isFaded;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                
                SizedBox(
                  width: 15,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
