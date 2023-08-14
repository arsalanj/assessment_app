import 'package:assessment_app/utilities/utilities.dart';
import 'package:flutter/material.dart';

/// Represents the screen that displays character details.
class CharacterDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;

  /// Constructs a new instance of [CharacterDetailScreen].
  ///
  /// The [imageUrl] and [title] are required to display character information.
  const CharacterDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Determine whether the device is in portrait mode or not.
    bool isPortrait = Utilities.isTablet(context)
        ? true
        : MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // Extract the first part of the title before the '-' and trim any whitespace.
          widget.title.split('-').first.trim(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Choose the appropriate layout based on device orientation.
            isPortrait
                ? _buildForPortrait(widget.imageUrl)
                : _buildForLandscape(widget.imageUrl),
          ],
        ),
      ),
    );
  }

  /// Builds a network image widget.
  Widget buildNetworkImage(String imageUrl) {
    return KeyedSubtree(
      key: ValueKey<String>(imageUrl), // Use imageUrl as the key
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        placeholderFit: BoxFit.fill,
        image: imageUrl,
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/Image_not_available.png');
        },
      ),
    );
  }

  /// Builds the UI for portrait orientation.
  Widget _buildForPortrait(String imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          child: buildNetworkImage(imageUrl),
        ),
        const SizedBox(height: 20),
        buildTitle(),
      ],
    );
  }

  /// Builds the title widget.
  Text buildTitle() {
    return Text(
      widget.title,
      style: const TextStyle(fontWeight: FontWeight.normal),
    );
  }

  /// Builds the UI for landscape orientation.
  Widget _buildForLandscape(String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          // flex: 1,
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            child: buildNetworkImage(imageUrl),
          ),
        ),
        const SizedBox(width: 20),
        // Spacer(),
        Expanded(
          // flex: ,
          child: buildTitle(),
        ),
      ],
    );
  }
}
