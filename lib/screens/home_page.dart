import 'package:assign_promilo/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../components/meetup_tab_view.dart';
import '../components/miscellenaous.dart';
import '../components/trending_meetup_tile.dart';
import '../components/trending_people_tile.dart';
import '../utils/bottom_right_clipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  ValueNotifier<int> tabChangeNotifier = ValueNotifier(0);
  final trendingPeopleData = [
    TrendingData(icon: 'author', author: 'Author', meetups: 1024),
    TrendingData(icon: 'mentor', author: 'Mentor', meetups: 956),
    TrendingData(icon: 'critic', author: 'critic', meetups: 600),
  ];

  @override
  void initState() {
    tabController.addListener(tabChangeListener);
    super.initState();
  }

  @override
  void dispose() {
    tabController.removeListener(tabChangeListener);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(children: [
                      Icon(Icons.search, color: Colors.black),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Search", border: InputBorder.none),
                          ),
                        ),
                      ),
                      Icon(Icons.mic, color: Colors.black)
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 200.0,
                child: TabBarView(
                  controller: tabController,
                  physics: const ClampingScrollPhysics(),
                  children: {1: 'India', 2: 'Nepal', 3: 'UK'}
                      .entries
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MeetupTabView(
                              image: 'assets/meetup_${e.key}.jpg',
                              label: "Popular Meetups in ${e.value}",
                            ),
                          ))
                      .toList(),
                ),
              ),
              TabIndexView(
                  tabChangeNotifier: tabChangeNotifier,
                  onChange: (index) => tabController.animateTo(index)),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SectionHeader(label: "Trending Popular People"),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 190.0),
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      TrendingPeopleTile(data: trendingPeopleData[index]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SectionHeader(label: "Top Trending Meetups"),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 170.0),
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/descriptionPage',
                            arguments: index + 1),
                        child: TrendingMeetupTile(index + 1));
                  },
                ),
              ),
              const SizedBox(height: 60.0)
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 2.0,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text(
        "Individual Meetup",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: false,
    );
  }

  void tabChangeListener() {
    if (!tabController.indexIsChanging &&
        tabController.index != tabChangeNotifier.value) {
      tabChangeNotifier.value = tabController.index;
    }
  }
}
