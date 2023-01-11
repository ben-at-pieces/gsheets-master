import 'package:connector_openapi/api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:test/test.dart';

/// These tests cover the methods afforded by the connector SDK
void main() async {
  const String port = '1000';
  const String host = 'http://localhost:$port';
  final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

  /// Future instance of Connect to be used in connectorApi Tests ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->
  Future<Context> connect() async {
    try {
      return connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.ULTRA_EDIT,
            platform: PlatformEnum.MACOS,
            version: '1.5.8',
          ),
        ),
      );
      // print('======== $connect');
    } catch (err) {
      throw Exception('Error occurred when establishing connection. error:$err');
    }
  }

  ///ConnectorApi Group
  ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
  /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
  /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
  group('Testing the connectorApi ', () {
    ///
    ///
    ///==============================================================================================
    test('/onboarded', () async {
      Context context = await connect();

      /// /onboarded Runtime Type
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
      String response = await connectorApi.onboarded(
        context.application.id,
        body: true,
      );

      expect(response.runtimeType, String);
    });

    ///==============================================================================================

    test('/connect', () async {
      /// /connect Runtime Type
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// call the endpoint
      Context connect = await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.PIECES_FOR_DEVELOPERS,
            platform: PlatformEnum.WINDOWS,
            version: '1.9.1',
          ),
        ),
      );

      expect(connect.runtimeType, Context);
    });

    ///==============================================================================================

    test('/{application}/snapshot', () async {
      Context context = await connect();

      /// /{application}/snapshot Runtime Type <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// (2) call the endpoint
      await connectorApi.snapshot(context.application.id);
    });

    ///==============================================================================================

    test('/{application}/search', () async {
      Context context = await connect();

      /// /{application}/search Runtime Type <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
      ///

      String query = 'Hello World';

      /// (2) call the endpoint
      Searched results = await connectorApi.search(context.application.id, query: query);

      /// We dont need an expect statement right now because the api will throw an error if it fails.
      /// TODO for the future check performance of the search query
      /// TODO check data validity (ie results suggested, exact...)
      /// TODO check different query and so on
    });

    ///==============================================================================================

    test('/{application}/intention', () async {
      /// (1) connect to os server
      Context context = await connect();

      /// /{application}/intention Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// (2) call the endpoint
      String intention = await connectorApi.intention(
        context.application.id,
        seededConnectorAsset: SeededConnectorAsset(
          format: SeededFormat(
            fragment: SeededFragment(
              /// **** Extremely important. **** you must pass in metadata on intention or else intention is useless...
              metadata: FragmentMetadata(ext: ClassificationSpecificEnum.js),
              string: TransferableString(
                raw: "() => console.log('hello world')",
              ),
            ),
          ),
        ),
      );
      expect(intention.runtimeType, String);
    });

    ///==============================================================================================

    test('/{application}/suggestion', () async {
      /// (1) connect to os server
      Context context = await connect();

      /// /{application}/suggestion Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// (2) call the endpoint
      Suggestion suggestion = await connectorApi.suggest(
        context.application.id,
        seededConnectorCreation: SeededConnectorCreation(
          asset: SeededConnectorAsset(
            format: SeededFormat(
              fragment: SeededFragment(
                string: TransferableString(
                  raw: 'hello world!',
                ),
              ),
            ),
          ),
        ),
      );
      // print(suggestion);
      expect(suggestion.runtimeType, Suggestion);
    });

    ///==============================================================================================

    test('/{application}/reaction', () async {
      /// (1) connect to os server
      Context context = await connect();

      /// reaction Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// (2) call Suggestion First and pass in seededConnectorCreation to Reaction API call
      SeededConnectorCreation tentativeCreation = SeededConnectorCreation(
        asset: SeededConnectorAsset(
          format: SeededFormat(
            fragment: SeededFragment(
              string: TransferableString(
                raw: 'hello world!',
              ),
            ),
          ),
        ),
      );
      Suggestion suggestion = await connectorApi.suggest(
        context.application.id,
        seededConnectorCreation: tentativeCreation,
      );
      expect(suggestion.runtimeType, Suggestion);

      /// (3) call the endpoint
      Reaction reaction = Reaction(
        save: true,
        seed: tentativeCreation,
      );

      /// (4) await the reaction
      await connectorApi.react(
        context.application.id,
        reaction: reaction,
      );

      // print(reaction);
      /// (5) expect runtime type to be of type Reaction
      expect(reaction.runtimeType, Reaction);
    });

    ///ToDo review how reaction can be used and tested

    ///==============================================================================================

    test('/{application}/track', () async {
      /// (1) connect to os server
      Context context = await connect();

      /// /{application}/track Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

      /// TODO lets check all the permutations of track in the future to go deeper on this test
      /// TODO but for now we will just call the track endpoint a single time
      /// (2) call the endpoint

      await connectorApi.track(
        context.application.id,
        seededConnectorTracking: SeededConnectorTracking(
          keyboard: SeededTrackedKeyboardEvent(description: 'testing_tracking_keyboard_event'),
        ),
      );
      // print(track);
    });

    test('/{application}/create', () async {
      /// (1) connect to os server
      Context context = await connect();

      /// /{application}/create Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
      ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
      /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
      /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
      /// (2) call the endpoint
      String create = await connectorApi.create(
        context.application.id,
        seededConnectorCreation: SeededConnectorCreation(
          asset: SeededConnectorAsset(
            metadata: SeededAssetMetadata(
              description: 'edit description',
              name: 'edit name',
              mechanism: MechanismEnum.MANUAL,
            ),
            format: SeededFormat(
              fragment: SeededFragment(
                metadata: FragmentMetadata(ext: ClassificationSpecificEnum.coffee),
                string: TransferableString(
                  raw: 'hello world!',
                ),
              ),
            ),
          ),
        ),
      );
      // print(create);

      ///returns "ok"
      expect(create.runtimeType, String);
    });
  });
}

///==============================================================================================

// TODO test that we can call intention with different ext && fragments && files??(maybe maybe not)
// TODO test performance
// TODO test possible error codes
// TODO test that we can call intention with different ext && fragments && files??(maybe maybe not)
// TODO test performance
// TODO test possible error codes
//TODO test that we can call intention with different ext && fragments && files??(maybe maybe not)
// TODO test performance/// TODO test possible error codes
// This test for now wll just connect to the Pieces OS using a single application
// TODO test /connect with all our applications && different operating systems in combination.
// TODO test data validity on the connect endpoint(go more in depth on the data and check that it is what we are expecting on a granular level)
// TODO check the performance(ie log the time it takes to connect ensure that performance tests are done on a machine basis)  and log to a file or something.
///
///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
/// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
/// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
///
///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
/// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
/// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
