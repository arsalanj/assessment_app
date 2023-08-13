import 'dart:async';

import 'package:assessment_app/bloc/character_bloc/character_bloc.dart';
import 'package:assessment_app/data/model/character_model.dart' as model;
import 'package:assessment_app/data/repositories/character_repository.dart';
import 'package:assessment_app/flavors/flavor_config.dart';
import 'package:assessment_app/main_common.dart';
import 'package:assessment_app/presentation/detail_screen.dart';
import 'package:assessment_app/utilities/utilities.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  String searchQuery = '';
  final ScrollController _scrollController = ScrollController();
  final bool _isSearching = true;
  // int _index = 0;

  model.RelatedTopic? character;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    _scrollController.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      logger.d('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _connectionStatus == ConnectivityResult.none
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Not connected to internet, please establish connectivity.',
                  // style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : BlocProvider(
              create: (context) => CharacterBloc(
                RepositoryProvider.of<CharacterRepository>(context),
              )..add(LoadCharacterEvent()),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(FlavorConfig.instance?.name ??
                      "Simpsons Character Viewer"),
                ),
                body: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: (context, state) {
                    if (state is CharacterLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CharacterLoadedState) {
                      return loadList(state, context);
                    }
                    if (state is CharacterErrorState) {
                      return Center(
                        child: Text(state.error.toString()),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
    );
  }

  Widget loadList(CharacterLoadedState state, BuildContext context) {
    List<model.RelatedTopic> filteredCharacters = state.character.relatedTopics
        .where((character) =>
            character.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    character ??= filteredCharacters.first;

    return Utilities.isTablet(context)
        ? Row(
            children: [
              Expanded(
                // flex: 1,
                child: makeCustomScrollView(filteredCharacters),
              ),
              Expanded(
                flex: 2,
                child: CharacterDetailScreen(
                  // key: ,
                  imageUrl:
                      '${FlavorConfig.instance?.values?.baseURL}${character?.icon.url}',
                  title: character?.text ?? "",
                ),
              )
            ],
          )
        : makeCustomScrollView(filteredCharacters);
  }

  Widget makeCustomScrollView(List<model.RelatedTopic> filteredCharacters) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: _isSearching ? 60 : 0,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            title: _isSearching
                ? Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search in the list...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  )
                : null,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  if (Utilities.isTablet(context)) {
                    setState(() {
                      // _index = index;
                      character = filteredCharacters[index];
                    });
                  } else {
                    _onCharacterTapped(context, filteredCharacters[index]);
                  }
                },
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filteredCharacters[index]
                          .text
                          .split('-')
                          .first
                          .trim()),
                      const Divider(),
                    ],
                  ),
                ),
              );
            },
            childCount: filteredCharacters.length,
          ),
        ),
      ],
    );
  }

  void _onCharacterTapped(BuildContext context, model.RelatedTopic character) {
    // Handle tap action here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(
          imageUrl:
              '${FlavorConfig.instance?.values?.baseURL}${character.icon.url}',
          title: character.text,
        ),
      ),
    );
  }
}
