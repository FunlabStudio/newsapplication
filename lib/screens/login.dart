import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/screens/homePage.dart';

sizeBox() {
  return SizedBox(
    height: 20,
  );
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  bool isSwitched = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool seePassword = true;

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.register) {
          User user = (await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email, password: _password))
              .user;

          print(user.uid);
          print(user);
          //return
        } else {
          User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email, password: _password))
              .user;
          //print(user.updatePassword('0001110'));
          print(user.uid);
          return await Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      } on FirebaseAuthException catch (e) {
        print('BIG ERROR IS: $e');
        if (e.code == 'too-many-requests') {
          scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Try again later')));
        }
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return <Widget>[
        //Email
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email'),
          validator: (val) {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val)
                ? null
                : "Please Enter Correct Email";
          },
          onSaved: (String value) => _email = value,
        ),
        sizeBox(),
        //Password
        TextFormField(
          key: Key('password'),
          //maxLength: 8,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: seePassword
                  ? Icon(
                      CupertinoIcons.eye_slash_fill,
                      color: Colors.black,
                    )
                  : Icon(CupertinoIcons.eye, color: Colors.black),
              onPressed: () {
                setState(() {
                  seePassword = !seePassword;
                });
              },
            ),
            labelText: 'Password',
          ),
          obscureText: seePassword,
          // ignore: missing_return
          validator: (val) {
            if (val.length <= 6) {
              if (val.isEmpty) {
                return 'Field Cannot Be Empty';
              }
              if (val.length < 5) {
                return 'Password Cant not be less than 7 Characters';
              }
              if (val.length > 7) {
                return 'Password Cant not be More than 25 Characters';
              }
              return null;
            }
          },
          onSaved: (String value) => _password = value,
        ),
        sizeBox(),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print(isSwitched);
            });
          },
          inactiveTrackColor: Colors.black12,
          activeTrackColor: Colors.black26,
          activeColor: Colors.teal,
          inactiveThumbColor: Colors.black,
        )
      ];
    } else {
      return <Widget>[
        //Email
        TextFormField(
          key: Key('email'),
          decoration: InputDecoration(labelText: 'Email'),
          validator: (val) {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val)
                ? null
                : "Please Enter Correct Email";
          },
          onSaved: (String value) => _email = value,
        ),
        sizeBox(),
        //Password
        TextFormField(
          key: Key('password'),
          //maxLength: 8,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: seePassword
                  ? Icon(
                      CupertinoIcons.eye_slash_fill,
                      color: Colors.black,
                    )
                  : Icon(CupertinoIcons.eye, color: Colors.black),
              onPressed: () {
                setState(() {
                  seePassword = !seePassword;
                });
              },
            ),
            labelText: 'Password',
          ),
          obscureText: seePassword,
          // ignore: missing_return
          validator: (val) {
            if (val.length <= 6) {
              if (val.isEmpty) {
                return 'Field Cannot Be Empty';
              }
              if (val.length < 5) {
                return 'Password Cant not be less than 7 Characters';
              }
              if (val.length > 7) {
                return 'Password Cant not be More than 25 Characters';
              }
              return null;
            }
          },
          onSaved: (String value) => _password = value,
        ),
        sizeBox(),
      ];
    }
  }

  Switch remember() {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          print(isSwitched);
        });
      },
      inactiveTrackColor: Colors.black12,
      activeTrackColor: Colors.black26,
      activeColor: Colors.teal,
      inactiveThumbColor: Colors.black,
    );
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        RaisedButton(
          shape: StadiumBorder(),
          color: Theme.of(context).accentColor,
          key: Key('signIn'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        sizeBox(),
        FlatButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
        sizeBox(),
      ];
    } else {
      return <Widget>[
        RaisedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        sizeBox(),
        FlatButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
