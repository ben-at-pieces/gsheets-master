import '../statistics_singleton.dart';

List<String> peoples = StatisticsSingleton().statistics?.persons ?? [];
List<String> links = StatisticsSingleton().statistics?.relatedLinks.toList() ?? [];
List<String> tags = StatisticsSingleton().statistics?.tags ?? [];
List<String> languages = StatisticsSingleton().statistics?.classifications.keys.toList() ?? [];
List<String> userdata = [
  // (StatisticsSingleton().statistics?.userPicture ?? ''),
  '''
${StatisticsSingleton().statistics?.user}
${StatisticsSingleton().statistics?.email}
OS: ${StatisticsSingleton().statistics?.versionProfile}
Domain: ${StatisticsSingleton().statistics?.vanityName}
''',
];
int index = StatisticsSingleton().statistics?.asset.length ?? 0;
List<String> snippetList = [
  ' ${StatisticsSingleton().statistics?.asset.toList()[index].name ?? ''}'
];

List<String> snippetName = snippetList.where((element) => element.isNotEmpty).toList();
List<String> dartRelatedStrings = [
  'Dart',
  'Flutter',
  'Client-side programming',
  'Server-side programming',
  'Cross-platform development',
  'Object-oriented programming',
  'Functional programming',
  'SDK',
  'IDE',
  'Hot reload',
  'DartPad',
  'Pub',
  'Dart SDK',
  'Flutter SDK',
  'Dart VM',
  'Dart code',
  'Dart syntax',
  'Dart libraries',
  'Dart packages',
  'Dart plugins',
  'Dart tools',
  'Dart framework',
  'Dart programming language',
  'Dart classes',
  'Dart objects',
  'Dart variables',
  'Dart functions',
  'Dart streams',
  'Dart Futures',
  'Dart isolates',
  'Dart async',
  'Dart await',
  'Dart callbacks',
  'Dart closure',
  'Dart inheritance',
  'Dart abstract class',
  'Dart interface',
  'Dart mixins',
  'Dart generics',
  'Dart type system',
  'Dart type inference',
  'Dart operator overloading',
  'Dart exception handling',
  'Dart asserts',
  'Dart collections',
  'Dart lists',
  'Dart maps',
  'Dart sets',
  'Dart enums',
  'Dart optional parameters',
  'Dart named parameters',
  'Dart optional named parameters',
  'Dart constructors',
  'Dart getters',
  'Dart setters',
  'Dart extensions',
  'Dart metadata',
  'Dart constants',
  'Dart final',
  'Dart static',
  'Dart keyword',
  'Dart literals',
  'Dart comment',
  'Dart style guide',
  'Dart best practices',
  'Dart patterns',
  'Dart debugging',
  'Dart testing',
  'Dart asserts',
  'Dart mock objects',
  'Dart integration tests',
  'Dart unit tests',
  'Dart test runner',
  'Dart coverage',
  'Dart code analysis',
  'Dart static analysis',
  'Dart linting',
  'Dart Dart2JS',
  'Dart VM',
  'Dart native extensions',
  'Dart strong mode',
  'Dart null safety',
  'Dart sound null safety',
  'Dart type inference engine',
  'Dart packages repository',
  'Dart open-source libraries',
  'Dart third-party packages',
  'Dart community',
  'Dart meetups',
  'Dart conferences',
  'Dart events',
  'Dart news',
  'Dart blogs',
  'Dart podcasts',
  'Dart forums',
  'Dart Discord',
  'Dart Stack Overflow',
];

