import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/screen/search_screen.dart';
import 'package:charcha/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String profilePic = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadData();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fetchedProfilePic = prefs.getString(prefs_string_profile_pic) ?? '';
    setState(() {
      profilePic = fetchedProfilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.transparent,
        title: Text('Charcha',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
            },
            splashColor: Colors.transparent,
          ),
          CircleAvatar(
            backgroundImage: (profilePic != "" && profilePic != null)
                ? NetworkImage(profilePic)
                : const AssetImage("assets/images/user_avatar.png")
                    as ImageProvider,
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 15,
          ),
          const SizedBox(
            width: 15,
          )
        ],
        bottom: TabBar(
            labelStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            controller: _tabController,
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Chats',
                  // style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Calls',
                  // style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ]),
      ),
      body: TabBarView(controller: _tabController, children: [
        Center(
          child: Text('Chat Screen'),
        ),
        Center(
          child: Text('Calls Screen'),
        )
      ]),
    );
  }
}
