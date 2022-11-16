import 'package:flutter/material.dart';
import 'package:gestionriesgos/src/global/global_variables_app.dart';
import 'package:gestionriesgos/src/logic/providers/provider_report.dart';
import 'package:gestionriesgos/src/widgets/widget_app_bar_pages.dart';
import 'package:gestionriesgos/src/widgets/widget_button.dart';
import 'package:gestionriesgos/src/widgets/widget_foto_add.dart';
import 'package:gestionriesgos/src/widgets/widget_text.dart';
import 'package:provider/provider.dart';

class PageDetailReport extends StatelessWidget {
  // final ModelReport? report;
  const PageDetailReport({
    super.key,
    // this.report
  });

  @override
  Widget build(BuildContext context) {
    final rprtPrv = Provider.of<ReportProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return rprtPrv.clearDataPrv(withBack: true);
      },
      child: GestureDetector(
        onTap: () => dismisKeybr(context),
        child: Scaffold(
          appBar: appBarPages(
            showArrow: true,
            // title: report != null ? 'Detalle Reporte' : 'Nuevo Reporte',
            title: 'Nuevo Reporte',
            onTapBack: () => rprtPrv.clearDataPrv(withBack: true),
          ),
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 20,
                  left: paddingHzApp + 10,
                  right: paddingHzApp + 10,
                  bottom: 150,
                ),
                child: Column(
                  children: [
                    const WFotoButton(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      // controller: rprtPrv.descCtrl,
                      onChanged: (value) => rprtPrv.onChangedetail(value),
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.always,

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Debes ingresar una descripción';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: text(
                          'Descripcion del Reporte',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 70,
                  child: button(
                    'Guardar Reporte',
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    onTap: () {
                      dismisKeybr(context);
                      rprtPrv.onSaveReport();
                    },
                    disable: rprtPrv.validateData() == false,
                    load: rprtPrv.loadSave,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
