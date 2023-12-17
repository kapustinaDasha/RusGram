import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_envoriment_1/domain/models/user_preview.dart';

import 'package:test_envoriment_1/features/home/bloc/posts_cubit.dart';
import 'package:test_envoriment_1/features/home/widgets/post_preview_card.dart';
import 'package:test_envoriment_1/features/profile/widgets/exit_button.dart';
import 'package:test_envoriment_1/data/remote_data_sources/profile/profile_data_source.dart';

class MyProfilePage extends StatefulWidget {
  //final String uid;
  MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late final ScrollController scrollController;
  late final PostsCubit postsCubit;
  late final ProfileDataSource profileDataSource;

  String about = "...";
  String profile = "...";
  String chel_name = "...";
  late UserPreview user;
  String userPicture = "https://bigfoto.name/uploads/posts/2022-03/1647521419_1-bigfoto-name-p-loading-1.png";
  TextEditingController chel_vvod = TextEditingController();
  TextEditingController profil_vvod = TextEditingController();
  TextEditingController about_vvod = TextEditingController();

  List<String> mediaItems = [
    "https://i.pinimg.com/originals/11/87/78/118778eab134f8e678bae1b0cb1fd63a.jpg",
    "https://i.pinimg.com/originals/40/50/a8/4050a83d0c6ddcb7a01774228f253e7a.jpg",
    "https://ekzo-animal.ru/wp-content/uploads/2023/05/e3c83cac875ffe9180d7b296af38478a.jpg",
    "https://static10.tgstat.ru/channels/_0/e7/e7ff3535a734899daf9234a41e60b272.jpg",
    "https://teacuppiggies.com/wp-content/uploads/2013/12/simon-for-halloween.jpg",
    "https://celes.club/uploads/posts/2021-12/thumbs/1638322895_70-celes-club-p-porosyata-mini-pigi-zhivotnie-krasivo-foto-74.jpg",
    "https://i.artfile.ru/1920x1747_815301_[www.ArtFile.ru].jpg",
    "https://i.pinimg.com/originals/8b/47/f0/8b47f0af6e010eabe63cb58d802f498b.jpg",
    "https://animalgid.ru/wp-content/uploads/2018/11/gettingenskiy-mini-pig.jpg",
    "https://i.pinimg.com/originals/21/20/62/212062558964c7f6756b29eb6ddd9c97.jpg",
    "https://i.pinimg.com/originals/09/38/18/09381808e457791d87a7888ad290ba88.jpg",
    "https://bigpicture.ru/wp-content/uploads/2013/07/MiniaturePigs08.jpg",
    "https://gagaru.club/uploads/posts/2023-02/1676255641_gagaru-club-p-porosenok-milii-instagram-6.jpg",
    "https://babai.ru/photos/articles/250719/3.jpg",
    "https://sun6-23.userapi.com/s/v1/ig2/fy5u7mqFsEXfHrTnxoHHWZoEm_-cXx7ySx9kf97HZYBjjTzu2ilf1pvosaerX1VLuBeS2WJoBwO5BawyJdo2GkiE.jpg?size=400x0&quality=96&crop=0,0,1080,1081&ava=1"
  ];

//Подгрузка страницы
  @override
  void initState() {
    scrollController = ScrollController()..addListener(listenScroll);
    postsCubit = PostsCubit(context.read())..initWithTag(tag: "person");
    profileDataSource = context.read<ProfileDataSource>();
    init();
    super.initState();
  }

  Future<void> init() async {
    final usersInfo = await profileDataSource.getProfiles();
    user = usersInfo.data[10];
    chel_name = user.firstName;
    about = user.title + ' ' + user.lastName;
    profile = user.lastName + ' ' + user.firstName;
    userPicture = user.picture;
    setState(() {});
  }

  Future<void> update({required String name, required String lastName}) async {
    final updatedUser = await profileDataSource.updateProfile(profileId: user.id, name: name, lastName: lastName);
    chel_name = updatedUser.firstName;
    about = updatedUser.title + ' ' + updatedUser.lastName;
    profile = updatedUser.lastName + ' ' + updatedUser.firstName;
    setState(() {});
  }


//Закрытие окна
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(this.profile),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      // backgroundColor: Colors.red,
                      backgroundImage: NetworkImage(
              userPicture
                          // 'https://sezon-dacha.ru/wp-content/uploads/7/8/2/78256eba0e9993d3a77700b9df309dc8.jpeg'
              ),
                      radius: 45,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(100, "Публикации"),
                              buildStatColumn(1, "Подписки"),
                              buildStatColumn(10000, "Подписчики")
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ExitButton(
                                text: 'Редактировать профиль',
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                borderColor: Colors.grey,
                                function: () {
                                  _showSimpleModalDialog(context);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Text(
                    this.chel_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    top: 1,
                  ),
                  child: Text(
                    this.about,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          BlocBuilder<PostsCubit, PostsState>(
              bloc: postsCubit,
              builder: (context, state) {
                return switch (state) {
                  PostsLoadedState() => GridView.builder(
                      shrinkWrap: true,
                      itemCount: state.postsInfo.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(
                          state.postsInfo.data[index].image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }),
                  _ => const Center(child: CircularProgressIndicator()),
                };
              }),
        ],
      ),
    );
  }

  //Функция, которая создает столбцы (подписчики, подписки и посты)
  Column buildStatColumn(int num, String label) {
    return Column(
      //Минимальная высота столбца
      mainAxisSize: MainAxisSize.min,
      //Выравнивание по центру
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> listenScroll() async {
    final isPageEnd = scrollController.offset + 150 >
        scrollController.position.maxScrollExtent;

    if (isPageEnd) {
      await postsCubit.nextPage();
    }
  }


  _showSimpleModalDialog(context) {
    // this.setState(() {});
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 8),
                      child: Text(
                        'Введите имя',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      // initialValue: this.chel_name,
                      controller: chel_vvod,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3, top: 8),
                      child: Text(
                        'Введите фамилию',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      // initialValue: this.profile,
                      controller: profil_vvod,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Center(
                      child: ExitButton(
                        text: 'Сохранить',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.grey,
                        function: () {
                          update(name: chel_vvod.text, lastName: profil_vvod.text);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    // RichText(
                    //   textAlign: TextAlign.justify,
                    //   text: TextSpan(
                    //       text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w400,
                    //           fontSize: 14,
                    //           color: Colors.black,
                    //           wordSpacing: 1
                    //       )
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
