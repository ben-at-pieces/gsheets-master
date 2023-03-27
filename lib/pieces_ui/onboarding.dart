import 'package:flutter/material.dart';

class OnboardingBase extends StatefulWidget {
  const OnboardingBase({
    Key? key,
    required this.children,
    required this.header,
    this.subheader,
    this.shortcuts,
    this.beta = false,
  }) : super(key: key);

  final List<Widget> children;
  final String header;
  final String? subheader;
  final Map<String, void Function()>? shortcuts;
  final bool beta;

  @override
  _OnboardingBaseState createState() => _OnboardingBaseState();
}

class _OnboardingBaseState extends State<OnboardingBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[300],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.header,
                              textAlign: TextAlign.center,
                            ),
                            if (widget.beta) ...[
                              SizedBox(width: 16),
                              Text('BETA'),
                            ],
                          ],
                        ),
                        if (widget.subheader != null) ...[
                          SizedBox(height: 8),
                          Text(
                            widget.subheader!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                        ...widget.children,
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            // TODO: Go to previous onboarding page
                          },
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.5, // replace with actual progress value
                          ),
                        ),
                        SizedBox(width: 16),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            // TODO: Go to next onboarding page
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Go to previous onboarding page
                    },
                    child: Text('Back'),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Go to next onboarding page or complete onboarding
                    },
                    child: Text(widget.beta ? 'Finish BETA' : 'Finish'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
