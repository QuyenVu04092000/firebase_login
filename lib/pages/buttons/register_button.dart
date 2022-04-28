import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget{
  VoidCallback _onPressed;
  RegisterButton({Key key, VoidCallback onPressed}):
        _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ButtonTheme(
        height: 45,
        child: RaisedButton(
          color: Colors.green,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)
          ),
          onPressed: (){
            this._onPressed();
            Navigator.of(context).pop();
          },
          child: Text('Register',style: TextStyle(color: Colors.white),),
        )
    );
  }
}