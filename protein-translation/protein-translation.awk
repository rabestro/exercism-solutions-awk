BEGIN {
    FPAT = "..?.?"
    Stop = @/UAA|UAG|UGA/
    Protein["AUG"] = "Methionine"
    Protein["UUU"] = Protein["UUC"] = "Phenylalanine"
    Protein["UUA"] = Protein["UUG"] = "Leucine"
    Protein["UCU"] = Protein["UCC"] = Protein["UCA"] = Protein["UCG"] = "Serine"
    Protein["UAU"] = Protein["UAC"] = "Tyrosine"
    Protein["UGU"] = Protein["UGC"] = "Cysteine"
    Protein["UGG"] = "Tryptophan"
}
{
    for (i = 1; i<= NF; ++i)
        if ($i ~ Stop)
            NF = i - 1
        else
            $i = translate($i)
    print
}

function translate(codon) {
    if (codon in Protein)
        return Protein[codon]
    print "Invalid codon"
    exit 1
}
