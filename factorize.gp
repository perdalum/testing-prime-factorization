\\ factorize.gp
\\ author: Per Møldrup-Dalum
\\ date:   2026-11-16

\\default(parisize, "128M");
\\default(parisizemax, "512M");

\\ read filename from environment, fall back to default
filename = getenv("LARGE_INTS");
if (filename == "",filename = "primes-1.dat");

lines = readstr(filename);
if (#lines == 0, error("file is empty or unreadable"));

\\ Process one line: "<ndigits>,<big_integer>"
factor_line(line) =
{
  local(parts, ndigits, n, t0, t1, factors);
  parts = strsplit(line, ",");

  if (#parts != 2, return());

  ndigits = eval(parts[1]);
  n       = eval(parts[2]);

  t0 = getwalltime();
  factors = factor(n);
  t1 = getwalltime();

  print(ndigits, "\t", t1 - t0);
};

\\ Simple for-loop: body is just a *single* function call
for (j = 1, #lines, factor_line(lines[j]));
quit


