
data = Import[$ScriptCommandLine[[2]], "CSV", "Numeric" -> False];
largeIntegers = ToExpression /@ data;

rows = ({#[[1]], 1000*First@AbsoluteTiming[FactorInteger[#[[2]]]]} &) /@ largeIntegers;

cols = Map[ToString, rows, {2}];

max1 = Max[StringLength /@ cols[[All, 1]]];
max2 = Max[StringLength /@ cols[[All, 2]]];

Do[
  Print[
    StringPadRight[cols[[i, 1]], max1], "   ",
    StringPadRight[cols[[i, 2]], max2]
  ],
  {i, Length[cols]}
]