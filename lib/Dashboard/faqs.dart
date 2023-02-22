import 'package:flutter/material.dart';

import '../CustomAppBar.dart';
import '../Tab_Peoples_List/peoples_list.dart';
import '../Bottom_bar/bottom_appbar_class.dart';

void main() => runApp(FloatingSettingsButton());

class FloatingSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> settings = [
      'FAQ: How are my snippets filtered?',
      'FAQ: How do | refresh my Saved Snippets List?',
      'FAQ: How do | modify Pieces for JetBrains user settings',
      'FAQ: How are snippets suggested within the JetBrains Snippet Treeview? #34',
      'FAQ: What is Pieces for JetBrains? #35',
      'FAQ: What are the main features of Pieces for JetBrains? #36',
      'FAQ: Is Pieces for JetBrains free to use? #37',
      'FAQ: What JetBrains products does Pieces for JetBrains support?',
      'FAQ: How do | install Pieces for JetBrains on my computer?',
      'FAQ: How do | get support if | have problems with Pieces for JetBrains?',
    ];
    List<String> explanations = [

      '''
The following three options are the only bit of information users currently get when viewing within settings.

1. none
2. moderate
3. strict

''',
      '''To refresh your saved snippets:

identify the Pieces side bar tab
open the side bar
at the top of the window, click the refresh icon
your snippets will refresh and newly added snippets will be viewable by expanding its respective language classification.


You should expect to see a ""successfully refreshed saved snippets"" pop up in the lower right hand corner of the screen"
"MacOS:
System Trey >-> Settings >-> Tools >-> Pieces

Windows:
File >-> Settings >-> Pieces"
''',
      '''Similar to the Pieces for ""filter by suggested"" view, The Pieces for JetBrains Suggested Snippet ListView returns a list of existing snippets that are perceived relavent to the users current flow.

Its important to understand that these suggested snippets are PFD resurfaced existing snippets in the repository.

The suggested snippet view does not suggest new snippets but instead resurfaces relavent snippets that were already saved to Pieces for Developers."
''',
      '''
Pieces for JetBrains is a software development tool that provides a comprehensive set of tools and plugins for JetBrains products such as IntelliJ IDEA, PyCharm, and others. It helps developers to enhance their productivity, speed up their workflows, and streamline their development processes.
Pieces for JetBrains provides a wide range of features, including:

1. Code Managing Features,

-code navigation & Viewing
-classification metadata refactoring.
-related people,
-related tags,
-related links,
-custom name,
-custom description,
-sensitives,
-People Management

2. Integrated debugging Features

-Autocomplete,
-Link sharing,
-Snippet Editing
3. Integrated version control systems (VCS)

-regularly updated, maintained and versioned with Github

4. Code generation & productivity boosting tools

-Autocomplete,
-drag n drop insert, and
-drag n drop reclassification"
''',


      '''Yes, JetBrains is free to download from the JetBrains marketplace

However, even though Pieces for JetBrains is free to install... users will need a personal jetBrains IntelliJ account to use the IDE itself.

Sign up for and try the Pieces for JetBrains Plugin with this free trial of JetBrains here."

''',
      '''Pieces for JetBrains supports a wide range of JetBrains products, including...

IntelliJ IDEA,
    PyCharm,
    Android Studio
WebStorm,
    and others.
You can check the Pieces official website for the complete list of supported products. here"
"JetBrains MarketPlace Installation
Where is the JetBrains MarketPlace? & How do I install the Pieces Plugin

Open IntelliJ IDEA
Click on the ""File"" menu in the top left corner of the window.
Select ""Settings"" or press ""Ctrl + Alt + S"" (for Windows) or ""Cmd + , "" (for Mac).
In the Settings window, expand the ""Plugins"" section.
Click on the ""Marketplace"" tab.
The JetBrains Marketplace will be displayed in the window, where you can search for and install plugins, including Pieces for JetBrains.
Simply search for Pieces for JetBrains, and click the install button. The installation process will guide you through the rest of the process.
Pieces for IntelliJ requires no restart when installing!''',

      '''Get Pieces for JetBrains through the official website or (getting started page). They offer a variety of resources, including a knowledge base ('Whats New'), community forum, and email support.

If you encounter any additional issues, we recommend checking the knowledge base (and or support center or whats new tab or getting started page) first and if you can't find a solution, you can submit a support ticket here.
''',
    ];


    Map<List<String>, List<String>> faqs = {settings: explanations};

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Frequently Asked Questions',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              FloatingActionButton(
                focusColor: Colors.green,
                tooltip: 'back',
                hoverColor: Colors.grey,
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  MyApp();
                },
              ),  SizedBox(
                height: 50,
                width: 50,
                child: Image.asset('faq.png'),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: .85,
                ),
              ),
            ),
            height: 300,
            width: 500,
            child: ListView.builder(
              itemCount: settings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index+1}'),
                  subtitle: Text('view'),
                  title: Text(settings.elementAt(index)),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(settings.toList().elementAt(index)),
                        content: Text(explanations.toList().elementAt(index)),
                        actions: [
                          ElevatedButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