List<String> typescriptRelatedStrings = [
  "console.log('Hello, World!');",
  'let x = 10;\nlet y = 20;\nconsole.log(x + y);',
  "let x: string = 'John Doe';\nconsole.log(`My name is ${'x'}`);",
  'let x: number[] = [1, 2, 3];\nconsole.log(x);',
  "let x: { name: string, age: number } = { name: 'John Doe', age: 30 };\nconsole.log(x);",
  'function add(a: number, b: number): number {\n  return a + b;\n}\nconsole.log(add(10, 20));',
  'let x: number[] = [1, 2, 3];\nlet y = x.map(item => item * 2);\nconsole.log(y);',
  'let x: number[] = [1, 2, 3];\nlet y = x.filter(item => item % 2 === 0);\nconsole.log(y);',
  'let x: number[] = [1, 2, 3, 4, 5];\nlet y = x.reduce((acc, item) => acc + item, 0);\nconsole.log(y);',
  'let x: number[] = [1, 2, 3];\nfor (let i = 0; i < x.length; i++) {\n  console.log(x[i]);\n}',
  'let x: number[] = [1, 2, 3];\nx.forEach(item => console.log(item));',
  'let x: number[] = [1, 2, 3];\nlet y = x.slice(0, 2);\nconsole.log(y);',
  'let x: number[] = [1, 2, 3];\nlet y = x.splice(1, 1, 4);\nconsole.log(x);\nconsole.log(y);',
  'let x: number[] = [1, 2, 3];\nlet y = x.concat([4, 5, 6]);\nconsole.log(y);',
  "let x: number[] = [1, 2, 3];\nlet y = x.join(', ');\nconsole.log(y);",
  "let x: string[] = 'hello world'.split(' ');\nconsole.log(x);",
  "let x: number = 'hello world'.indexOf('world');\nconsole.log(x);",
  "let x: string = 'hello world'.substring(0, 5);\nconsole.log(x);",
  "let x: string = 'hello world'.slice(0, 5);\nconsole.log(x);",
  "let x: string = 'hello world'.replace('hello', 'hi');\nconsole.log(x);",
  "let x: string = 'hello world'.toUpperCase();\nconsole.log(x);",
  "let x: string = 'HELLO WORLD'.toLowerCase()",
];

List<String> javaScript = [
  "console.log('Hello, World!')",
  'var x = 10;\nvar y = 20;\nconsole.log(x + y);',
  "var x = 'John Doe';\nconsole.log('My name is ' + x);",
  'var x = [1, 2, 3];\nconsole.log(x);',
  "var x = { name: 'John Doe', age: 30 };\nconsole.log(x);",
  'function add(a, b) {\n  return a + b;\n}\nconsole.log(add(10, 20));',
  'var x = [1, 2, 3];\nvar y = x.map(function(item) {\n  return item * 2;\n});\nconsole.log(y);',
  'var x = [1, 2, 3];\nvar y = x.filter(function(item) {\n  return item % 2 === 0;\n});\nconsole.log(y);',
  'var x = [1, 2, 3, 4, 5];\nvar y = x.reduce(function(acc, item) {\n  return acc + item;\n}, 0);\nconsole.log(y);',
  'var x = [1, 2, 3];\nfor (var i = 0; i < x.length; i++) {\n  console.log(x[i]);\n}',
  'var x = [1, 2, 3];\nx.forEach(function(item) {\n  console.log(item);\n});',
  'var x = [1, 2, 3];\nvar y = x.slice(0, 2);\nconsole.log(y);',
  'var x = [1, 2, 3];\nvar y = x.splice(1, 1, 4);\nconsole.log(x);\nconsole.log(y);',
  'var x = [1, 2, 3];\nvar y = x.concat([4, 5, 6]);\nconsole.log(y);',
  "var x = [1, 2, 3];\nvar y = x.join(', ');\nconsole.log(y);",
  "var x = 'hello world'.split(' ');\nconsole.log(x);",
  "var x = 'hello world'.indexOf('world');\nconsole.log(x);",
  "var x = 'hello world'.substring(0, 5);\nconsole.log(x);",
  "var x = 'hello world'.slice(0, 5);\nconsole.log(x);",
  "var x = 'hello world'.replace('hello', 'hi');\nconsole.log(x);",
  "var x = 'hello world'.toUpperCase();\nconsole.log(x);",
  "var x = 'HELLO WORLD'.toLowerCase();\nconsole.log(x);",
  "var x = '   hello world   '.trim();\nconsole.log(x);",
];

