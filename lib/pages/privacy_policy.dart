import '/shared/exports.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var uploadImage = Provider.of<UploadImage>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Container(
            color: Theme.of(context).canvasColor,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 60),
            child: heading(
              "Privacy Policy",
              50,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 150),
            child: productTileText(
                "Last Updated: ${dateTimetoText(DateTime.now())},\n\nThis Privacy Policy outlines how Wealth Pro we collects, uses, discloses, and protects personal information when you use our web-based Customer Relationship Management (CRM) portal. We are committed to safeguarding your privacy and ensuring the security of your personal data. By accessing and using the Portal, you consent to the practices described in this Privacy Policy. We may collect personal information that you provide directly when you use the Portal, such as your name and other information required for account registration and usage. Additionally, we automatically collect usage information about your interactions with the Portal, including your IP address, device information, browser type, and usage patterns. This information helps us improve the Portal's functionality and user experience. We use your personal information to provide and improve the CRM services offered through the Portal, including customer management, communication, and support. We may also use your email address to send you updates, notifications, newsletters, and other relevant information about the Portal, but you can opt-out of receiving marketing communications at any time. Furthermore, usage information is utilized for analytics, troubleshooting, security, and to enhance the functionality and performance of the Portal. We implement reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. However, please understand that no data transmission over the internet is completely secure, and we cannot guarantee the security of your information.You have the right to access, correct, update, or delete your personal information. You can do so by logging into your account or contacting us at ${AppConsts.careEmail1}. We will make reasonable efforts to respond to your requests promptly.We use cookies and similar tracking technologies to collect usage information and improve your experience on the Portal. You can manage cookie preferences through your browser settings.The Portal is not intended for children under the age of 13, and we do not knowingly collect or maintain personal information from children under 13. If you believe we have inadvertently collected such information, please contact us to have it removed.We may update this Privacy Policy periodically to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any material changes by posting a revised Privacy Policy on the Portal. Your continued use of the Portal constitutes acceptance of the updated Privacy Policy.If you have any questions, concerns, or requests regarding this Privacy Policy or the handling of your personal information, please contact us at ${AppConsts.careEmail1}.By using the Portal, you acknowledge that you have read and understood this Privacy Policy and consent to the collection, use, and disclosure of your personal information as described herein.,",
                20,
                overF: TextOverflow.clip),
          ),
        ]),
      ),
    );
  }
}
