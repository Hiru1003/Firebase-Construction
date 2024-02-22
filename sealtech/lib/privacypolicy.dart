import 'package:flutter/material.dart';
import 'package:sealtech/components/button.dart';
import 'package:sealtech/components/theme.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy and Security',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Diam tristique massa massa netus aliquet pellentesque consequat sagittis elit. Odio ipsum malesuada arcu fermentum eget egestas odio. Eget lobortis quis ultricies risus. In ut eget pharetra mauris bibendum condimentum. Vitae quis viverra id mattis eget mauris mattis. Ac consectetur vulputate interdum egestas. Arcu eget id tortor viverra integer elit mollis. Interdum arcu ut imperdiet turpis. Fermentum pharetra nam ut malesuada vestibulum massa. Nunc est arcu diam cursus. Dolor tincidunt pharetra congue maecenas. Morbi sapien mauris fermentum magna. Eget amet in proin sed. Etiam adipiscing diam diam odio. Habitasse feugiat turpis nulla commodo sed phasellus. Imperdiet purus malesuada libero duis sed. Volutpat etiam ac vitae ac. Purus augue nec porta quisque venenatis nascetur vulputate varius pulvinar. Ullamcorper diam mattis lorem nulla donec at neque pharetra egestas. Dolor eu maecenas enim tincidunt blandit tincidunt viverra semper tortor. Enim leo posuere congue vitae turpis bibendum imperdiet tellus. Sit sed pulvinar vel vitae auctor. Eget sapien ultricies viverra nec. Consectetur pulvinar sed consequat et quam. Sodales pulvinar ut mauris id quis. Erat at in diam auctor. Velit duis bibendum ut massa. Et elementum in nisi pharetra et proin euismod lectus. Sed vivamus aliquet at auctor amet ut molestie. Facilisis quis bibendum eu commodo at ultrices eget nulla nulla. Rhoncus ac interdum venenatis viverra quis pellentesque pretium ornare ac. In leo nisl purus faucibus.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    activeColor: Colors.orange,
                    checkColor: Colors.white,
                  ),
                  const Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              Center(
                child: Button(
                  buttonText: 'Continue',
                  enableIcon: false,
                  onPressed: () {
                    // Replace print with a logging framework
                    // logger.info('Button pressed!');
                  },
                  color: 'orange',
                  isStroked: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}