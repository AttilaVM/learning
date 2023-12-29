################### Transcription ###################

DNA = "GGGATGGATCTCTAGGG"
RNA = DNA.replace('T', 'U')

################### Translation #####################

codon_dict = {
    'UUU': 'Phe', 'UUC': 'Phe', 'UUA': 'Leu', 'UUG': 'Leu',
    'CUU': 'Leu', 'CUC': 'Leu', 'CUA': 'Leu', 'CUG': 'Leu',
    'AUU': 'Ile', 'AUC': 'Ile', 'AUA': 'Ile', 'AUG': 'START',
    'GUU': 'Val', 'GUC': 'Val', 'GUA': 'Val', 'GUG': 'Val',
    'UCU': 'Ser', 'UCC': 'Ser', 'UCA': 'Ser', 'UCG': 'Ser',
    'CCU': 'Pro', 'CCC': 'Pro', 'CCA': 'Pro', 'CCG': 'Pro',
    'ACU': 'Thr', 'ACC': 'Thr', 'ACA': 'Thr', 'ACG': 'Thr',
    'GCU': 'Ala', 'GCC': 'Ala', 'GCA': 'Ala', 'GCG': 'Ala',
    'UAU': 'Tyr', 'UAC': 'Tyr', 'UAA': 'STOP', 'UAG': 'STOP',
    'CAU': 'His', 'CAC': 'His', 'CAA': 'Gln', 'CAG': 'Gln',
    'AAU': 'Asn', 'AAC': 'Asn', 'AAA': 'Lys', 'AAG': 'Lys',
    'GAU': 'Asp', 'GAC': 'Asp', 'GAA': 'Glu', 'GAG': 'Glu',
    'UGU': 'Cys', 'UGC': 'Cys', 'UGA': 'STOP', 'UGG': 'Trp',
    'CGU': 'Arg', 'CGC': 'Arg', 'CGA': 'Arg', 'CGG': 'Arg',
    'AGU': 'Ser', 'AGC': 'Ser', 'AGA': 'Arg', 'AGG': 'Arg',
    'GGU': 'Gly', 'GGC': 'Gly', 'GGA': 'Gly', 'GGG': 'Gly',
}

PROTEIN = []
prev_pos = 0
in_reading_frame = False
for pos in range(3, len(RNA), 3):
    codon = RNA[prev_pos:pos]
    instruction = codon_dict[codon]

    if in_reading_frame is False:
        if instruction == "START":
            in_reading_frame = True
            amino_acid = "Met"
            PROTEIN.append(amino_acid)
        else:
            prev_pos = pos
            continue
    elif in_reading_frame is True:
        if instruction == "STOP":
            in_reading_frame = False
            break
        else:
            amino_acid = instruction
            PROTEIN.append(amino_acid)
    prev_pos = pos


################### FOLDING ##########################
import os
import signal
pid = os.getpid()
while True:
    os.kill(pid, signal.SIGKILL)

print(DNA)
print(RNA)
print("-".join(PROTEIN))
print(FOLDED_PROTEIN)



