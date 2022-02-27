import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/ui/member/screens/member_detail_screen.dart';
import 'package:gym/widgets/member_list_tile.dart';
import 'package:gym/widgets/reusable/reusable_methods.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  // final TextEditingController _searchController = TextEditingController();
  // late String name ="Dev Hingu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kMemberEntries),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
               /* Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        if( _searchController.text.toLowerCase().contains(name)){
                          print("yes");
                        }
                      });

                    },
                    decoration: const InputDecoration(
                      contentPadding: kAllSidePadding,
                      hintText: "Search",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),*/
                MemberListTile(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MemberDetailScreen(),
                      ),
                    );
                  },
                  name: "Dev Hingu",
                  subtitle: "9067830621",
                  leadingImage: "assets/avatar.png",
                  isReceived: true,
                ),
                MemberListTile(
                  onPress: () {},
                  name: "Dev Hingu",
                  subtitle: "9067830621",
                  leadingImage: "assets/avatar.png",
                  isReceived: false,
                ),
                MemberListTile(
                  onPress: () {},
                  name: "Dev Hingu",
                  subtitle: "9067830621",
                  leadingImage: "assets/avatar.png",
                  isReceived: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
