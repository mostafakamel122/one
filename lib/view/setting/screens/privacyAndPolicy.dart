import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                '1. Introduction',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to ONE ("we," "us," or "our"). At ONE, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how ONE collects, uses, discloses, and safeguards your personal data when you interact with our website, mobile applications, or products.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '2. Information We Collect',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              _buildListItem('Personal Information',
                  'This may include your name, contact information (email address, phone number), shipping address, and billing information.'),
              _buildListItem('Transaction Data',
                  'Information about your purchases, payment methods, and order history.'),
              _buildListItem('Usage Data',
                  'Data about your interactions with our website, such as pages visited, products viewed, and your IP address.'),
              _buildListItem('Device Information',
                  'Information about the device and browser you use to access our services.'),
              _buildListItem('Location Information',
                  'We may collect your geolocation information with your consent.'),
              _buildListItem('Cookies and Similar Technologies',
                  'We use cookies and similar technologies to enhance your experience and collect data about your usage of our services.'),
              SizedBox(height: 20.0),
              Text(
                '3. How We Use Your Information',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              _buildListItem('Processing and Fulfilling Orders', ''),
              _buildListItem('Providing Customer Support', ''),
              _buildListItem('Personalizing Your Experience', ''),
              _buildListItem('Marketing and Promotional Communications', ''),
              _buildListItem('Improving Our Products and Services', ''),
              _buildListItem('Legal and Compliance Purposes', ''),
              SizedBox(height: 20.0),
              Text(
                '4. Information Sharing',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              _buildListItem(
                  'Service Providers', 'who help us operate our business.'),
              _buildListItem('Legal Authorities',
                  'when required by law or to protect our rights.'),
              _buildListItem(
                  'Business Partners', 'for joint marketing initiatives.'),
              _buildListItem(
                  'Third-party Analytics and Advertising Providers', ''),
              SizedBox(height: 20.0),
              Text(
                '5. Your Choices',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              _buildListItem(
                  'Access, Update, or Delete Your Personal Information', ''),
              _buildListItem('Opt-out of Marketing Communications', ''),
              _buildListItem(
                  'Disable Cookies Through Your Browser Settings', ''),
              SizedBox(height: 20.0),
              Text(
                '6. Data Security',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We employ security measures to protect your personal information, but no data transmission over the internet is entirely secure.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '7. Children\'s Privacy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our services are not intended for children under 16. We do not knowingly collect data from children.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '8. Changes to This Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We may update this Privacy Policy. The revised version will be posted on our website with the effective date.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '9. Contact Us',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have questions about our Privacy Policy or your data, please contact ONE at [Your Contact Information].',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
