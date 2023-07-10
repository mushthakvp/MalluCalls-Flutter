import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../screen/call/view/call_view.dart';
import '../../../screen/home/model/video_model.dart';
import '../../../util/colors.dart';
import '../../../util/responsive.dart';
import '../provider/video_view_provider.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoViewProvider? _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<VideoViewProvider>();
    _getVideo();
  }

  Future<void> _getVideo() async {
    await _provider!.getVideo();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff671af0),
          elevation: 0,
          title: const Text(
            'Mallu Videos',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Apc.whiteColor.withOpacity(0.8),
            labelStyle: TextStyle(
              fontFamily: 'Galano',
              fontSize: Responsive.text! * 1.8,
              color: Apc.whiteColor,
            ),
            labelColor: Apc.whiteColor,
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.symmetric(
                horizontal: Responsive.width! * 16,
              ),
              borderRadius: BorderRadius.circular(
                Responsive.radius! * 10,
              ),
              borderSide: BorderSide(
                width: 3,
                color: Apc.whiteColor.withOpacity(0.5),
              ),
            ),
            tabs: const [
              Tab(
                text: "Normal",
              ),
              Tab(
                text: "Professional",
              ),
            ],
          ),
        ),
        body: Selector<VideoViewProvider, bool>(
            selector: (context, provider) => provider.isLoading,
            builder: (context, loading, _) {
              return loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff671af0),
                      ),
                    )
                  : TabBarView(
                      children: [
                        NormalViewWidget(
                          data: _provider!.video,
                          obj: _provider,
                        ),
                        NormalViewWidget(
                          data: _provider!.professional,
                          obj: _provider,
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}

class NormalViewWidget extends StatelessWidget {
  const NormalViewWidget({
    super.key,
    required this.data,
    this.obj,
  });
  final List<Professional> data;
  final VideoViewProvider? obj;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Center(
            child: Text(
              'No Personal Videos Available',
              style: TextStyle(
                fontFamily: "Galano",
                color: Apc.greyColor,
                fontSize: Responsive.text! * 2,
              ),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height! * 2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final data = this.data[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallView(data: data),
                    ),
                  );
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.width! * 4,
                ),
                leading: CircleAvatar(
                  radius: Responsive.radius! * 10,
                  backgroundImage: CachedNetworkImageProvider(
                    data.videoProfile!,
                  ),
                ),
                title: Text(
                  data.videoUser!,
                  style: TextStyle(
                    fontFamily: "Galano",
                    color: Apc.blackColor,
                    fontSize: Responsive.text! * 2,
                  ),
                ),
                subtitle: Text(
                  data.videoPlace!,
                  style: TextStyle(
                    fontFamily: "Galano",
                    color: Apc.greyColor,
                    fontSize: Responsive.text! * 1.8,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Delete Video"),
                          content: const Text(
                              "Are you sure you want to delete this video?"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                obj?.deleteVideo(id: data.id ?? '');
                                Navigator.pop(context);
                              },
                              child: const Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xff671af0),
                  ),
                ),
              );
            },
          );
  }
}
