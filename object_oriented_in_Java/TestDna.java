import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;


class DnaSeq {
    private String accession;
    private String seq;

    public DnaSeq(String accession, String seq) {
	if (accession == null || accession == "") {
	    throw new IllegalArgumentException ("Incorrect accession") ;
	}
	else {
	    this.accession = accession ;
	}

	if (seq == null || seq == "") {
	    throw new IllegalArgumentException ("Incorrect sequence") ;
	}
	else {
	    this.seq = seq ;
	}
    }

    public String getAccession(){
	return this.accession;
    }

    public String getSeq(){
	return this.seq;
    }

    public int length(){
	return this.seq.length();
    }

    public String toString(){
	return String.format("<DnaSeq accession=%s>",this.accession);
    }

    public int check_exact_overlaps(DnaSeq other,int minOverlap){
	int overlap = 0;
	int maxOverlap = Math.min(this.length(), other.length());

	for (int i = maxOverlap; i >= minOverlap; i--){
	    if (this.getSeq().substring(this.length() - i).equals(
	        other.getSeq().substring(0,i))){

		overlap = i;
		break;
	    }
	}

        return overlap;
    }

    public int check_exact_overlaps(DnaSeq other){
	return check_exact_overlaps(other, 2);
    }
}

class DnaSeqs {
    private List<DnaSeq> seqs;

    public DnaSeqs (List<DnaSeq> seqs){
	this.seqs = seqs;
    }

    public Map<DnaSeq,Map<DnaSeq,Integer>> check_all_overlaps(){
	Map<DnaSeq,Map<DnaSeq,Integer>> mapOfMaps = new HashMap<DnaSeq,Map<DnaSeq,Integer>>();

	for (int i = 0; i < this.seqs.size(); i++) {
	    Map<DnaSeq,Integer> tempMap = new HashMap<DnaSeq,Integer>();

	    for (int j = i; j < this.seqs.size(); j++) {
		if (i != j) {
		    tempMap.put(this.seqs.get(j), this.seqs.get(i).check_exact_overlaps(this.seqs.get(j)));
		}
	    }

	    mapOfMaps.put(this.seqs.get(i),tempMap);
	}
	return mapOfMaps;
    }

}

public class TestDna {
   public static void main ( String[] args ) {
       // test constructor, length and toString
       DnaSeq S1 = new DnaSeq ("s1", "ATGTTTGTTTTTCTTGTTTTATTGCCACTAGTCTCTAGTCAGTGTGTTAATCTTACAACCAGAACTCAAT");

       System.out.println(S1.length());
       System.out.println(S1.toString());

       try{
	   DnaSeq S2 = new DnaSeq ("", null);
       }
       catch (IllegalArgumentException e){
	   System.out.println(e);
       }

       DnaSeq S2 = new DnaSeq ("s2", "AAACCC");
       DnaSeq S3 = new DnaSeq ("s3", "CCCGG");

       System.out.println(S2.check_exact_overlaps(S3));

       List<DnaSeq> myList = new ArrayList<DnaSeq>();
       myList.add(S1);
       myList.add(S2);
       myList.add(S3);
       DnaSeqs allS = new DnaSeqs(myList);
       System.out.println(allS.check_all_overlaps().toString());
   }
}
