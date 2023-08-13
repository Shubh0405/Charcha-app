import 'package:charcha/models/message.dart';
import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/res/socket_constants.dart';
import 'package:charcha/screen/search_screen.dart';
import 'package:charcha/services/user_service.dart';
import 'package:charcha/sockets/socket.dart';
import 'package:charcha/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubits/user_chat_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final socket = SocketSingleton().socket;
  String profilePic = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadChats();
    _connectSocket();
    _listenChatSockets();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Unsubscribe from socket events when disposing
    socket.off(socket_event_new_message);
    super.dispose();
  }

  Future<void> _connectSocket() async {
    final prefs = await SharedPreferences.getInstance();
    String? userProfileId = prefs.getString(prefs_string_user_profile_id);

    socket.emit(socket_event_setup, userProfileId);
  }

  Future<void> _listenChatSockets() async {
    socket.on(socket_event_new_message, (message) async {
      print("New message received!");
      await _loadChats();
    });
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fetchedProfilePic = prefs.getString(prefs_string_profile_pic) ?? '';
    setState(() {
      profilePic = fetchedProfilePic;
    });
  }

  Future<void> _loadChats() async {
    await BlocProvider.of<UserChatCubit>(context).loadUserChats();
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
                          builder: (context) => const SearchScreen()))
                  .then((value) => _loadChats());
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
        ChatList(
          loadChats: _loadChats,
        ),
        Center(
          child: Text('Calls Screen'),
        )
      ]),
    );
  }
}
