import 'package:flutter/material.dart';
import 'package:practice_insta/constants/common_size.dart';
import 'package:practice_insta/widgets/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<bool> followings = List.generate(30, (index) => false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : ListView.separated(
          itemCount: followings.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                setState(() {
                  followings[index] = !followings[index];
                });
              },
              leading: RoundedAvatar(size: 50,),
              title: Text('userName $index'),
              subtitle: Text('user bio number $index'),
              trailing: Container(
                  height: 30,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: followings[index] ? Colors.red[50] : Colors.blue[50],
                    border : Border.all(color: Colors.red, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child : Text(
                    'Following',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  )
              ),
            );
          },
          separatorBuilder: (context, index){
            return Divider(
              color: Colors.grey,
            );
          },
      )
    );
  }
}