List<String> sqlTerms = [
  'SQL',
  'SELECT',
  'FROM',
  'WHERE',
  'GROUP BY',
  'HAVING',
  'ORDER BY',
  'LIMIT',
  'OFFSET',
  'JOIN',
  'INNER JOIN',
  'LEFT JOIN',
  'RIGHT JOIN',
  'FULL OUTER JOIN',
  'UNION',
  'INTERSECT',
  'EXCEPT',
  'INSERT INTO',
  'UPDATE',
  'DELETE',
  'CREATE TABLE',
  'ALTER TABLE',
  'DROP TABLE',
  'TRUNCATE TABLE',
  'AS',
  'ON',
  'USING',
  'DISTINCT',
  'IN',
  'BETWEEN',
  'LIKE',
  'IS NULL',
  'IS NOT NULL',
  'EXISTS',
  'ALL',
  'ANY',
  'SOME',
  'AVG',
  'COUNT',
  'MAX',
  'MIN',
  'SUM',
  'GROUP_CONCAT',
  'CONCAT',
  'SUBSTRING',
  'TRIM',
  'UPPER',
  'LOWER',
  'ROUND',
  'CEILING',
  'FLOOR',
  'ABS',
  'SIGN',
  'MOD',
  'POW',
  'SQRT',
  'LOG',
  'EXP',
  'PI',
  'RAND',
  'WITH ROLLUP',
  'HAVING',
  'CASE',
  'WHEN',
  'THEN',
  'ELSE',
  'END',
  'COALESCE',
  'NULLIF',
  'IFNULL',
  'ISNULL',
  'IF',
  'EXISTS',
  'NOT EXISTS',
  'INNER',
  'LEFT',
  'RIGHT',
  'FULL OUTER',
  'CROSS',
  'UNION ALL',
  'UNION',
  'INTERSECT',
  'EXCEPT',
  'ASC',
  'DESC',
  'INDEX',
  'PRIMARY KEY',
  'FOREIGN KEY',
  'UNIQUE',
  'CHECK',
  'DEFAULT',
  'CONSTRAINT',
  'TRIGGER',
  'VIEW',
  'PROCEDURE',
  'FUNCTION',
  'CASCADE',
  'RESTRICT',
  'NO ACTION',
  'SET NULL',
  'SET DEFAULT',
];

// List<String> userSnippets = StatisticsSingleton().statistics?.asset.toList().elementAt();

List<String> dartSnippets = [
  "print('Hello, Dart!');",
  "var name = 'Dart';\nprint('Hello, \$name!');",
  "var x = 10;\nvar y = 20;\nprint('The sum of x and y is: \${x + y}');",
  'var numbers = [1, 2, 3, 4, 5];\nprint(numbers);',
  "var person = {'name': 'John Doe', 'age': 30};\nprint(person);",
  'var isTrue = true;\nvar isFalse = false;\nprint(isTrue);\nprint(isFalse);',
  "if (10 > 5) {\n  print('10 is greater than 5');\n}",
  'for (var i = 0; i < 5; i++) {\n  print(i);\n}',
  'var numbers = [1, 2, 3, 4, 5];\nfor (var number in numbers) {\n  print(number);\n}',
  'var i = 0;\nwhile (i < 5) {\n  print(i);\n  i++;\n}',
  'var add = (int a, int b) => a + b;\nprint(add(10, 20));',
  "class Car {\n  String make;\n  String model;\n\n  Car(this.make, this.model);\n}\n\nvar car = Car('Toyota', 'Camry');\nprint(car.make);\nprint(car.model);",
  'void printSum(int a, int b) {\n  print(a + b);\n}\n\nprintSum(10, 20);',
  'var list = [1, 2, 3, 4, 5];\nlist.',
  'var list = [1, 2, 3, 4, 5];\nvar doubled = list.map((item) => item * 2);\nprint(doubled);',
  'var list = [1, 2, 3, 4, 5];\nvar sum = list.reduce((current, next) => current + next);\nprint(sum);',
  'var list = [1, 2, 3, 4, 5];\nvar first = list.first;\nprint(first);',
  'var list = [1, 2, 3, 4, 5];\nvar last = list.last;\nprint(last);',
  'var list = [1, 2, 3, 4, 5];\nvar length = list.length;\nprint(length);',
  'var list = [1, 2, 3, 4, 5];\nvar isEmpty = list.isEmpty;\nprint(isEmpty);',
  'var list = [1, 2, 3, 4, 5];\nvar isNotEmpty = list.isNotEmpty;\nprint(isNotEmpty);',
];
List<String> sqlSnippets = [
  'SELECT * FROM customers;',
  'SELECT first_name, last_name FROM customers;',
  'SELECT COUNT(*) FROM customers;',
  'SELECT DISTINCT country FROM customers;',
  "SELECT * FROM customers WHERE country = 'USA';",
  "SELECT * FROM customers WHERE country = 'USA' OR country = 'UK';",
  "SELECT * FROM customers WHERE country IN ('USA', 'UK');",
  'SELECT * FROM customers ORDER BY first_name;',
  'SELECT * FROM customers ORDER BY first_name DESC;',
  "SELECT * FROM customers WHERE country = 'USA' ORDER BY first_name DESC;",
  'SELECT AVG(amount) FROM orders;',
  'SELECT SUM(amount) FROM orders;',
  'SELECT MAX(amount) FROM orders;',
  'SELECT MIN(amount) FROM orders;',
  'SELECT * FROM customers JOIN orders ON customers.customer_id = orders.customer_id;',
  'SELECT * FROM customers LEFT JOIN orders ON customers.customer_id = orders.customer_id;',
  'SELECT * FROM customers RIGHT JOIN orders ON customers.customer_id = orders.customer_id;',
  'SELECT * FROM customers FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id;',
  'SELECT * FROM customers CROSS JOIN orders;',
  "SELECT * FROM customers WHERE country = 'USA' AND (state = 'CA' OR state = 'NY');",
  'SELECT first_name, last_name, country, state FROM customers GROUP BY country, state;',
  'SELECT country, COUNT(*) FROM customers GROUP BY country;',
  'SELECT country, SUM(amount) FROM customers JOIN orders ON customers.customer_id = orders.customer_id GROUP BY country;',
  'SELECT * FROM customers LIMIT 10;',
  'SELECT * FROM customers OFFSET 10;',
  'SELECT * FROM customers LIMIT 10 OFFSET 10;',
  'CREATE TABLE customers (customer_id INT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), country VARCHAR(50), state VARCHAR(50));',
  'ALTER TABLE customers ADD COLUMN email VARCHAR(100);',
  'ALTER TABLE customers DROP COLUMN email;',
  'ALTER TABLE customers RENAME COLUMN first_name TO firstName;',
  "INSERT INTO customers (customer_id, first_name, last_name, country, state) VALUES (1, 'John', 'Doe', 'USA', 'CA');",
  "UPDATE customers SET first_name = 'Jane' WHERE customer_id = 1;",
  'DELETE FROM customers WHERE customer_id = 1;',
  'CREATE INDEX idx_customers_first_name ON customers (first_name);',
  'DROP INDEX idx_customers_first_name;',
  'CREATE UNIQUE INDEX idx_customers_first_name_last_name ON customers (first_name, last',
];

