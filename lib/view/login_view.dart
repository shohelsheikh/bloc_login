import 'package:block_refresh/blocs/app_properties_bloc.dart';
import 'package:block_refresh/blocs/login_bloc.dart';
import 'package:block_refresh/models/LoginApi/login_api_response.dart';
import 'package:block_refresh/networking/Repsonse.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginbloc;
  late AppPropertiesBloc appBloc;

  TextEditingController textEditingController_email = TextEditingController();
  TextEditingController textEditingController_password= TextEditingController();


  @override
  void initState() {
    super.initState();
    appBloc = AppPropertiesBloc();
    _loginbloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title:
        StreamBuilder<Object>(
            stream: appBloc.appbartitle,
            initialData: "Main Dart",
            builder: (context, snapshot) {
              return Text(snapshot.data.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20));
            }
        ),
        backgroundColor: Color(0xFF333333),
      ),
      backgroundColor: Color(0xFF333333),
      body: Center(
        child: Column(
          children: [

            bloc_AppProperties_widgets(),


            bloc_Login_And_AppProperties_widgets(),



          ],
        ),
      )
    );
  }



  @override
  void dispose() {
    appBloc.dispose();
    _loginbloc.dispose();
    super.dispose();
  }

Widget bloc_AppProperties_widgets() {
    return Column(
      children: [
        InkWell(
          onTap: ()
          {
            appBloc.updateappbartitle("Title Boss Is Here!!!");
            appBloc.updateTitle("Boss Is Here!!!");
          },
          child:
          Text("Click Here To View Boss",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child:
          StreamBuilder<Object>(
              stream: appBloc.titleStream,
              initialData: "Main Dart",
              builder: (context, snapshot) {
                return Text(snapshot.data.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20));
              }
          ),
        ),

      ],
    );

  }

Widget bloc_Login_And_AppProperties_widgets() {
    return
      Column(
        children: [
          Container(
            height: 45,
            child: TextFormField(
              controller: textEditingController_email,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontFamily: 'overpass_regular',
                color: Colors.white,
                fontSize: 13,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: 'overpass_regular',
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  fillColor: Colors.white,
                  hintText:"Enter Email",
                  isDense: true,
                  contentPadding: EdgeInsets.zero),

            ),
          ),
          Container(
            height: 45,
            child: TextFormField(
              controller: textEditingController_password,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontFamily: 'overpass_regular',
                color: Colors.white,
                fontSize: 13,
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: 'overpass_regular',
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  fillColor: Colors.white,
                  hintText:"Enter Password",
                  isDense: true,
                  contentPadding: EdgeInsets.zero),

            ),
          ),

          GestureDetector(
            onTap: ()
            {
              appBloc.updateTitle("Boss Is Here!!!");   // This is for updating or refreshing the only widget text
              // This is api call
              _loginbloc.loginApi(textEditingController_email.text.toString(),textEditingController_password.text.toString());


            },
            child:
            Container(
              child:
              Text("Login",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),

          StreamBuilder<Response<Login_api_response>>(
            stream: _loginbloc.loginDataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data!.message);
                    break;
                  case Status.COMPLETED:
                    if(snapshot.data!.data.status=="1")
                    {
                      return    Container(
                        child:
                        Column(
                          children: [

                            Container(
                                margin:const EdgeInsets.only(top: 12),
                                child: Text(snapshot.data!.data.msg.toString(), style: TextStyle(color: Colors.white, fontSize: 20))),

                            Container(
                                margin:const EdgeInsets.only(top: 12),
                                child: Text(snapshot.data!.data.userId.toString(), style: TextStyle(color: Colors.white, fontSize: 20))),

                            Container(
                                margin:const EdgeInsets.only(top: 12),
                                child: Text(snapshot.data!.data.status.toString(), style: TextStyle(color: Colors.white, fontSize: 20))),


                          ],
                        ),
                      );
                    }
                    else
                      return    Container(
                        child:
                        Text("Login Failed",
                            style: TextStyle(color: Colors.white, fontSize: 20)),
                      );


                    break;
                  case Status.ERROR:
                    return  Container(
                      child:
                      Text("Login error",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    );
                    break;
                }
              }
              return Container();
            },
          ),


        ],
      );

  }


}



class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({required this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}

