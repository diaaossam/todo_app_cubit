import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../shared/helper/assets_manger.dart';
import '../../../shared/helper/size_config.dart';
class NoTaskToday extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.bodyHeight * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManger.EmptyList),
            ),
          ),
        ),
        AppText(
          text: 'No Tasks Today .. !',
          isTitle: true,
          color: Colors.black38,
        )
      ],
    );
  }
}
