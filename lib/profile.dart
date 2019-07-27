import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile>{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {



    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    /*Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => null,//new ProfileScreen(detailsUser: details),
      ),
    );*/
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        title: Text("Profile"),
      ),
      body: Builder(
          builder: (context) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GoogleSignInButton(
                onPressed:() => _signIn(context)
              .then((FirebaseUser user) => print(user))
              .catchError((e) => print(e)),
                darkMode: true, // default: false
              )
            ],
          )

      //GoogleSignInButton(
        //onPressed: () {_signIn(context)},
        //darkMode: true, // default: false
      )
    );
  }
}

class UserDetails{
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.userName, this.photoUrl, this.userEmail, this.providerData);
}

class ProviderDetails{
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}