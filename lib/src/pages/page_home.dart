import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/global_helpers.dart';
import 'package:gestionriesgos/src/global/global_page_navigator.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/model/model_report.dart';
import 'package:gestionriesgos/src/logic/providers/provider_auth.dart';
import 'package:gestionriesgos/src/logic/providers/provider_report.dart';
import 'package:gestionriesgos/src/theme/theme.dart';
import 'package:gestionriesgos/src/widgets/widget_app_bar_pages.dart';
import 'package:gestionriesgos/src/widgets/widget_card.dart';
import 'package:gestionriesgos/src/widgets/widget_emply_list.dart';
import 'package:gestionriesgos/src/widgets/widget_load.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';
import 'package:provider/provider.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final rprtPrv = Provider.of<ReportProvider>(context);
    final authPrv = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: kScafoldColor,
      appBar: appBarPages(
        showArrow: false,
        title: 'Mis Reportes',
        widgetRight: IconButton(
          onPressed: () => authPrv.logOut(),
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
      floatingActionButton: btnAddReport(),
      body: rprtPrv.loadGetRep
          ? Center(child: loadwidget())
          : rprtPrv.listReport.isEmpty
              ? const Center(
                  child: EmplyPageText(
                    description: 'Un no has agregado reportes a la lista',
                  ),
                )
              : listReports(
                  rprtPrv.listReport,
                ),
    );
  }

  Widget listReports(List<ModelReport> list) {
    return ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHzApp,
        vertical: 15,
      ),
      itemBuilder: (context, index) {
        return cardReport(list[index]);
      },
    );
  }

  Widget cardReport(ModelReport report) {
    return CtCard(
      margin: const EdgeInsets.only(bottom: 15),
      showShadow: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: FileImage(
                  File(report.path!),
                ),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20),
          ),
          text(
            report.description!,
            padding: const EdgeInsets.only(
              top: 10,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CtCard(
              color: kprimaryColor.withAlpha(
                70,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 3,
              ),
              child: text(
                dateSt(report.date!),
                size: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget btnAddReport() {
    return FloatingActionButton(
      onPressed: () => toPage(
        name: '/detail_report',
      ),
      backgroundColor: kprimaryColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
