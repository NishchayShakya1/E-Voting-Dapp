import 'package:e_voting/pages/electionInfo.dart';
import 'package:e_voting/services/functions.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infuraUrl, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Election'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter Election Name",
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (controller.text.length > 0) {
                            await startElection(controller.text, ethClient!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ElectionInfo(
                                        ethClient: ethClient!,
                                        electionName: controller.text))));
                          }
                        },
                        child: Text("Start Election")))
              ],
            ),
          ),
        ));
  }
}
