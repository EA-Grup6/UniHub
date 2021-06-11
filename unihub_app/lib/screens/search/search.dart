import 'package:flutter/material.dart';
import 'package:unihub_app/screens/search/searchFeedPublications.dart';
import 'package:unihub_app/screens/search/searchOffers.dart';
import 'package:unihub_app/screens/search/searchProfiles.dart';

class SearchScreen extends StatefulWidget {
  @override
  Search createState() => Search();
}

TabController _tabController;
final List<Tab> myTabs = <Tab>[
  Tab(text: 'Feed publications'),
  Tab(text: 'Offers'),
  Tab(text: 'Profiles'),
];

class Search extends State<SearchScreen> with TickerProviderStateMixin {
  String currentTab = 'Feed Publications';
  TextEditingController _searchController;

  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          this.currentTab = 'Feed Publication';
        } else if (_tabController.index == 1) {
          this.currentTab = 'Offers';
        } else if (_tabController.index == 2) {
          this.currentTab = 'Profiles';
        }
      });
    });
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        keyword = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String keyword = '';
  List<String> finalSelectedFeedPubsFields = [];
  List<String> availableFeedPubFields = ['Content', 'Username'];

  List<String> finalSelectedOffersFields = [];
  List<String> availableOffersFields = [
    'University',
    'Subject',
    'Type',
    'Description',
    'Username',
  ];

  List<String> finalSelectedProfilesFields = [];
  List<String> availableProfilesFields = [
    "Fullname",
    "Degree",
    "University",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: myTabs,
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white,
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Search'),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 35,
              child: TextField(
                style: TextStyle(color: Colors.grey[300], fontSize: 14.0),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search ' + currentTab,
                  hintStyle: TextStyle(color: Colors.grey[300], fontSize: 14.0),
                  filled: true,
                  fillColor: Colors.white30,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[400], width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.grey[500], width: 1),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: () {
                //Alert para seleccionar si queremos buscar por usuario/contenido/universidad/facultad/asignaturas...
                //El contenido del alert debe variar si estamos en feed publications, offers o profiles (no tiene sentido buscar por campos que no existen!)
                showFiltersDialog(this.context, finalSelectedFeedPubsFields,
                    finalSelectedOffersFields, finalSelectedProfilesFields);
              },
            )
          ]),
        ),
        body: TabBarView(controller: _tabController, children: [
          SearchFeedPubsScreen(
              finalSelectedFeedPubsFields, keyword.toLowerCase()),
          SearchOffersScreen(finalSelectedOffersFields, keyword.toLowerCase()),
          SearchProfilesScreen(
              finalSelectedProfilesFields, keyword.toLowerCase())
        ]),
      ),
    );
  }

  showFiltersDialog(BuildContext context, List<String> feedPubsFilters,
      List<String> offersFilters, List<String> profilesFilters) {
    // set up the buttons
    List<String> selectedFeedPubsFields = feedPubsFilters;
    List<String> selectedOffersFields = offersFilters;
    List<String> selectedProfilesFields = profilesFilters;
    Widget acceptFilters = TextButton(
        child: Text("Filter by selected fields"),
        onPressed: () {
          if (_tabController.index == 0) {
            setState(() {
              finalSelectedFeedPubsFields = selectedFeedPubsFields;
            });
          } else if (_tabController.index == 1) {
            setState(() {
              finalSelectedOffersFields = selectedOffersFields;
            });
          } else if (_tabController.index == 2) {
            setState(() {
              finalSelectedProfilesFields = selectedProfilesFields;
            });
          }
          Navigator.pop(context);
        });

    Widget dismissFilters = TextButton(
      child: Text("Dismiss selected fields"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(10),
        title: Text("Filter options"),
        content: _tabController.index == 0
            ? StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ListView.builder(
                      itemCount: availableFeedPubFields.length,
                      itemBuilder: (BuildContext context, index) {
                        return new CheckboxListTile(
                            title: Text(availableFeedPubFields[index]),
                            value: selectedFeedPubsFields
                                .contains(availableFeedPubFields[index]),
                            onChanged: (bool value) {
                              setState(() {
                                value
                                    ? selectedFeedPubsFields
                                        .add(availableFeedPubFields[index])
                                    : selectedFeedPubsFields
                                        .remove(availableFeedPubFields[index]);
                              });
                            });
                      },
                    ),
                  );
                },
              )
            : _tabController.index == 1
                ? StatefulBuilder(builder: (context, setState) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ListView.builder(
                        itemCount: availableOffersFields.length,
                        itemBuilder: (BuildContext context, index) {
                          return new CheckboxListTile(
                              title: Text(availableOffersFields[index]),
                              value: selectedOffersFields
                                  .contains(availableOffersFields[index]),
                              onChanged: (bool value) {
                                setState(() {
                                  value
                                      ? selectedOffersFields
                                          .add(availableOffersFields[index])
                                      : selectedOffersFields
                                          .remove(availableOffersFields[index]);
                                });
                              });
                        },
                      ),
                    );
                  })
                : _tabController.index == 2
                    ? StatefulBuilder(builder: (context, setState) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: ListView.builder(
                            itemCount: availableProfilesFields.length,
                            itemBuilder: (BuildContext context, index) {
                              return new CheckboxListTile(
                                  title: Text(availableProfilesFields[index]),
                                  value: selectedProfilesFields
                                      .contains(availableProfilesFields[index]),
                                  onChanged: (bool value) {
                                    setState(() {
                                      value
                                          ? selectedProfilesFields.add(
                                              availableProfilesFields[index])
                                          : selectedProfilesFields.remove(
                                              availableProfilesFields[index]);
                                    });
                                  });
                            },
                          ),
                        );
                      })
                    : Container(),
        actions: [dismissFilters, acceptFilters]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

/*
class DataSearch extends SearchDelegate<String> {
  final subjects = [
    "EA",
    "MF",
    "AERO",
    "MV",
    "ITA",
    "MGTA",
    "DSA",
    "XLAM",
    "ALGEBRA",
    "AMPLI1",
    "AMPLI2",
    "PDS",
    "INFO2",
    "SX",
    "TIQ",
    "CSD",
  ];

  final recentSubjects = [
    "INFO2",
    "SX",
    "TIQ",
    "CSD",
  ];

  final String searchingBy;

  DataSearch(this.searchingBy);

  @override
  String get searchFieldLabel => 'Search ' + this.searchingBy;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selection
    return Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final subjectsList = query.isEmpty
        ? recentSubjects
        : subjects.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.subject),
        title: RichText(
          text: TextSpan(
              text: subjectsList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: subjectsList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: subjectsList.length,
    );
  }
}
*/
