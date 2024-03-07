import 'package:assign_promilo/components/bottom_navigation_bar.dart';
import 'package:assign_promilo/components/miscellenaous.dart';
import 'package:assign_promilo/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);
  final ValueNotifier<int> tabChangeNotifier = ValueNotifier<int>(0);

  final greyTextStyle = const TextStyle(fontSize: 16.0, color: Colors.grey);
  final String dloremIpsum =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  void initState() {
    tabController.addListener(tabChangeListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ModalRoute.of(context)?.settings;

    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(142, 188, 187, 187)),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                          minHeight: 100.0, maxHeight: 250.0),
                      child: Stack(
                        children: [
                          TabBarView(
                              controller: tabController,
                              children: [1, 2, 3]
                                  .map((e) => Hero(
                                        tag: e == 1
                                            ? 'descriptionHero${settings?.arguments ?? ''}'
                                            : '',
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Image.asset(
                                              'assets/meetup_$e.jpg',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  ImageUtils().errorBuilder,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [1, 2, 3]
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ValueListenableBuilder(
                                              valueListenable:
                                                  tabChangeNotifier,
                                              builder: (context, value, child) {
                                                return InkWell(
                                                  onTap: () => tabController
                                                      .animateTo(e - 1),
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: value + 1 == e
                                                            ? Colors.white
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.4)),
                                                    child:
                                                        const SizedBox.square(
                                                            dimension: 8.0),
                                                  ),
                                                );
                                              }),
                                        ))
                                    .toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icons.download_outlined,
                        Icons.bookmark_outline,
                        Icons.favorite_outline,
                        Icons.fullscreen_outlined,
                        Icons.star_outline,
                        Icons.share
                      ]
                          .map((e) => IconButton(
                              onPressed: e == Icons.share ? shareClicked : null,
                              icon: Icon(e)))
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
            const LikesAndRatingBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Actor Name',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text('Indian Actress', style: greyTextStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('Duration 20 mins', style: greyTextStyle),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.wallet_outlined,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            'Total Average Fees \$9999',
                            style: greyTextStyle,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    'About',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200.0),
                    child: Text(
                      dloremIpsum,
                      maxLines: 7,
                      style: greyTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See more",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 40, 53, 147)),
                        )),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void shareClicked() {
    Share.share('The Shar Feature is Working...');
  }

  AppBar appBar() {
    return AppBar(
      elevation: 2.0,
      backgroundColor: Colors.white,
      shadowColor: Colors.grey,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: const Text(
        "Description",
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

class LikesAndRatingBar extends StatelessWidget {
  const LikesAndRatingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.bookmark_outline,
          color: Color.fromARGB(255, 8, 64, 177),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 8.0),
          child: Text(
            '1024',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Icon(Icons.favorite_outline, color: Color.fromARGB(255, 8, 64, 177)),
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 8.0),
          child: Text(
            '938',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        RatingBar(),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('3.2',
                style: TextStyle(color: Color.fromARGB(255, 8, 64, 177))))
      ],
    );
  }
}

class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black.withAlpha(20)),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <double>[1, 1, 1, 0.2, 0]
              .map((e) => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.star,
                      size: 12.0,
                      color: e == 0
                          ? Colors.white
                          : Colors.blueAccent.withOpacity(e),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
