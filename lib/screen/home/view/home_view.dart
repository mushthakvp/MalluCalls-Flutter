import 'package:flutter/material.dart';
import 'package:mallu_calls/admin/view/view/video_view.dart';
import 'package:mallu_calls/util/server.dart';
import 'package:mallu_calls/util/shimmer_widget.dart';
import 'package:mallu_calls/util/url.dart';
import '../../../admin/add/view/add_view.dart';
import '../../../util/colors.dart';
import '../../../util/responsive.dart';
import '../model/video_model.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/normal_widget.dart';
import 'widgets/professional_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<VideoModel> fetchPosts() async {
    try {
      List response = await Server.get(Urls.getVideo);
      if (response.first >= 200 && response.first < 300) {
        VideoModel videoModel = VideoModel.fromJson(response.last);
        return videoModel;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  Stream<VideoModel> getProducts() async* {
    while (true) {
      try {
        final VideoModel posts = await fetchPosts();
        yield posts;
      } catch (e) {
        yield VideoModel();
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Apc.whiteColor,
        body: StreamBuilder<VideoModel>(
          stream: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data?.userReward ??= 0;
              snapshot.data?.video ??= [];
              snapshot.data?.professional ??= [];
              snapshot.data?.userImage ?? '';
              snapshot.data?.userName ?? 'Mallu Calls';
              return NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: const Color(0xff671af0),
                      title: const Text(
                        'Mallu Calls ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Galano',
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddView(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.add_call,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VideoView(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.play_circle_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: Responsive.width! * 3),
                      ],
                      expandedHeight: Responsive.height! * 26,
                      pinned: true,
                      flexibleSpace: AppBarWidget(data: snapshot.data!),
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
                          Tab(text: 'Normal'),
                          Tab(text: 'Professional'),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    NormalWidget(
                      data: snapshot.data?.video,
                      coin: snapshot.data?.userReward,
                    ),
                    ProfessionalWidget(
                      data: snapshot.data?.professional,
                      coin: snapshot.data?.userReward,
                    ),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xff671af0),
                  elevation: 0.2,
                  title: const Text(
                    'Mallu Calls ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Galano',
                    ),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ShimmerWidget(
                        baseColor: Apc.shimmer,
                        highlightColor: Apc.whiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
