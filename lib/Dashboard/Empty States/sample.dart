import 'package:flutter/material.dart';
import 'package:gsheets/Dashboard/custom_classes.dart';
import 'package:side_navigation/side_navigation.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const MainView(),
    ),
  );
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Views to display
  List<Widget> views = const [
    Center(
      child: Text('Pieces Desktop App'),
    ),
    Center(
      child: Text(
        '''
Saving a Snippet

What it is?
Saving a snippet refers to the process of storing a piece of code within the Pieces for Developers app for future use.

How it is used?
Users can save a snippet by navigating to the Snippets tab within the Pieces for Developers app, clicking on the "Create Snippet" button, and entering the necessary information such as the snippet name, description, language, code, and any dependencies or tags.

How it helps the user on a daily basis?
By saving frequently used code snippets within Pieces for Developers, users can quickly access and reuse them without having to search for them each time. This can save users a significant amount of time and increase productivity.

How it helps the user on a weekly basis?
On a weekly basis, saving snippets can help users better organize and streamline their coding projects. By categorizing and tagging snippets, users can more easily find the code they need and ensure consistency across their projects.

How it helps the user on a monthly basis?
Over time, saving snippets can help users build a library of reusable code that can be applied to multiple projects. This can save users significant time and effort and help them complete projects more quickly.
  ''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
Deleting a Snippet

What it is?
Deleting a snippet refers to the process of removing a saved code snippet from the Pieces for Developers app.

How it is used?
Users can delete a snippet by navigating to the Snippets tab within the Pieces for Developers app, locating the snippet they wish to delete, clicking on the "Delete" button, and confirming the deletion.

How it helps the user on a daily basis?
By allowing users to remove unwanted or outdated code snippets, deleting snippets can help keep the user's code library organized and easy to navigate.

How it helps the user on a weekly basis?
On a weekly basis, deleting snippets can help users maintain the quality of their code library by removing snippets that are no longer relevant or accurate.

How it helps the user on a monthly basis?
Over time, deleting snippets can help users keep their code library current and ensure that they are using the most up-to-date and accurate code snippets.
      
      ''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
      
Editing a Snippet

What it is?
Editing a snippet refers to the process of modifying a saved code snippet within the Pieces for Developers app.

How it is used?
Users can edit a snippet by navigating to the Snippets tab within the Pieces for Developers app, locating the snippet they wish to edit, clicking on the "Edit" button, making the necessary changes, and saving the updated snippet.

How it helps the user on a daily basis?
By allowing users to easily modify saved code snippets, editing snippets can help users customize their code library to better suit their needs.

How it helps the user on a weekly basis?
On a weekly basis, editing snippets can help users improve the quality of their code library by modifying snippets to be more accurate or efficient.

How it helps the user on a monthly basis?
Over time, editing snippets can help users build a library of customized and optimized code snippets that can be applied to multiple projects.
      
      ''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
      
View Snippet Context

What it is?
View Snippet Context is a feature in Pieces For Developers that allows the user to view the context of a code snippet, including the file it was taken from, its location within the file, and any surrounding code.

How it is used?
To view the context of a code snippet in Pieces For Developers, the user must first locate the snippet in the app. Once located, the user can click on the snippet to open it in the editor view. From here, the user can click the "View Context" button at the top of the editor view to see the context of the snippet.

How it helps the user on a daily basis?
Viewing the context of a code snippet in Pieces For Developers can help the user understand how the snippet fits into the larger codebase and how it can be used effectively. By seeing the snippet in context, the user can make more informed decisions about how to use it in their own code.

How it helps the user on a weekly basis?
On a weekly basis, viewing snippet context can help the user become more familiar with the codebase they are working with. By seeing the context of multiple snippets, the user can develop a better understanding of the overall structure of the codebase and how different pieces of code fit together.

How it helps the user on a monthly basis?
Over the course of a month, viewing snippet context can help the user build up a more comprehensive understanding of the codebase they are working with. By seeing the context of different snippets over time, the user can develop a deeper understanding of how the codebase is organized and how different parts of the code interact with each other.
      ''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
Shareable Link Generation

Piece’s Shareable Link is the ultimate workflow facilitator for teams looking to collaborate and share code snippets quickly and easily. You can create a shareable link to any of your saved code snippets in the Pieces for Developers desktop app, and then send that link to anyone in your team. They can then open and view the snippet in their own Pieces app, saving them valuable time and effort.

Here's how it works:
Step 1: Connect to Pieces Cloud To use Pieces Share, you need to have an active connection to Pieces Cloud. If you're not already connected, simply sign up for a free account and follow the on-screen instructions to connect your Pieces for Developers desktop app to the cloud.

Step 2: Generate a Shareable Link Once you're connected to Pieces Cloud, you can generate a shareable link for any of your saved code snippets in the desktop app. Simply click on the "Share" button next to the snippet you want to share, and then copy the generated link.

Step 3: Share with Your Team With your shareable link in hand, you can send it to anyone on your team via email, Slack, or any other messaging platform your team uses. When they click on the link, they'll be taken to a web page where they can view the code snippet in their own Pieces for Developers app.

Step 4: Save the Shared Snippet Once they've opened the shared snippet, your team member can easily save it to their own Pieces library by clicking the "Save to Pieces" button. From there, they can use and modify the snippet as needed, streamlining your team's development process and increasing efficiency.

Whether you're working on a small project or a large-scale development effort, Pieces Share is the ultimate tool for sharing and collaborating on code snippets with your team. Try it today and see the difference it can make!   ''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
What is it?

Activity view is a feature in the Pieces for Developers Desktop App that allows you to track and view recent activity within your project. The Activity view provides a chronological list of events, including commits, file changes, and comments, allowing you to easily track changes made by you and your team members.

keyboard shortcut:

MacOS: [ command + shift + a ]

Windows: [ ctrl + shift + a ]

How to use Activity view:

To access the Activity view, simply open the Pieces for Developers Desktop App and…

navigate to the Activity tab. From there, you can view a chronological list of recent events within your project, as well as any associated comments or other details. You can also filter the list by event type or search for specific events using keywords or phrases.

navigate to the activity view by clicking the icon shown
after clicking the activity view icon, you can view a chronological list of recent events within your project, as well as any associated comments or other details. You can also filter the list by event type or search for specific events using keywords or phrases.
The refresh icon will refresh this feed and force the most recent activity into view 
''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
Pieces for VS Code Plugin:

What it is?
The Pieces for VS Code Plugin is an extension that integrates the Pieces for Developers functionality with Visual Studio Code. It allows users to easily save, organize, and search code snippets directly within the editor.

How it is used?
To use the Pieces for VS Code Plugin, users need to first install it from the Visual Studio Code Marketplace. Once installed, they can create new snippets or save existing code as a snippet by selecting the code and using the keyboard shortcut or context menu option. The plugin also provides quick access to search and insert saved snippets directly from within the editor.

How it helps the user on a daily basis?
The Pieces for VS Code Plugin helps users save time by allowing them to easily store and retrieve frequently used code snippets without leaving the editor. This can improve workflow and increase productivity.

How it helps the user on a weekly basis?
On a weekly basis, the Pieces for VS Code Plugin can help users maintain organized and efficient coding practices. By using the plugin to save and organize frequently used code snippets, users can ensure that they have quick access to the code they need, when they need it.

How it helps the user on a monthly basis?
Over a longer period of time, the Pieces for VS Code Plugin can help users build up a library of useful code snippets that can be reused across multiple projects. This can save significant time and effort, and improve code consistency and quality.
''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
Pieces for IntelliJ Plugin:

What it is?
The Pieces for IntelliJ Plugin is an extension that integrates the Pieces for Developers functionality with IntelliJ IDEA, a popular Java IDE. It allows users to easily save, organize, and search code snippets directly within the IDE.

How it is used?
To use the Pieces for IntelliJ Plugin, users need to first install it from the IntelliJ IDEA Marketplace. Once installed, users can create new snippets or save existing code as a snippet by selecting the code and using the keyboard shortcut or context menu option. The plugin also provides quick access to search and insert saved snippets directly from within the IDE.

How it helps the user on a daily basis?
The Pieces for IntelliJ Plugin helps users save time by allowing them to easily store and retrieve frequently used code snippets without leaving the IDE. This can improve workflow and increase productivity.

How it helps the user on a weekly basis?
On a weekly basis, the Pieces for IntelliJ Plugin can help users maintain organized and efficient coding practices. By using the plugin to save and organize frequently used code snippets, users can ensure that they have quick access to the code they need, when they need it.

How it helps the user on a monthly basis?
Over a longer period of time, the Pieces for IntelliJ Plugin can help users build up a library of useful code snippets that can be reused across multiple projects. This can save significant time and effort, and improve code consistency and quality.

''',
        style: TextStyle(fontSize: 10),
      ),
    ),
    Center(
      child: Text(
        '''
Pieces for Developers Chrome Extension:

What it is?
The Pieces for Developers Chrome extension is a powerful tool that enables users to easily save code snippets they find on the web. It provides a one-click save feature that allows users to quickly capture code blocks from any webpage.

How it is used?
To use the Pieces for Developers Chrome extension, users must first install it on their Google Chrome browser. Once installed, they can save code snippets by hovering over the code block and clicking the Pieces button or by highlighting and right-clicking the code block and using a keyboard shortcut. The extension automatically enriches the snippets with useful information such as the source URL, a description, language classification, and relevant tags for easy searching.

How it helps the user on a daily basis?
The Pieces for Developers Chrome extension helps users save time by allowing them to quickly and easily save code snippets from the web. This can help developers build up a library of useful code snippets that can be reused across multiple projects, increasing productivity and improving code consistency and quality.

How it helps the user on a monthly basis?
On a monthly basis, the Pieces for Developers Chrome extension can help users manage and organize their code snippets. The snippets can be viewed and managed in the Pieces desktop app, which enables users to easily search for and retrieve the code they need. This can save significant time and effort, and ensure that users have quick access to the code they need when they need it.
''',
        style: TextStyle(fontSize: 10),
      ),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// You can use an AppBar if you want to
      //appBar: AppBar(
      //  title: const Text('App'),
      //),

      // The row is needed to display the current view
      body: Row(
        children: [
          /// Pretty similar to the BottomNavigationBar!
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SideNavigationBar(
              expandable: true,
              selectedIndex: selectedIndex,
              items: const [

                SideNavigationBarItem(
                  icon: Icons.computer,
                  label: 'Pieces Desktop App',
                ),
                SideNavigationBarItem(
                  icon: Icons.save,
                  label: 'Saving a Snippet',
                ),
                SideNavigationBarItem(
                  icon: Icons.delete,
                  label: 'Deleting a Snippet',
                ),
                SideNavigationBarItem(
                  icon: Icons.edit,
                  label: 'Editing a Snippet',
                ),
                SideNavigationBarItem(
                  icon: Icons.line_style_outlined,
                  label: 'View Context',
                ),
                SideNavigationBarItem(
                  icon: Icons.ios_share,
                  label: 'Shareable Links',
                ),
                SideNavigationBarItem(
                  icon: Icons.auto_graph_outlined,
                  label: 'Activity',
                ),
                SideNavigationBarItem(
                  icon: Icons.verified_rounded,
                  label: 'VS Code',
                ),
                SideNavigationBarItem(
                  icon: Icons.verified_rounded,
                  label: 'JetBrains IntelliJ',
                ),
                SideNavigationBarItem(
                  icon: Icons.verified_rounded,
                  label: 'Chrome Ext',
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),

          /// Make it take the rest of the available width
          Expanded(
            child: views.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}
