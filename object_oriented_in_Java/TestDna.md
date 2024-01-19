# Working with DNA sequences

The domain we work in is DNA sequences, and we will prototype a small
DNA sequences analysis. You will implement one simple class and three
functions.



## A class for DNA sequences

Define the class DnaSeq to hold two string attributes: an accession
(which is supposed to be a unique identifier of a DNA sequence) and a
DNA sequence. Name the attributes accession and seq. It should be
possible to define a DnaSeq object like this:

```java
my_seq = DnaSeq('abc123', 'ACGTACGT')
```

- Your class should have a constructor (__init__, as given in the
  stub) and two methods: __len__ and __str__. Methods with these names
  have special meaning in Python: if a class has these two methods
  defined, then one can apply the functions len and str to them.
- In this exercise, __len__should return the length of the DNA
  sequence (so ignore the accession), and __str__ should return a
  "label" for convenient printing looking like <DnaSeq
  accession=abc123>, when applied to the example above. That is, you
  should use a template like <DnaSeq accession=XXX> and insert the
  accession of the object instead of XXX.
- Instantiation with empty accession or sequences strings should raise
  a ValueError exception. That is, a call like DnaSeq('', None) should
  raise the exception.  The methods should not print anything, just
  return values.



## A function to check overlaps

We want to be able to detect overlaps between sequence using a
function called check_exact_overlap. We say that sequence a overlaps
with sequence b if there is a suffix in a of some length L that is
identical to a prefix of length L in b. Note that this definition is
not commutative: a can overlap with b, without b overlapping with a.

Example 1: The DNA sequence AAACCC has an overlap of length 3 with
CCCCGATT, because the last three characters of AAACCC are identical
with the first three characters of CCCCGATT. These sequences have no
overlap of lengths 4 or longer.

Example 2: AAACCC has no overlap with GTACCC or GGGCCCTTT, because
there is no suffix of AAACCC that is identical to a prefix of GTACCC
or GGGCCCTTT.

Example 3: AAACCC overlaps with ACCC. In fact, it overlaps completely,
with length 4.

Implement check_exact_overlap to take three parameters: two DnaSeq
objects (corresponding to a and b above) and a minimum
length. Overlaps shorter than the minimum length are to be ignored.

Requirements:
- The minimum overlap length parameter should have default value of 10.
- The length of the longest detectable overlap larger than the minimum length should be returned.
- Return 0 if no overlap is detected.



## A higher-order function for checking all overlaps

Implement the function overlaps which takes two parameters:

- A list of DnaSeq objects.
- An overlap detection function.

An example of an overlap detection function is check_exact_overlap,
but any replacement would do. In the testing code, alternative overlap
functions are constructed from check_exact_overlap using other minimum
overlap lengths. If lst is a list of DnaSeq objects, then
overlaps(lst, check_exact_overlap) is a valid call to the function.

All detectable overlaps among pairs of sequences in the input list are to be returned.

Requirements:

- Return a dictionary of dictionaries containing the lengths of
  overlaps between sequences. If d is the result of a call to
  overlaps, and the sequences with accessions s1 and s2 overlaps
  with length 10, then d['s1']['s2'] == 10 should be true. If those
  two sequences were the only input, the nested dictionary could be
  written as {'s1': {'s2': 10}}.
- There should be no empty entries in the returned dictionary. If s1
  does not overlap with any of the input sequences, then there should
  not be an entry for s1 in the returned dictionary.
- Nothing should be printed, only returned, by the function.