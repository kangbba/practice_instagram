import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practiceinsta/screens/profile_screen.dart';
import 'package:practiceinsta/widgets/rounded_avatar.dart';

import '../constants/common_size.dart';
import '../constants/screen_size.dart';

enum SelectedTab
{
  left,
  right
}

class ProfileBody extends StatefulWidget {

  final Function onMenuChanged;

  const ProfileBody({super.key, required this.onMenuChanged});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> with SingleTickerProviderStateMixin{
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    _iconAnimationController = AnimationController(vsync: this, duration: duration);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _iconAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(delegate: SliverChildListDelegate(
                    [
                      Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(common_gap),
                              child: RoundedAvatar(size: 80),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: common_gap),
                                child: Table(
                                  children: [
                                    TableRow(
                                        children: [
                                          _valueText('123123'),
                                          _valueText('123123'),
                                          _valueText('123123')
                                        ]
                                    ),
                                    TableRow(
                                        children: [
                                          _valueText('Post'),
                                          _valueText('Followers'),
                                          _valueText('Following')
                                        ]
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]
                      ),
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _tabButtons(),
                      _selectedIndicator(),
                    ]
                )
                ),
                _imagesPager()
              ],
            ),
          ),
        ],
      ),
    );
  }
  Row _appbar() {
    return Row(
      children: [
        SizedBox(width: 44,
        ),
        Expanded(child: Text('Jinhyung', textAlign: TextAlign.center,)),
        IconButton(
          icon: AnimatedIcon(icon : AnimatedIcons.menu_close, progress: _iconAnimationController,),
          onPressed: (){
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed ? _iconAnimationController.reverse(): _iconAnimationController.forward();
          }
        )
      ],
    );
  }
  Text _valueText(String value) => Text(
    value, textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold),
  );

  Text _labelText(String value) => Text(
    value, textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.w300,
        fontSize: 11),
  );

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: duration,
                  transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
                  curve: Curves.fastOutSlowIn,
                  child: images(),
                ),
                AnimatedContainer(
                  duration: duration,
                  transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
                  curve: Curves.fastOutSlowIn,
                  child: images(),
                )
              ],
            )
        );
  }

  _tabSelected(SelectedTab selectedTab){
    debugPrint(selectedTab.toString());
    setState(() {
      switch(selectedTab){
        case SelectedTab.left:
            _selectedTab = SelectedTab.left;
            _leftImagesPageMargin = 0;
            _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.right:
            _selectedTab = SelectedTab.right;
            _leftImagesPageMargin = -size.width;
            _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  GridView images() {
    return GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, crossAxisCount: 3, childAspectRatio: 1,
                  children: List.generate(30, (index) => CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "https://picsum.photos/id/$index/300/300")
                  ),
                );
  }

  Widget _selectedIndicator()
  {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
      alignment: (_selectedTab == SelectedTab.left) ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
          height: 3,
          width: size.width/2,
          color : Colors.black87,
      )
    );
  }

  Row _tabButtons() {
    return Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: ImageIcon(AssetImage('assets/images/grid.png'),
                        color: (_selectedTab == SelectedTab.left) ? Colors.black : Colors.black26,),

                      onPressed: (){
                        _tabSelected(SelectedTab.left);
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: ImageIcon(AssetImage('assets/images/saved.png'),
                        color: (_selectedTab == SelectedTab.left) ? Colors.black26 : Colors.black,),

                      onPressed: (){
                        setState((){
                          _tabSelected(SelectedTab.right);
                        });
                      },
                    ),
                  ),
                ],
              );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap, vertical: common_gap * 1),
      child: SizedBox(
        height: 24,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: BorderSide(
                width: 1,
                color: Colors.black45
            ),
          ),
          onPressed: () { },
          child: Text('Edit Profile', style : TextStyle(fontWeight: FontWeight.bold, color: Colors.black), ),
        ),
      ),
    );
  }

  Widget _username()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('username', style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }

  Widget _userBio()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text('this is what i believe',
        style: TextStyle(fontWeight: FontWeight.w400),),
    );
  }
}
