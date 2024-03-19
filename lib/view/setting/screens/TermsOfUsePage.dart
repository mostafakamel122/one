import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Use'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Effective Date: [Insert Date]',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to ONE ("we," "us," or "our"). By accessing or using our website, mobile applications, or products, you agree to comply with and be bound by the following Terms of Use. If you do not agree to these terms, please do not use our services.',
              ),
              SizedBox(height: 20.0),
              Text(
                '2. Changes to Terms',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We reserve the right to modify these Terms of Use at any time without prior notice to users. Your continued use of our services after any changes constitute your acceptance of the revised terms.',
              ),
              SizedBox(height: 20.0),
              Text(
                '3. Ownership and Use of Designs',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '3.1 Submitted Designs: Users may submit unique designs to ONE for consideration. When a design is submitted and approved by ONE, the design becomes the sole property of ONE. The original designer relinquishes all rights to the design, including but not limited to the right to use, reproduce, or distribute the design elsewhere.',
              ),
              Text(
                '3.2 Use of Approved Designs: ONE has full authority to decide how and when to use the approved designs on its products. This may include, but is not limited to, incorporating the design into clothing and other merchandise without further consent from the original designer.',
              ),
              SizedBox(height: 20.0),
              Text(
                '4. Intellectual Property',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'All content and materials on our services, including but not limited to text, images, logos, and trademarks, are the property of ONE and are protected by intellectual property laws. Users may not reproduce, distribute, or use our content without our prior written consent.',
              ),
              SizedBox(height: 20.0),
              Text(
                '5. Offers and Pricing',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '5.1 Subject to Change: Our offers, promotions, and pricing are subject to change at any time without previous notice to the user. We strive to provide accurate and up-to-date information, but errors may occur.',
              ),
              Text(
                '5.2 Availability: Products and offers are subject to availability. We reserve the right to limit the quantity of products available for purchase.',
              ),
              SizedBox(height: 20.0),
              Text(
                '6. Termination of Access',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'ONE may, at its sole discretion, terminate or suspend a user\'s access to our services at any time for violations of these Terms of Use or for any other reason.',
              ),
              SizedBox(height: 20.0),
              Text(
                '7. Limitation of Liability',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'ONE is not liable for any direct, indirect, incidental, consequential, or punitive damages arising from your use of our services. We do not warrant that our services will be error-free or uninterrupted.',
              ),
              SizedBox(height: 20.0),
              Text(
                '8. Governing Law',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'These Terms of Use are governed by the laws of Egypt. Any disputes shall be resolved in the courts of Egypt.',
              ),
              SizedBox(height: 20.0),
              Text(
                '9. Return and Exchange Policy',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '9.1 Returns and Exchanges: We understand that sometimes a product may not meet your expectations, or you may need a different size or color. You have the right to return or exchange any purchased item within 14 days of receiving it, provided it meets our return and exchange criteria outlined below.',
              ),
              Text(
                '9.2 Return and Exchange Criteria: To initiate a return or exchange, the item must be in its original condition, with all tags and labels intact. It should not show any signs of wear, damage, or alteration.',
              ),
              Text(
                '9.3 Return and Exchange Process: To request a return or exchange, please contact our customer support team within the 14-day period. They will provide you with instructions on how to proceed with the return or exchange.',
              ),
              Text(
                '9.4 Refunds and Replacement: Upon receiving and inspecting the returned item, we will process your refund or replacement, depending on your preference and item availability. Please allow a reasonable time for the refund to reflect in your account.',
              ),
              Text(
                '9.5 Shipping Costs: Please note that shipping costs for returns and exchanges are the responsibility of the customer unless the return or exchange is due to a mistake on our part or a defective product.',
              ),
              SizedBox(height: 20.0),
              Text(
                '10. Cash-Back and Wallet',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '10.1 Cash-Back Earnings: Users who refer our organization to others and earn cash-back rewards will have the option to accumulate these earnings in their wallet.',
              ),
              Text(
                '10.2 Cash-Out Waiting Period: Please note that cash-outs can be requested only after a minimum waiting period of 15 days from the transaction made by the user you referred to our organization. This ensures accurate processing and verification of transactions.',
              ),
              Text(
                '10.3 Wallet Balance Updates: Your wallet balance will be updated automatically after the 15-day waiting period from the referred transaction. We will notify you once your balance has been updated and is available for cash-out.',
              ),
              Text(
                '10.4 Wallet Notifications: You will receive a notification informing you of your updated wallet balance. Please ensure your contact information is up-to-date to receive these notifications.',
              ),
              Text(
                '10.5 Balance Adjustment: Be aware that your wallet balance may be subject to adjustment due to our return and exchange policy, as outlined in our Return and Exchange Policy. Any adjustments will be reflected in your updated balance.',
              ),
              SizedBox(height: 20.0),
              Text(
                '11. Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions or concerns about these Terms of Use, please contact ONE at [Your Contact Information].',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