List<String> answers = [
  '''Github issue requesting more clarity with respect to the filter snippets based on the current files extension.

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

List<String> learn = [
  'What is the meaning of life?',
  'What is AI?',
  'What is machine learning?',
  'What is deep learning?',
  'What is natural language processing?',
  'What is computer vision?',
  'What is robotics?',
  'What is the history of AI?',
  'What are the applications of AI?',
  'What are the ethical considerations of AI?',
  'What is the future of AI?',
  'What is the difference between AI and machine learning?',
  'What is the difference between machine learning and deep learning?',
  'What is the difference between deep learning and artificial neural networks?',
  'What is a neural network?',
  'What is a convolutional neural network?',
  'What is a recurrent neural network?',
  'What is a generative adversarial network?',
  'What is reinforcement learning?',
  'What is unsupervised learning?',
  'What is supervised learning?',
  'What is transfer learning?',
  'What is multi-task learning?',
  'What is transfer learning used for?',
  'What is a decision tree?',
  'What is random forest?',
  'What is gradient boosting?',
  'What is K-nearest neighbors?',
  'What is linear regression?',
  'What is logistic regression?',
  'What is Naive Bayes?',
  'What is support vector machines?',
  'What is neural style transfer?',
  'What is sentiment analysis?',
  'What is image classification?',
  'What is object detection?',
  'What is image segmentation?',
  'What is image captioning?',
  'What is speech recognition?',
  'What is text generation?',
  'What is language translation?',
  'What is text classification?',
  'What is text summarization?',
  'What is chatbot development?',
  'What is conversational AI?',
  'What is dialogue management?',
  'What is voice user interface?',
  'What is language modeling?',
  'What is named entity recognition?',
  'What is part-of-speech tagging?',
  'What is sentiment analysis used for?'
];

List<String> prompts = [
  'What is image classification?',
  'What is object detection?',
  'What is image captioning?',
  'What is speech recognition?',
  'What is text generation?',
  'What is language translation?',
  'What is text classification?',
  'What is text summarization?',
  'What is chatbot development?',
  'What is conversational AI?',
  'What is dialogue management?',
  'What is voice user interface?',
  'What is language modeling?',
  'What is named entity recognition?',
  'What is the meaning of life?',
  'What is AI?',
  'What is machine learning?',
  'What is deep learning?',
  'What is natural language processing?',
  'What is computer vision?',
  'What is robotics?',
  'What is the history of AI?',
  'What are the applications of AI?',
  'What are the ethical considerations of AI?',
  'What is the future of AI?',
  'What is the difference between AI and machine learning?',
  'What is the difference between machine learning and deep learning?',
  'What is the difference between deep learning and artificial neural networks?',
  'What is a neural network?',
  'What is a convolutional neural network?',
  'What is a recurrent neural network?',
  'What is a generative adversarial network?',
  'What is reinforcement learning?',
  'What is unsupervised learning?',
  'What is supervised learning?',
  'What is transfer learning?',
  'What is multi-task learning?',
  'What is transfer learning used for?',
  'What is a decision tree?',
  'What is random forest?',
  'What is gradient boosting?',
  'What is K-nearest neighbors?',
  'What is linear regression?',
  'What is logistic regression?',
  'What is Naive Bayes?',
  'What is support vector machines?',
  'What is neural style transfer?',
  'What is sentiment analysis?',
  'What is part-of-speech tagging?',
  'What is sentiment analysis used for?'
];

List<String> pythonRelatedStrings = [
  "print('Hello, World!')",
  'a = 5\nb = 10\nprint(a + b)',
  "name = input('What is your name? ')\nprint('Hello, ' + name + '!')",
  "names = ['John', 'Jane', 'Jim']\nprint(names[0])",
  'for i in range(5):\n\tprint(i)',
  "def say_hello(name):\n\treturn 'Hello, ' + name\nprint(say_hello('John'))",
  'x = [1, 2, 3, 4, 5]\nprint(sum(x))',
  'x = [1, 2, 3, 4, 5]\nfor i in x:\n\tprint(i)',
  "x = 'Hello, World!'\nprint(x.upper())",
  "x = 'hello, world!'\nprint(x.capitalize())",
  'x = [1, 2, 3, 4, 5]\nprint(max(x))',
  'x = [1, 2, 3, 4, 5]\nprint(min(x))',
  'x = [1, 2, 3, 4, 5]\nprint(len(x))',
  'x = [1, 2, 3, 4, 5]\nx.append(6)\nprint(x)',
  'x = [1, 2, 3, 4, 5]\nx.pop()\nprint(x)',
  'x = [1, 2, 3, 4, 5]\nx.sort()\nprint(x)',
  'x = [1, 2, 3, 4, 5]\ny = x.copy()\nprint(y)',
  'x = [1, 2, 3, 4, 5]\nx.insert(0, 0)\nprint(x)',
  'x = [1, 2, 3, 4, 5]\ndel x[0]\nprint(x)',
  'x = [1, 2, 3, 4, 5]\nx.remove(3)\nprint(x)',
  'x = [1, 2, 3, 4, 5]\nx.extend([6, 7, 8])\nprint(x)',
  'x = (1, 2, 3, 4, 5)\nfor i in x:\n\tprint(i)',
  'x = (1, 2, 3, 4, 5)\nprint(len(x))',
  "x = {'name': 'John', 'age': 25}\nprint(x['name'])",
  "x = {'name': 'John', 'age': 25}\nx['age'] = 26\nprint(x)",
  "x = {'name': 'John', 'age': 25}\nx.update({'email': 'john@example.com'})\nprint(x)",
  "x = {'name': 'John', 'age': 25}\nx.pop('age')\nprint(x)",
  "x = {'name': 'John', 'age': 25}\ndel x['name']\nprint(x)",
  'Unittest',
  'Mock objects',
  'Pytest',
  'Docstrings',
  'Type hints',
  'Classes',
  'Objects',
  'Inheritance',
  'Encapsulation',
  'Polymorphism',
  'Abstraction',
  'Metaclasses',
  'Decorators',
  'Generators',
  'Coroutines',
  'Iterators',
  'Context managers',
  'Regular expressions',
  'Pattern matching',
  'Numeric libraries',
  'Scientific computing',
  'Data visualization',
  'Matplotlib',
  'Seaborn',
  'Plotly',
  'Pandas',
  'Numpy',
  'Scipy',
  'Web frameworks',
  'Django',
  'Flask',
  'FastAPI',
  'SQLAlchemy',
  'ORM',
  'RESTful API',
  'Web scraping',
  'Beautiful Soup',
  'Scrapy',
  'Command line interfaces',
  'Argparse',
  'Click',
  'Fire',
  'Cryptography',
  'SSL',
  'TLS',
  'Hashing',
  'Encryption',
  'Key generation',
  'Public key cryptography',
  'Asynchronous programming',
  'Multithreading',
  'Concurrency',
  'Parallel processing',
  'GIL',
  'C extensions',
  'PyPy',
  'Jupyter Notebook',
  'IPython',
  'Colab',
  'Anaconda',
  'Virtualenv',
  'Conda',
  'Community',
  'Conferences',
  'Meetups',
  'Forums',
  'Blogs',
  'Podcasts',
  'Books',
  'Tutorials',
  'Online courses',
  'Stack Overflow',
  'GitHub',
];
