import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Model3DImage extends StatefulWidget {
  final String url;
  const Model3DImage({super.key, required this.url});

  @override
  State<Model3DImage> createState() => _Model3DImageState();
}

class _Model3DImageState extends State<Model3DImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ModelViewer(
      src: widget.url,
      autoRotate: true,
      autoPlay: true,
      loading: Loading.lazy,
      autoRotateDelay: 1,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
