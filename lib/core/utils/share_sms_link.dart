import 'package:url_launcher/url_launcher.dart';
import 'package:whatsy/core/model/user_model.dart';

void shareSmsLink({
  required List<List<UserModel>> phoneContact,
  required int index,
}) {
  launchUrl(
    Uri.parse(
      "sms:${phoneContact[1][index].phone}?body=Let's chat on Whatsy! it's a fast, simple, "
      "and secure app we can call each other for free. Get it at https://whatsapp.com/dl/",
    ),
  );
}
