import 'package:blocdemo/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'bloc/weather_bloc.dart';
import 'common/city_input_field.dart';
import 'generated/l10n.dart';
import 'model/weather.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // List all of the app's supported locales here
      supportedLocales: S.delegate.supportedLocales,
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER


        // A class which loads the translations from ARB files
        S.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],

      home: WeatherPageState(title: 'Flutter Demo Home Page'),
    );
  }
}

class WeatherPageState extends StatefulWidget {
  WeatherPageState({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeatherPageStateState createState() => _WeatherPageStateState();
}

class _WeatherPageStateState extends State<WeatherPageState> {
  final weatherBloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        bloc: weatherBloc,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder(
            bloc: weatherBloc,
            builder: (context, state) {
              if (state is InitialWeatherState)
                return buildInitialInput();
              else if (state is WeatherLoadingState)
                return buildLoading();
              else if (state is WeatherLoadedState)
                return buildColumnWithData(state.weather);
              else
                return buildLoading();
            },
          ),
        ),
      ),
    );
  }

  format(){
    var now = new DateTime.now();
    var formatter = new DateFormat.yMMMMd(Intl.getCurrentLocale());
    String formatted = formatter.format(now);
    return formatted;
  }
  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
           "${weather.temp.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          // Display the temperature with 1 decimal place
           format(),
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
