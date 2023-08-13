import 'package:charcha/models/user.dart';
import 'package:charcha/screen/chat_screen.dart';
import 'package:charcha/services/user_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> _searchResult = [];

  void _performSearch(String value) async {
    if (value == "" || value == null) {
      return;
    }

    Map<String, dynamic> searchResponse = await UserService.searchUser(value);
    List<User> userList = [];

    if (searchResponse["data"] != [] || searchResponse["data"] != null) {
      for (Map<String, dynamic> user in searchResponse["data"]) {
        User userData = User(
            userId: user["_id"],
            userProfileId: user["user"],
            userName: user["username"],
            fullName: user["fullName"]);
        if (user.containsKey("profilePic")) {
          userData.profilePic = user["profilePic"];
        }

        if (user.containsKey("profileStatus")) {
          userData.profileStatus = user["profileStatus"];
        }

        userList.add(userData);
      }
    }

    setState(() {
      _searchResult = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: safeAreaHeight),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface, // Set the background color
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
              child: TextFormField(
                onChanged: (value) => _performSearch(value),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface), // Set the text color
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Search...',
                    labelStyle: TextStyle(color: Colors.grey)),
                // validator: _validateEmail,
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      var user = _searchResult[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      userId: user.userId,
                                      chatProfilePic: user.profilePic,
                                      chatName: user.fullName)));
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              (user.profilePic != "" && user.profilePic != null)
                                  ? NetworkImage(user.profilePic)
                                  : const AssetImage(
                                          "assets/images/user_avatar.png")
                                      as ImageProvider,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          radius: 17,
                        ),
                        title: Text(
                          user.userName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w300),
                        ),
                        subtitle: Text(
                          user.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
