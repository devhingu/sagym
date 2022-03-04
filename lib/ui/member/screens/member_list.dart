import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/constants/constants.dart';
import 'package:gym/provider/member_provider.dart';
import 'package:gym/ui/dashboard/constants/dashboard_constants.dart';
import 'package:gym/ui/member/constants/member_constants.dart';
import 'package:gym/ui/member/screens/member_detail_screen.dart';
import 'package:gym/ui/member/screens/reminder_screen.dart';
import 'package:gym/constants/methods/reusable_methods.dart';
import 'package:provider/provider.dart';
import '../../../widgets/member/member_tile.dart';

class MemberListScreen extends StatefulWidget {
  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;
  String userName = "";
  final TextEditingController _searchController = TextEditingController();
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  String personName = "";

  getMemberListData() async {
    var data = await _fireStore
        .collection("Trainers")
        .doc(kCurrentUser?.email)
        .collection("memberDetails")
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
    return "Complete";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getMemberListData();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var element in List.from(_allResults)) {
        personName = "${element["firstName"]} ${element["lastName"]}"
            .trim()
            .toLowerCase();
        if (personName.contains(_searchController.text.toLowerCase())) {
          showResults.add(element);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(kMemberEntries),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReminderScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {

             await getMemberListData();
             await Future.delayed(const Duration(seconds: 2));
          },
          child: Column(
            children: [
              Padding(
                padding: kThreeSidePadding,
                child: _searchField(),
              ),
              heightSizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _entryDetails(),
              ),
              heightSizedBox(height: 15.0),
              _memberStreamBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _memberStreamBuilder() =>
      NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Flexible(
          child: ListView.builder(
            itemCount: _resultsList.length,
            itemBuilder: (BuildContext context, int index) {
              return _memberListTile(_resultsList[index], context);
            },
          ),
        ),
      );

  MemberTile _memberListTile(dynamic doc, BuildContext context) => MemberTile(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailScreen(doc: doc),
            ),
          );
        },
        name: "${doc[paramsFirstName]} ${doc[paramsLastName]}",
        email: doc[paramsEmail],
        status: doc[paramsStatus],
        batch: doc[paramsBatch],
      );

  Row _entryDetails() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kEntryDetails,
            style: kTextFormFieldLabelTextStyle,
          ),
          const Icon(
            kEllipsisIcon,
            color: kDarkGreyColor,
          ),
        ],
      );

  TextFormField _searchField() => TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: kAllSidePadding,
          border: textFormFieldInputBorder(),
          hintText: kSearch,
          prefixIcon: const Icon(
            kSearchIcon,
            color: kGreyColor,
          ),
          focusedBorder: textFormFieldInputBorder()
              .copyWith(borderSide: const BorderSide(color: kBlackColor)),
        ),
      );
}
