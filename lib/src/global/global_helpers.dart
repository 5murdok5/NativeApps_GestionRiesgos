// parse date to string
import 'package:gestionriesgos/src/global/actions/actions_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String dateSt(int miliseconds) {
  final DateTime dt = DateTime.fromMillisecondsSinceEpoch(miliseconds);
  final date = DateFormat('dd/MM/yyyy hh:mm:ss a').format(dt);
  return date;
}

Future<XFile?> takePicture({bool fromCamera = true}) async {
  try {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
  } catch (e) {
    showToast('Upps!!, No fue posible obtener la fotografía');
    return null;
  }
}
