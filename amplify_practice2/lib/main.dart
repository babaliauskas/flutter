import 'package:amplify_practice2/hidden_drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HidderDrawer(),
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool isSignUpComplete = false;
//   bool isSignedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }

//   Future<void> _configureAmplify() async {
//     try {
//       final auth = AmplifyAuthCognito();
//       final graphQL = AmplifyAPI(modelProvider: ModelProvider.instance);
//       final datastorePlugin =
//           AmplifyDataStore(modelProvider: ModelProvider.instance);
//       await Amplify.addPlugins([auth, datastorePlugin, graphQL]);

//       await Amplify.configure(amplifyconfig);
//     } on Exception catch (e) {
//       safePrint('An error occurred configuring Amplify: $e');
//     }
//   }

//   Future<void> signUpUser() async {
//     try {
//       final userAttributes = <CognitoUserAttributeKey, String>{
//         CognitoUserAttributeKey.email: 'l.babaliauskas@gmail.com',
//         CognitoUserAttributeKey.phoneNumber: '+15559101234',
//         // additional attributes as needed
//       };
//       final result = await Amplify.Auth.signUp(
//         username: 'l.babaliauskas@gmail.com',
//         password: 'Test123!',
//         options: CognitoSignUpOptions(userAttributes: userAttributes),
//       );
//       setState(() {
//         isSignUpComplete = result.isSignUpComplete;
//       });
//       safePrint('Signed UP');
//     } on AuthException catch (e) {
//       safePrint(e.message);
//     }
//   }

//   Future<void> signOutCurrentUser() async {
//     try {
//       await Amplify.Auth.signOut();
//       safePrint('Sign out');
//     } on AuthException catch (e) {
//       print(e.message);
//     }
//   }

//   Future<void> confirmUser() async {
//     try {
//       final result = await Amplify.Auth.confirmSignUp(
//           username: 'l.babaliauskas@gmail.com', confirmationCode: '273633');

//       setState(() {
//         isSignUpComplete = result.isSignUpComplete;
//       });
//       safePrint('Confirmed');
//     } on AuthException catch (e) {
//       safePrint(e.message);
//     }
//   }

//   Future<void> signInUser() async {
//     try {
//       final result = await Amplify.Auth.signIn(
//         username: 'l.babaliauskas@gmail.com',
//         password: 'Test123!',
//       );

//       setState(() {
//         isSignedIn = result.isSignedIn;
//       });
//       safePrint('SignedIn');
//     } on AuthException catch (e) {
//       safePrint(e.message);
//     }
//   }

//   Future<void> savePost() async {
//     final newPost = Todo(
//       title: 'sdfasdfasf',
//       isCompleted: false,
//     );
//     try {
//       safePrint("TODO : $newPost");
//       await Amplify.DataStore.save(newPost);
//     } on Exception catch (e) {
//       safePrint('Error posting: $e');
//     }
//   }

//   Future<List<Todo?>> getItems() async {
//     try {
//       final request = ModelQueries.list(Todo.classType);
//       final response = await Amplify.API.query(request: request).response;

//       final todos = response.data?.items;
//       if (todos == null) {
//         print('errors: ${response.errors}');
//         return <Todo?>[];
//       }
//       safePrint(todos);
//       return todos;
//     } on ApiException catch (e) {
//       print('Query failed: $e');
//     }
//     return <Todo?>[];
//   }

//   Future<void> createTodo() async {
//     try {
//       final todo = Todo(title: 'my first todo');
//       final request = ModelMutations.create(todo);
//       final response = await Amplify.API.mutate(request: request).response;

//       final createdTodo = response.data;
//       if (createdTodo == null) {
//         safePrint('errors: ${response.errors}');
//         return;
//       }
//       safePrint('Mutation result: ${createdTodo.title}');
//     } on ApiException catch (e) {
//       safePrint('Mutation failed: $e');
//     }
//   }

//   Future<void> createTodoWithOwner() async {
//     try {
//       final item = SomeTest(title: "Lorem ipsum dolor sit amet");
//       // final todo = Todo(title: 'my first todo');
//       final request = ModelMutations.create(item);
//       final response = await Amplify.API.mutate(request: request).response;

//       final createdTodo = response.data;
//       if (createdTodo == null) {
//         safePrint('errors: ${response.errors}');
//         return;
//       }
//       safePrint('Mutation result createTodoWithOwner: ${createdTodo.title}');
//     } on ApiException catch (e) {
//       safePrint('Mutation failed: $e');
//     }
//   }

//   Future<void> _isAdmin() async {
//     try {
//       final result = await Amplify.Auth.fetchUserAttributes();
//       // final result = await Amplify.Auth.
//       for (final element in result) {
//         print('key: ${element.userAttributeKey}; value: ${element.value}');
//       }
//     } on Exception catch (e) {
//       safePrint('An eror occured checking user rights: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const Text('Reegister'),
//             TextButton(
//               onPressed: signUpUser,
//               child: const Text('SIgn Up'),
//             ),
//             TextButton(
//               onPressed: confirmUser,
//               child: const Text('Confirm'),
//             ),
//             TextButton(
//               onPressed: signInUser,
//               child: const Text('SignIn'),
//             ),
//             TextButton(
//               onPressed: _isAdmin,
//               child: const Text('Attributs'),
//             ),
//             TextButton(
//               onPressed: savePost,
//               child: const Text('save post'),
//             ),
//             TextButton(
//               onPressed: getItems,
//               child: const Text('fetch posts'),
//             ),
//             TextButton(
//               onPressed: createTodo,
//               child: const Text('Create Todo'),
//             ),
//             TextButton(
//               onPressed: signOutCurrentUser,
//               child: const Text('Sign out'),
//             ),
//             TextButton(
//               onPressed: createTodoWithOwner,
//               child: const Text('withOwner'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
