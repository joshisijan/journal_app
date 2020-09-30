import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journal_app/providers/today_provider.dart';
import 'package:journal_app/reuseables/custom_bar.dart';
import 'package:journal_app/reuseables/icon_text_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddImage extends StatelessWidget {
  var image;
  PickedFile pickedImage;
  @override
  Widget build(BuildContext context) {
    image = context.select((TodayProvider todayProvider) => todayProvider.getImagePath);
    TodayProvider todayProvider = Provider.of<TodayProvider>(context, listen: false);
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              height: 300.0,
              width: double.maxFinite,
              child: Column(
                children: [
                  CustomBar(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Upload Image',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Choose a Image to upload',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  IconTextButton(
                    title: 'Choose from Library',
                    icon: Icons.photo_library,
                    onPress: () async {
                      try{
                        pickedImage = await ImagePicker().getImage(source: ImageSource.gallery).then((value) => value);
                      }catch(e){
                        print('error from choose from library\n' + e.toString());
                      }
                      if(pickedImage != null){
                        todayProvider.setImage(pickedImage.path);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  IconTextButton(
                    title: 'Take a Photo',
                    icon: Icons.photo_camera,
                    onPress: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
        );
      },
      child: Container(
        width: 100.0,
        height: 160.0,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(5.0),
            image: image == null ? null : DecorationImage(
              image: FileImage(File(image)),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).textTheme.caption.color.withAlpha(150),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0, 0.5),
              ),
            ]),
        child: Center(
          child: image == null ?  Icon(Icons.add_circle_outline, size: 40.0, color: Theme.of(context).primaryColor,) : null,
        ),
      ),
    );
  }
}
