import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';



const String question1 =r'''<p>A longitudinal wave is traveling through a medium with a wave speed of <span class=\"math-tex\"><span class=\"math-tex\">\\(340 \\mathrm{~m} / \\mathrm{s}\\)</span></span>. If the frequency of the wave is 85 Hz , calculate the wavelength.</p>\r\n''';
const String question2 =r'''<p><span style=\"font-size:16px;\"><span style=\"font-family:Poppins;\">The mixture of <span class=\"math-tex\"><span class=\"math-tex\">\\(\\mathrm{H}_{2(g)}, \\mathrm{I}_{2(g)}\\)</span></span>&nbsp;and&nbsp;<span class=\"math-tex\"><span class=\"math-tex\">\\(\\mathrm{HI}_{(g)}\\)</span></span>&nbsp;is at equilibrium.</span></span></p>\r\n''';
const question3 =r'''<p><span style=\"font-size:16px;\"><span style=\"font-family:Poppins;\">The equilibrium constants for the following two reactions at 298 K are given below:<br />\r\n\\[<br />\r\n\\begin{aligned}<br />\r\n&amp; 2 A \\rightleftharpoons B+C ; K_1=16 \\\\<br />\r\n&amp; 2 B+C \\rightleftharpoons 2 X ; K_2=25<br />\r\n\\end{aligned}<br />\r\n\\]</span></span></p>\r\n\r\n<p><span style=\"font-size:16px;\"><span style=\"font-family:Poppins;\">What is the value of <span class=\"math-tex\">\\(K\\)</span> for the reaction,<br />\r\n\\[<br />\r\nA+\\frac{1}{2} B \\rightleftharpoons X \\text { at } 298 \\mathrm{~K} ?<br />\r\n\\]</span></span><br />\r\n&nbsp;</p>\r\n''';

const sample = r'''<div class="container">
<h2>
Inline MathJax
</h2>

<p>$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$</p>
<p>
The scripts in this file allow math formulas to be written anywhere within the HTML code.  To start a formula you use either a dollar sign \$ or you can use a slash an an open parentheses "/(".  To end the inline math, you have another dollar sign or a back slash and a closing parentheses.  Enclosing in double dollar signs put the math on its own line.  Or you can use the backslash and a hard bracket "\[".
</p>

<p>
If you need to actually use a regular dollar sign in the text, then you need to 'escape' it so the page doesn't think its the start of math.  In order to escape it you use a backslash before the dollar sign.  "\\$"
</p>

<h3>
Examples
</h3>
<ol>
<li>Dollar Signs: $y=mx+1$</li>
<li>Parenthesis: \(y=mx+2\)</li>
<li>Double Dollar Signs: $$y=mx+3$$</li>
<li>Hard Bracket: \[y=mx+5\]</li>
  <li>$\lim_{x \to \infty} \exp(‐x) = 0$</li>
  <li>$\cos (2\theta) = \cos^2 \theta ‐ \sin^2 \theta$</li>
  <li>$a \bmod b$</li>
  <li>$x \equiv a \pmod b$</li>
</ol>

<h4>
In a sentence
</h4>
<p>
When $a \ne 0$, there are two solutions to \(ax^2 + bx + c = 0\) and they are
$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$
</p>
</div>''';
main() {
  runApp(const FlutterTeXExample());
}

class FlutterTeXExample extends StatelessWidget {
  const FlutterTeXExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TexViewFullExample(),
    );
  }
}

class TexViewFullExample extends StatefulWidget {
  const TexViewFullExample({super.key});

  @override
  State<TexViewFullExample> createState() => _TexViewFullExampleState();
}

class _TexViewFullExampleState extends State<TexViewFullExample> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: TeXView(
        enableHtmlInterceptor: false,
        renderingEngine: const TeXViewRenderingEngine.mathjax(),
        child: TeXViewColumn(children:
        List.generate(10, (index) {
          if(index==2){
            return
             TeXViewInkWell(child: 
              TeXViewDocument(
              
              '---------BTN----------'), id: '1',
              onTap: (id) {
                setState(() {
                  
                });
                log('Ontap $id');
              
              },
              );
          }
          return const TeXViewDocument(sample);
        })),
      ),
    );
  }
}
