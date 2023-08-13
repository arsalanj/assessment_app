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
  model.RelatedTopic? character;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    // Initialize connectivity status and subscription
    _initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    // Cancel the connectivity subscription and dispose of the scroll controller
    _connectivitySubscription.cancel();

    _scrollController.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (mounted) {
        _updateConnectionStatus(result);
      }
    } on PlatformException catch (e) {
      logger.d('Couldn\'t check connectivity status', error: e);
    }
  }

  // Update the connection status when it changes
  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _connectionStatus == ConnectivityResult.none
          ? _buildNoInternetWidget()
          : BlocProvider(
              create: (context) => CharacterBloc(
                  RepositoryProvider.of<CharacterRepository>(context))
                ..add(LoadCharacterEvent()),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    FlavorConfig.instance?.name ?? "Simpsons Character Viewer",
                  ),
                ),
                body: BlocBuilder<CharacterBloc, CharacterState>(
                  builder: _buildBlocBuilder,
                ),
              ),
            ),
    );
  }

// Build widget based on the CharacterState
  Widget _buildBlocBuilder(BuildContext context, CharacterState state) {
    if (state is CharacterLoadingState) {
      return _buildLoadingWidget();
    } else if (state is CharacterLoadedState) {
      return _buildCharacterList(state, context);
    } else if (state is CharacterErrorState) {
      return Center(
        child: Text(state.error.toString()),
      );
    } else {
      return Container(); // Return an empty container by default
    }
  }

  // Build widget for no internet connectivity
  Widget _buildNoInternetWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Not connected to the internet. Please establish connectivity.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Build loading widget during character loading state
  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Build widget for displaying characters list
  Widget _buildCharacterList(CharacterLoadedState state, BuildContext context) {
    final filteredCharacters = state.character.relatedTopics
        .where((character) =>
            character.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    character ??= filteredCharacters.first;

    return Utilities.isTablet(context)
        ? Row(
            children: [
              Expanded(
                child: _makeCustomScrollView(filteredCharacters),
              ),
              Expanded(
                flex: 2,
                child: CharacterDetailScreen(
                  imageUrl:
                      '${FlavorConfig.instance?.values?.baseURL}${character?.icon.url}',
                  title: character?.text ?? "",
                ),
              )
            ],
          )
        : _makeCustomScrollView(filteredCharacters);
  }

  // Build custom scroll view for characters list
  Widget _makeCustomScrollView(List<model.RelatedTopic> filteredCharacters) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: _isSearching ? 60 : 0,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1,
            title: _isSearching ? _buildSearchBar() : null,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _buildCharacterListItem(filteredCharacters),
            childCount: filteredCharacters.length,
          ),
        ),
      ],
    );
  }

  // Build search bar widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextField(
        onChanged: _onSearchTextChanged,
        decoration: const InputDecoration(
          hintText: 'Search in the list...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  // Callback for search text change
  void _onSearchTextChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  // Build callback for creating character list items
  Widget Function(BuildContext, int) _buildCharacterListItem(
      List<model.RelatedTopic> filteredCharacters) {
    return (context, index) {
      return GestureDetector(
        onTap: () {
          if (Utilities.isTablet(context)) {
            setState(() {
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
              Text(filteredCharacters[index].text.split('-').first.trim()),
              const Divider(),
            ],
          ),
        ),
      );
    };
  }

  // Handle character tapped event
  void _onCharacterTapped(BuildContext context, model.RelatedTopic character) {
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
