import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart'
    as cached_network_image;
import 'package:flutter/material.dart';
import 'package:gonna_client/services/storage/storage.dart';
import 'package:gonna_client/services/user/user.dart' as user_service;

class UserListItem extends StatelessWidget {
  final user_service.User user;

  UserListItem(this.user);

  static String _abbreviation(user_service.User user) {
    var abbreviation = "";
    if (user.firstName != null && user.firstName!.length > 0) {
      abbreviation += user.firstName![0].toUpperCase();
    }
    if (user.lastName != null && user.lastName!.length > 0) {
      abbreviation += user.lastName![0].toUpperCase();
    }
    return abbreviation;
  }

  static Widget _avatar(user_service.User user) {
    if (user.profileId == null) {
      return CircleAvatar(
        child: Text(
          _abbreviation(user),
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return FutureBuilder(
        future: StorageService.instance.getProfilePictureThumbnailUrl(user.profileId!),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return CircleAvatar(
              backgroundImage: cached_network_image.CachedNetworkImageProvider(
                  snapshot.data!),
            );
          } else if (snapshot.hasError) {
            print('Error getting profile picture thumbnail url: ${snapshot.error}');
            return CircleAvatar(
              child: Text(
                _abbreviation(user),
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return CircleAvatar(
              child: Text(
                _abbreviation(user),
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        });
  }

  static Widget? _maybeInviteButton(user_service.User user) {
    if (user.profileId != null) {
      return null;
    }
    return TextButton(
      onPressed: () {
        // TODO: implement invite.
      },
      child: const Text('Invite'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _avatar(user),
      title: Text((user.firstName ?? "") + " " + (user.lastName ?? "")),
      subtitle: Text(user.phoneNumber),
      trailing: _maybeInviteButton(user),
    );
  }
}

class UsersList extends StatelessWidget {
  final Iterable<user_service.User> users;

  UsersList(this.users);

  @override
  Widget build(BuildContext context) {
    List<user_service.User> usingTheApplist = [];
    for (var user in users.where((user) => user.profileId != null)) {
      usingTheApplist.add(user);
    }
    List<user_service.User> notUsingTheApplist = [];
    for (var user in users.where((user) => user.profileId == null)) {
      notUsingTheApplist.add(user);
    }

    List<Widget> list = [];
    if (usingTheApplist.isNotEmpty) {
      list.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('USING THE APP (${usingTheApplist.length} CONTACTS)',
              style: TextStyle(color: Colors.grey))));
      list.add(Divider(thickness: 1));
    }
    for (var user in usingTheApplist) {
      list.add(UserListItem(user));
      list.add(Divider(
        thickness: 1,
      ));
    }
    if (notUsingTheApplist.isNotEmpty) {
      list.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'NOT USING THE APP (${notUsingTheApplist.length} CONTACTS)',
              style: TextStyle(color: Colors.grey))));
      list.add(Divider(thickness: 1));
    }
    for (var user in notUsingTheApplist) {
      list.add(UserListItem(user));
      list.add(Divider(
        thickness: 1,
      ));
    }
    return ListView(
      children: list,
    );
  }
}

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: StreamBuilder<Iterable<user_service.User>>(
          stream: user_service.UserService.instance
              .queryPhoneContactsUsersByName(query),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<user_service.User>> snapshot) {
            List<Widget> noDataWidgets = [];
            if (snapshot.hasData) {
              return Container(
                  child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(child: UsersList(snapshot.data!))
              ]));
            } else if (snapshot.hasError) {
              noDataWidgets.add(Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}.}'),
              ));
            } else {
              noDataWidgets.addAll([
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ]);
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: noDataWidgets,
              ),
            );
          },
        ));
  }
}
