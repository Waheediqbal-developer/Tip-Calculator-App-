import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tip_calculator_app/providers/ThemeProvider.dart';
import 'package:tip_calculator_app/providers/TipCalculatorModel.dart';
import 'package:tip_calculator_app/widgets/bill_amount_field.dart';
import 'package:tip_calculator_app/widgets/person_counter.dart';
import 'package:tip_calculator_app/widgets/themeToggler.dart';
import 'package:tip_calculator_app/widgets/tip_row.dart';
import 'package:tip_calculator_app/widgets/tip_slider.dart';
import 'package:tip_calculator_app/widgets/total_per_person.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ( context) => Tipcalculatormodel()),
      ChangeNotifierProvider(create: (context)=> ThemeProvider())
      ],
      child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'UTip App',
      theme: themeProvider.currentTheme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final model = Provider.of<Tipcalculatormodel>(context);
    
    // Add style

    final style = theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 20),
            child: ThemeToggleButton(),
          )
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalPerPerson(theme: theme, style: style, total: model.totalPerPerson),
            // Form
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 2)),
                child: Column(
                  children: [
                    BillAmountField(
                      billAmount: model.billTotal.toString(),
                      onChanged: (value) {
                      model.updateBillTotal(double.parse(value));
                        // print("Amount: $value");
                      },
                    ),
                    // Split Bill area
                    PersonCounter(
                      theme: theme,
                      personCount: model.personCount,
                      onDecrement:model.decrement,
                      onIncrement: model.increment,
                    ),
                    // === Tip Section ==
                    TipRow(theme: theme, totalTip: model.billTotal, percentage: model.tipPercentage,),

                    // == Slider Text ==
                    Text('${(model.tipPercentage * 100).round()}%'),

                    // == Tip Slider ==
                    TipSlider(
                      tipPercentage: model.tipPercentage,
                      onChanged: (double value) {
                        model.updateTipPercentage(value);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


