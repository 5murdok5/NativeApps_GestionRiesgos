import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/providers/provider_report.dart';
import 'package:gestionriesgos/src/theme/theme.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';
import 'package:provider/provider.dart';

class WFotoButton extends StatelessWidget {
  const WFotoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final rprtPrv = Provider.of<ReportProvider>(context);

    return InkWell(
      onTap: () async {
        dismisKeybr(context);
        await rprtPrv.getPhoto();
      },
      // onTap: () => toPage(
      //   page: PageCamera(
      //     camera: splPrv.cameras,
      //     getImg: (path) {
      //       setState(() {
      //         if (path != null) {
      //           imgPath = path;
      //         }
      //       });
      //     },
      //   ),
      // ),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: rprtPrv.imgFile.path != ''
                    ? Colors.white
                    : kSecondaryColor.withAlpha(
                        230,
                      ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(5, 5),
                  )
                ]),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInCubic,
              child: rprtPrv.imgFile.path != ''
                  ? contBtnImg(rprtPrv.imgFile.path)
                  : contButtonNoImg(),
            ),
          ),
        ],
      ),
    );
  }

  Widget contBtnImg(String img) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: FileImage(
            File(img),
          ),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            verticalDirection: VerticalDirection.up,
            children: [
              // const CircleAvatar(
              //   backgroundColor: Colors.white,
              //   child: Icon(
              //     Icons.delete,
              //     size: 22,
              //     color: Colors.redAccent,
              //   ),
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit,
                  size: 22,
                  color: Colors.blue[900],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget contButtonNoImg() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text(
            'Agregar Fotografia',
            color: Colors.white,
            type: 'subtitle2',
            size: 16,
          ),
          const Icon(
            Icons.add_a_photo_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
