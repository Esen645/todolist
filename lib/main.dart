import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_altiiki/giris/google_sign_in.dart';
import 'screens/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

     home: SplashScreen(),
    ); // MaterialApp
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFarebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      isFarebaseInitialized = true;
    });
    if (FirebaseAuth.instance.currentUser != null) {
      anaSayfayaGit();
    }
  }

  void anaSayfayaGit() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Image(
                image: AssetImage('assets/images/a.png'),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isFarebaseInitialized
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          await signInWithGoogle();
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          await FirebaseFirestore.instance
                              .collection('kullanicilar')
                              .doc(uid)
                              .set(
                            {
                              'girisYaptiMi': true,
                              'sonGirisTarihi': FieldValue.serverTimestamp(),
                            },
                            SetOptions(merge: true),
                          );
                          anaSayfayaGit();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(
                              255, 135, 15, 247), // background
                          onPrimary: const Color.fromARGB(
                              255, 228, 151, 9), // foreground
                        ),
                        icon: Image.asset(
                          "assets/images/google.png",
                        ),
                        label: const Text('Sign in with Google'),
                      )
                    : const CircularProgressIndicator()),
          ]),
    );
  }
}

class UserHeader extends StatefulWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  _UserHeaderState createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  Future<Uint8List?>? _ppicFuture;
  @override
  void initState() {
    super.initState();
    _ppicFuture = _ppicIndir();
  }

  Future<Uint8List?> _ppicIndir() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('kullanicilar')
        .doc(uid)
        .get();
    final userRecMap = documentSnapshot.data();
    if (userRecMap == null) return null;
    if (userRecMap.containsKey('ppicref')) {
      Uint8List? uint8list =
          await FirebaseStorage.instance.ref(userRecMap['ppicref']).getData();
      return uint8list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 236, 75, 12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(FirebaseAuth.instance.currentUser!.displayName!),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () async {
                XFile? xFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (xFile == null) return;
                final imagePath = xFile.path;
                final uid = FirebaseAuth.instance.currentUser!.uid;
                final ppicRef =
                    FirebaseStorage.instance.ref("ppics").child("$uid.jpg");
                await ppicRef.putFile(File(imagePath));

                await FirebaseFirestore.instance
                    .collection('kullanicilar')
                    .doc(uid)
                    .update({'ppicref': ppicRef.fullPath});
                setState(() {
                  _ppicFuture = _ppicIndir();
                });
              },
              child: FutureBuilder<Uint8List?>(
                  future: _ppicFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final picInMemory = snapshot.data!;
                      return CircleAvatar(
                        backgroundImage: MemoryImage(picInMemory),
                      );
                    }
                    return const CircleAvatar(
                      child: Text("BE"),
                    );
                  })),
        ],
      ),
    );
  }
}
