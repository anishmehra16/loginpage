import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:googleapis_auth/auth_browser.dart';
void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(home:Scaffold(
      appBar: AppBar(
        title:const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            
          Image.asset('lib/aseets/logotype-letter-login-logo-design-graphic-symbol-icon-sign-illustration-creative-idea-vector.jpg',height:200 ,width: 200,),

            TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value;
                },
              ),
              TextFormField(
                decoration:const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: _submitForm
                  
              ),
            ],
          ),
        ),
      ),
    )
    );
  }


void _submitForm() async{
  if(_formKey.currentState!.validate()){
    _formKey.currentState!.save();
    final scopes = ['scope1', 'scope2'];
    try{ 
      final creds = await obtainAccessCredentialViauserConsent(ClientId, scopes, hotedDomain:'selectamount');

final sheetsApi = SheetsApi(creds.client);
        final spreadsheetId = '1Cj1_MP5YBGB5NOJ11ukj7Y_seJdzW4c6eviXgcvsyiQ';
        final range = 'A1:B100';
        final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
        final values = response.values;
        if (values != null) {
          for (var row in values) {
            if (row[0] == _username && row[1] == _password) {
              Navigator.pushNamed(context, '/next-page');
              return;
            }
          }
        }
        Fluttertoast.showToast(msg: 'Invalid username or password');
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}

