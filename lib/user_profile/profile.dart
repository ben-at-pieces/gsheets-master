// // ignore_for_file: omit_local_variable_types
//
// import 'package:core_openapi/api/user_api.dart';
// import 'package:core_openapi/api_client.dart';
// import 'package:test/test.dart';
//
// void main() async {
//   String port = '1000';
//   String host = 'http://localhost:$port';
//   UserApi userApi = UserApi(ApiClient(basePath: host));
//   ReturnedUserProfile userProfile = await userApi.userSnapshot();
//
//   /// TODO handle instances where user is not signed in and working offline
//
//   group('User Profile Tests', () {
//     //
//     //
//     test('USER RUNTIME', () async {
//       /// return a print statement if our user profile is null
//       if (userProfile == null) {
//         return ('unable to test our user specific properties');
//         // expect that the users vanity is not empty
//       }
//       expect(userProfile.runtimeType, ReturnedUserProfile);
//     });
//     test('VANITY DOMAIN', () async {
//       //  define the vanity string name
//       String? vanityName = userProfile.user?.vanityname;
//
//       /// return a print statement if our user vanity domain name is null
//       if (vanityName == null) {
//         return ('unable to ensure the vanity name has been set');
//       }
//       return ('Vanity Domain Name: $vanityName');
//       // expect that the users vanity is not empty
//       expect(vanityName != null, true);
//     });
//     test('GOOGLE_IMAGE', () async {
//       // define the google image string name
//       String? userImage = userProfile.user?.picture;
//       //optional print
//       print('google image: $userImage');
//       // expect user image to not be empty
//       expect(userImage, isNotEmpty);
//     });
//     test('EMAIL', () async {
//       // define the user email string name
//       String? email = userProfile.user?.email;
//       // optional print statement
//       print('user email: $email');
//       // expect user to have an email...
//       expect(email, isNotEmpty);
//     });
//     test('CLOUD RUNNING', () async {
//       // define your allocationStatusEnum ('cloud')
//       AllocationStatusEnum? cloud = userProfile.user?.allocation?.status.cloud;
//       // optional print statement
//       print('user cloud is $cloud');
//       // expect cloud status to be " AllocationStatusEnum.RUNNING
//       /// print statement to hand a null user allocation
//       if (userProfile.user?.allocation?.status.cloud.value != null) {
//         expect(cloud?.value == 'RUNNING', true);
//       }
//       if (userProfile.user?.allocation?.status.cloud.value == null) {
//         expect(cloud?.value == 'RUNNING', false);
//       }
//     });
//     test('font size: ', () async {
//       // define your allocationStatusEnum ('font')
//       int? font = userProfile.user?.aesthetics.font.size;
//       // optional print statement
//       print('Font size: $font');
//       // expect font size to be 16
//       expect(font, 16);
//     });
//     test('TimeStamp', () async {
//       // define your time stamp (readable timestamp)
//       String? timeStamp = userProfile.user?.created?.readable;
//       // optional print
//       print('saved $timeStamp');
//       // expect that our timestamp is not empty
//       expect(timeStamp, isNotEmpty);
//     });
//   });
// }
