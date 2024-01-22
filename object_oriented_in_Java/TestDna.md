# Working with DNA sequences

The goal is to write a DNA sequences analysis prototype.



## Exercise 1: a class for DNA sequences (🌶)

Define a class `DnaSeq` with two *private* attributes of type `String`:
- `accession`, the unique identifier of a DNA sequence
- `seq`, the DNA sequence

Your class should have a constructor allowing you to define
DNA sequence objects like this
```java
DnaSeq my_seq = new DnaSeq('abc123', 'ACGTACGT')
```
where `abc123` is the accession and `ACGTACGT` the sequence of `my_seq`.
Calling the constructor with empty accession or sequence strings
(e.g. `DnaSeq('', null)`) should raise
an `IllegalArgumentException`.


Your class should also have *getters* for the two private attributes and
the following methods:
- `public int length()` returning the length of the DNA
  sequence (ignoring the accession)
- `public String toString()` pretty printing a DNA sequence object as
  `<DnaSeq accession=XXX>` where `XXX` is replaced by the accession of the object.



## Exercise 2: a method checking overlaps (🌶🌶🌶)

Add a method
```java
public int check_exact_overlaps(DnaSeq other,int minOverlap)
```
to `DnaSeq` detecting overlaps between sequences.
Two sequences `a` and `b` have an overlap of length *L*
if the **last** *L* characters in `a`'s sequence (suffix)
coincide with the **first** *L* characters in `b`'s sequence (prefix).

(**Warning**: this is not a symmetric property!).

The method should return the biggest `L >= minOverlap` such that
the two sequences (`this` and `other`) have an overlap of length *L*
and *0* if there is no such *L*.

- **Example 1**: The DNA sequence `AAACCC` has an overlap of length 3 with
  `CCCCGATT`, but no overlap of length 4 or longer.
- **Example 2**: `AAACCC` has no overlap with `GTACCC` or `GGGCCCTTT`.

- **Example 3**: `AAACCC` overlaps with `ACCC`. In fact, it overlaps completely,
  with length 4.

We can then add a method
```java
public int check_exact_overlaps(DnaSeq other){
	return check_exact_overlaps(other, 2);
}
```
setting the default value of `minOverlap` to *2*.



## Exercise 3: checking all overlaps in a list of DNA sequences (🌶🌶)

Define a class `DnaSeqs` whose objects are lists of DNA sequences.
The class should have one private attribute `seqs` of type
`List<DnaSeq>` and a constructor.
It should also have a method `check_all_overlaps` that returns the overlaps
of all pairs of sequences in `seqs`.

Assuming that overlaps are sparse, the method should return a
"dictionary of dictionaries" containing the lengths of
overlaps between sequences.

**Hint**: import `java.util.Map` for a dictionary API and
`java.util.HashMap` for an implementation of the Map-API.
Using this, what type should `check_all_overlaps` return?

If `s1` and `s2` overlap with length 10, then the resulting dictionary
should a have an entry with key `s1` and as value a dictionary that
itself has an entry with key `s2` and value 10.
There should be no entries for zero overlaps.
If `s1` does not have a non-zero overlap with another sequence,
it should not appear as a key in the dictionary.
