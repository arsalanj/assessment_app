import 'package:assessment_app/utilities/utilities.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String title;

  CharacterDetailScreen({
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
    bool isPortrait = Utilities.isTablet(context)
        ? true
        : MediaQuery.of(context).orientation == Orientation.portrait;
    //  &&
    //     !Utilities.isTablet(context);

    // print(imageUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
            isPortrait
                ? _buildForPortrait(widget.imageUrl)
                : _buildForLandscape(widget.imageUrl),
          ],
        ),
      ),
    );
  }

  Widget buildNetworkImage(String imageUrl) {
    return KeyedSubtree(
      key: ValueKey<String>(imageUrl), // Use imageUrl as the key
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: imageUrl,
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/Image_not_available.png');
        },
      ),
    );
  }

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

  Text buildTitle() {
    return Text(
      widget.title,
      style: const TextStyle(fontWeight: FontWeight.normal),
    );
  }

  Widget _buildForLandscape(String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          // flex: 1,
          child: buildNetworkImage(imageUrl),
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
