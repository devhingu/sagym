import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/icon_constants.dart';
import 'package:gym/ui/member/screen/reminder_screen.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/methods/reusable_methods.dart';
import '../../../constants/asset_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/param_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../constants/text_style_constants.dart';
import '../../../widgets/member/member_tile.dart';
import 'member_detail_screen.dart';

class MemberListScreen extends StatefulWidget {
  static const String id = "member_list_screen";

  const MemberListScreen({Key? key}) : super(key: key);

  @override
  State<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final kCurrentUser = FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance;
  String userName = "";
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  bool _offStage = true;
  String personName = "";

  getMemberListData() async {
    var data = await _fireStore
        .collection("Trainers")
        .doc(kCurrentUser?.email)
        .collection("memberDetails")
        .get();
    if (mounted) {
      setState(() {
        _allResults = data.docs;
      });
    }

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
        personName = "${element[paramFirstName]} ${element[paramLastName]}"
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

  void showMemberListByStatus({required bool isActive}) {
    _resultsList.clear();
    var showActiveList = [];
    var showInactiveList = [];
    if (isActive) {
      for (var element in List.from(_allResults)) {
        if (element[paramStatus] == true) {
          showActiveList.add(element);
          setState(() {
            _resultsList = showActiveList;
            _offStage = false;
          });
        }
      }
    } else {
      for (var element in List.from(_allResults)) {
        if (element[paramStatus] == false) {
          showInactiveList.add(element);
          setState(() {
            _resultsList = showInactiveList;
            _offStage = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _offStage = true;
            });
            await getMemberListData();
            await Future.delayed(const Duration(seconds: 2));
          },
          child: _allResults.isEmpty
              ? Center(
                  child: Image.asset(kNoDataImagePath),
                )
              : Column(
                  children: [
                    Padding(
                      padding: kThreeSidePadding,
                      child: _searchField(),
                    ),
                    heightSizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
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

  AppBar _appBar(BuildContext context) => AppBar(
        title: const Text(kMemberEntries),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              navigatePushNamedMethod(context, ReminderScreen.id);
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      );

  TextFormField _searchField() => TextFormField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          contentPadding: kAllSidePadding,
          border: textFormFieldInputBorder(),
          hintText: kSearch,
          prefixIcon: const Icon(
            icSearch,
            color: kGreyColor,
          ),
          focusedBorder: textFormFieldInputBorder()
              .copyWith(borderSide: const BorderSide(color: kBlackColor)),
        ),
      );

  Row _entryDetails() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            kEntryDetails,
            style: kTextFormFieldLabelTextStyle,
          ),
          Row(
            children: [
              Offstage(
                offstage: _offStage,
                child: _clearFilterButton(),
              ),
              IconButton(
                onPressed: showPopUpMenu,
                icon: const Icon(
                  icEllipsis,
                  color: kDarkGreyColor,
                ),
              ),
            ],
          ),
        ],
      );

  TextButton _clearFilterButton() => TextButton(
        onPressed: () async {
          setState(() {
            _resultsList.clear();

            getMemberListData();
            _offStage = true;
          });
        },
        child: const Text(
          kClearFilter,
          style: TextStyle(fontSize: 16.0),
        ),
      );

  showPopUpMenu() async => await showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(100, 100, 0, 100),
        items: [
          PopupMenuItem<String>(
            onTap: () {
              showMemberListByStatus(isActive: true);
            },
            child: const Text(kActive),
            value: kActive,
          ),
          PopupMenuItem<String>(
            onTap: () {
              showMemberListByStatus(isActive: false);
            },
            child: const Text(kInactive),
            value: kInactive,
          ),
        ],
        elevation: 8.0,
      );

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
              return Dismissible(
                background: _dismissibleContainer(),
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) async {
                  await _fireStore
                      .collection("Trainers")
                      .doc(kCurrentUser?.email)
                      .collection("memberDetails")
                      .doc(_resultsList[index][paramEmail])
                      .delete();
                  getMemberListData();
                },
                child: _memberListTile(_resultsList[index], context),
              );
            },
          ),
        ),
      );

  Container _dismissibleContainer() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: kAllSideVerySmallPadding,
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: kBackgroundColor,
              size: 28.0,
            ),
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
        name: "${doc[paramFirstName]} ${doc[paramLastName]}",
        email: doc[paramEmail],
        status: doc[paramStatus],
        batch: doc[paramBatch],
      );
}
